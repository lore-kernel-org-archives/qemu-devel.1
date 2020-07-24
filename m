Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A484C433E8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 07:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA5D02068F
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 07:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="A6EK4Ppb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5D02068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jysTq-0003WB-WE
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 03:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jysTC-0002vB-9x; Fri, 24 Jul 2020 03:50:18 -0400
Received: from mail-eopbgr80108.outbound.protection.outlook.com
 ([40.107.8.108]:55365 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jysT9-00019G-LR; Fri, 24 Jul 2020 03:50:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AW7heYoVFhwKPPI3yPHBHizAEJ6vkKjvwh7Lvw0S2OKcly2YYMszMMBgPgbQ5QlQWeE4Dd6RcHETYkrdPJn0/MDogAwCjjTs/AFdXSrTDMxGiQVaMAX3HC/P2E3cAfu9WeBkMqVjZHl0nE6NbfG11OJdrLoNzXkinrjfgRyqRk+/+3FSOObK3p2nD/sBcyhYVeareoU44dMFPhJSbo4dWPogabA9BqLOcyhU8llVDdVpgvvZULs2x6XZvrpQA/QoRpB2otN85ERa5aEjIjnxEcMJepgGPqe5PVSE3L3GBBllcmINYNHigA4PWqnJSDVSbXxKvmy6Lr5tHiXfnepcEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=752YTzeceA6UiRxVpnEzwPNiJhRWQJ1pHDGvqE9SHtI=;
 b=SZ79CD6S47eMnBb4M8jccsBpqd5vtIteoBMDMiCkLtKP1m1v2fITa9b7ktFyhq81UgSJLBPsY0pKnK6yLDNNJjo5Y3++Y3mt7MnIy3rBzf8/tfmEnRgapyBKoRrpol0gf/dRG0GrskA5L4NCYevGhZ2hN7+bpb+f6PZcMfbpgUi3MR8iaoeKzWIOgBrVc4bT82KeX/WeYHIJ9hxnjDBnhzu8Bc7X1vZnDK2gYeRDj336iNl/Opkr3o8vzyiJC7ZFb/jCM+7OWYoVSG8kSrqQ3ihb6tPNdA5cPa/aRAPzo4hHe1vIfoX14+5K6gzmJ68+QcNGRVzwz6aeeuOgwpIU5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=752YTzeceA6UiRxVpnEzwPNiJhRWQJ1pHDGvqE9SHtI=;
 b=A6EK4PpbRYqPNoj5Wr7tA0Bt1kk4z4TR3Hzm/VXanm9VgUNXlqIMRX7zNWp3HgU+sHvlOF6EoUj7cX1NB8ocF4ps0B3pSitw6Jd+s7dQnkgbJg8T/rBPSWb1Z79+HkXlGZafx7JOCqQ2GDeih8o5g2Vl1JwjZGmIyI5Ue0GcbLU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3957.eurprd08.prod.outlook.com (2603:10a6:20b:a2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18; Fri, 24 Jul
 2020 07:50:11 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 07:50:11 +0000
Subject: Re: [PATCH v2 22/22] qemu-iotests/199: add source-killed case to
 bitmaps postcopy
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-23-vsementsov@virtuozzo.com>
 <6874a389-9a21-4090-8856-e1f9c285ced5@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a4e59c75-2b21-ffae-b116-77d97f3f2012@virtuozzo.com>
Date: Fri, 24 Jul 2020 10:50:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <6874a389-9a21-4090-8856-e1f9c285ced5@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0008.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.156) by
 AM0PR02CA0008.eurprd02.prod.outlook.com (2603:10a6:208:3e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Fri, 24 Jul 2020 07:50:11 +0000
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e81c230f-478a-4024-d81b-08d82fa631a8
X-MS-TrafficTypeDiagnostic: AM6PR08MB3957:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3957A7B70898E262B5C7645DC1770@AM6PR08MB3957.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VVfG4A1uuNQRxmQZc4wj6LmZ0EJnYhBVQr6hjEuTPBwf0amBqqadz1GjBlkl36HOrMxDw4u0F80VVdoxC4pG+hjBMjTK1bAe5J/a3boeT3UuyOL6/y9L3OWUXUYu1HQZMjHtv3g2P7+wgRV/ZutR6CfH0tAp4P5L6lMoYXeXl9/xDdhZzgJnJhCf2RN5lzsxRNInh2A1AUviIMBcIqwTXjnNr6EG4j9aP53fXYmWQq9vqJeeX+wvm3GAj6Y+H8qHVwBsHWTljYqvH5DLOKtCdeyEyi+KAp1OpnV7Tma+NobfZ5GauI2Wocwj9/3dur2AacAMBqvBSzl2YlfctaUzTF/0mjxMwGRey00T0ZotNKxo22DwVSx1TlNErde9O38n
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39840400004)(376002)(366004)(346002)(396003)(26005)(186003)(478600001)(52116002)(31686004)(8676002)(8936002)(2616005)(86362001)(83380400001)(16526019)(53546011)(6486002)(31696002)(4326008)(956004)(5660300002)(66946007)(66556008)(66476007)(2906002)(54906003)(16576012)(316002)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 7ACNNIfd+Ygd7ZL3Tv2JRY84LSmOII+FoqRzZ86Bk4tjYa/A2Equw7+ToUr0ZSzfghpeGZ70X1StAzbk/13a6ozI1PF2I/f0wOyTiBXVBpDbZfCR7NbX9V9iIzlZ+ehycb71N8GzR0SmViUnMdtBrFGNwyLdrFbgg2P7QUgzBzSNktLhxiTcx5qT1RlFrJuwLNmc3a6U/kRVh68x11P6nQpTVHh5tr9lXdRnVBvzoCuBRJkQnlIraMJkLUJXLxpOo07pUHZ4jiQ1lFBMGlvbOI4jGpQOck8jFs4rwsmLEKcFhz2EN/LOTdMzUIR/vkM3csnlmQOCquTowjpocwWJD9nej888eYY+xvhV3qznu3mZrK64viP6vbed2tSOGvB9uHrlsLrccmy84OlfiE/uqguZ02rqLAHBPL97UmGNita+oJ7vSuWCvAYuVarx7h3noTveTzLvmuRvclfCsdXoQITpikHIODTYiNDscPr2poGQ109Gw7Sn4nMIaliZ+GRs
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e81c230f-478a-4024-d81b-08d82fa631a8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 07:50:11.8255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DpCrlZymvL+eG9z3kdUgtBSUWDqlDz/YJvpBlwNh50gtAD67B0EEfEAhRzvlYObtwLgrYWwofo6XXEakJ+qmxUvDeoH08YNk5toZgcHyvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3957
Received-SPF: pass client-ip=40.107.8.108;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 03:50:13
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

19.02.2020 20:15, Andrey Shinkevich wrote:
> On 17/02/2020 18:02, Vladimir Sementsov-Ogievskiy wrote:
>> Previous patches fixes behavior of bitmaps migration, so that errors
>> are handled by just removing unfinished bitmaps, and not fail or try to
>> recover postcopy migration. Add corresponding test.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/199     | 15 +++++++++++++++
>>   tests/qemu-iotests/199.out |  4 ++--
>>   2 files changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
>> index 0d12e6b1ae..d38913fa44 100755
>> --- a/tests/qemu-iotests/199
>> +++ b/tests/qemu-iotests/199
>> @@ -235,6 +235,21 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>>           self.vm_a.launch()
>>           check_bitmaps(self.vm_a, 0)
>> +    def test_early_kill_source(self):
>> +        self.start_postcopy()
>> +
>> +        self.vm_a_events = self.vm_a.get_qmp_events()
>> +        self.vm_a.kill()
>> +
>> +        self.vm_a.launch()
>> +
>> +        match = {'data': {'status': 'completed'}}
>> +        e_complete = self.vm_b.event_wait('MIGRATION', match=match)
> 
> A failed migration gets the status 'completed'. That misleads a user but is not in the scope of this series, I guess.

It's not failed. Only bitmaps are not migrated, which is not a problem.. Probably we should invent some additional status or QAPI event for this, but yes, not in this series.

> 
>> +        self.vm_b_events.append(e_complete)
>> +
>> +        check_bitmaps(self.vm_a, 0)
>> +        check_bitmaps(self.vm_b, 0)
>> +
>>   if __name__ == '__main__':
>>       iotests.main(supported_fmts=['qcow2'])
>> diff --git a/tests/qemu-iotests/199.out b/tests/qemu-iotests/199.out
>> index fbc63e62f8..8d7e996700 100644
>> --- a/tests/qemu-iotests/199.out
>> +++ b/tests/qemu-iotests/199.out
>> @@ -1,5 +1,5 @@
>> -..
>> +...
>>   ----------------------------------------------------------------------
>> -Ran 2 tests
>> +Ran 3 tests
>>   OK
>>
> 
> The updated test passed.
> 
> Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>


-- 
Best regards,
Vladimir

