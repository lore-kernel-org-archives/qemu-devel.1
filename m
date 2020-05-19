Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B0EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 13:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A167F2081A
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 13:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="fScYmAJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A167F2081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb2hz-0007br-TM
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 09:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jb2hR-00078d-Gn; Tue, 19 May 2020 09:54:29 -0400
Received: from mail-vi1eur05on2138.outbound.protection.outlook.com
 ([40.107.21.138]:56865 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jb2hN-0006MD-WF; Tue, 19 May 2020 09:54:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6Xz5LJpMJFzSujGj/egW98iD6NLIGtmN70SXQ409GcJ91QzsGHo39ZDbLWY5HsseWvnkTWr9gsw5Eir1ZgdwP0fSNp+k6YVV8MuLZfv1wiL0yRhj88axUSQv5fy9g3t2V+ODWax/Fnup+dw4E0cSe8xxaYv0bo0doaqn1ubyrbpjbRQcv0hCCD19eyx5S27o6UbUgp2Dnetj/Wwpp6ql6WGAk6VnMKfzZhQlDdbzNBs/FVgxXM7Xq47hwsSq6G8ahX53xYSKbeewIt/Lh02ijj6aSGGRLvWWX6t/p8PdbRpyl2I95oaW5tHeM4ioF0W+shZMhINIkVXAj7Esm13MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JxQ27pguuiA+IvdhqeDsfOWlU3+z18UAh4Cz2auIho=;
 b=LvVobWlAaiv4H0c+ga8M6L0InwsQ3BcrunrLNoeip82quQI7rzNLWncffVnGQNMHMNrnKjLhD9K8ObUuxfW/TMupBrLh7SFKl2wl5jbsEMbq7SW95MXIEjM5xoHnO1iSlvwlx8md4Bxvsw6dyB1+NIK88bOs0w+x+uez2n3qxA7zPZZg0N20W/OI5QAZ6WDqAXTqil8P2swD+/b0nqbjRxOuU0pjUE39NNdn/6z0kv0UFJ6PUK0kYk5yWICl+oYQSpAfjD1odlArkgcnexOqgvirraafqT+Dv4Y6Y1aghUpsgfOO7EL7qXxX+Kz9O62nf+9zVjnctR3GixZ+iIhgHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JxQ27pguuiA+IvdhqeDsfOWlU3+z18UAh4Cz2auIho=;
 b=fScYmAJWBqRr8CQmJtY9Plnhn8tE1c9B4+rhwDIsJ1t6Sbf2kWvTo9EWqTfzuRHFbUdFeE8frCKueb8Nk/FxgujgnDGC2ad1jWzA5xLp5rgbLvb1j1kCWRxuLLEclxXzFq3oaGZ7iLainBh7cHmHb/Z2UybfaeE9+m9gGjPB9SE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com (2603:10a6:208:ff::27)
 by AM0PR08MB5236.eurprd08.prod.outlook.com (2603:10a6:208:155::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Tue, 19 May
 2020 13:54:20 +0000
Received: from AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f]) by AM0PR08MB3745.eurprd08.prod.outlook.com
 ([fe80::95e6:1da8:1244:d16f%4]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 13:54:20 +0000
Subject: Re: [RFC PATCH 0/3] block: Synchronous bdrv_*() from coroutine in
 different AioContext
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <20200512144318.181049-1-kwolf@redhat.com>
 <6d78bc78-0c44-d703-6f9f-e048ea34fdd9@proxmox.com>
 <20200514142606.GH5518@linux.fritz.box>
 <285ba39f-9ee6-e089-13f7-a98ea0a84866@virtuozzo.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <548700ea-78db-fabc-d1eb-6d89af39ece3@virtuozzo.com>
Date: Tue, 19 May 2020 16:54:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <285ba39f-9ee6-e089-13f7-a98ea0a84866@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR0302CA0036.eurprd03.prod.outlook.com
 (2603:10a6:205:2::49) To AM0PR08MB3745.eurprd08.prod.outlook.com
 (2603:10a6:208:ff::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.161.50) by
 AM4PR0302CA0036.eurprd03.prod.outlook.com (2603:10a6:205:2::49) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend
 Transport; Tue, 19 May 2020 13:54:19 +0000
X-Originating-IP: [178.34.161.50]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3162b81-3ab0-4382-b978-08d7fbfc2100
X-MS-TrafficTypeDiagnostic: AM0PR08MB5236:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB5236F44A52C489D5BA679E6ACFB90@AM0PR08MB5236.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tlPlS3ePR3ncHdnWRnz8s/Zk7qFn0xLdor77Agen0ejd3eUywRUyp07YkUjYCRTlJVQ8vWFPC5YT6VlIg/fay7BXSI3Ajop+ge4mujsWA/6VZelIByOLlXiIhSJwJvLHo5c0TN3wg5rZU6db0CNBEsZy6ut855IoXGNuBiDXngTysPoq5eYvWRJFjym0jYfEYoY2ozF1TpdMlqZ647Y6eUU9BSlja1m+9HCr6SpyfLODvtdhEWiLYxl15wlERy6S++OzFhuChIpMWip52TIC3SLGWPXcpyj3VqQTMrVBnMVqiyfadR8owFCUSUdnbDEZqGISiODeiDxdDJBzU9G6liRNt8JEjYkKLE1CrhwDSo60qyp/DtUEtkakxe2y91ezsSB6Tb0P3vAkEXLCTN1uz9YkQea+74EGEFd0ASzlYGWH9AmsrqEnD6x6tUUU8UrsAGMIz7VP0ABLkAm4XwFqrSd3NvPJaGhDZ/OkrDDaj1cffEfesQp/q5sNmXmwqB8cD1xuho/vlbcfYVNY2MwPU9EHbdun+9RWr3WHCZy93WNp1PRZPKHWpDoS0UEUhis7HQtE97Gi9ZCnkPKmyTTdng==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB3745.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39840400004)(346002)(136003)(366004)(396003)(26005)(36756003)(478600001)(316002)(31696002)(110136005)(31686004)(966005)(16576012)(2906002)(86362001)(2616005)(956004)(6486002)(52116002)(5660300002)(66476007)(4326008)(8676002)(186003)(66556008)(66946007)(16526019)(53546011)(8936002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: kXebKQSFhdyC9Dsjr4Ug4hTwL/sHC+oy7AsER86uVlu4AH68COqH2iP/Nwju23J/sgg55WU6XStV5fFXFOwQwCD5oM1yqXWAByGD1WpyOnTOc6bBlNHHonX6gSOBxEtw0gHKT3CH2K11fOke3xBGPD9Z5JzO5K5YDaPjC/cg+9SKhY7CpHGGwhflcCVX10vJH7KULANkyUTLnAqF6Z6+Y+gwRip7w88JJbq+AMace9kNloiOaYhkmaHy0+8SHHt3OyA0kZ2tbIz2V+qU+eqp55Og8ftEUGI9+Ualy9VzN1KzAc92ew8uRmXeSly5fsyAAh1hpzyvli3qImWMUynUYOn0XASnRPiUSZwzMFMo0x7WmURn03TLGTg5DBNygMYmzYgDJpH/cA9FLa5CToF1X2ZlMzJd91K907NwqjgtyumLiCTXJJYhs922phyhOfkuBOGugeoISxniqozY/hCEpGs28k295Y3sNrVGW8dArpU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3162b81-3ab0-4382-b978-08d7fbfc2100
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 13:54:20.1899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4oZlaVlJyOskUrklO5GiEQIrG07lT4yc7jYiLHeZgF2D3kTzTtZx3I+hMLN706vYummoBDWbEUV4ItfQ7eMsmeWYLKKPaPJmPggUQsxzJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5236
Received-SPF: pass client-ip=40.107.21.138;
 envelope-from=dplotnikov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 09:54:21
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
Cc: qemu-block@nongnu.org, s.reiter@proxmox.com, qemu-devel@nongnu.org,
 armbru@redhat.com, stefanha@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 19.05.2020 15:32, Vladimir Sementsov-Ogievskiy wrote:
> 14.05.2020 17:26, Kevin Wolf wrote:
>> Am 14.05.2020 um 15:21 hat Thomas Lamprecht geschrieben:
>>> On 5/12/20 4:43 PM, Kevin Wolf wrote:
>>>> Stefan (Reiter), after looking a bit closer at this, I think there 
>>>> is no
>>>> bug in QEMU, but the bug is in your coroutine code that calls block
>>>> layer functions without moving into the right AioContext first. I've
>>>> written this series anyway as it potentially makes the life of callers
>>>> easier and would probably make your buggy code correct.
>>>
>>>> However, it doesn't feel right to commit something like patch 2 
>>>> without
>>>> having a user for it. Is there a reason why you can't upstream your
>>>> async snapshot code?
>>>
>>> I mean I understand what you mean, but it would make the interface 
>>> IMO so
>>> much easier to use, if one wants to explicit schedule it beforehand 
>>> they
>>> can still do. But that would open the way for two styles doing 
>>> things, not
>>> sure if this would seen as bad. The assert about from patch 3/3 
>>> would be
>>> already really helping a lot, though.
>>
>> I think patches 1 and 3 are good to be committed either way if people
>> think they are useful. They make sense without the async snapshot code.
>>
>> My concern with the interface in patch 2 is both that it could give
>> people a false sense of security and that it would be tempting to write
>> inefficient code.
>>
>> Usually, you won't have just a single call into the block layer for a
>> given block node, but you'll perform multiple operations. Switching to
>> the target context once rather than switching back and forth in every
>> operation is obviously more efficient.
>>
>> But chances are that even if one of these function is bdrv_flush(),
>> which now works correctly from a different thread, you might need
>> another function that doesn't implement the same magic. So you always
>> need to be aware which functions support cross-context calls which
>> ones don't.
>>
>> I feel we'd see a few bugs related to this.
>>
>>> Regarding upstreaming, there was some historical attempt to upstream it
>>> from Dietmar, but in the time frame of ~ 8 to 10 years ago or so.
>>> I'm not quite sure why it didn't went through then, I see if I can get
>>> some time searching the mailing list archive.
>>>
>>> We'd be naturally open and glad to upstream it, what it effectively
>>> allow us to do is to not block the VM to much during snapshoting it
>>> live.
>>
>> Yes, there is no doubt that this is useful functionality. There has been
>> talk about this every now and then, but I don't think we ever got to a
>> point where it actually could be implemented.
>>
>> Vladimir, I seem to remember you (or someone else from your team?) were
>> interested in async snapshots as well a while ago?
>
> Den is working on this (add him to CC)
Yes, I was working on that.

What I've done can be found here: 
https://github.com/denis-plotnikov/qemu/commits/bgs_uffd

The idea was to save a snapshot (state+ram) asynchronously to a separate 
(raw) file using the existing infrastructure.
The goal of that was to reduce the VM downtime on snapshot.

We decided to postpone this work until "userfaultfd write protected 
mode" wasn't in the linux mainstream.
Now, userfaultfd-wp is merged to linux. So we have plans to continue 
this work.

According to the saving the "internal" snapshot to qcow2 I still have a 
question. May be this is the right place and time to ask.

If I remember correctly, in qcow2 the snapshot is stored at the end of 
the address space of the current block-placement-table.
We switch to the new block-placement-table after the snapshot storing is 
complete. In case of sync snapshot, we should switch the
table before the snapshot is written, another words, we should be able 
to preallocate the the space for the snapshot and keep a link
to the space until snapshot writing is completed.
The question is whether it could be done without qcow2 modification and 
if not, could you please give some ideas of how to implement that?

Denis
>
>>
>>> I pushed a tree[0] with mostly just that specific code squashed 
>>> together (hope
>>> I did not break anything), most of the actual code is in commit [1].
>>> It'd be cleaned up a bit and checked for coding style issues, but 
>>> works good
>>> here.
>>>
>>> Anyway, thanks for your help and pointers!
>>>
>>> [0]: https://github.com/ThomasLamprecht/qemu/tree/savevm-async
>>> [1]: 
>>> https://github.com/ThomasLamprecht/qemu/commit/ffb9531f370ef0073e4b6f6021f4c47ccd702121
>>
>> It doesn't even look that bad in terms of patch size. I had imagined it
>> a bit larger.
>>
>> But it seems this is not really just an async 'savevm' (which would save
>> the VM state in a qcow2 file), but you store the state in a separate
>> raw file. What is the difference between this and regular migration into
>> a file?
>>
>> I remember people talking about how snapshotting can store things in a
>> way that a normal migration stream can't do, like overwriting outdated
>> RAM state instead of just appending the new state, but you don't seem to
>> implement something like this.
>>
>> Kevin
>>
>
>


