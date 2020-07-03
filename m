Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4D5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:30:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB31C206A1
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ck+BAMN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB31C206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrPVl-0007dP-3r
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jrPV0-0006qd-9R; Fri, 03 Jul 2020 13:29:18 -0400
Received: from mail-eopbgr150090.outbound.protection.outlook.com
 ([40.107.15.90]:50059 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jrPUx-0005kb-DB; Fri, 03 Jul 2020 13:29:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gE6XXewzbN2ILMx0Q1FlLomz71n387NsF/8mzjS0qK5SSJc3NOtsiw7KHl8Xg2HsHJTJwWjLRXvRB2kAfkTgrbRsMsm2y8ZKRcyDyCbie2THPyuSnVmkv6gAc789RzjpXtMAEB7sErfyawBYxtOIqA3DKoJwzRRoL4Ud/QeXSy+99wmYTKKGOHmZpoah2oFSkzgTK93wAfTvYrSWycGnrqC3+ZaDAzHqxnwU0PPnI4H2eqEMLPHIBlY8OHQCYWAZzv+SdIuF/pqNVcA+8YlfO3SYCRpr6VcfRgtpipad85/uhRMpG2kdxksK47sOx2h5q2ZwI6NOnqpjekJxO6KRgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuR04kbUm6Ju4zn7qYa2hF+cxEGz/pFveg3nSw5Egxc=;
 b=leN9VwSVOp2VZDv6DcayzL1akNB3klgU5I/AEzbvSi7sl75Dw7OWBvcnUQ1Ul7h1ZP/WMCEjTYjUjpd4Rb/8WsFq+4OxF2KyjRZ6K2GURl99DHHypNZ8Qpk42uGrfUcnjzBYZng6rFo9Aj/EAXLxmNdMBtbljnRwMWkDJSKO2x33bWLoVS5U/OBCEK0TUBLY9jLKEwZWaIDBuh0A/sC/t36oOJ//sggyV+VEO49BLsOn+FTxpvoryLOIBPr/bz4pK1JMS5VYm8HCOFdcEoSeaC70bGj/PwovPpg7SjoafBROASDHH/RCOWxWsWm0RzHDV9kma+2pQk9p1mhHb2vEQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuR04kbUm6Ju4zn7qYa2hF+cxEGz/pFveg3nSw5Egxc=;
 b=ck+BAMN3j6EqHH2yCTGhwvFipTPS8LOWqQF4zWtp5Fip/u4TqhMDNt6l3QN8tLeaqSMAGC90G2WjqyBnb39NhtOb2anLOK4QbQrQNIMWqxZ092FE3/qPySRz1ObroKn+5TTpmRl5fZjOLXY8NN/VSIh5jNWBi0apj5PI4BYPCq4=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB4600.eurprd08.prod.outlook.com (2603:10a6:20b:84::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Fri, 3 Jul
 2020 17:29:11 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8%4]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 17:29:11 +0000
Subject: Re: [PATCH 0/6] migration: bring savevm/loadvm/delvm over to QMP
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200702175754.2211821-1-berrange@redhat.com>
 <a747fcd4-d87e-8124-a988-f3ae678c856e@virtuozzo.com>
 <20200703172224.GT2213227@redhat.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
Message-ID: <a8015fd3-e73e-c70e-9ba7-fa1bc047a1c2@virtuozzo.com>
Date: Fri, 3 Jul 2020 20:29:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200703172224.GT2213227@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HE1P192CA0003.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::13)
 To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 HE1P192CA0003.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20 via Frontend Transport; Fri, 3 Jul 2020 17:29:10 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cf12d9f-2207-4260-1529-08d81f769951
X-MS-TrafficTypeDiagnostic: AM6PR08MB4600:
X-Microsoft-Antispam-PRVS: <AM6PR08MB460095B45B8A4E436128D1F5B66A0@AM6PR08MB4600.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7JBNtltFeIz1YMeoymBsXZCp33aZHKdll/dsZiw5zs/6siIoaOFiSrQMTaBCmKWIgCkoLW/JJLY5wjkfWahUtNSfwHcR/EO23jLWkxiZFV3lI6yvE094IMtD+dA+PvFzH5T2Sc00kpki5ruZUqXLjrKhiK0bQ31UWwE4R27cuJOGKXJQpx4trr8Rl0G3UUja91lHoOpjJoDjsliiyPjgOrD0MqpMPJiIFxDlkkVYVFh4fLxRDc0ZKBzvdVIPZ9nYZPsID/Gi1iuYF37yOsP+3D+Iabx0R8eDKKz3KnduStDd8GxMc1xuBkHy0A0UTmfsixfOKjQwxfvAgXgs3fRi2K/z9W+VcgH6kHYJmvT1GM3LjHP5CplEcT1qh5XjUckJIp2SLlvlbAo8pLsTPM+tV9jmsDp28wup9M1frEUy0yV4SM7+reA14/ZiRaus32EyGKE1Yozt1ECmYAICXgAu2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(396003)(39850400004)(136003)(7416002)(53546011)(36756003)(26005)(186003)(6486002)(16526019)(966005)(5660300002)(8936002)(478600001)(4326008)(8676002)(83380400001)(2906002)(66476007)(31696002)(86362001)(66556008)(66946007)(6916009)(31686004)(16576012)(52116002)(54906003)(2616005)(316002)(956004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: lSglAmnnGew/Yfvlf4Jglm76PwwfpR8DMqAdSd14MeyIFywgitAeboumKiQCVQLA9RSYw/X1yQaKnZdEjvLg0LNFCjmJAWAop5pIMZNxLL9yiXKGoPVWu6eeak8+N2pdZthOQIteH7qMFmeFh7/qxYdlDo/mcOR3odUx2OeYHl4lG2WXhAnMPmZ8iz/01Wkegzvfr0TKp7iaUF68T5MjhYrnzm+2FZzV/gVLMzZ6x0i61hANs18e3//1UiRHLxdOTIJ9OSw8GuffCUmg10OrGhjypWxFuB3LNksFPf8XRGzMEoXqdLaolihvxddeCdUw4oL/i5/XC/BoZNFnRNCeoK2zrMZMowgLbNGnxHOoikwTvVdapSCBC4XEIA/KNPK98T3EFCJkU2jwfHgPgE0F7ffBe/NGayBpnqWkbol9zMpx2tVPofTGay0fcFBNwigNDn4uiN+tf5WU8rCXubQT+1qr3olw5IN3pFmz4r+FWTj8UovDoU5NHIGXJ3Jet9Qf
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf12d9f-2207-4260-1529-08d81f769951
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4214.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 17:29:11.3354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/8NOV5XghEI24oz5JraMxUGUBKVJunpA3qYiSVH/LNtOTAAm3Ox5XPsvW+OJELJDcLOzJpmo6NfHRRPkpV4QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4600
Received-SPF: pass client-ip=40.107.15.90; envelope-from=den@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 13:29:12
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/20 8:22 PM, Daniel P. Berrangé wrote:
> On Fri, Jul 03, 2020 at 08:15:44PM +0300, Denis V. Lunev wrote:
>> On 7/2/20 8:57 PM, Daniel P. Berrangé wrote:
>>> When QMP was first introduced some 10+ years ago now, the snapshot
>>> related commands (savevm/loadvm/delvm) were not converted. This was
>>> primarily because their implementation causes blocking of the thread
>>> running the monitor commands. This was (and still is) considered
>>> undesirable behaviour both in HMP and QMP.
>>>
>>> In theory someone was supposed to fix this flaw at some point in the
>>> past 10 years and bring them into the QMP world. Sadly, thus far it
>>> hasn't happened as people always had more important things to work
>>> on. Enterprise apps were much more interested in external snapshots
>>> than internal snapshots as they have many more features.
>>>
>>> Meanwhile users still want to use internal snapshots as there is
>>> a certainly simplicity in having everything self-contained in one
>>> image, even though it has limitations. Thus the apps that end up
>>> executing the savevm/loadvm/delvm via the "human-monitor-command"
>>> QMP command.
>>>
>>>
>>> IOW, the problematic blocking behaviour that was one of the reasons
>>> for not having savevm/loadvm/delvm in QMP is experienced by applications
>>> regardless. By not portting the commands to QMP due to one design flaw,
>>> we've forced apps and users to suffer from other design flaws of HMP (
>>> bad error reporting, strong type checking of args, no introspection) for
>>> an additional 10 years. This feels rather sub-optimal :-(
>>>
>>> In practice users don't appear to care strongly about the fact that these
>>> commands block the VM while they run. I might have seen one bug report
>>> about it, but it certainly isn't something that comes up as a frequent
>>> topic except among us QEMU maintainers. Users do care about having
>>> access to the snapshot feature.
>>>
>>> Where I am seeing frequent complaints is wrt the use of OVMF combined
>>> with snapshots which has some serious pain points. This is getting worse
>>> as the push to ditch legacy BIOS in favour of UEFI gain momentum both
>>> across OS vendors and mgmt apps. Solving it requires new parameters to
>>> the commands, but doing this in HMP is super unappealing.
>>>
>>>
>>>
>>> After 10 years, I think it is time for us to be a little pragmatic about
>>> our handling of snapshots commands. My desire is that libvirt should never
>>> use "human-monitor-command" under any circumstances, because of the
>>> inherant flaws in HMP as a protocol for machine consumption. If there
>>> are flaws in QMP commands that's fine. If we fix them in future, we can
>>> deprecate the current QMP commands and remove them not too long after,
>>> without being locked in forever.
>>>
>>>
>>> Thus in this series I'm proposing a direct 1-1 mapping of the existing
>>> HMP commands for savevm/loadvm/delvm into QMP as a first step. This does
>>> not solve the blocking thread problem, but it does eliminate the error
>>> reporting, type checking and introspection problems inherant to HMP.
>>> We're winning on 3 out of the 4 long term problems.
>>>
>>> If someone can suggest a easy way to fix the thread blocking problem
>>> too, I'd be interested to hear it. If it involves a major refactoring
>>> then I think user are better served by unlocking what look like easy
>>> wins today.
>>>
>>> With a QMP variant, we reasonably deal with the problems related to OVMF:
>>>
>>>  - The logic to pick which disk to store the vmstate in is not
>>>    satsifactory.
>>>
>>>    The first block driver state cannot be assumed to be the root disk
>>>    image, it might be OVMF varstore and we don't want to store vmstate
>>>    in there.
>>>
>>>  - The logic to decide which disks must be snapshotted is hardwired
>>>    to all disks which are writable
>>>
>>>    Again with OVMF there might be a writable varstore, but this can be
>>>    raw rather than qcow2 format, and thus unable to be snapshotted.
>>>    While users might wish to snapshot their varstore, in some/many/most
>>>    cases it is entirely uneccessary. Users are blocked from snapshotting
>>>    their VM though due to this varstore.
>>>
>>> These are solved by adding two parameters to the commands. The first is
>>> a block device node name that identifies the image to store vmstate in,
>>> and the second is a list of node names to exclude from snapshots.
>>>
>>> In the block code I've only dealt with node names for block devices, as
>>> IIUC, this is all that libvirt should need in the -blockdev world it now
>>> lives in. IOW, I've made not attempt to cope with people wanting to use
>>> these QMP commands in combination with -drive args.
>>>
>>> I've done some minimal work in libvirt to start to make use of the new
>>> commands to validate their functionality, but this isn't finished yet.
>>>
>>> My ultimate goal is to make the GNOME Boxes maintainer happy again by
>>> having internal snapshots work with OVMF:
>>>
>>>   https://gitlab.gnome.org/GNOME/gnome-boxes/-/commit/c486da262f6566326fbcb5e=
>>> f45c5f64048f16a6e
>>>
>>> Daniel P. Berrang=C3=A9 (6):
>>>   migration: improve error reporting of block driver state name
>>>   migration: introduce savevm, loadvm, delvm QMP commands
>>>   block: add ability to filter out blockdevs during snapshot
>>>   block: allow specifying name of block device for vmstate storage
>>>   migration: support excluding block devs in QMP snapshot commands
>>>   migration: support picking vmstate disk in QMP snapshot commands
>>>
>>>  block/monitor/block-hmp-cmds.c |  4 +-
>>>  block/snapshot.c               | 68 +++++++++++++++++++------
>>>  include/block/snapshot.h       | 21 +++++---
>>>  include/migration/snapshot.h   | 10 +++-
>>>  migration/savevm.c             | 71 +++++++++++++++++++-------
>>>  monitor/hmp-cmds.c             | 20 ++------
>>>  qapi/migration.json            | 91 ++++++++++++++++++++++++++++++++++
>>>  replay/replay-snapshot.c       |  4 +-
>>>  softmmu/vl.c                   |  2 +-
>>>  9 files changed, 228 insertions(+), 63 deletions(-)
>> I have tried to work in this interface in 2016. That time
>> we have struggled with the idea that this QMP interface should
>> be ready to work asynchronously.
>>
>> Write-protect userfaultfd was merged into vanilla Linux
>> thus it is time to async savevm interface, which will also
>> bring async loadvm and some rework for state storing.
>>
>> Thus I think that with the introduction of the QMP interface
>> we should at least run save VM not from the main
>> thread but from the background with the event at the end.
> spawning a thread in which to invoke save_snapshot() and load_snapshot()
> is easy enough.  I'm not at all clear on what we need in the way of
> mutex locking though, to make those methods safe to run in a thread
> that isn't the main event loop.

I am unsure that this is so easy. We need to be protected from other
operations
coming through QMP interface. Right now parallel operations are not allowed.

> Even with savevm/loadvm being blocking, we could introduce a QMP event
> straight away, and document that users shouldn't assume the operation
> is complete until they see the event. That would let us make the commands
> non-blocking later with same documented semantics.
OK. Let us assume that you have added QMP savevm as proposed. It is
sync now. Sooner or later (I hope sooner) we will have to re-implement
this command with async version of the command, which will bring
again event etc and thus you will have to add compat layers to the
libvirt.

I think that it would be cleaner to start with the interface suitable for
further (coming) features and not copy obsolete implementation.
Yes, unfortunately, this is much more complex :(

Den

