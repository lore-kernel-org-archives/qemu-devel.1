Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A380AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:16:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52B75208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AUitScAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B75208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrPJ4-0008Mu-KE
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jrPI3-000720-5p; Fri, 03 Jul 2020 13:15:55 -0400
Received: from mail-db8eur05on2127.outbound.protection.outlook.com
 ([40.107.20.127]:57953 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jrPI0-0002bK-BP; Fri, 03 Jul 2020 13:15:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLM1oeYjmW2Xuib1FR5eghKvvDmI6aNLF79uBOwU49URp6qX1YEb9CzdBMesbO5CijbJPaZ9VbkaZASMfRZpKMfil3ssrEqKD+rivAVEl7XnYE7MaQ8wfwkz/2QbfQ24dyfK8YS+L+/qjV+aVtRWg9pIbL7knRhOaYsEeW/u6+bIW/YdEE6YMhupZ0ngPiAPR03/kucsqROTI7/idda2bAu+w1eemLuNK2wIpIzoTHHYNKHVlte9er2aNkgQz+198jkfB1g3cFGBe3vay6T0mxOTs+UOZiFAtD88Q0vI0V15M5XGht7D+pgryFQjaqpvIBIq4wVnZzOn3i/If5h9fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94dGflzbFAgW2qH4xcmU02+iVv+Z4IMSBJgxVOFNw2Q=;
 b=aMn2cvEcPA4VD48cKuA417SF24GIkZ2bf3rBb6IDItOt3u7FXO15nFaeVVD0ONfAgShBE+s0tPQFWA0I8gATeZi9ORLoT9LtweYGufhFKs7d6qiqdT36bcQfcTtPgKQ6Ssgjv7tK9GBHYSCIVT51sty64XyEtoT/6RwXWieXF02I8e2G0Sug3Ox/xQO9GO9gNu9Mo+quxSmKmCKram6KshW5+aE7tXo5qC1QGx0i39Yhg5A3kdqHRC6vmpgndO8gAA2dUgpPfeXOVDMaIvkVRtx5u6Vqe8C1IgV9YpDOHj+2qQttPo/fFbuHopZo+PFKv6x1Ui5J4SVoo5bhjclnFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94dGflzbFAgW2qH4xcmU02+iVv+Z4IMSBJgxVOFNw2Q=;
 b=AUitScAQQdqJShaZNl3AW1Hf/rLPj+8Od4evAp3Kup/zeWRiH1axQML7e7NuFlt3j8urS3Eu584IKcnPDIHF+m/eQJxeOCCfqNShq8JQ1+cyTkr/7gl0G4xatGnBSzCJzFb7Z/75ceTBln8JybdE5phLYmYfN1MT4ejJm/czXVs=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM5PR0802MB2452.eurprd08.prod.outlook.com (2603:10a6:203:9f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Fri, 3 Jul
 2020 17:15:47 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8%4]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 17:15:47 +0000
Subject: Re: [PATCH 0/6] migration: bring savevm/loadvm/delvm over to QMP
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200702175754.2211821-1-berrange@redhat.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
Message-ID: <a747fcd4-d87e-8124-a988-f3ae678c856e@virtuozzo.com>
Date: Fri, 3 Jul 2020 20:15:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200702175754.2211821-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR05CA0161.eurprd05.prod.outlook.com
 (2603:10a6:7:28::48) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 HE1PR05CA0161.eurprd05.prod.outlook.com (2603:10a6:7:28::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.21 via Frontend Transport; Fri, 3 Jul 2020 17:15:46 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 366f0bf9-6dad-46dc-2dd8-08d81f74ba11
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2452:
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2452BC40E3585130BC98D151B66A0@AM5PR0802MB2452.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3QJYxe1Q1RwCSEp5Lm/orCX6pFQFxSsmjf2zTGYBhtnvMTv6r+lPg3iOQGHeQRWU5TvKvAm7w4/wNfDB4jiYqLehgPowIOsOq/j5J2QzSMBmoh6VUjin9X9BsOgBbIY20ndF4NGY0F4ajlHiu0UY7uKRyCz5GkOxSOcB7kpwsIhf6kn5xhHDV5EKCsx7ch86T2asYditdVyzuDfk7ugJ5yI6Cmz9KwHK/JrvX8oz+7eubTopyhmMKz/mtmdJcEVRyKjAQDBzUOxscBv5wpxtvRwduQiyjEX5i1ok5GxNCmqKFoCB27VQZiOO/c3MsI1YkbUVZ7qwo0ri0hHADRbWsXbEak9I2AjttkblCrwI7Xy8gJddE0QTdFFg0pPNOVK/I4kfKt2mFRmukBAmM1VgiSzumYrBZ3jpJLIJfwfJS1lwdKgDfkZkF827DvxmxBGdMJF/9BHcLFqmMhlfzzfb3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(376002)(346002)(39840400004)(396003)(8676002)(7416002)(956004)(2616005)(52116002)(31696002)(83380400001)(316002)(16576012)(54906003)(186003)(16526019)(36756003)(53546011)(26005)(31686004)(86362001)(478600001)(8936002)(966005)(6486002)(5660300002)(4326008)(2906002)(66556008)(66476007)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: EgnErs//4snkBnOHlwLXZBcdAmsc5LbHAgQzRsY3AjAAh1+hpLOtuiN0CvCFU2YXnlIcoL7In+pZavV/a92CwBMMDkK0fEw8G0LAdqZPHg6OzN4+mQaVFds1bx8pSAva8WEbeIN6QMbWnvYBA8mmdVuvB6to+wgRWoQcsbizBuFk9kmG/cxnBm4SL/HPSPspAFyBeYrHFCaE8WnwzTWKezCnWN1w4B6D3ECxSoqa7MjWlIrqxs5aL3EHerir7bTkpREkELGtXqHeym4Ywxc7ZfDwZUor6Pi3JjbgmoWrurpDOh5AVGKzl94QDpE2k/hEyUgok48r6yjKyQip5fVpXVQyGd6zCVw505c0nkHjZSWY9nR2xXDnp7qeaSeeBwIEyqf/BAMjIhTuKyies+NqWZzWQGEjoy8IiLemlieXlU8VYos78V0IGz6JiXKE3XtomyGd9ecjm0Yh5UEYchuKGZ26EYGwBXYts7EY1WAcm++RfiGoI/23x8DO5eE1x4SX
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 366f0bf9-6dad-46dc-2dd8-08d81f74ba11
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4214.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 17:15:47.3199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S18T/WMmVJLIAWdW/NK0/iNKcsv2in6636Ksy/MTxh9Pg6H6h3BqfDKL38wZ/y1sYBqhcEwWXywLkcXivimQmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2452
Received-SPF: pass client-ip=40.107.20.127; envelope-from=den@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 13:15:48
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
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/2/20 8:57 PM, Daniel P. Berrangé wrote:
> When QMP was first introduced some 10+ years ago now, the snapshot
> related commands (savevm/loadvm/delvm) were not converted. This was
> primarily because their implementation causes blocking of the thread
> running the monitor commands. This was (and still is) considered
> undesirable behaviour both in HMP and QMP.
>
> In theory someone was supposed to fix this flaw at some point in the
> past 10 years and bring them into the QMP world. Sadly, thus far it
> hasn't happened as people always had more important things to work
> on. Enterprise apps were much more interested in external snapshots
> than internal snapshots as they have many more features.
>
> Meanwhile users still want to use internal snapshots as there is
> a certainly simplicity in having everything self-contained in one
> image, even though it has limitations. Thus the apps that end up
> executing the savevm/loadvm/delvm via the "human-monitor-command"
> QMP command.
>
>
> IOW, the problematic blocking behaviour that was one of the reasons
> for not having savevm/loadvm/delvm in QMP is experienced by applications
> regardless. By not portting the commands to QMP due to one design flaw,
> we've forced apps and users to suffer from other design flaws of HMP (
> bad error reporting, strong type checking of args, no introspection) for
> an additional 10 years. This feels rather sub-optimal :-(
>
> In practice users don't appear to care strongly about the fact that these
> commands block the VM while they run. I might have seen one bug report
> about it, but it certainly isn't something that comes up as a frequent
> topic except among us QEMU maintainers. Users do care about having
> access to the snapshot feature.
>
> Where I am seeing frequent complaints is wrt the use of OVMF combined
> with snapshots which has some serious pain points. This is getting worse
> as the push to ditch legacy BIOS in favour of UEFI gain momentum both
> across OS vendors and mgmt apps. Solving it requires new parameters to
> the commands, but doing this in HMP is super unappealing.
>
>
>
> After 10 years, I think it is time for us to be a little pragmatic about
> our handling of snapshots commands. My desire is that libvirt should never
> use "human-monitor-command" under any circumstances, because of the
> inherant flaws in HMP as a protocol for machine consumption. If there
> are flaws in QMP commands that's fine. If we fix them in future, we can
> deprecate the current QMP commands and remove them not too long after,
> without being locked in forever.
>
>
> Thus in this series I'm proposing a direct 1-1 mapping of the existing
> HMP commands for savevm/loadvm/delvm into QMP as a first step. This does
> not solve the blocking thread problem, but it does eliminate the error
> reporting, type checking and introspection problems inherant to HMP.
> We're winning on 3 out of the 4 long term problems.
>
> If someone can suggest a easy way to fix the thread blocking problem
> too, I'd be interested to hear it. If it involves a major refactoring
> then I think user are better served by unlocking what look like easy
> wins today.
>
> With a QMP variant, we reasonably deal with the problems related to OVMF:
>
>  - The logic to pick which disk to store the vmstate in is not
>    satsifactory.
>
>    The first block driver state cannot be assumed to be the root disk
>    image, it might be OVMF varstore and we don't want to store vmstate
>    in there.
>
>  - The logic to decide which disks must be snapshotted is hardwired
>    to all disks which are writable
>
>    Again with OVMF there might be a writable varstore, but this can be
>    raw rather than qcow2 format, and thus unable to be snapshotted.
>    While users might wish to snapshot their varstore, in some/many/most
>    cases it is entirely uneccessary. Users are blocked from snapshotting
>    their VM though due to this varstore.
>
> These are solved by adding two parameters to the commands. The first is
> a block device node name that identifies the image to store vmstate in,
> and the second is a list of node names to exclude from snapshots.
>
> In the block code I've only dealt with node names for block devices, as
> IIUC, this is all that libvirt should need in the -blockdev world it now
> lives in. IOW, I've made not attempt to cope with people wanting to use
> these QMP commands in combination with -drive args.
>
> I've done some minimal work in libvirt to start to make use of the new
> commands to validate their functionality, but this isn't finished yet.
>
> My ultimate goal is to make the GNOME Boxes maintainer happy again by
> having internal snapshots work with OVMF:
>
>   https://gitlab.gnome.org/GNOME/gnome-boxes/-/commit/c486da262f6566326fbcb5e=
> f45c5f64048f16a6e
>
> Daniel P. Berrang=C3=A9 (6):
>   migration: improve error reporting of block driver state name
>   migration: introduce savevm, loadvm, delvm QMP commands
>   block: add ability to filter out blockdevs during snapshot
>   block: allow specifying name of block device for vmstate storage
>   migration: support excluding block devs in QMP snapshot commands
>   migration: support picking vmstate disk in QMP snapshot commands
>
>  block/monitor/block-hmp-cmds.c |  4 +-
>  block/snapshot.c               | 68 +++++++++++++++++++------
>  include/block/snapshot.h       | 21 +++++---
>  include/migration/snapshot.h   | 10 +++-
>  migration/savevm.c             | 71 +++++++++++++++++++-------
>  monitor/hmp-cmds.c             | 20 ++------
>  qapi/migration.json            | 91 ++++++++++++++++++++++++++++++++++
>  replay/replay-snapshot.c       |  4 +-
>  softmmu/vl.c                   |  2 +-
>  9 files changed, 228 insertions(+), 63 deletions(-)
>
> --=20
> 2.26.2
>
>
>
I have tried to work in this interface in 2016. That time
we have struggled with the idea that this QMP interface should
be ready to work asynchronously.

Write-protect userfaultfd was merged into vanilla Linux
thus it is time to async savevm interface, which will also
bring async loadvm and some rework for state storing.

Thus I think that with the introduction of the QMP interface
we should at least run save VM not from the main
thread but from the background with the event at the end.

Den

