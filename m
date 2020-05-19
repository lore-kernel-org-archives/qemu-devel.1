Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1480CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 12:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1C47204EF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 12:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="aN5OYq2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C47204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb1TN-0006NM-1t
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 08:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jb1Qb-00037A-Cp; Tue, 19 May 2020 08:33:02 -0400
Received: from mail-eopbgr70127.outbound.protection.outlook.com
 ([40.107.7.127]:35875 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jb1QW-0004Oa-Ga; Tue, 19 May 2020 08:32:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsiW/T0pqRixq4u8xTDrUga1JRSLJUaJdYoLknyEYskffhe2jQuZPjx4EVBz+15Z1IUtcWDcmx95nvdbbZoqRB7xsqvL2jlKn9vrYbWR0IyUjbYnR/PiRI+A6A9S1+97YVmoSh2Hsi1m0yTfxB7NtzcimI+8wdbB8Y9vMOy/hnodIY8IIKPSOvQC4Ca4YxLR9Ixg4M3mFtxr/qUZaScNJS7Y45Rnh4o5xuaxRMHEo/ch1T55Sa+kgzlb2gxnZl0my4D/XK0QGsH9FFEWHa42YB240qHOc/eRBJ8gBhTuivW4HkCmjoLZpRk/JztUil5+tPX5gLUNpJbIzuKLEgopog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUAXb7oPRYWBp8jm8cjLKSqiIUl1sEtqymIR0rMbtd4=;
 b=kS7S1Cr68ZyjmJtPCAY//Ns6Vd1wOOtyoc0zO8GfV8Z81Ualbwf3CFdyk4t42Ar7EV4k7YmouEwlcLHDuX1Sw9zCGCL4/JuJc9MS5s8iSNocKxZZJqGnmdzAS2Dy7BGN0Sw76kZpzEMPHy2vpIeap4HB4d2tlj7ucoZmX8iywWHSfrvAH9WE2Zruw7Gjy1+oe0AiEw36x67eznlpIYVhrlDsfygvYqzjzL1qQQ75VVLXMP77GNfLaReaeIOTHO2z/Ysp/aeQWVky2bE71JlpQqplSP1NxczPx9THwNEYvDKELglY5d4OCNpBmabS/XEgNOjEkE1F9qXSiuRqARA3Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUAXb7oPRYWBp8jm8cjLKSqiIUl1sEtqymIR0rMbtd4=;
 b=aN5OYq2qqNkzZiIVoLbrPFP5WwlcOkleKfQ6LHTUsGoz8etk8sW5auOj5449A0VcFtBHhqBg5p/w7AErrS2K5AYLErmpu8T26P9kf989mEus57UUWPqlfa82SlD9RD/3EybtFHSX+6UEzVqabC3BZuLEn25yOeO6zqUgl+vsgZk=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5430.eurprd08.prod.outlook.com (2603:10a6:20b:106::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Tue, 19 May
 2020 12:32:46 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 12:32:46 +0000
Subject: Re: [RFC PATCH 0/3] block: Synchronous bdrv_*() from coroutine in
 different AioContext
To: Kevin Wolf <kwolf@redhat.com>, Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <20200512144318.181049-1-kwolf@redhat.com>
 <6d78bc78-0c44-d703-6f9f-e048ea34fdd9@proxmox.com>
 <20200514142606.GH5518@linux.fritz.box>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <285ba39f-9ee6-e089-13f7-a98ea0a84866@virtuozzo.com>
Date: Tue, 19 May 2020 15:32:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200514142606.GH5518@linux.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0071.eurprd04.prod.outlook.com
 (2603:10a6:208:1::48) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.178) by
 AM0PR04CA0071.eurprd04.prod.outlook.com (2603:10a6:208:1::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.24 via Frontend Transport; Tue, 19 May 2020 12:32:44 +0000
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c200b83a-454b-478e-2019-08d7fbf0bbea
X-MS-TrafficTypeDiagnostic: AM7PR08MB5430:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5430308D67A1CF9E56C468D1C1B90@AM7PR08MB5430.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hsKgvlZS3Brxb1m0RkFmdRmguRXRwAEbR+TxJgBCI+hYBXLPMwn5AEeTx1PtDSBoIX9qdbE4F8bV9D2Qwj8nWidOa35d1fP2LUNL7f3YxP4qn2lCB7p8iVQvLQlAuli3DdVH48WdVul8GeMt+/oXvT9gVbVJnKl/B9avuQ2y12rwivcdCq5OUnr3eumP7Db/ykQY+3ymMBQ/iSqltydZKuGkZDJPE6kmGLnpSrAm1qrbbaKYlCZDIC8WbdTGBx72LZVT1hEctCpMtK7TXrdbHYRHLRuzKOgI/B7wB9UQ58kepGqqvAsgWk5O/WSESHEWGgbjsu2/OQVMzdHI1vu8UySGmxSJ12JfYucpMQIOAtrCVMMQIaz+QZxBMgr6qkwky2vtz7GC29QUWNeGnLNEoKsB5eIuisZ3qqJZdZkziKSsHcgW7y5pE32dYpePzYe5WdBxnG41D+X0rXtg47ny6mIzV4QOtRRMPD1te+rx0/7XIIVRg85wxyTPAzJFma6cQedMeaKkyKI3tMgm1JmcCxDTGTL8MOon+c8m4B2Jci16ef8jRKt3OTgfn6ZdushQAwYbhh+rCn1y1d0/kaMcRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39840400004)(5660300002)(966005)(107886003)(31696002)(2616005)(956004)(66946007)(53546011)(8936002)(316002)(6486002)(36756003)(4326008)(66476007)(110136005)(16576012)(478600001)(86362001)(16526019)(186003)(26005)(31686004)(52116002)(66556008)(8676002)(6666004)(2906002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: +q4P8ETfw9tUdrKEolETkyhW/kQ6tcASnXXEvnNIKjK8lp0xknTEAX5WA2Aepfl/+FW7AMJKtAFQbHLkgZdikhdsNk2QYK9BJy4Tedn3SoQUZ+EwUaFDPONU00qiHK2HDHF9nF0obporPpz6rvmXCfjPY8wVEJOjlr2vlifSqPvwhOCiqYHUICiIZH5lFlpzV77pkLRxuo5yy7IXJDuHuuGItYh2fUtD4Bb1fVxHT78mz0/4RvxCnoR9asT8xYzm6VXQ5Vnk2VQYPHtltlx4oX4WFe/0t9xZEnJvyNLF6fQNDhmjWhPAcOkWPcVU+k2/deNZwhPnyNs+PpPT1mss43xy/maRxJ39EJpV3yqSmg4WgN4WgKIqrfbsR4ub7NTruEQ5GeY/8I706wvDCLrMWqx06aDbSml6EIu+2Vk/RR5IFkLCvegZ2Fap9EWhGHiwNQNtkb9egLT5rcVt3JCHC4N4y/H+BZ5Nqtx7MAjOZzytdauc7XvWrjNqlpjKwPyZ
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c200b83a-454b-478e-2019-08d7fbf0bbea
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 12:32:46.0745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8xJIY0zvWAqf90e8WhkNMk5jP9xpjqSjekvVQ3q/dvAZNrAqRTFDKYvL77NEm0zT5e1To5+CrDcZZDChRDvWxsJU17juDpcQQhaAL4k3D8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5430
Received-SPF: pass client-ip=40.107.7.127;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 08:32:48
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
 armbru@redhat.com, Denis Plotnikov <dplotnikov@virtuozzo.com>,
 stefanha@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

14.05.2020 17:26, Kevin Wolf wrote:
> Am 14.05.2020 um 15:21 hat Thomas Lamprecht geschrieben:
>> On 5/12/20 4:43 PM, Kevin Wolf wrote:
>>> Stefan (Reiter), after looking a bit closer at this, I think there is no
>>> bug in QEMU, but the bug is in your coroutine code that calls block
>>> layer functions without moving into the right AioContext first. I've
>>> written this series anyway as it potentially makes the life of callers
>>> easier and would probably make your buggy code correct.
>>
>>> However, it doesn't feel right to commit something like patch 2 without
>>> having a user for it. Is there a reason why you can't upstream your
>>> async snapshot code?
>>
>> I mean I understand what you mean, but it would make the interface IMO so
>> much easier to use, if one wants to explicit schedule it beforehand they
>> can still do. But that would open the way for two styles doing things, not
>> sure if this would seen as bad. The assert about from patch 3/3 would be
>> already really helping a lot, though.
> 
> I think patches 1 and 3 are good to be committed either way if people
> think they are useful. They make sense without the async snapshot code.
> 
> My concern with the interface in patch 2 is both that it could give
> people a false sense of security and that it would be tempting to write
> inefficient code.
> 
> Usually, you won't have just a single call into the block layer for a
> given block node, but you'll perform multiple operations. Switching to
> the target context once rather than switching back and forth in every
> operation is obviously more efficient.
> 
> But chances are that even if one of these function is bdrv_flush(),
> which now works correctly from a different thread, you might need
> another function that doesn't implement the same magic. So you always
> need to be aware which functions support cross-context calls which
> ones don't.
> 
> I feel we'd see a few bugs related to this.
> 
>> Regarding upstreaming, there was some historical attempt to upstream it
>> from Dietmar, but in the time frame of ~ 8 to 10 years ago or so.
>> I'm not quite sure why it didn't went through then, I see if I can get
>> some time searching the mailing list archive.
>>
>> We'd be naturally open and glad to upstream it, what it effectively
>> allow us to do is to not block the VM to much during snapshoting it
>> live.
> 
> Yes, there is no doubt that this is useful functionality. There has been
> talk about this every now and then, but I don't think we ever got to a
> point where it actually could be implemented.
> 
> Vladimir, I seem to remember you (or someone else from your team?) were
> interested in async snapshots as well a while ago?

Den is working on this (add him to CC)

> 
>> I pushed a tree[0] with mostly just that specific code squashed together (hope
>> I did not break anything), most of the actual code is in commit [1].
>> It'd be cleaned up a bit and checked for coding style issues, but works good
>> here.
>>
>> Anyway, thanks for your help and pointers!
>>
>> [0]: https://github.com/ThomasLamprecht/qemu/tree/savevm-async
>> [1]: https://github.com/ThomasLamprecht/qemu/commit/ffb9531f370ef0073e4b6f6021f4c47ccd702121
> 
> It doesn't even look that bad in terms of patch size. I had imagined it
> a bit larger.
> 
> But it seems this is not really just an async 'savevm' (which would save
> the VM state in a qcow2 file), but you store the state in a separate
> raw file. What is the difference between this and regular migration into
> a file?
> 
> I remember people talking about how snapshotting can store things in a
> way that a normal migration stream can't do, like overwriting outdated
> RAM state instead of just appending the new state, but you don't seem to
> implement something like this.
> 
> Kevin
> 


-- 
Best regards,
Vladimir

