Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C386C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:45:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5833D20578
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bv0IAh9S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5833D20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4STJ-00063q-Dh
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:45:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4SDT-0005n9-Qb
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:28:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4SDS-0000i9-Ms
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:28:51 -0500
Received: from mail-eopbgr60123.outbound.protection.outlook.com
 ([40.107.6.123]:38414 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1j4SDQ-0000h5-82; Wed, 19 Feb 2020 11:28:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4gGydYGzIAbhVF0EzzE9rMsvSohp/CeSopx//qiIHkhb4dw4ketOeiNiBdGy09WAruSaSFFM3PRc0aDa1/Z/Vhmb2BemwjA/cHeUOSMzzxwBDnocQxL6qn/isn1hZsdAoost8nsiLa1i4iumWPDfzJqm5mq7B5Cvn+Vg4yAHGq6UTrCjebkcz2lztKBO3IKJC+bYtPuVE+2Zs+pioa08D2oWNrfcpVIT68MWxjTk4JsVdt8ljubrd1iVPcza9jjc4WuiWRFNEDhP1leQFauUYfdgxK1iHfxrRDr2vb52axaNwL50Uwg72k5QILcw3St0vCtKKMSafioreMySlJF8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLEOFDGMmY2vdcUyKkzqejjTouiWlpTmrMWoGvIFYhQ=;
 b=J1jrznYeNE1Dk2I2FDwmle5WwpqCcCeEC7Qixh5tUWJG3yskWt4Lce/nhBQC0AmBunBNXiUyw+wHFwloCA5woWsYz3oBVBD6++9iGpFDPqGDdtTot3CTFSqQ0o1/c+d0d7R/XWduAbS3rGwosKjjehvTxyXllemXlVcwMgavp+CV4AwaubLLzfHhT3gT73V7z/cA4WnAsP9trZmEjzfpA58f48jOszu52V1M6F/dhXwAjT1skA12nFl5LF3FCYZHp5kYG9RZVnb/pTM5yeo5BolIk4uFARKnFEUD4NahvxhzyTwEP3Ibo0fUJMRekrxRBSBVb56EY6VSoKrzZ0f0AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLEOFDGMmY2vdcUyKkzqejjTouiWlpTmrMWoGvIFYhQ=;
 b=bv0IAh9STuHAypIkvz0L3/qpHLFUGdj4VRE2RacKzlhPxNS28eRychLlYgnYR3cCYEDTmIzuOjs3izeSxgpwO+PEIEj4DTV/mSIbZoBu3N2AdssQbPytZTkdfcl0b/a7PfWbusDRr/Ul4i9Gf2qvon4XLnugelyPdWDZgJUTbA8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB3014.eurprd08.prod.outlook.com (52.135.164.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 16:28:46 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d%5]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 16:28:46 +0000
Subject: Re: [PATCH v2 20/22] qemu-iotests/199: check persistent bitmaps
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-21-vsementsov@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <edb4bcd0-87de-ba20-0540-468d0450a504@virtuozzo.com>
Date: Wed, 19 Feb 2020 19:28:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200217150246.29180-21-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0304.eurprd05.prod.outlook.com
 (2603:10a6:7:93::35) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1PR05CA0304.eurprd05.prod.outlook.com (2603:10a6:7:93::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Wed, 19 Feb 2020 16:28:45 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 709216ff-14c9-4511-d3e0-08d7b558caa9
X-MS-TrafficTypeDiagnostic: AM6PR08MB3014:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3014F203F9D91DC64EAF38A7F4100@AM6PR08MB3014.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(39850400004)(396003)(376002)(366004)(346002)(199004)(189003)(478600001)(66946007)(66556008)(86362001)(36756003)(6486002)(26005)(16526019)(52116002)(4326008)(956004)(44832011)(31686004)(36916002)(2616005)(5660300002)(8936002)(81156014)(16576012)(8676002)(2906002)(316002)(31696002)(53546011)(81166006)(54906003)(66476007)(186003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3014;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZuMxZ7cQcfkvFhA2hOdP8Ej277BNp0e4xvr24RRZXWxw5pq4CzYPg5DARBE9M/Y90Wsupq8wvjZ0DY3hlVXvPXsDKdTW37187LsKccX8UiNsQIN9wwpWWdbObhnBb3k4Th5dkvNevF1h5xe2Q2Ey2VJINkoGdTztZuF10RAo7FzagvZR23WE4GrfzrkF0Dpq0dfqwwGUyeNJyXahqNgrtK1oU6lFFWAiEzEZ7G9yK1L7w9DwRjBbRFg4QalNLr+g5hXf6nBBmbvV76sBXi/Gj2sjAuK+gfUCZJFcXKmKIeVbM7/LJxEBJnQiLvG6S9oPMG/ryKAXyhmGmXexw6XdLBVv8s5zSmNzG8f1rYQC4R/dgdXTUtOnfMKn6fD67MEVpLpR5RfHluYiMPCSQQsXMiHcb/UugvYAR6VOPZoaFMYgcq8Tp4b5Li/gCdsYIiKE
X-MS-Exchange-AntiSpam-MessageData: VNapDkoxc6TfIimbCwtTcORUFUUQj4TZ8nY55Ld2fS+BEk0JrVcgo7GkmEVgd5wfKpUzm4o5Nxrg9IENEOCtVajD7A7JEIrKo/Hb96HDY2SiwY0jomIOuwhTaImJXJ23rF5mat+CfgZlqCpjHBymeA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 709216ff-14c9-4511-d3e0-08d7b558caa9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 16:28:45.9870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: brd1yJHGOLExRkhjWosv+xm6p9tm9LBVd6D/TybAulCyJtLnGytbPQmSfTn07fYgyGZUzM33L4dUsAuZjyZrRypYq2iySiQCDac0KrXjjtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3014
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.123
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
> Check that persistent bitmaps are not stored on source and that bitmaps
> are persistent on destination.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   tests/qemu-iotests/199 | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
> index 969620b103..8baa078151 100755
> --- a/tests/qemu-iotests/199
> +++ b/tests/qemu-iotests/199
> @@ -117,7 +117,8 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>           for i in range(nb_bitmaps):
>               result = self.vm_a.qmp('block-dirty-bitmap-add', node='drive0',
>                                      name='bitmap{}'.format(i),
> -                                   granularity=granularity)
> +                                   granularity=granularity,
> +                                   persistent=True)
>               self.assert_qmp(result, 'return', {})
>   
>           result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
> @@ -193,6 +194,19 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>               print('downtime:', downtime)
>               print('postcopy_time:', postcopy_time)
>   
> +        # check that there are no bitmaps stored on source
> +        self.vm_a_events += self.vm_a.get_qmp_events()
> +        self.vm_a.shutdown()
> +        self.vm_a.launch()
> +        check_bitmaps(self.vm_a, 0)
> +
> +        # check that bitmaps are migrated and persistence works
> +        check_bitmaps(self.vm_b, nb_bitmaps)
> +        self.vm_b.shutdown()
> +        # recreate vm_b, so there is no incoming option, which prevents
> +        # loading bitmaps from disk
> +        self.vm_b = iotests.VM(path_suffix='b').add_drive(disk_b)
> +        self.vm_b.launch()
>           check_bitmaps(self.vm_b, nb_bitmaps)
>   
>           # Check content of migrated bitmaps. Still, don't waste time checking
> 

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
-- 
With the best regards,
Andrey Shinkevich

