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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4D1C433E5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:52:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF71920714
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fpH6nyhR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF71920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyrZ5-0006nO-1I
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 02:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jyrXp-00050x-DS; Fri, 24 Jul 2020 02:51:01 -0400
Received: from mail-am6eur05on2097.outbound.protection.outlook.com
 ([40.107.22.97]:21664 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jyrXl-00011k-2v; Fri, 24 Jul 2020 02:51:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9m/6pKbPFItKlBrWyRCo8IBoGfqIL8WPS75N6UilDxpGeP7hMo0679upe/F7Qfc4psAMl7IBsy+5Iq2ICaVbP9QIHrZmfYAwsmk9GsX4TiabA0b5Esi779r8qLBm+Fpy9XQW6X+WVC66QXw8Pv7SaljyVWQ4DM+hHdgsYp+VITbsqE/C+L/1fPeJBRxRSg+3GCdX2YWgpbi0eFHv0Vv0E75f0kobAesHNynQUM3ZRlS3oDuEtETIlu12er2ENwaKB4JLeN96H/7mY9+4DWbVq4hzaRqKzqk2tov9fdzQU6W1nUJO/QXgGncpcwNGfG1A531t1BTmlbDC19W2vENAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhpGSrzgtbddaOeokZzLc1wqpz/2q7lRrUZkumFAkWg=;
 b=KqkDCuRcWM7O5F9vPxWyATIOJUCplg6DmJSxJ7o2wrzEdh/t1EWnsSUMgtcoANi+/zUsmReYVH8PWD2eic4l3NSKXK7nBnmxQqu7lGw2YkwWWyU5hQrAQPZsfClPflVVf9B83NPX9hFNQLKNXNb6hgs/NOMlhhIRi1eMb7KzrkxmuQq1nc9DJzFW0qeHxamrgxRGMeOznfWeEXt1zvJN4TaykYp46v01wufTP70xxcS8N3LofXWw632szUu2Li3zCJnuaYnPp2/rta2nFI/xZQCF2jvnl633oM+yl1KFCZGrCuP/GmJ3LLlH0hY/I13RHgJ+fm4Ew1RiYCgzr/PGXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhpGSrzgtbddaOeokZzLc1wqpz/2q7lRrUZkumFAkWg=;
 b=fpH6nyhRafI35VrBmJoiJDUyWWnAWZbY3fSLSUPYVAGQ4fQYBLR0s6DohXWGDIjy9U8N1Uij97ee/BKe8bixF5fQnN2F2jmcd+VX1t4u+psx1KOCW0FcwA6WKvuPW3qnODt0W76D9Ci6Zz75yerQWo8D3t2YQZgr37tKo0ACXho=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2420.eurprd08.prod.outlook.com (2603:10a6:203:9e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Fri, 24 Jul
 2020 06:50:53 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 06:50:53 +0000
Subject: Re: [PATCH v2 14/22] qemu-iotests/199: better catch postcopy time
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
 <20200217150246.29180-15-vsementsov@virtuozzo.com>
 <ef51a28c-c9d8-7dc3-e203-883f9f48fbad@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <254ebb7e-5b0f-a56d-8a40-27fb166c99fa@virtuozzo.com>
Date: Fri, 24 Jul 2020 09:50:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <ef51a28c-c9d8-7dc3-e203-883f9f48fbad@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0P190CA0016.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::26) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.156) by
 AM0P190CA0016.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Fri, 24 Jul 2020 06:50:52 +0000
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b15cd2fe-c6c4-47c0-11ac-08d82f9de87b
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2420:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2420253C755F76153142D112C1770@AM5PR0802MB2420.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q5FMCiTJLcmGSbwCfMFjjEZi/CSPVE9j7zV+7FQgJlIMA5n+3z1O0lHLtSIucZo9m3SRmyPhgA6Yh8BK7msc4N1KCShuxKeXosJbXtvD+U6abagzBVWp4XJDRGqiz1J88q7wRFa10Mwbalv8RTliGYGu0AWcNL0noDKx0Deu7BwbPjKYlg7ucsC/0zUQoURcqirWHkcQNli3YiBxRy3Vmw9JwKC12ZJG2yC3n18Zl/oP7u0WDuhaS9yiJdhuXYDa+yYdmawYw8za5j8LKUCs1mOsnhLO5igMK4CYWkxRwbjQyr5Xh4u49Yl9zEuu1EM5nuzhHgB4bcLom6ef/ufNK1kxaPMkI5QlOi1N1HJEft2UnHpm+4Nu6Y+XbAimvExf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(346002)(366004)(39840400004)(136003)(8936002)(16526019)(86362001)(8676002)(186003)(316002)(6486002)(16576012)(2906002)(83380400001)(31686004)(53546011)(54906003)(36756003)(31696002)(26005)(4326008)(66476007)(66556008)(66946007)(2616005)(956004)(5660300002)(478600001)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: G39WaEsUM9USusxliPyjtZk9A1KuYRzVFOQ51hE+O+YzDnerQ/QZ1uHXWOQqPfKOAUI2gYXi56JeP7pqPXmqa1hDiFVXR8eIjZ5EnaS8+Bt/wgHFyob9D4oOzoqdcj3Yb/SeI/yaZxd53beCeSb2LKwIQn2iLRb+6MXCt+SL69IlJybPJtwv2V38HKw0CAqkz2P6QrCx5UNfcrmjfu4nuGhYkDCjOrkoE2+xInw5LxsGLIx7SJ2pzjhsGGiBk3grox4h99D8QKONUWaEQ3lSAlvw0NV1z0hegYc4KSB1S3Bd2LrAitpsAq+en9f2GnlvYnjStqGrLsWq81yeKfrH0LccfmUnGc5cvTzan2Z1xoZIYKfzF/gua+KKy9kTVqMD72vxQXVr/Gh8GAMcd3uXlItz5KRyWPu2ipvMCLkZ/iH/3dDv17MiwsnT/AmSR3Z1MmED+EzmwvIro/iuC6IXUUespYqZ1X5O+tMN45VKIOuHdSlAVHHnIBwyGWK5izeq
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b15cd2fe-c6c4-47c0-11ac-08d82f9de87b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 06:50:53.1189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yzNqzcXf3MfAyvWGYiSoiagzvhHe2f6Oa3Pz3gXfN/Wv4NnLgMHo9zpqcfq0gu5sjJYlcrGvvimqouf947QUCWpzrMOCHFJQVETJFYHya3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2420
Received-SPF: pass client-ip=40.107.22.97;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 02:50:53
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

19.02.2020 16:16, Andrey Shinkevich wrote:
> On 17/02/2020 18:02, Vladimir Sementsov-Ogievskiy wrote:
>> The test aims to test _postcopy_ migration, and wants to do some write
>> operations during postcopy time.
>>
>> Test considers migrate status=complete event on source as start of
>> postcopy. This is completely wrong, completion is completion of the
>> whole migration process. Let's instead consider destination start as
>> start of postcopy, and use RESUME event for it.
>>
>> Next, as migration finish, let's use migration status=complete event on
>> target, as such method is closer to what libvirt or another user will
>> do, than tracking number of dirty-bitmaps.
>>
>> Finally, add a possibility to dump events for debug. And if
>> set debug to True, we see, that actual postcopy period is very small
>> relatively to the whole test duration time (~0.2 seconds to >40 seconds
>> for me). This means, that test is very inefficient in what it supposed
>> to do. Let's improve it in following commits.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/199 | 72 +++++++++++++++++++++++++++++++++---------
>>   1 file changed, 57 insertions(+), 15 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
>> index dda918450a..6599fc6fb4 100755
>> --- a/tests/qemu-iotests/199
>> +++ b/tests/qemu-iotests/199
>> @@ -20,17 +20,43 @@
>>   import os
>>   import iotests
>> -import time
>>   from iotests import qemu_img
>> +debug = False
>> +
>>   disk_a = os.path.join(iotests.test_dir, 'disk_a')
>>   disk_b = os.path.join(iotests.test_dir, 'disk_b')
>>   size = '256G'
>>   fifo = os.path.join(iotests.test_dir, 'mig_fifo')
>> +def event_seconds(event):
>> +    return event['timestamp']['seconds'] + \
>> +        event['timestamp']['microseconds'] / 1000000.0
>> +
>> +
>> +def event_dist(e1, e2):
>> +    return event_seconds(e2) - event_seconds(e1)
>> +
>> +
>>   class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>>       def tearDown(self):
> It's common to put the definition of setUp() ahead

Preexisting, I don't want to update it in this patch

> 
>> +        if debug:
>> +            self.vm_a_events += self.vm_a.get_qmp_events()
>> +            self.vm_b_events += self.vm_b.get_qmp_events()
>> +            for e in self.vm_a_events:
>> +                e['vm'] = 'SRC'
>> +            for e in self.vm_b_events:
>> +                e['vm'] = 'DST'
>> +            events = (self.vm_a_events + self.vm_b_events)
>> +            events = [(e['timestamp']['seconds'],
>> +                       e['timestamp']['microseconds'],
>> +                       e['vm'],
>> +                       e['event'],
>> +                       e.get('data', '')) for e in events]
>> +            for e in sorted(events):
>> +                print('{}.{:06} {} {} {}'.format(*e))
>> +
>>           self.vm_a.shutdown()
>>           self.vm_b.shutdown()
>>           os.remove(disk_a)
>> @@ -47,6 +73,10 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>>           self.vm_a.launch()
>>           self.vm_b.launch()
>> +        # collect received events for debug
>> +        self.vm_a_events = []
>> +        self.vm_b_events = []
>> +
>>       def test_postcopy(self):
>>           write_size = 0x40000000
>>           granularity = 512
>> @@ -77,15 +107,13 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>>               self.vm_a.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
>>               s += 0x10000
>> -        bitmaps_cap = {'capability': 'dirty-bitmaps', 'state': True}
>> -        events_cap = {'capability': 'events', 'state': True}
>> +        caps = [{'capability': 'dirty-bitmaps', 'state': True},
> The name "capabilities" would be an appropriate identifier.

This will result in following lines growing and not fit into one line. I'll leave
"caps". Also, they are called "caps" in iotest 169 and in migration.c. And here in the
context always used together with full word ('capability': or capabilities=).

> 
>> +                {'capability': 'events', 'state': True}]
>> -        result = self.vm_a.qmp('migrate-set-capabilities',
>> -                               capabilities=[bitmaps_cap, events_cap])
>> +        result = self.vm_a.qmp('migrate-set-capabilities', capabilities=caps)
>>           self.assert_qmp(result, 'return', {})
>> -        result = self.vm_b.qmp('migrate-set-capabilities',
>> -                               capabilities=[bitmaps_cap])
>> +        result = self.vm_b.qmp('migrate-set-capabilities', capabilities=caps)
>>           self.assert_qmp(result, 'return', {})
>>           result = self.vm_a.qmp('migrate', uri='exec:cat>' + fifo)
>> @@ -94,24 +122,38 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
>>           result = self.vm_a.qmp('migrate-start-postcopy')
>>           self.assert_qmp(result, 'return', {})
>> -        while True:
>> -            event = self.vm_a.event_wait('MIGRATION')
>> -            if event['data']['status'] == 'completed':
>> -                break
>> +        e_resume = self.vm_b.event_wait('RESUME')
> "event_resume" gives a faster understanding

OK, no problem

> 
>> +        self.vm_b_events.append(e_resume)
>>           s = 0x8000
>>           while s < write_size:
>>               self.vm_b.hmp_qemu_io('drive0', 'write %d %d' % (s, chunk))
>>               s += 0x10000
>> +        match = {'data': {'status': 'completed'}}
>> +        e_complete = self.vm_b.event_wait('MIGRATION', match=match)
> "event_complete" also

OK

> 
>> +        self.vm_b_events.append(e_complete)
>> +
>> +        # take queued event, should already been happened
>> +        e_stop = self.vm_a.event_wait('STOP')
> "event_stop"

OK

> 
>> +        self.vm_a_events.append(e_stop)
>> +
>> +        downtime = event_dist(e_stop, e_resume)
>> +        postcopy_time = event_dist(e_resume, e_complete)
>> +
>> +        # TODO: assert downtime * 10 < postcopy_time
> 
> I got the results below in debug mode:
> 
> downtime: 6.194924831390381
> postcopy_time: 0.1592559814453125
> 1582102669.764919 SRC MIGRATION {'status': 'setup'}
> 1582102669.766179 SRC MIGRATION_PASS {'pass': 1}
> 1582102669.766234 SRC MIGRATION {'status': 'active'}
> 1582102669.768058 DST MIGRATION {'status': 'active'}
> 1582102669.801422 SRC MIGRATION {'status': 'postcopy-active'}
> 1582102669.801510 SRC STOP
> 1582102675.990041 DST MIGRATION {'status': 'postcopy-active'}
> 1582102675.996435 DST RESUME
> 1582102676.111313 SRC MIGRATION {'status': 'completed'}
> 1582102676.155691 DST MIGRATION {'status': 'completed'}
> 
>> +        if debug:
> with no usage in the following patches, you can put the whole block of relative code above under the "if debug: section
> 
>> +            print('downtime:', downtime)
>> +            print('postcopy_time:', postcopy_time)
>> +
>> +        # Assert that bitmap migration is finished (check that successor bitmap
>> +        # is removed)
>>           result = self.vm_b.qmp('query-block')
>> -        while len(result['return'][0]['dirty-bitmaps']) > 1:
>> -            time.sleep(2)
>> -            result = self.vm_b.qmp('query-block')
>> +        assert len(result['return'][0]['dirty-bitmaps']) == 1
>> +        # Check content of migrated (and updated by new writes) bitmap
>>           result = self.vm_b.qmp('x-debug-block-dirty-bitmap-sha256',
>>                                  node='drive0', name='bitmap')
>> -
>>           self.assert_qmp(result, 'return/sha256', sha256)
>>
> 
> Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

Thanks!

-- 
Best regards,
Vladimir

