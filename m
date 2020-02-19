Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927C1C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 13:19:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D7D721D56
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 13:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OZmL59T0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D7D721D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4PGZ-0008Aa-H0
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 08:19:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4PDe-0005Vm-IM
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:17:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1j4PDd-0006kV-3G
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:16:50 -0500
Received: from mail-eopbgr10112.outbound.protection.outlook.com
 ([40.107.1.112]:63150 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1j4PDR-0006cF-UG; Wed, 19 Feb 2020 08:16:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SI2KJ0lRsNI8ZPlunWoNmkF0nXnniup/fkZNZ3HDclEQ3uFKqE109Ct90QtNHcfwvjTUxWXnUlI789hC8/s12UCzBcaPCqxc8OrHuiIUmVUESGRAlXvw0G/61Dtd+Q+SRjY5lYYGLNJ+pkElWV77zRqzjrOd5VZEYGtKQBpwk1VjeTPrzE13ADwL5pWe5NtVu8GkFW5bhnolNZXPc/NN6sRADMAfcRWyPiz8ypSg5dLjdqSAUzUkiPSK5N8LZfq26nPhXfbaSJIwu9bCOvqpG46tYwTvHKvVbjcDg71UfF2sruJSBy8SB+mRrhPDS0JwoLIbES3s4UBAv9AMwmLZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ScgkLBeYCI3R4bjjjGUOjvh+BpS4+/liaUz0YWvnRA=;
 b=h8U2kONqJFZL0Sdl7UwfDEubHkATHg7uRYgJEQOnAbfK7Wd0aPJoTdiiHxwJvJsu3Pwj2HQmyyewg+JdxUFyX3JePKEgEENoLFaRddvjvbs1KsCKMGCXTknD03M02pDz05AjdDD1AaITG4b104746erYSO9TntDtdCui5c6AJW+Mc3BW+G6ULE0JgtLBpAxGuc9bFvDw25v0vlWEFkd6G2buffHinoQMu605rRvIYO6HltSVbXss2lONiu876EJawWRMk0af3oy4iMTLeEXG8dge8Z8FN3TkD0WHWan+/aICqtFzfcVZKj44RkDPq90hhds9ULCZpzhoz3L1jDKPVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ScgkLBeYCI3R4bjjjGUOjvh+BpS4+/liaUz0YWvnRA=;
 b=OZmL59T0+9Fu1ZssNWZOmXnA0b8B/Vbo60w3Biya28yfGlr67hkncrRM59+OllnlN/2GBcXkVPy3T6A0bYndHN0FK6gKOYbzy8kqdCk75JKMrcnr8NDeUMaXk1qeUpxb2KY1gpgp6YRk2EuszBLXaOOSOrT21Zptp03/hOoQKwM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com (10.255.123.95) by
 AM6PR08MB3656.eurprd08.prod.outlook.com (20.177.116.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.31; Wed, 19 Feb 2020 13:16:30 +0000
Received: from AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d]) by AM6PR08MB5048.eurprd08.prod.outlook.com
 ([fe80::1883:da16:865a:139d%5]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 13:16:30 +0000
Subject: Re: [PATCH v2 14/22] qemu-iotests/199: better catch postcopy time
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-15-vsementsov@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Organization: Virtuozzo
Message-ID: <ef51a28c-c9d8-7dc3-e203-883f9f48fbad@virtuozzo.com>
Date: Wed, 19 Feb 2020 16:16:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200217150246.29180-15-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0307.eurprd05.prod.outlook.com
 (2603:10a6:7:93::38) To AM6PR08MB5048.eurprd08.prod.outlook.com
 (2603:10a6:20b:ee::31)
MIME-Version: 1.0
Received: from [172.16.24.225] (185.231.240.5) by
 HE1PR05CA0307.eurprd05.prod.outlook.com (2603:10a6:7:93::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25 via Frontend Transport; Wed, 19 Feb 2020 13:16:29 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b15f374c-ee78-4324-af0d-08d7b53deec3
X-MS-TrafficTypeDiagnostic: AM6PR08MB3656:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3656B500084FF82A3542127AF4100@AM6PR08MB3656.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:299;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(39850400004)(396003)(376002)(366004)(346002)(189003)(199004)(31696002)(26005)(6486002)(36756003)(186003)(86362001)(478600001)(4326008)(31686004)(16526019)(53546011)(5660300002)(316002)(81156014)(66946007)(2906002)(8676002)(81166006)(44832011)(2616005)(956004)(36916002)(54906003)(66556008)(52116002)(16576012)(8936002)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3656;
 H:AM6PR08MB5048.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K7nRlg+mCxgacWQiXHDwDUqpjW7Dh1IsUSSxHsst6aiZJGos8gDM4JdH4/iA+UkM+lW+4zHjFtoffXqvW85BcTQAIwWVzuPTtPPl5MZCf+geordIyqLLhTrMkXLE34UDB6Frc0K7Jy/vIKp1akeNDi61yK7wER/QoBkNLaBJqokNlqtc/JgI17ELk6xVoZGbctoO2joiq9xRNatiqUzreW/ljhJdYEMbnwceqfwDiN9rqFDhWDWSNaFElTIS5UdpuuWvPMvHja4RxQq/AE7sPnf6cCv3wk8w7afBSH7r7X3e1fDGnFN69R9Pctgn7A59KE8y77k1rNu+rZCWfWcYL0DApc2OBZt06KoyNRS4HZMK0PE+5WUemxdo1U4cM9TtONVb6QXB3ogiKdsKvoAyiqzi1PINZ4iiHy1ViWWfxQfrEqvWRroPmaqR8YNXfxFE
X-MS-Exchange-AntiSpam-MessageData: Iyww3jLXpGFhhL21RpQs4HLPTuX6lkcPZ6QQQiukX1Ae80GPrnPcJzKzKpC66wdVoF9j5ZdcQ6GJ/t7a0alqrhcYWVb/ZWNUBz2BRDsTjKito44udhQd13Tw8ac9UvpqKgb9nFoXepSi45Jht/n1AQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b15f374c-ee78-4324-af0d-08d7b53deec3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 13:16:30.2037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KE5Rt4OFe4rsvA+ehXtX4qChse7N9D2Ka94KuogIyzTGL0D6j80L4vcCUQzpSEnOZyRThzZCweYdUGvSY3evg2ltZ0gZkFRz6UYEgeSzOk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3656
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.112
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
> The test aims to test _postcopy_ migration, and wants to do some write
> operations during postcopy time.
> 
> Test considers migrate status=complete event on source as start of
> postcopy. This is completely wrong, completion is completion of the
> whole migration process. Let's instead consider destination start as
> start of postcopy, and use RESUME event for it.
> 
> Next, as migration finish, let's use migration status=complete event on
> target, as such method is closer to what libvirt or another user will
> do, than tracking number of dirty-bitmaps.
> 
> Finally, add a possibility to dump events for debug. And if
> set debug to True, we see, that actual postcopy period is very small
> relatively to the whole test duration time (~0.2 seconds to >40 seconds
> for me). This means, that test is very inefficient in what it supposed
> to do. Let's improve it in following commits.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   tests/qemu-iotests/199 | 72 +++++++++++++++++++++++++++++++++---------
>   1 file changed, 57 insertions(+), 15 deletions(-)
> 
> diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
> index dda918450a..6599fc6fb4 100755
> --- a/tests/qemu-iotests/199
> +++ b/tests/qemu-iotests/199
> @@ -20,17 +20,43 @@
>   
>   import os
>   import iotests
> -import time
>   from iotests import qemu_img
>   
> +debug = False
> +
>   disk_a = os.path.join(iotests.test_dir, 'disk_a')
>   disk_b = os.path.join(iotests.test_dir, 'disk_b')
>   size = '256G'
>   fifo = os.path.join(iotests.test_dir, 'mig_fifo')
>   
>   
> +def event_seconds(event):
> +    return event['timestamp']['seconds'] + \
> +        event['timestamp']['microseconds'] / 1000000.0
> +
> +
> +def event_dist(e1, e2):
> +    return event_seconds(e2) - event_seconds(e1)
> +
> +
>   class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>       def tearDown(self):
It's common to put the definition of setUp() ahead

> +        if debug:
> +            self.vm_a_events += self.vm_a.get_qmp_events()
> +            self.vm_b_events += self.vm_b.get_qmp_events()
> +            for e in self.vm_a_events:
> +                e['vm'] = 'SRC'
> +            for e in self.vm_b_events:
> +                e['vm'] = 'DST'
> +            events = (self.vm_a_events + self.vm_b_events)
> +            events = [(e['timestamp']['seconds'],
> +                       e['timestamp']['microseconds'],
> +                       e['vm'],
> +                       e['event'],
> +                       e.get('data', '')) for e in events]
> +            for e in sorted(events):
> +                print('{}.{:06} {} {} {}'.format(*e))
> +
>           self.vm_a.shutdown()
>           self.vm_b.shutdown()
>           os.remove(disk_a)
> @@ -47,6 +73,10 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>           self.vm_a.launch()
>           self.vm_b.launch()
>   
> +        # collect received events for debug
> +        self.vm_a_events = []
> +        self.vm_b_events = []
> +
>       def test_postcopy(self):
>           write_size = 0x40000000
>           granularity = 512
> @@ -77,15 +107,13 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>               self.vm_a.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
>               s += 0x10000
>   
> -        bitmaps_cap = {'capability': 'dirty-bitmaps', 'state': True}
> -        events_cap = {'capability': 'events', 'state': True}
> +        caps = [{'capability': 'dirty-bitmaps', 'state': True},
The name "capabilities" would be an appropriate identifier.

> +                {'capability': 'events', 'state': True}]
>   
> -        result = self.vm_a.qmp('migrate-set-capabilities',
> -                               capabilities=[bitmaps_cap, events_cap])
> +        result = self.vm_a.qmp('migrate-set-capabilities', capabilities=caps)
>           self.assert_qmp(result, 'return', {})
>   
> -        result = self.vm_b.qmp('migrate-set-capabilities',
> -                               capabilities=[bitmaps_cap])
> +        result = self.vm_b.qmp('migrate-set-capabilities', capabilities=caps)
>           self.assert_qmp(result, 'return', {})
>   
>           result = self.vm_a.qmp('migrate', uri='exec:cat>' + fifo)
> @@ -94,24 +122,38 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>           result = self.vm_a.qmp('migrate-start-postcopy')
>           self.assert_qmp(result, 'return', {})
>   
> -        while True:
> -            event = self.vm_a.event_wait('MIGRATION')
> -            if event['data']['status'] == 'completed':
> -                break
> +        e_resume = self.vm_b.event_wait('RESUME')
"event_resume" gives a faster understanding

> +        self.vm_b_events.append(e_resume)
>   
>           s = 0x8000
>           while s < write_size:
>               self.vm_b.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
>               s += 0x10000
>   
> +        match = {'data': {'status': 'completed'}}
> +        e_complete = self.vm_b.event_wait('MIGRATION', match=match)
"event_complete" also

> +        self.vm_b_events.append(e_complete)
> +
> +        # take queued event, should already been happened
> +        e_stop = self.vm_a.event_wait('STOP')
"event_stop"

> +        self.vm_a_events.append(e_stop)
> +
> +        downtime = event_dist(e_stop, e_resume)
> +        postcopy_time = event_dist(e_resume, e_complete)
> +
> +        # TODO: assert downtime * 10 < postcopy_time

I got the results below in debug mode:

downtime: 6.194924831390381
postcopy_time: 0.1592559814453125
1582102669.764919 SRC MIGRATION {'status': 'setup'}
1582102669.766179 SRC MIGRATION_PASS {'pass': 1}
1582102669.766234 SRC MIGRATION {'status': 'active'}
1582102669.768058 DST MIGRATION {'status': 'active'}
1582102669.801422 SRC MIGRATION {'status': 'postcopy-active'}
1582102669.801510 SRC STOP
1582102675.990041 DST MIGRATION {'status': 'postcopy-active'}
1582102675.996435 DST RESUME
1582102676.111313 SRC MIGRATION {'status': 'completed'}
1582102676.155691 DST MIGRATION {'status': 'completed'}

> +        if debug:
with no usage in the following patches, you can put the whole block of 
relative code above under the "if debug: section

> +            print('downtime:', downtime)
> +            print('postcopy_time:', postcopy_time)
> +
> +        # Assert that bitmap migration is finished (check that successor bitmap
> +        # is removed)
>           result = self.vm_b.qmp('query-block')
> -        while len(result['return'][0]['dirty-bitmaps']) > 1:
> -            time.sleep(2)
> -            result = self.vm_b.qmp('query-block')
> +        assert len(result['return'][0]['dirty-bitmaps']) == 1
>   
> +        # Check content of migrated (and updated by new writes) bitmap
>           result = self.vm_b.qmp('x-debug-block-dirty-bitmap-sha256',
>                                  node='drive0', name='bitmap')
> -
>           self.assert_qmp(result, 'return/sha256', sha256)
>   
>   
> 

Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
-- 
With the best regards,
Andrey Shinkevich

