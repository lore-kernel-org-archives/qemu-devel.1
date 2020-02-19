Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63144C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:17:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A8362465D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="mCm2TX97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8362465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4SyM-0003QW-Bc
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 12:17:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4Swj-0001rz-55
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 12:15:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4Swh-0002WA-4F
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 12:15:36 -0500
Received: from mail-vi1eur05on2122.outbound.protection.outlook.com
 ([40.107.21.122]:7745 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1j4Swe-0002Qy-D3; Wed, 19 Feb 2020 12:15:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMDzKL5gyXnxsH1jtmjELOC6hksGL0Xowf4SadT9vru+EYNAhs/OVhTNLkKidto9hmO/0uKcV93Vcjl0eiyLitj1ieuAqfthXL0jtcxX5H+4PgBZVgRGHjq6guRzNhLZyzh2/55guuYJJrOFEGWfssoI+QFlmtcbk7oyFeyrvAUZq23PNoLrucHzIz+AEMhZ3jxVlU7eiHVk4yPUhts5q0nqBgmbUWBvLIFrIJZdL5xdh6LyfRlWMQf5alMeahImbBjqcNF1MxoSPX9ioePNMtQMM1AVy4lQfjWJ9J31MXE52ge5VE7DMzFjmj2l4QlvfdsntDjOeByH7yB5Eiv61g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZufrIe8G+Uun6FGgoXNpe+unq3tM1eJcyhux4kjYPY=;
 b=Hj93ZC4SlFwnl2BhOIF7QqfChAFgywxUimZVOtYmyxla5C8Zf5Souyh4NeKplxPyLBGPn+zNvHkQzfGqohbcLrxHe6wqAds6WQdZrjYbxKWT1vrdUcD74NNiJxOX9UNPzpSmEx53czhhDkaLpICgx6cTPc270OXA6NF4e4hFEkp1H0Yt6JYmqnuTBs3bpHlwwq0c0x6CBdSq4lKen5QbECASvk1tXDFpZwHaqjkO/Wq7PCbVSF6k1ywdyz77AuC65VypSrGUrz+c95JbL+SYukSeDKaeLkd6R0hFJJvLwMhtdr/FPOtA/y4DKDVjEmOYsPPryiuybOWfFLcF5HqnYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZufrIe8G+Uun6FGgoXNpe+unq3tM1eJcyhux4kjYPY=;
 b=mCm2TX97X57mhlGhCgTDS/xcX1WrgtcF9HxZy8ricJ7SS6FoB01Sk6DAgRTZyPMWcVHOq4aqyVueWSSh5bEorroBdJDt1SHfRJQC7449Fu1zZPKooEARQpeKPNrbydCsIvczSyZ2rx46Fi8RN7iHC41bk5Xuxm8iSWiKlSIFGjk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB5208.eurprd08.prod.outlook.com (10.255.122.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.29; Wed, 19 Feb 2020 17:15:29 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d%5]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 17:15:29 +0000
Subject: Re: [PATCH v2 22/22] qemu-iotests/199: add source-killed case to
 bitmaps postcopy
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-23-vsementsov@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <6874a389-9a21-4090-8856-e1f9c285ced5@virtuozzo.com>
Date: Wed, 19 Feb 2020 20:15:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200217150246.29180-23-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P189CA0014.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::27)
 To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1P189CA0014.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Wed, 19 Feb 2020 17:15:28 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcf1c80f-40f2-4ce4-cc26-08d7b55f5174
X-MS-TrafficTypeDiagnostic: AM6PR08MB5208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB520887ED9BEEACD7697B7AB7F4100@AM6PR08MB5208.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(366004)(346002)(136003)(396003)(39850400004)(376002)(189003)(199004)(36756003)(53546011)(16526019)(186003)(4326008)(31696002)(26005)(44832011)(6486002)(2616005)(956004)(86362001)(5660300002)(316002)(8936002)(16576012)(31686004)(81166006)(66556008)(66946007)(66476007)(81156014)(36916002)(8676002)(478600001)(2906002)(54906003)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5208;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uXA/DLQaAyee9dxGU2ZaH2Q8M2zgCyS8horWxFHn8jtKhO7BYjLLE1aFo+kd2t3XzVnyw1oN89Y0Pq86lP0R6rAluiUuXWRwrQJ9urWhT3HBbuoBSEIJlMeOqsoKQEx9XuV13q2qiZ5NwyeTURC+kEYbqj3ynwc1mX27OMfqlZUCNi1C/SP4ZQ9dy7tVdQr/qmYdparPP4DOoxLi06vMvU5FmexbknsOFWLJ5wbnqhxFTC5/2j/f+uDxMDBIFJTFALdNLgbODBh/y42rhuafcjeDmCv3w0meEmJdZzETJUMtcxn+pXGBLzXNBZviq+ABsKKVqqadhXQ//CkMTy6jec5FqSUgyzLEM0/VWihRMdgpHi6deXPcrfVQMacMdv6NRCetrua9foGnEGwoo5Dy+GWlVfqcmS6B1yrRohZRq2bGfvgTQ3nU8cCiUwmlfKth
X-MS-Exchange-AntiSpam-MessageData: R2S9DOIIVI0eh53cGnMakSQu7OCDddePzICfNYRkTyr1mCFgdR5UcHAS7gUs4ePxVQQQCr8X4VAjl79yAxb2VkSgPRKkYLQQ23snmtY82IqqOnY5mkAH5yUu+Gm5DWVIyBcy9+sPzoc2FGOXi2QCig==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf1c80f-40f2-4ce4-cc26-08d7b55f5174
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 17:15:29.0283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fndQAgPmnR+smUC3f4WwRhyldPKU0zLV7+adJAw/WAQNOIdzAwaF06vrz65S3I5JQZjqv3fw9bZG+jhgKXxCqNXpc6Zj0JW3TEGOazG8yx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5208
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.21.122
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 dgilbert@redhat.com, qemu-block@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/02/2020 18:02, Vladimir Sementsov-Ogievskiy wrote:
> Previous patches fixes behavior of bitmaps migration, so that errors
> are handled by just removing unfinished bitmaps, and not fail or try to
> recover postcopy migration. Add corresponding test.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   tests/qemu-iotests/199     | 15 +++++++++++++++
>   tests/qemu-iotests/199.out |  4 ++--
>   2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
> index 0d12e6b1ae..d38913fa44 100755
> --- a/tests/qemu-iotests/199
> +++ b/tests/qemu-iotests/199
> @@ -235,6 +235,21 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>           self.vm_a.launch()
>           check_bitmaps(self.vm_a, 0)
>   
> +    def test_early_kill_source(self):
> +        self.start_postcopy()
> +
> +        self.vm_a_events = self.vm_a.get_qmp_events()
> +        self.vm_a.kill()
> +
> +        self.vm_a.launch()
> +
> +        match = {'data': {'status': 'completed'}}
> +        e_complete = self.vm_b.event_wait('MIGRATION', match=match)

A failed migration gets the status 'completed'. That misleads a user but 
is not in the scope of this series, I guess.

> +        self.vm_b_events.append(e_complete)
> +
> +        check_bitmaps(self.vm_a, 0)
> +        check_bitmaps(self.vm_b, 0)
> +
>   
>   if __name__ == '__main__':
>       iotests.main(supported_fmts=['qcow2'])
> diff --git a/tests/qemu-iotests/199.out b/tests/qemu-iotests/199.out
> index fbc63e62f8..8d7e996700 100644
> --- a/tests/qemu-iotests/199.out
> +++ b/tests/qemu-iotests/199.out
> @@ -1,5 +1,5 @@
> -..
> +...
>   ----------------------------------------------------------------------
> -Ran 2 tests
> +Ran 3 tests
>   
>   OK
> 

The updated test passed.

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
-- 
With the best regards,
Andrey Shinkevich

