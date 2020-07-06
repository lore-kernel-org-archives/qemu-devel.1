Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968F3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A8520708
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eb+6mF1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A8520708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsTiD-000446-KN
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jsThJ-0003Rg-Ec; Mon, 06 Jul 2020 12:10:25 -0400
Received: from mail-eopbgr60113.outbound.protection.outlook.com
 ([40.107.6.113]:8879 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jsThH-0004ec-1a; Mon, 06 Jul 2020 12:10:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhJ7znNxKUSQhN8DrPq0JkTT3AZcT+ZJtkKjDOBA457xrewNRBfKhdfCsD178Cf6VaqcyToZnsx3Q61Iw9DvJq9r3YY4rpJDSz2Iwz2Tjo2rh1jDrQfAHkARdBdmFPeJM2xnS2gcIt/teuN0w4cZ1V5TqMJghqqr91go5Xgx5k9LETirbhIfUMALtvr06Gf2Ox6Lsq127jmhW2uAp2hUuqUeXwykhpu/BsZyz+EUbQBZ3oSoG6PZCnCwhIrCUUW5VgaI3Hdmq2Le9z7b4Cvsobea6sivbu4IMck9fr1jvJKtoaVinRD36SKFUUwbMQcHPl4FNJkK+iKjU0YVqlKIzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7aeHljPMLGwB4voqts9iQ8/9BLvvbIul7ApzbP890I=;
 b=D8avNfnFzdqLK81qtQKjkVTvqwJKqwyvTMKczntc9kY6wi7M0zRkXLdbtjmI4eK4457vCngZrhVtScyN1U3k8o+8Fv8HjMCZdgkifyUzc+hbrNZB8LpOgebaGnsmYH7vEc+gYdSqnc8nax7rCFZdfI+zkcnxbV/np/XvSQCPo5e5S6oL3jVxHamc5k8DZCS8nQCmo2xge7KKHi5Ba4saqiLEuxl062+cv9TVvkqQiOS32KbRKp+6fo3HEAhFN/j8/W3O1ljjUFBIoUuNWH7DMF4rb1zfWV8mj8S9gk08quX4IvluAAGjzAKuwFiYhR6ZooeqiiFICXfF00WSNBRg9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7aeHljPMLGwB4voqts9iQ8/9BLvvbIul7ApzbP890I=;
 b=eb+6mF1xWmJI0yjQzSIINGGUD0jv/AKMnF+bibVnB+PypqI/PLOg09YyK4zDqxY0Rz0Q7VC1ZymfNFfLKRfweTj8iKQNHzatwjjw+EhuRewirOrkcs+D1owW1cx3pFiHPe1kzFTCP/wj464wyfdwawPvMglSuK5JThhoyAlcwPA=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB4691.eurprd08.prod.outlook.com (2603:10a6:20b:cc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Mon, 6 Jul
 2020 16:10:20 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8%4]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 16:10:20 +0000
Subject: Re: [PATCH 0/6] migration: bring savevm/loadvm/delvm over to QMP
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20200702175754.2211821-1-berrange@redhat.com>
 <a747fcd4-d87e-8124-a988-f3ae678c856e@virtuozzo.com>
 <20200703172224.GT2213227@redhat.com>
 <a8015fd3-e73e-c70e-9ba7-fa1bc047a1c2@virtuozzo.com>
 <20200706152701.GB5052@linux.fritz.box> <20200706152902.GH2603839@redhat.com>
 <20200706155011.GC5052@linux.fritz.box> <20200706160318.GI2603839@redhat.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
Message-ID: <c64f8661-505b-a725-7333-e41cc00d4177@virtuozzo.com>
Date: Mon, 6 Jul 2020 19:10:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200706160318.GI2603839@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR1001CA0017.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::27) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 HE1PR1001CA0017.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:f7::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20 via Frontend Transport; Mon, 6 Jul 2020 16:10:19 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09d507b9-ae91-4af2-3f0d-08d821c71477
X-MS-TrafficTypeDiagnostic: AM6PR08MB4691:
X-Microsoft-Antispam-PRVS: <AM6PR08MB469175FD41AC5EF450631EC2B6690@AM6PR08MB4691.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aDeCqrgjVx0ElaseMgbswoXpsxQrpKt48dZBuO3K1CXfAx08OQzrSOXh3osMr/XVrdmbcEefkcCDtWtHhEMtQzCOHdgsCuEwnT//1/K+4NJJ2myDr18HEH3TLenRh9tdOyabIMVFprv1JZBzTmOEUoFguBzfKMnBIP7kMIm075wvzQdJDZCNrhvuiYvg/kOBvljreLLXzIjyAs5HbvW4wWzPD/1k3kFKUXsSw+uyph9naJIFHyx1VgSLnualW9+9U3Qn0XySTef6+Erk3MNgXzk2FBvKM6znTbfvEy6riRl8sQJ+bG8dPwz0z/P/N9tYJXPJz0QHi2kEiu2JDbjLTQj96rK92sn3hP56Beu6BNpAuti00g3PkRhgOBtT1EjDuZLByBCkNv1lrC/ZkCNKIAWGcSXsLrqNrDAeQzHHzISdmHqazbWStBChJA2M+sd6e/VmcdZlVWpQM2uLgdJdZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(396003)(39840400004)(366004)(16526019)(316002)(5660300002)(16576012)(8676002)(110136005)(478600001)(66556008)(30864003)(66476007)(66946007)(8936002)(7416002)(54906003)(4326008)(86362001)(2906002)(6486002)(186003)(53546011)(26005)(966005)(31686004)(31696002)(83380400001)(36756003)(6666004)(52116002)(956004)(2616005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ldbDjDGzxhaXRZokp1jGa0hlFena5Z1r2LNoluf3RmgfZxIjA7OzT9m2jz0ZBtSIwQUuz7Dk3mFh/LmNm/VtV+qJZmNp0UfMvhCYxqwRKj8nZXkWzr0D8gMVIO7qNrlnpckhHSC3m1eZvRmOwItoxyK/p+iqN6Uv8tIvPcvZMVGXzMPx0kCVn5eHGW0zNjNuaXKGEXkFPeGYYYmnEXwTbxz0uDopP2MePHCRiYm+Mv/yKcV7FWQ8NOqxbByKJdXmdF/gGqamXB0pS2Yv7kS3qGwv9M3TyROslrINNpArFBjz/vjZpPrVwGxElWJ/G2pV2yrVwKiApkIOuJQm/YIFBUdan4yS6f2owXT0dZZv2Rl4oPaiwxZ6DtIoym6IhJXJ18jCtjEyGLybY+EmsAVa1c09BRy1Mt8qH2qdf6aQ/u3mEXyLVDlTeYyYBOAHCASCSvZ/0SSL7w0WsHYqqVUZu+QToeeVscfxxgjuEK7a3+H3jDb9GvNwzpmXl7n5At4r
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d507b9-ae91-4af2-3f0d-08d821c71477
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4214.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 16:10:20.0921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzKUZrPMEm/Y1Fk0VxLKczTA7iZUNDMPqG+talA3X8K4g/GV962Sby78w/laCqOQs1OnpusKWCOBcxZFNB4U0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4691
Received-SPF: pass client-ip=40.107.6.113; envelope-from=den@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 12:10:20
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
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/6/20 7:03 PM, Daniel P. Berrangé wrote:
> On Mon, Jul 06, 2020 at 05:50:11PM +0200, Kevin Wolf wrote:
>> Am 06.07.2020 um 17:29 hat Daniel P. Berrangé geschrieben:
>>> On Mon, Jul 06, 2020 at 05:27:01PM +0200, Kevin Wolf wrote:
>>>> Am 03.07.2020 um 19:29 hat Denis V. Lunev geschrieben:
>>>>> On 7/3/20 8:22 PM, Daniel P. BerrangÃÂ© wrote:
>>>>>> On Fri, Jul 03, 2020 at 08:15:44PM +0300, Denis V. Lunev wrote:
>>>>>>> On 7/2/20 8:57 PM, Daniel P. BerrangÃÂ© wrote:
>>>>>>>> When QMP was first introduced some 10+ years ago now, the snapshot
>>>>>>>> related commands (savevm/loadvm/delvm) were not converted. This was
>>>>>>>> primarily because their implementation causes blocking of the thread
>>>>>>>> running the monitor commands. This was (and still is) considered
>>>>>>>> undesirable behaviour both in HMP and QMP.
>>>>>>>>
>>>>>>>> In theory someone was supposed to fix this flaw at some point in the
>>>>>>>> past 10 years and bring them into the QMP world. Sadly, thus far it
>>>>>>>> hasn't happened as people always had more important things to work
>>>>>>>> on. Enterprise apps were much more interested in external snapshots
>>>>>>>> than internal snapshots as they have many more features.
>>>>>>>>
>>>>>>>> Meanwhile users still want to use internal snapshots as there is
>>>>>>>> a certainly simplicity in having everything self-contained in one
>>>>>>>> image, even though it has limitations. Thus the apps that end up
>>>>>>>> executing the savevm/loadvm/delvm via the "human-monitor-command"
>>>>>>>> QMP command.
>>>>>>>>
>>>>>>>>
>>>>>>>> IOW, the problematic blocking behaviour that was one of the reasons
>>>>>>>> for not having savevm/loadvm/delvm in QMP is experienced by applications
>>>>>>>> regardless. By not portting the commands to QMP due to one design flaw,
>>>>>>>> we've forced apps and users to suffer from other design flaws of HMP (
>>>>>>>> bad error reporting, strong type checking of args, no introspection) for
>>>>>>>> an additional 10 years. This feels rather sub-optimal :-(
>>>>>>>>
>>>>>>>> In practice users don't appear to care strongly about the fact that these
>>>>>>>> commands block the VM while they run. I might have seen one bug report
>>>>>>>> about it, but it certainly isn't something that comes up as a frequent
>>>>>>>> topic except among us QEMU maintainers. Users do care about having
>>>>>>>> access to the snapshot feature.
>>>>>>>>
>>>>>>>> Where I am seeing frequent complaints is wrt the use of OVMF combined
>>>>>>>> with snapshots which has some serious pain points. This is getting worse
>>>>>>>> as the push to ditch legacy BIOS in favour of UEFI gain momentum both
>>>>>>>> across OS vendors and mgmt apps. Solving it requires new parameters to
>>>>>>>> the commands, but doing this in HMP is super unappealing.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> After 10 years, I think it is time for us to be a little pragmatic about
>>>>>>>> our handling of snapshots commands. My desire is that libvirt should never
>>>>>>>> use "human-monitor-command" under any circumstances, because of the
>>>>>>>> inherant flaws in HMP as a protocol for machine consumption. If there
>>>>>>>> are flaws in QMP commands that's fine. If we fix them in future, we can
>>>>>>>> deprecate the current QMP commands and remove them not too long after,
>>>>>>>> without being locked in forever.
>>>>>>>>
>>>>>>>>
>>>>>>>> Thus in this series I'm proposing a direct 1-1 mapping of the existing
>>>>>>>> HMP commands for savevm/loadvm/delvm into QMP as a first step. This does
>>>>>>>> not solve the blocking thread problem, but it does eliminate the error
>>>>>>>> reporting, type checking and introspection problems inherant to HMP.
>>>>>>>> We're winning on 3 out of the 4 long term problems.
>>>>>>>>
>>>>>>>> If someone can suggest a easy way to fix the thread blocking problem
>>>>>>>> too, I'd be interested to hear it. If it involves a major refactoring
>>>>>>>> then I think user are better served by unlocking what look like easy
>>>>>>>> wins today.
>>>>>>>>
>>>>>>>> With a QMP variant, we reasonably deal with the problems related to OVMF:
>>>>>>>>
>>>>>>>>  - The logic to pick which disk to store the vmstate in is not
>>>>>>>>    satsifactory.
>>>>>>>>
>>>>>>>>    The first block driver state cannot be assumed to be the root disk
>>>>>>>>    image, it might be OVMF varstore and we don't want to store vmstate
>>>>>>>>    in there.
>>>>>>>>
>>>>>>>>  - The logic to decide which disks must be snapshotted is hardwired
>>>>>>>>    to all disks which are writable
>>>>>>>>
>>>>>>>>    Again with OVMF there might be a writable varstore, but this can be
>>>>>>>>    raw rather than qcow2 format, and thus unable to be snapshotted.
>>>>>>>>    While users might wish to snapshot their varstore, in some/many/most
>>>>>>>>    cases it is entirely uneccessary. Users are blocked from snapshotting
>>>>>>>>    their VM though due to this varstore.
>>>>>>>>
>>>>>>>> These are solved by adding two parameters to the commands. The first is
>>>>>>>> a block device node name that identifies the image to store vmstate in,
>>>>>>>> and the second is a list of node names to exclude from snapshots.
>>>>>>>>
>>>>>>>> In the block code I've only dealt with node names for block devices, as
>>>>>>>> IIUC, this is all that libvirt should need in the -blockdev world it now
>>>>>>>> lives in. IOW, I've made not attempt to cope with people wanting to use
>>>>>>>> these QMP commands in combination with -drive args.
>>>>>>>>
>>>>>>>> I've done some minimal work in libvirt to start to make use of the new
>>>>>>>> commands to validate their functionality, but this isn't finished yet.
>>>>>>>>
>>>>>>>> My ultimate goal is to make the GNOME Boxes maintainer happy again by
>>>>>>>> having internal snapshots work with OVMF:
>>>>>>>>
>>>>>>>>   https://gitlab.gnome.org/GNOME/gnome-boxes/-/commit/c486da262f6566326fbcb5e=
>>>>>>>> f45c5f64048f16a6e
>>>>>>>>
>>>>>>>> Daniel P. Berrang=C3=A9 (6):
>>>>>>>>   migration: improve error reporting of block driver state name
>>>>>>>>   migration: introduce savevm, loadvm, delvm QMP commands
>>>>>>>>   block: add ability to filter out blockdevs during snapshot
>>>>>>>>   block: allow specifying name of block device for vmstate storage
>>>>>>>>   migration: support excluding block devs in QMP snapshot commands
>>>>>>>>   migration: support picking vmstate disk in QMP snapshot commands
>>>>>>>>
>>>>>>>>  block/monitor/block-hmp-cmds.c |  4 +-
>>>>>>>>  block/snapshot.c               | 68 +++++++++++++++++++------
>>>>>>>>  include/block/snapshot.h       | 21 +++++---
>>>>>>>>  include/migration/snapshot.h   | 10 +++-
>>>>>>>>  migration/savevm.c             | 71 +++++++++++++++++++-------
>>>>>>>>  monitor/hmp-cmds.c             | 20 ++------
>>>>>>>>  qapi/migration.json            | 91 ++++++++++++++++++++++++++++++++++
>>>>>>>>  replay/replay-snapshot.c       |  4 +-
>>>>>>>>  softmmu/vl.c                   |  2 +-
>>>>>>>>  9 files changed, 228 insertions(+), 63 deletions(-)
>>>>>>> I have tried to work in this interface in 2016. That time
>>>>>>> we have struggled with the idea that this QMP interface should
>>>>>>> be ready to work asynchronously.
>>>>>>>
>>>>>>> Write-protect userfaultfd was merged into vanilla Linux
>>>>>>> thus it is time to async savevm interface, which will also
>>>>>>> bring async loadvm and some rework for state storing.
>>>>>>>
>>>>>>> Thus I think that with the introduction of the QMP interface
>>>>>>> we should at least run save VM not from the main
>>>>>>> thread but from the background with the event at the end.
>>>>>> spawning a thread in which to invoke save_snapshot() and load_snapshot()
>>>>>> is easy enough.  I'm not at all clear on what we need in the way of
>>>>>> mutex locking though, to make those methods safe to run in a thread
>>>>>> that isn't the main event loop.
>>>>> I am unsure that this is so easy. We need to be protected from other
>>>>> operations
>>>>> coming through QMP interface. Right now parallel operations are not allowed.
>>>>>
>>>>>> Even with savevm/loadvm being blocking, we could introduce a QMP event
>>>>>> straight away, and document that users shouldn't assume the operation
>>>>>> is complete until they see the event. That would let us make the commands
>>>>>> non-blocking later with same documented semantics.
>>>>> OK. Let us assume that you have added QMP savevm as proposed. It is
>>>>> sync now. Sooner or later (I hope sooner) we will have to re-implement
>>>>> this command with async version of the command, which will bring
>>>>> again event etc and thus you will have to add compat layers to the
>>>>> libvirt.
>>>>>
>>>>> I think that it would be cleaner to start with the interface suitable for
>>>>> further (coming) features and not copy obsolete implementation.
>>>>> Yes, unfortunately, this is much more complex :(
>>>> Should we make this a job (may or may not be a block job) that just
>>>> happens to block the VM and return completion immediately with the
>>>> simple implementation we can have today? Then moving it later to a
>>>> truly async operation mode should become transparent to the QMP client.
>>> What would making it a job / block job need from a QMP design POV ?
>> The actual QMP syntax for the command wouldn't look much different (I
>> think just a new option 'job-id'), but the difference would be that it's
>> not documented as performing the whole action, but just starting the
>> job. The expectation would then be that it can be managed with the
>> job-* commands and that it emits the job status events.
>>
>> This may sound complicated, but most of it is actually covered by the
>> generic job infrastructure.
>>
>> The simplest job that we have is blockdev-create, which is implemented
>> in block/create.c (99 lines including the license header). I think this
>> would be a good model for our new case.
This proposal looks perfect to me!

> The QMP design and internal API looks simple enough, but I'm wondering
> what implications come with the job infra wrt locking/thread safety. In
> particular I see the "job_start" command runs the impl in a coroutine.
> I can't tell if that's going to cause any interactions wrto the current
> loadvm/savevm impl and its assumptions about blocking execution while
> running.
>
> Regards,
> Daniel
Right now we don't care. This is API part. For the implentation part the
code remains as-is. In this case we just adopt libvirt to the new
approach while QEMU remains old. Converting QEMU to new iface
is indeed separate (much more complex) task.

Den

