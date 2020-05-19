Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030C5C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:28:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5BA22075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JocsIxoZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BA22075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb4AW-00070P-Sr
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jb3oD-0004kT-O7; Tue, 19 May 2020 11:05:33 -0400
Received: from mail-vi1eur05on2100.outbound.protection.outlook.com
 ([40.107.21.100]:63687 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jb3oB-0005Gc-JQ; Tue, 19 May 2020 11:05:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYQDz2NThfgGjMUexjyeGOQScEwsEuiDxm7yBNU/yybdkmiqfmbiIjNhFtiXszNhAxjDO6cgzQ0kEF6bvweIA+MoJ9M/N92fwP+53TuVT7di1IJuVy2xCEAEFif+G4tT2hyJU4O2w/fXckMZBLTk1r+saTJGN8QmUWgzG7+cqujfq5x5od4gUEnzyfxEJ9q7rQAbdN4VJjmHjaNzVbKRikqbr3saoDRuXxoH+wfeSbRjMKgOtoG7FvzdlhECTAZqalXzaP//XYEafDnRoBgYKd0JUQ51EoJ0lF5xGavytoKkvse2g+LbQBVpVPki8/cNC2XQAX+DtdniDrtDQuImDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5VwAbCdll0w44+kVod7U29Tg9alkH8r50XNwh45bMI=;
 b=hkebZ830Iw59Qz4xGo9QLEMiqgN5fZz8e7AUfVPr6jCRygd02oTF5XE9gQ8c6L1IjK6dO4UMmBVPWjVR6IIaSyybDzH4FpWhgwfwkNa0iv+9om2cDiV7iKwDi4yS6OUXmOHUcp6X0XE+1OY4SY5CcVr5aBxKu26DNNIX2WyS2ZcNeEl51elKwSKuh1IKZgGmm5V7zzqBxS1eh6KHI/JvW0anbPjtLYjhwBz8gXxcDC13UppTeKkOkQIEPfmiV9ZN131kcFfxtFVk+qhSe5SrGqAT8G4UH/kJp81OSXrwB639UUfnU3SIFqIvPXrJRiN/UJ53MZw814KaaHkfbuY0mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5VwAbCdll0w44+kVod7U29Tg9alkH8r50XNwh45bMI=;
 b=JocsIxoZfg28K+stzfAbLm4VgbSkkzkSGJv6NdWAJZELeVmjg5G6jqG6YQIjsVx7w+aqovinzIUyeczk9zAmhLFnJTqX8/ZWKdaFl6PBrB0RNrmrrhplBXMpstN24Uv8SBoy6TEP0o/dCK3vLAfvbWyMFTkHHw3zFfcyqWeppto=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (2603:10a6:208:ff::27)
 by AM0PR08MB4563.eurprd08.prod.outlook.com (2603:10a6:208:131::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Tue, 19 May
 2020 15:05:28 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f%4]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 15:05:28 +0000
Subject: Re: [RFC PATCH 0/3] block: Synchronous bdrv_*() from coroutine in
 different AioContext
To: Kevin Wolf <kwolf@redhat.com>
References: <20200512144318.181049-1-kwolf@redhat.com>
 <6d78bc78-0c44-d703-6f9f-e048ea34fdd9@proxmox.com>
 <20200514142606.GH5518@linux.fritz.box>
 <285ba39f-9ee6-e089-13f7-a98ea0a84866@virtuozzo.com>
 <548700ea-78db-fabc-d1eb-6d89af39ece3@virtuozzo.com>
 <20200519141858.GN7652@linux.fritz.box>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <dfed81f7-9806-9aaf-459f-13f786b67e0a@virtuozzo.com>
Date: Tue, 19 May 2020 18:05:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200519141858.GN7652@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR04CA0030.eurprd04.prod.outlook.com
 (2603:10a6:208:122::43) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.161.50) by
 AM0PR04CA0030.eurprd04.prod.outlook.com (2603:10a6:208:122::43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend
 Transport; Tue, 19 May 2020 15:05:25 +0000
X-Originating-IP: [178.34.161.50]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb54c8e0-e94c-4a34-90ae-08d7fc0610f1
X-MS-TrafficTypeDiagnostic: AM0PR08MB4563:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB45636EAB2C3F202E573AE73CCFB90@AM0PR08MB4563.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rjx1mGyhsfkqFSKW+yDnZhUPyiey3TYoaFQCxCni1K7BwrLzWDQrqiWTubDGhNrC7wDX7/Vz2/4DB3jBgmAyy95Teu3ntBZrfwPbdsSYNQFyRDluL3oYnvtwL+zejZ9iAFsJ+oLjTbYWdGiMn5DxoDCJzeKSombaWivcop/cUTHs/h/4GXieFaAjxM3z3YyXvJNyG4zLEw8NdxKD3h205X7wFwtJJfF6MNEgpuPO7HdJgDCoPq8bsR4BKwldFSpd42FhJ6nYizd+z+9F11Wy7BKNxLd+vLAoM7xADeMzVYwGchxTA4znbuQf1bDrnm6cs0VSNNLjiAMBa8D8WUJAXH31lWQIwNLzW/gT7UGKGSCtlnfBKhKNAbxnvtbx/KqK/y6P/cEaTIvZyERqC9odiOomgSG63JXuqLNVj5zZti0KGTrMpj3ERTg0i05A4km17eds0m/Emwy8M4jagaiWTkItaW6bY9Rc47FcXrUQ+fpzdnsZG/9QZvZkD5gGL5jEbX9C/nQEZ+7j153b6G27uAkY8CwF4sb7paXAsz/nPlXbfH6w8/kIPcLAVIwVjmjeyYOZ1FSy3bhPySwUP1ykTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(136003)(39840400004)(346002)(366004)(8936002)(66946007)(86362001)(66476007)(66556008)(956004)(54906003)(16576012)(2616005)(31696002)(186003)(16526019)(316002)(5660300002)(26005)(8676002)(4326008)(6916009)(31686004)(2906002)(966005)(52116002)(478600001)(6486002)(36756003)(53546011)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 94MipXOxTfd7rKziO0S+nEhD5A+HVpnrJ0femtvU8qtGTgsbJdwq6Py4SncZU3nBroyDZEJsNWfB5yi/BPepuYjeOGrnhHL/RxnYL7VI5e2g2xCjwVddXttmGbsAcefO8+OmmAcyuQkwx+YbOsS81BqqgWTP3SieSNo3ErIOk2S8j99B2B6cl/iWoTyLTfJeirFSlA5tLOPQTW0ZPM6XoizyIGpfG9BmcfuBSd/ucWjsH9ZQ52qustB6FnxSVyvM20bHo8qnNqiMGhws9vIm1KUs1EKMgCN182qP+1VCyzB5a1Pr27YwP1HDZXC4OFl+vPWTMi3QgyWlcYA5QT6BDr7nd2JA1xGqf+pvkawGvlcMxUGqEFSiirnAtOpcHBgQRS0HZIKxTZF0nwOJ+VN54DKpUxO+biMjM5Xlv9cfz6V6cwCsJS43DlG6v6y+s1tZwOi6/aRxnjjl3GtJvUktEeu1oBc/DwpF4MKMZdCYCuU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb54c8e0-e94c-4a34-90ae-08d7fc0610f1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 15:05:28.1933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IILGmM85Gq92kTGft9Jshjkg0CHCArU7w5Tfb6vQOCOErdJ1JAsI9eHNFx1A3cmme6N8O4QQGjo0h6gf5SlPYVPEOnWPQe6aZPFitOmsRoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4563
Received-SPF: pass client-ip=40.107.21.100;
 envelope-from=dplotnikov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 11:05:29
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, s.reiter@proxmox.com,
 armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 19.05.2020 17:18, Kevin Wolf wrote:
> Am 19.05.2020 um 15:54 hat Denis Plotnikov geschrieben:
>>
>> On 19.05.2020 15:32, Vladimir Sementsov-Ogievskiy wrote:
>>> 14.05.2020 17:26, Kevin Wolf wrote:
>>>> Am 14.05.2020 um 15:21 hat Thomas Lamprecht geschrieben:
>>>>> On 5/12/20 4:43 PM, Kevin Wolf wrote:
>>>>>> Stefan (Reiter), after looking a bit closer at this, I think
>>>>>> there is no
>>>>>> bug in QEMU, but the bug is in your coroutine code that calls block
>>>>>> layer functions without moving into the right AioContext first. I've
>>>>>> written this series anyway as it potentially makes the life of callers
>>>>>> easier and would probably make your buggy code correct.
>>>>>> However, it doesn't feel right to commit something like
>>>>>> patch 2 without
>>>>>> having a user for it. Is there a reason why you can't upstream your
>>>>>> async snapshot code?
>>>>> I mean I understand what you mean, but it would make the
>>>>> interface IMO so
>>>>> much easier to use, if one wants to explicit schedule it
>>>>> beforehand they
>>>>> can still do. But that would open the way for two styles doing
>>>>> things, not
>>>>> sure if this would seen as bad. The assert about from patch 3/3
>>>>> would be
>>>>> already really helping a lot, though.
>>>> I think patches 1 and 3 are good to be committed either way if people
>>>> think they are useful. They make sense without the async snapshot code.
>>>>
>>>> My concern with the interface in patch 2 is both that it could give
>>>> people a false sense of security and that it would be tempting to write
>>>> inefficient code.
>>>>
>>>> Usually, you won't have just a single call into the block layer for a
>>>> given block node, but you'll perform multiple operations. Switching to
>>>> the target context once rather than switching back and forth in every
>>>> operation is obviously more efficient.
>>>>
>>>> But chances are that even if one of these function is bdrv_flush(),
>>>> which now works correctly from a different thread, you might need
>>>> another function that doesn't implement the same magic. So you always
>>>> need to be aware which functions support cross-context calls which
>>>> ones don't.
>>>>
>>>> I feel we'd see a few bugs related to this.
>>>>
>>>>> Regarding upstreaming, there was some historical attempt to upstream it
>>>>> from Dietmar, but in the time frame of ~ 8 to 10 years ago or so.
>>>>> I'm not quite sure why it didn't went through then, I see if I can get
>>>>> some time searching the mailing list archive.
>>>>>
>>>>> We'd be naturally open and glad to upstream it, what it effectively
>>>>> allow us to do is to not block the VM to much during snapshoting it
>>>>> live.
>>>> Yes, there is no doubt that this is useful functionality. There has been
>>>> talk about this every now and then, but I don't think we ever got to a
>>>> point where it actually could be implemented.
>>>>
>>>> Vladimir, I seem to remember you (or someone else from your team?) were
>>>> interested in async snapshots as well a while ago?
>>> Den is working on this (add him to CC)
>> Yes, I was working on that.
>>
>> What I've done can be found here:
>> https://github.com/denis-plotnikov/qemu/commits/bgs_uffd
>>
>> The idea was to save a snapshot (state+ram) asynchronously to a separate
>> (raw) file using the existing infrastructure.
>> The goal of that was to reduce the VM downtime on snapshot.
>>
>> We decided to postpone this work until "userfaultfd write protected mode"
>> wasn't in the linux mainstream.
>> Now, userfaultfd-wp is merged to linux. So we have plans to continue this
>> work.
>>
>> According to the saving the "internal" snapshot to qcow2 I still have a
>> question. May be this is the right place and time to ask.
>>
>> If I remember correctly, in qcow2 the snapshot is stored at the end of
>> the address space of the current block-placement-table.
> Yes. Basically the way snapshots with VM state work is that you write
> the VM state to some offset after the end of the virtual disk, when the
> VM state is completely written you snapshot the current state (including
> both content of the virtual disk and VM state) and finally discard the
> VM state again in the active L1 table.
>
>> We switch to the new block-placement-table after the snapshot storing
>> is complete. In case of sync snapshot, we should switch the table
>> before the snapshot is written, another words, we should be able to
>> preallocate the the space for the snapshot and keep a link to the
>> space until snapshot writing is completed.
> I don't see a fundamental difference between sync and async in this
> respect. Why can't you write the VM state to the current L1 table first
> like we usually do?

I'm not quite sure I understand the point.
Let's see all the picture of async snapshot: our goal is to minimize a 
VM downtime during the snapshot.
When we do async snapshot we save vmstate except RAM when a VM is stopped
using the current L1 table (further initial L1 table). Then, we want the 
VM start running
and write RAM content. At this time all RAM is write-protected.
We unprotect each RAM page once it has been written.
All those RAM pages should go to the snapshot using the initial L1 table.
Since the VM is running, it may want to write new disk blocks,
so we need to use a NEW L1 table to provide this ability. (Am I correct 
so far?)
Thus, if I understand correctly, we need to use two L1 tables: the 
initial one to store RAM pages
to the vmstate and the new one to allow disk writings.

May be I can't see a better way to achieve that. Please, correct me if 
I'm wrong.

Denis
>
> We always have only one active L1 table at a time, which simplifies
> cluster allocation a bit, so it would be preferable to keep it this way.
>
> Kevin
>



