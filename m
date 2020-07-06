Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BDFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:08:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47A0720708
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DaJR+iI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A0720708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsTft-0001iP-HT
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jsTeu-0000vQ-He; Mon, 06 Jul 2020 12:07:56 -0400
Received: from mail-eopbgr60108.outbound.protection.outlook.com
 ([40.107.6.108]:34880 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1jsTer-00043Z-2A; Mon, 06 Jul 2020 12:07:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkAd3ojTPfiZDu+H0RWT7JvHODGhOP/Q71Wa2ei7EZ1VPeC5hOsXCTloon+MCHBgZFx8OY7O0tjpu4RSLqbwI0FUSKAT5zEfcpMhoCI+G5/7rTgI3batPUh95gSpDD2QlaLV5s5iv0KDsIZ2/82dy8iWwXLI2PYNj/PHEbWuA7xzkfTBcS9YzKhOufpQZDt7q+t580ogrizJBT5CWJZOYoqT5Zcl1XVzMk/o9vslfDR7YHwPC+FSQ8MMl7vhQT9uYns2YNe/qC7ZeNpVSJ37j3mLzbCzuwnxjSBsDUdxdiXzeA/KktFZ2MCCwQWwVbMX/QB1Dwp3jwQT8D6EiH4NMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9pMS5jTwUe9EVmzz8sdPEGXAmftYQw6+5sQoZdsDSw=;
 b=FNOl44o4ZiiCIQ1GSIa8rIf8OkIHXorVWMHDHTU0yAirrhHtQfugnRUHVCmbTo0tkcZUsuJIvakKeRcFW1c9IpWRhgxBfmlU4rDeAGAcxx7hrDenUMZLXcNsQhuU0sCxXh6k7kBr/aW5G9dhVRsvsAQad5Y44Wh8KYOGo6qHDZFug+tv9gme7chckDRD5zIZ9BMtC/I3qRC4zrwQZDB/S1YtnkB9XhFj+aF/M2rh89pJWwFMvm9H9vjH4dnTH3TWUrFi71+EO2qt2JDpGLXlgcYzK91j/UXB2+HP05qqOx5NmLzM9+jyEc4lHDZynbR4B4nya5fUe3qngw4XA9tQjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9pMS5jTwUe9EVmzz8sdPEGXAmftYQw6+5sQoZdsDSw=;
 b=DaJR+iI7K452owq150Zj9kZ03jBCh6Qap1X5cPLLiqZQZIO8XHaK7sS0ATKy9p5FsbpvukfcX9SQ1ss53tD4fjNL9ScAvweGInT4WGWnpohSEDWPXqWbN5M+cBAXgnCwekttHFpeGxegecsbNwz7CCpu/g9i8TJ8j7wb41V9mBM=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 by AM6PR08MB4691.eurprd08.prod.outlook.com (2603:10a6:20b:cc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Mon, 6 Jul
 2020 16:07:48 +0000
Received: from AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8]) by AM6PR08MB4214.eurprd08.prod.outlook.com
 ([fe80::821:7596:cf7f:68f8%4]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 16:07:48 +0000
Subject: Re: [PATCH 0/6] migration: bring savevm/loadvm/delvm over to QMP
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200702175754.2211821-1-berrange@redhat.com>
 <a747fcd4-d87e-8124-a988-f3ae678c856e@virtuozzo.com>
 <20200703172224.GT2213227@redhat.com>
 <a8015fd3-e73e-c70e-9ba7-fa1bc047a1c2@virtuozzo.com>
 <20200706142834.GF2603839@redhat.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
Message-ID: <d02ffd2e-959a-70ac-0feb-b31935babfe9@virtuozzo.com>
Date: Mon, 6 Jul 2020 19:07:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200706142834.GF2603839@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR0501CA0034.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::44) To AM6PR08MB4214.eurprd08.prod.outlook.com
 (2603:10a6:20b:8d::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.27] (31.148.204.195) by
 HE1PR0501CA0034.eurprd05.prod.outlook.com (2603:10a6:3:1a::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.21 via Frontend Transport; Mon, 6 Jul 2020 16:07:47 +0000
X-Originating-IP: [31.148.204.195]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cd19e58-49a0-4922-4908-08d821c6ba1c
X-MS-TrafficTypeDiagnostic: AM6PR08MB4691:
X-Microsoft-Antispam-PRVS: <AM6PR08MB469175B859419DD1D8FF7B3FB6690@AM6PR08MB4691.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QmXZXzGA1BYhL1oQVKrcmxZe1NzZ/GEQYhSxf2UhX7/0Rr6ncZyb/5kiIpcjLpp1LPrV7XlVXPqrhK0Uaha7edhAm7wQVa8yDPJofkeo2tHBaJ4d+/Ayj+uOzAkaspmSBz2WPmTXv0R6nrY1k2V+L2YCbbywoatgB28WYig5YMkUFW/roQPUxJkKm6sDNarAP+zXeh8Hr2xBXknMO/PaVN6WwVPKkPSr6dZkvIg0kyzWsbBOmMJ5hCIMUn8lkpcgaklr/cGtu7QF0sz+zdNsoeIQMmCj6REXL8a02oORCmWJ0RCJdQBs06ER6zirrbnySASTCiV3xgvJrt2t46Vv7MSewrSnQDQ5y6uHhpTi0TLva7/Kdhj5fjbMluSBbIcqaYhVAEyT9u+xuUIOTecxb0JrVZ8j4OsXUYa2yCVA+RVOBsJzy90VakXbY5fdHGMFVS2GZYCK2kzI2KUZCn1ryg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4214.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39840400004)(396003)(136003)(346002)(376002)(53546011)(6486002)(186003)(26005)(6916009)(2906002)(52116002)(2616005)(956004)(966005)(31686004)(31696002)(83380400001)(36756003)(86362001)(478600001)(66476007)(66946007)(66556008)(316002)(5660300002)(16576012)(16526019)(8676002)(4326008)(7416002)(54906003)(8936002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: FxVowPfBxmMYbTIeXqV9iqeDAFxsAJBIZOynZ3fQLtsCiVWehb+1RWqAgL2S/u3EQwVNjx5Czv0O0pk2icjwuRMK2cSS0ILrI4HW8R/FxNMCAPIM2J1cEq4Y2M2BMmBlb969pWUVHK+MnklRwEL9T/SRsK+ZC4I3tPdH4I/8AJtK85OWVc33tAFnmWkh2WTH8rWCpNGuS83ETKyWb/HqapX+X34si1itMseBE20SLwvvtuQaUQ4dG7pFg+AIaOBaowGEpW3yofU7z2+/RwrTOcnurK1B9KiD6VdICnm5lBptt6c2Hv8AXmGtLlSIEkiCJUH/ggSS+tMy3lhn9UVyFHxjTLT1/vEReOLj12cGy1nuCb8iUuw6lR39heFVQPpiBez1QTtfhLIWlWuoUmGu0sY9eGwAD2ObUCCSTzdDZfG8B7vTPnfXoITeZi10s8vqJyASyEZYaiSEPPIsT+xsmMs6SDmMs4Fgk3CMpFKhdUk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd19e58-49a0-4922-4908-08d821c6ba1c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4214.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 16:07:48.4051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +WthiGvjx7m8VtYX5DZdB/fUjOjmMwuB+1P4RqUS2ON8WqufbKEFmestnW2vfmILfMT1jwy2ZFrxQM6t+NGxnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4691
Received-SPF: pass client-ip=40.107.6.108; envelope-from=den@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 12:07:50
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
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/6/20 5:28 PM, Daniel P. Berrangé wrote:
> On Fri, Jul 03, 2020 at 08:29:08PM +0300, Denis V. Lunev wrote:
>> On 7/3/20 8:22 PM, Daniel P. Berrangé wrote:
>>> On Fri, Jul 03, 2020 at 08:15:44PM +0300, Denis V. Lunev wrote:
>>>> On 7/2/20 8:57 PM, Daniel P. Berrangé wrote:
>>>>> When QMP was first introduced some 10+ years ago now, the snapshot
>>>>> related commands (savevm/loadvm/delvm) were not converted. This was
>>>>> primarily because their implementation causes blocking of the thread
>>>>> running the monitor commands. This was (and still is) considered
>>>>> undesirable behaviour both in HMP and QMP.
>>>>>
>>>>> In theory someone was supposed to fix this flaw at some point in the
>>>>> past 10 years and bring them into the QMP world. Sadly, thus far it
>>>>> hasn't happened as people always had more important things to work
>>>>> on. Enterprise apps were much more interested in external snapshots
>>>>> than internal snapshots as they have many more features.
>>>>>
>>>>> Meanwhile users still want to use internal snapshots as there is
>>>>> a certainly simplicity in having everything self-contained in one
>>>>> image, even though it has limitations. Thus the apps that end up
>>>>> executing the savevm/loadvm/delvm via the "human-monitor-command"
>>>>> QMP command.
>>>>>
>>>>>
>>>>> IOW, the problematic blocking behaviour that was one of the reasons
>>>>> for not having savevm/loadvm/delvm in QMP is experienced by applications
>>>>> regardless. By not portting the commands to QMP due to one design flaw,
>>>>> we've forced apps and users to suffer from other design flaws of HMP (
>>>>> bad error reporting, strong type checking of args, no introspection) for
>>>>> an additional 10 years. This feels rather sub-optimal :-(
>>>>>
>>>>> In practice users don't appear to care strongly about the fact that these
>>>>> commands block the VM while they run. I might have seen one bug report
>>>>> about it, but it certainly isn't something that comes up as a frequent
>>>>> topic except among us QEMU maintainers. Users do care about having
>>>>> access to the snapshot feature.
>>>>>
>>>>> Where I am seeing frequent complaints is wrt the use of OVMF combined
>>>>> with snapshots which has some serious pain points. This is getting worse
>>>>> as the push to ditch legacy BIOS in favour of UEFI gain momentum both
>>>>> across OS vendors and mgmt apps. Solving it requires new parameters to
>>>>> the commands, but doing this in HMP is super unappealing.
>>>>>
>>>>>
>>>>>
>>>>> After 10 years, I think it is time for us to be a little pragmatic about
>>>>> our handling of snapshots commands. My desire is that libvirt should never
>>>>> use "human-monitor-command" under any circumstances, because of the
>>>>> inherant flaws in HMP as a protocol for machine consumption. If there
>>>>> are flaws in QMP commands that's fine. If we fix them in future, we can
>>>>> deprecate the current QMP commands and remove them not too long after,
>>>>> without being locked in forever.
>>>>>
>>>>>
>>>>> Thus in this series I'm proposing a direct 1-1 mapping of the existing
>>>>> HMP commands for savevm/loadvm/delvm into QMP as a first step. This does
>>>>> not solve the blocking thread problem, but it does eliminate the error
>>>>> reporting, type checking and introspection problems inherant to HMP.
>>>>> We're winning on 3 out of the 4 long term problems.
>>>>>
>>>>> If someone can suggest a easy way to fix the thread blocking problem
>>>>> too, I'd be interested to hear it. If it involves a major refactoring
>>>>> then I think user are better served by unlocking what look like easy
>>>>> wins today.
>>>>>
>>>>> With a QMP variant, we reasonably deal with the problems related to OVMF:
>>>>>
>>>>>  - The logic to pick which disk to store the vmstate in is not
>>>>>    satsifactory.
>>>>>
>>>>>    The first block driver state cannot be assumed to be the root disk
>>>>>    image, it might be OVMF varstore and we don't want to store vmstate
>>>>>    in there.
>>>>>
>>>>>  - The logic to decide which disks must be snapshotted is hardwired
>>>>>    to all disks which are writable
>>>>>
>>>>>    Again with OVMF there might be a writable varstore, but this can be
>>>>>    raw rather than qcow2 format, and thus unable to be snapshotted.
>>>>>    While users might wish to snapshot their varstore, in some/many/most
>>>>>    cases it is entirely uneccessary. Users are blocked from snapshotting
>>>>>    their VM though due to this varstore.
>>>>>
>>>>> These are solved by adding two parameters to the commands. The first is
>>>>> a block device node name that identifies the image to store vmstate in,
>>>>> and the second is a list of node names to exclude from snapshots.
>>>>>
>>>>> In the block code I've only dealt with node names for block devices, as
>>>>> IIUC, this is all that libvirt should need in the -blockdev world it now
>>>>> lives in. IOW, I've made not attempt to cope with people wanting to use
>>>>> these QMP commands in combination with -drive args.
>>>>>
>>>>> I've done some minimal work in libvirt to start to make use of the new
>>>>> commands to validate their functionality, but this isn't finished yet.
>>>>>
>>>>> My ultimate goal is to make the GNOME Boxes maintainer happy again by
>>>>> having internal snapshots work with OVMF:
>>>>>
>>>>>   https://gitlab.gnome.org/GNOME/gnome-boxes/-/commit/c486da262f6566326fbcb5e=
>>>>> f45c5f64048f16a6e
>>>>>
>>>>> Daniel P. Berrang=C3=A9 (6):
>>>>>   migration: improve error reporting of block driver state name
>>>>>   migration: introduce savevm, loadvm, delvm QMP commands
>>>>>   block: add ability to filter out blockdevs during snapshot
>>>>>   block: allow specifying name of block device for vmstate storage
>>>>>   migration: support excluding block devs in QMP snapshot commands
>>>>>   migration: support picking vmstate disk in QMP snapshot commands
>>>>>
>>>>>  block/monitor/block-hmp-cmds.c |  4 +-
>>>>>  block/snapshot.c               | 68 +++++++++++++++++++------
>>>>>  include/block/snapshot.h       | 21 +++++---
>>>>>  include/migration/snapshot.h   | 10 +++-
>>>>>  migration/savevm.c             | 71 +++++++++++++++++++-------
>>>>>  monitor/hmp-cmds.c             | 20 ++------
>>>>>  qapi/migration.json            | 91 ++++++++++++++++++++++++++++++++++
>>>>>  replay/replay-snapshot.c       |  4 +-
>>>>>  softmmu/vl.c                   |  2 +-
>>>>>  9 files changed, 228 insertions(+), 63 deletions(-)
>>>> I have tried to work in this interface in 2016. That time
>>>> we have struggled with the idea that this QMP interface should
>>>> be ready to work asynchronously.
>>>>
>>>> Write-protect userfaultfd was merged into vanilla Linux
>>>> thus it is time to async savevm interface, which will also
>>>> bring async loadvm and some rework for state storing.
>>>>
>>>> Thus I think that with the introduction of the QMP interface
>>>> we should at least run save VM not from the main
>>>> thread but from the background with the event at the end.
>>> spawning a thread in which to invoke save_snapshot() and load_snapshot()
>>> is easy enough.  I'm not at all clear on what we need in the way of
>>> mutex locking though, to make those methods safe to run in a thread
>>> that isn't the main event loop.
>> I am unsure that this is so easy. We need to be protected from other
>> operations
>> coming through QMP interface. Right now parallel operations are not allowed.
>>
>>> Even with savevm/loadvm being blocking, we could introduce a QMP event
>>> straight away, and document that users shouldn't assume the operation
>>> is complete until they see the event. That would let us make the commands
>>> non-blocking later with same documented semantics.
>> OK. Let us assume that you have added QMP savevm as proposed. It is
>> sync now. Sooner or later (I hope sooner) we will have to re-implement
>> this command with async version of the command, which will bring
>> again event etc and thus you will have to add compat layers to the
>> libvirt.
>>
>> I think that it would be cleaner to start with the interface suitable for
>> further (coming) features and not copy obsolete implementation.
>> Yes, unfortunately, this is much more complex :(
> QMP-ifying the current design gives us a quick win by removing the
> dependancy on HMP, for negligible effort. It further lets us unlock
> a few extra useful features, again for negligible effort or maint
> burden, since we already have pretty much all the code already for HMP.
>
> Supporting internal snapshots is an explicit non-goal for Red Hat in terms
> of the products we're using QEMU with, as they all use external snapshots.
> Thus I'm very limited in time I can put into this feature myself. I am 
> proposing this QMP-ification with my community hat on instead, as it looks
> like a quick win to help out various apps today, but it limits the amount
> of time I can justify spending on this.
>
> If someone wants to work on a perfect design that's great, but I don't
> want us to do nothing now, and continue to wait for a perfect solution
> that has shown no sign of arriving in 10 years.
>
> Regards,
> Daniel
I understand this. My proposal is may be a bit controversal but affordable.
Let us make current synchronous implementation as-is, not changes
at all, but design API in async way. Thus the command

+{ 'command': 'savevm',
+  'data': { 'tag': 'str' } }

should be considered as "start the operations", while the end is
signaled via event.

In this case we will be able to separate API part and implementation
part. What do you think on this?

Den


