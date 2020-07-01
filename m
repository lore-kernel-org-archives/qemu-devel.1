Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C42C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:23:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E03220781
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ByaxINXV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E03220781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqfWU-0006GY-EK
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 12:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqfPi-0006H7-Ol
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:16:46 -0400
Received: from mail-db8eur05on2112.outbound.protection.outlook.com
 ([40.107.20.112]:36576 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jqfPf-0007G7-10
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:16:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTnb91EbW1AaejQIcG2SZVQJuxXEFsJnTWh5opFrL85CmoRUzJCps5OENkDRq7U2Qi3QeRur8wlSJo4VrOAop9Z5NQWaFhOAYBIbODkFxQ3frs2aZ5YIPP8pVveBrxCy5iMteAxzz2ncWej73u+cv6+AOFpjzvz7K6mDwgdEqP8qokFvXfe158M7DkI6l5s/ktQ23GPJ4jmZFOKc08TEvGEWKJ21Nr2VWiGdYy6/iUdKsmjQswqKXtl0KW/NxAkKRicGmNCBw9z3yxsXvzH/db6Z0cEIrjtpczm9irNNxrotFZYXPlfYT0QoDiOmQFHi8BNf4sQ6F2/rOuI7j/CzyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbVHUlzjatvg6kCsVSZKrF/xW/hVzojVHwc6rRRO0/U=;
 b=IKtyulDXWlwKi6KLRj9W0S0Nki9otEGDekLDkhHWL8uZJBkE03aiDlBK/zK5ONmkWHbC5sK+w6TR3Wn61nkZR2GnqKQ8iAi7rF9dAQVDHdLHmAF1yyYl07cSYkwOATa64cfKTs+Ao3SvDEgZD8ABi9JJC8qIGLeCThNZ0U4mOhjH+KOsJPOzDt7UnUjcNo4b0UoT1m2iFDiFpPtbhyBke0n4hg6lYZjyyyyqKSpCEv38DhzNSGBfmBKa8jgT8M6oJY92x1dhj9x7v45LSQYU+XQQk+ZCjM/3EnBap7aw6ac5AqDJ70BL0XH7f7+LuoYMExVoQYCQgZDJfb0/aym+ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbVHUlzjatvg6kCsVSZKrF/xW/hVzojVHwc6rRRO0/U=;
 b=ByaxINXV8OwTr2zOv2hGMxa0fzUpBsguX53f+FATtSRKGB5nCnXz4ciS/b3qY77XiJkX2kWCQLxhajgoS/8eFNafAqZkExvPUyvNIYlpOSybTmVJ6W3viF47joz5iMFw8ISxqZxtEZfjpSYzMl9hyFK0BK2bCEm8IVmcDUzgl+4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5205.eurprd08.prod.outlook.com (2603:10a6:20b:ee::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Wed, 1 Jul
 2020 16:16:40 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3131.028; Wed, 1 Jul 2020
 16:16:40 +0000
Subject: Re: Properly quitting qemu immediately after failing migration
To: Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <0dce6c63-4b83-8b1a-6d00-07235f637997@redhat.com>
 <92ce741d-ef67-fbf9-a889-27d9ae218681@virtuozzo.com>
 <9eecca93-e7d9-d1da-7fcd-ee60978ec460@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <61a5c813-d638-3e03-05a6-a7b0c27cc834@virtuozzo.com>
Date: Wed, 1 Jul 2020 19:16:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <9eecca93-e7d9-d1da-7fcd-ee60978ec460@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR08CA0025.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::38) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.28) by
 AM0PR08CA0025.eurprd08.prod.outlook.com (2603:10a6:208:d2::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.21 via Frontend Transport; Wed, 1 Jul 2020 16:16:40 +0000
X-Originating-IP: [185.215.60.28]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e409b6b1-62d9-41b8-75c7-08d81dda232c
X-MS-TrafficTypeDiagnostic: AM6PR08MB5205:
X-Microsoft-Antispam-PRVS: <AM6PR08MB5205F0F7B0E13AE08410A65DC16C0@AM6PR08MB5205.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kXgd3wxIxtAWNw7VVtjQIF8fruDBw2ya5a67myqqCNCGTl+QKRgRu6q0qD1jGo01WpPYiYu36G7K2R2XP7QBnAIIBIgMe8eVWqT+utPhnGdh4WeJXbJRQOcJaUIT64QaeOctYtgjOx1g4dwGJHQfj0PNDb28tCEk3xYG/AeRhGnm95nrU7jhN+7QbUgyFeh7q/8ot+SuJ3fr8d4lrd2p62mzCq6ZMD/xZ1PKhJavlTGTqTxdEhMaQumTy1/xkOcy1OEcoDglGMWywVO7wBOlNUaHbGCgWo4ulqtDMyk7fQtBhCIUyQTLthuDpXqJ9VTG9sNKwr+qrKoWDC5dJE9dYJFj/TrqSq1Ox1UcxsHrZl0ML4djpKg8stTiy5lXKNBXYy+M1MfyCx3nWHylXWIb6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(39840400004)(136003)(396003)(31686004)(8676002)(16526019)(26005)(110136005)(31696002)(16576012)(66476007)(83380400001)(66946007)(66556008)(478600001)(316002)(186003)(36756003)(52116002)(8936002)(5660300002)(86362001)(6486002)(2616005)(956004)(53546011)(2906002)(14773001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: h3FcdC2lZAvuqaVgb8zFmi4WU8KK1wDeYQNKMHDFmz6Ev0la3rGqXBzMqZAUBBVhGKNxomAG9RuHnAlifLEHxsjsYNPYvOhFyizdrYxkYee5e+kVYnWc7jsJBV9xy15j+82SwbZvDb3yzfzA2m7x2Yg96Wlrl1OUSNJK7kEAwTdr/KygIXxQHq7mHDISYBlzajKESwhjql5hvEO7m4ptMjS7UDdH2Expset+ZbK4T1kVUALo/P/D8C2JdgASDl+shw3btdWGWHY2WIH1zc9Dlxph5KY2IsQmdmzyhCd7XJkdRFdiPdkHi395c3H1tn/kUGFqpNl8VRLN+gKZc2WEryjRnI2whAha3lKYYwGbrA4wQlxFoZAwlCOGDw1RRi2owXsBkwBWj8aYVWBrMI66NT/O0hv0tC0ZNg8MRvP0xz1JXzxb7RPRJYP5EbU2yqGUe0gyFYjZ8mGPg1RKuUDXdYVpkr7DaHKpcwHrY6eatUo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e409b6b1-62d9-41b8-75c7-08d81dda232c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 16:16:40.3933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E7xJ2nAYCBIBRKou51KQn3r/e41huJ03vtmXPpk3WmHew+DcpAaHHf2ld7HyAkOkaPTuVZSHebiQy/BW7T4c2wikTG5yQG++gQwEQzAsJLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5205
Received-SPF: pass client-ip=40.107.20.112;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 12:16:41
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

29.06.2020 18:00, Max Reitz wrote:
> On 29.06.20 16:18, Vladimir Sementsov-Ogievskiy wrote:
>> 29.06.2020 16:48, Max Reitz wrote:
>>> Hi,
>>>
>>> In an iotest, I’m trying to quit qemu immediately after a migration has
>>> failed.  Unfortunately, that doesn’t seem to be possible in a clean way:
>>> migrate_fd_cleanup() runs only at some point after the migration state
>>> is already “failed”, so if I just wait for that “failed” state and
>>> immediately quit, some cleanup functions may not have been run yet.
>>>
>>> This is a problem with dirty bitmap migration at least, because it
>>> increases the refcount on all block devices that are to be migrated, so
>>> if we don’t call the cleanup function before quitting, the refcount will
>>> stay elevated and bdrv_close_all() will hit an assertion because those
>>> block devices are still around after blk_remove_all_bs() and
>>> blockdev_close_all_bdrv_states().
>>>
>>> In practice this particular issue might not be that big of a problem,
>>> because it just means qemu aborts when the user intended to let it quit
>>> anyway.  But on one hand I could imagine that there are other clean-up
>>> paths that should definitely run before qemu quits (although I don’t
>>> know), and on the other, it’s a problem for my test.
>>>
>>> I tried working around the problem for my test by waiting on “Unable to
>>> write” appearing on stderr, because that indicates that
>>> migrate_fd_cleanup()’s error_report_err() has been reached.  But on one
>>> hand, that isn’t really nice, and on the other, it doesn’t even work
>>> when the failure is on the source side (because then there is no
>>> s->error for migrate_fd_cleanup() to report).
> 
> (I’ve now managed to work around it by invoking blockdev-del on a node
> affected by bitmap migration until it succeeds, because blockdev-del can
> only succeed once the bitmap migration code has dropped its reference to
> it.)
> 
>>> In all, I’m asking:
>>> (1) Is there a nice solution for me now to delay quitting qemu until the
>>> failed migration has been fully resolved, including the clean-up?
>>>
>>> (2) Isn’t it a problem if qemu crashes when you issue “quit” via QMP at
>>> the wrong time?  Like, maybe lingering subprocesses when using “exec”?
>>>
>>>
>>
>> I'll look more closely tomorrow, but as a short answer: try my series
>> "[PATCH v2 00/22] Fix error handling during bitmap postcopy" it
>> handles different problems around migration failures & qemu shutdown,
>> probably it will help.
> 
> Not, it doesn’t seem to.
> 
> I’m not sure what exactly that series addresses, but FWIW I’m hitting
> the problem in non-postcopy migration.  What my simplest reproducer does is:

Bitmaps migration is postcopy by nature (and it may not work without
migrate-start-postcopy, but work in most simple cases, as when we have
small bitmap data to migrate, it can migrate during migration downtime).
Most complicated part of the series were about postcopy. Still it fixes some other things.

It seems, that patch (see the second paragraph)
"[PATCH v2 10/22] migration/block-dirty-bitmap: cancel migration on shutdown"

>    If target is turned of prior to postcopy finished, target crashes
>    because busy bitmaps are found at shutdown.
>    Canceling incoming migration helps, as it removes all unfinished (and
>    therefore busy) bitmaps.

>    Similarly on source we crash in bdrv_close_all which asserts that all
>    bdrv states are removed, because bdrv states involved into dirty bitmap
>    migration are referenced by it. So, we need to cancel outgoing
>    migration as well.
     
should address exactly your issue.

> 
> On the source VM:
> 
> blockdev-add node-name='foo' driver='null-co'
> block-dirty-bitmap-add node='foo' name='bmap0'
> 
> (Launch destination VM with some -incoming, e.g.
> -incoming 'exec: cat /tmp/mig_file')
> 
> Both on source and destination:
> 
> migrate-set-capabilities capabilities=[
>      {capability='events', state=true},
>      {capability='dirty-bitmaps', state=true}
> ]
> 
> On source:
> 
> migrate uri='exec: cat > /tmp/mig_file'
> 
> Then wait for a MIGRATION event with data/status == 'failed', and then
> issue 'quit'.
> 
> Max
> 

Can you post exact reproducer iotest?

I've tried to reproduce by doing

diff --git a/tests/qemu-iotests/300 b/tests/qemu-iotests/300
index 621a60e179..eeec47f97f 100755
--- a/tests/qemu-iotests/300
+++ b/tests/qemu-iotests/300
@@ -94,23 +94,6 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
  
          self.assertEqual(status == 'completed', migration_success)
          if status == 'failed':
-            # Wait until the migration has been cleaned up
-            # (Otherwise, bdrv_close_all() will abort because the
-            # dirty bitmap migration code still holds a reference to
-            # the BDS)
-            # (Unfortunately, there does not appear to be a nicer way
-            # of waiting until a failed migration has been cleaned up)
-            timeout_msg = 'Timeout waiting for migration to be cleaned up'
-            with iotests.Timeout(30, timeout_msg):
-                while os.path.exists(mig_sock):
-                    pass
-
-                # Dropping src_node_name will only work once the
-                # bitmap migration code has released it
-                while 'error' in self.vm_a.qmp('blockdev-del',
-                                               node_name=self.src_node_name):
-                    pass
-
              return
  
          self.vm_a.wait_for_runstate('postmigrate')


with your iotest, but it doesn't reproduce for me.



-- 
Best regards,
Vladimir

