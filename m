Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D53C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:43:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2775E20714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ci/UJwvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2775E20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE8ka-0000Ua-7p
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 05:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jE8jq-00087J-2Y
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jE8jo-0005gy-Bh
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:42:17 -0400
Received: from mail-eopbgr00111.outbound.protection.outlook.com
 ([40.107.0.111]:36257 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jE8jo-0005Fo-3O; Tue, 17 Mar 2020 05:42:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAGm3p5h/c3Jn6E0T/QthJNOPoCtdBmdPNukned8O8AnG1HjRf8c2vd1+k8viDFfJRjXnnuH2ejnOyUwHvnpmkgRJ/7VOUd/yIl8vHo7hHwcW89xCWLz4Gh8VKHOJdU4CGE1Bj/d7J3WIY1ebvYiJ6VTi1KjeeSdXVhOrIQ4VAwKD24ybdi+HWqjidOxopaZdalHQk9mt5AgQgoaPHr876OVT9/mifPebuRE2OnyPyD9ZDV6KwRHi6ALKi3Ow38taVmuIynwBii4Yt8nbfCzB6Py3eriE6xWgtsz+gvBzGFxL6C/g8iPIE5H75/qOleEG8RIJ2UOd6epr+OGGVmJPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXIrKZnGV8uShkz+6JSMur7bn9zGmhlSZt9rYDbIgqQ=;
 b=HJDjvra/ik7PtXNdueI0PxUXUowO3zVFSA3PNlasvYb6RPPCjhDUtxYiHLX0KlrlfT+ERQiQZsfStP42AbkMoAoTKr6qSmTf80c//FZz05MgySIsxAjM4Xb0PYXCy9AjXjOVl7vCvjoVMHADEdvCFwB5QQCCsi8Xj6DhpzXcLNfoDM3c2ayFl/rAHgX4O6c9jFtUqDfeqNjYZ0xZ7JRbbwkwbAtNCsiy7n4h/6B5GVwGcswhMPtSTnPM7Y3IwB2q440qQdP5zr5fh+10mBkMKlXp0BBmM2Fj1skj6QQdc7Vv9KsfhWwKLwC/1mnhIuK/RjSf66VN19aBquG7FOkeRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXIrKZnGV8uShkz+6JSMur7bn9zGmhlSZt9rYDbIgqQ=;
 b=ci/UJwvIGx5k88nPldSDy2GMglL/qqa7dRtmIUZQKbo12Cg1ZNiLUbPJKn5JCvnDzDLDM/OBGadzM2lWaDHVmoXAPTql0XsNmxGerDv9iZz4G6z+oucKdPsm0rHpAdp+DcTwUz9Tff+RM7pkmZ+OajQ8kujSrUTf4SYAHWjCYPI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com (10.175.35.136) by
 HE1PR0802MB2409.eurprd08.prod.outlook.com (10.175.33.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Tue, 17 Mar 2020 09:42:11 +0000
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f]) by HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f%12]) with mapi id 15.20.2814.021; Tue, 17 Mar
 2020 09:42:11 +0000
Subject: Re: [PATCH v7 00/11] error: auto propagated local_err part I
To: Markus Armbruster <armbru@redhat.com>
References: <20200131130118.1716-1-vsementsov@virtuozzo.com>
 <87y2shdg00.fsf@dusky.pond.sub.org>
 <87abeabb-c8ee-ed6f-6b3a-b3fc24d07b89@virtuozzo.com>
 <87r1xsfjnh.fsf@dusky.pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200317124207292
Message-ID: <97edc043-6ad8-0dd1-4eda-663b350072dd@virtuozzo.com>
Date: Tue, 17 Mar 2020 12:42:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <87r1xsfjnh.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0004.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::14) To HE1PR0802MB2507.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.248) by
 ZR0P278CA0004.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.18 via Frontend Transport; Tue, 17 Mar 2020 09:42:08 +0000
X-Tagtoolbar-Keys: D20200317124207292
X-Originating-IP: [185.215.60.248]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99de89e7-b7e1-4602-73be-08d7ca577703
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2409:
X-Microsoft-Antispam-PRVS: <HE1PR0802MB24096AA289A08D5A5A4966FEC1F60@HE1PR0802MB2409.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(136003)(376002)(396003)(366004)(39850400004)(199004)(7416002)(6486002)(4326008)(2906002)(36756003)(478600001)(186003)(2616005)(86362001)(5660300002)(16526019)(956004)(26005)(81166006)(81156014)(8936002)(8676002)(66946007)(66556008)(66476007)(31686004)(16576012)(31696002)(6916009)(316002)(52116002)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2409;
 H:HE1PR0802MB2507.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v0IMbzFjhPMgsr6JNq6WEodQ8826TVSIJZ2FpNoXweRIofOfEllNBXMO1HKN5UJiYAe8Wml868JPJ1sIUAtqX5ChwnwgUL+yg2cUH0VvvcIVlj1rBCei4flGSivLzzLFlCOoe5GJeBEHCXiNX5noc/1TShxwQX9IRZTRp+Wg958CTjOOuqWxArZ6ITZzraFv4JkXGaZvvPz+GmswiOvdbvS/vZ37lrkg7TrtiT0XKymsKq1M8Q3ngJ8l41bjBVDWnb4SWbgVB4erySUhiJfL+y8ZK4XHWR16K1uHbBjoTGKqXiDywZjsPZfDFCPkxRGFYOn4phFxQyNMNWqJvgZRhljFcAac2WZuUEAOK1Sa8IJf+PrKkbC01ctBykMrAsRuheGzxbigbFxrYkWF/3JBD4siZN7Joz4XW9K5acNXsWChdnyrx7Vof4/IOoUw8TCt
X-MS-Exchange-AntiSpam-MessageData: SnWv491aGNSFBak2gNfLU+JGMoZ3Fa083mZISh5wBtQ8saNt+8ODi5oxcenDr8S0NOKEOAL4dTiRZGGhJDPgJU+po7z1ykOHrKe0c1ntOi4reMtQlTIMMggrBSLapBVrN81TXZVBhm3/iek68iuCyQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99de89e7-b7e1-4602-73be-08d7ca577703
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 09:42:10.9632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YQZfKrPcX6hDs1sz2iLl1M0VS0QoiHcD8sdfkhE0k4SEFAaHul5IvVqJ+vmJ7QbyhY2dE5YZ/JqFJW9iOAuG1pRhFV8msqWxKPfY0LR8wQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2409
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.0.111
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Paul Durrant <paul@xen.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

16.03.2020 17:40, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
> 
>> 03.03.2020 11:01, Markus Armbruster wrote:
>>> Hi Vladimir,
>>>
>>> I've come to rather like your ERRP_AUTO_PROPAGATE() idea.  What I
>>> wouldn't like is a protracted conversion.
>>>
>>> Once we're happy with PATCH 1-3, it's a matter of running Coccinelle and
>>> reviewing its output.  I'm confident we can converge on PATCH 1-3.
>>>
>>> It's two weeks until soft freeze.  We need to decide whether to pursue a
>>> partial conversion for 5.0 (basically this series plus the two patches
>>> we identified in review of PATCH 1), or delay until 5.1.  In either
>>> case, I want the conversion to be finished in 5.1.
>>>
>>> Please do not feel pressured to make the 5.0 deadline.
>>>
>>> I can queue up patches for 5.1 during the freeze.
>>>
>>> How would you like to proceed?
>>>
>>
>> Hi Markus! Funny coincidence: exactly now (less than 1 hour ago), I've
>> started working for the next version for these series. So, I'm going to
>> resend today. Of course, I'd prefer to merge something to 5.0 if at all
>> possible.
> 
> That was v8, followed by v9.  We're clearly converging.  However, the
> soft freeze is tomorrow already.
> 
> You've persevered with this idea for quite a while; some impatience
> would be quite excusable now.  Still, I doubt part I making 5.0 matters.

Not a problem. I hope, I'll resend soon, then it will be up to you.

> The hand-written part is likely to rebase easily, and the generated part
> should be regenerated instead of rebased anyway.
> 
> What actually matters is *finishing* the job.  What does that take?
> 
> * Consensus on the hand-written part.  I think we're basically there, we
>    just want to work in a few more tweaks.

I'll resend today, most probably it would be your version of coccinelle (if I will not find real sense in fn inheritance).

> 
> * Split the generated part into reviewable batches, regenerating patches
>    as necessary.  Solicit review.  First batch is part of this series,
>    and v9 looks ready to me.  I assume you'll prepare the remaining
>    batches.

Yes I will. This is the reward for this work: send one hundred generated patches :))

> 
> * Queue up batches as they become ready, post pull requests.  I can do
>    that.
> 
> * Update the QAPI code generator to the new Error usage.  I can do that.
> 

Great!

-- 
Best regards,
Vladimir

