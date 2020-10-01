Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3360C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4033020872
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wc43B8mC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4033020872
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNzDk-0003sF-0Y
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 10:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kNzCU-0002tJ-8i; Thu, 01 Oct 2020 10:04:50 -0400
Received: from mail-am6eur05on2093.outbound.protection.outlook.com
 ([40.107.22.93]:63629 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kNzCD-0005I2-6U; Thu, 01 Oct 2020 10:04:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHhzDMB6GsSswQ1Kl+ex9tAMBZXUni4HiNFVlKSI/HPkB/CpqH8qh/m8r3bxjZk/uvRhCfdxumwgXbw/GBvFqvV0+uYfzOSFyFn/TTqEMXGpLqfdHbgNXLjq0o8fUiRmYn3TTvoGPvszUguPwu0SNYLfMh1r2KKoHVwDmwvvqgTCumeETbQ0rwRsl3x23uD8qt5pEU4f3rKxyG3NnrY72F6NfOP/am5gNah0tGf0sDNUiu7pZYWMNrWg6gLRNN8FCLvl/DFkxTc3InHbMjT7IAthS4Veedi5zstJbNV2CYddayU0elcGJkmEzX8FdXuOMjJzacW3lvg2DWtDwuB93A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lx3k+dwmQzdglGydwYYkhfltammJ5vcf5OfpjfGGSmI=;
 b=QHXlj/74YehMLu58txz/tasCSAdrZTFZ2gncEG0PYIGfF0kCVLwVVJxHASHpmQ/sn7GRLGYMeBaGoN8WqXIGZCvCsMWjC5KYoaRPbjHKkfPLYNovF94nN4KN2KXQVgwjKzqf9GLwfMj5t1qSQ7Y5bxobAvIjIiQMnd/KIQ2mV+fFqRvSNUNPgG/rNzF/impUnu6MnzteBUnd2WIGTCbnUJSPxnFLK5ZmuP6r7p1t/l1g5z9jXQRPJ0rNWSiCje3JcegN39Ky+8LmgrdmyqC6dJE67V9G42rzdioen/csG1f9dWLHTO09m4gReyKdTMmEvmGUsdSMWm4pazc50FQA2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lx3k+dwmQzdglGydwYYkhfltammJ5vcf5OfpjfGGSmI=;
 b=wc43B8mCpoBcLf4FUvx8iYTCyO31GIycoi8BFAmv3p3TVDixfybDUyJsmgyot/459Z3+4xc0ubpJ4WJr7XljdMWk3RqwECKgGQZNC9tihiRk2X5hbbd16EcwW4fnMkMtFHyg0Bj66Brtd0wFRwywvS4RER/o+P/BsX85eZjFjPY=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3959.eurprd08.prod.outlook.com (2603:10a6:20b:aa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Thu, 1 Oct
 2020 14:04:24 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3433.034; Thu, 1 Oct 2020
 14:04:24 +0000
Subject: Re: qcow2 merge_cow() question
To: Alberto Garcia <berto@igalia.com>, qemu block <qemu-block@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
References: <b44aafbf-bd00-3bc0-68c4-5cc01a6b8b01@virtuozzo.com>
 <w51wo1si2jv.fsf@maestria.local.igalia.com>
 <20684b8e-4f13-794a-f3d2-974ba380277b@virtuozzo.com>
 <w51lfgspqw6.fsf@maestria.local.igalia.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e8de6d58-2b43-5d4c-6981-8b07c70db6b1@virtuozzo.com>
Date: Thu, 1 Oct 2020 17:04:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
In-Reply-To: <w51lfgspqw6.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: FR2P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.82) by
 FR2P281CA0027.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.18 via Frontend Transport; Thu, 1 Oct 2020 14:04:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 836c2e06-10e9-4bde-9978-08d86612e6dd
X-MS-TrafficTypeDiagnostic: AM6PR08MB3959:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3959850D52AAA5BA866C10BFC1300@AM6PR08MB3959.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HBIBnX9zlrdQ5QV2Ubm6n4qE8Vw0/qnhQnHGZeRIyixqjawX3ImaifhqjBMEMA2xNdo8pDZYZ16HO9b0z+onFlem+I4psWiRgF86+MT/WT6EPRY7cgfb5iTWjJXDnw9ia7XLZdacTlwmgCbFbCOPDEdzWfBjitmTInHHLid6MmEqeBddJ7vIncNzzxV8txKx5JYD10pq8cPqp2bcrkoDDMX7EcuLGknjV73pt9Yg/XMknd3WGXFfDqcW6Fpl35juL6ahlotGrOq8XTVdfmF+cRjtus8tjCCW2h13ylp2DCIO4Z++0JyzkU2ENl0oRKn3XLjzMTyQe/xlsuYcEzEPfRNspd4Dty0YsCBLjWY1UsogPeewRWcnPUUWJ5CtOJ5u
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(136003)(39830400003)(396003)(16576012)(316002)(66946007)(2906002)(66476007)(66556008)(956004)(478600001)(54906003)(8676002)(2616005)(86362001)(4326008)(5660300002)(31686004)(8936002)(36756003)(26005)(31696002)(110136005)(83380400001)(186003)(16526019)(6486002)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: oKgidwzdUa+3qCOW9uFrgwjowOT5yR4cGE5N549snNnkSH+elPXiKTzQkwyk7zKjtpzAPLr2wGgnlOaSWjgKTzS5eV3vWNP5Oh656Fyx+I5ZWfCMljiuHItKTcwOpPZ/4zWJSg2cemxjTmgprVzBBmBO1vPKvIZHabEzz+H53mAPd6rvidJHPQhTgWdWaoAKF+FkP8/xtssvpFByFP49La+A0HdwhB5mbgl6OqjgqVjPlEw6UwF5DUAivkNy45zoicR0TmBt78EoKFidZb3CoORILDIGNHRVxSuaW2wLSHryV8QMEWZmQAGVJ/RrB/E1/t7xKhxEt+yM6y0hQmDYAJ2eKQ3KN4sFUxws57qIY6/h20vs8GcFF98oQE4pAPckUmRkcJmwa0TyzQt7XBuRJ84Aa0Ietyra9WxKC432bP3VbkY1YoP9jv/gjJLzbKAQXHz0KQ/w89KyiI+UBUY86jfqxyERbKhnTq48yCYoWL8o3kIbcJfPGamYGBVp1ic3HUQNNgnnIZ1dkNb8spU3rKXOAN8Hd3hH9hfSyken2wvGHaTYvMvq9YZT69WUFNr9S84odUORF5gQP4lecNfkDob0fdUtCilMmmoQJAab7elihmCHESvtwmoHvhZtTjdyV91SW/WxiHmh4S8DXhOW5w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 836c2e06-10e9-4bde-9978-08d86612e6dd
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 14:04:24.3105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0g/VJlhgFapj02uv5q3WYaLVpri1fk7+YctCrM95UO0c1BDbXRj+ceem+nMrkU6fZuKoiiGwaApfqEk+/0Nx9k20FerTPruIm8+dnO7ckA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3959
Received-SPF: pass client-ip=40.107.22.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 10:04:26
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.26, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

29.09.2020 18:02, Alberto Garcia wrote:
> On Fri 21 Aug 2020 03:42:29 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
>>>> What are these ifs for?
>>>>
>>>>              /* The data (middle) region must be immediately after the
>>>>               * start region */
>>>>              if (l2meta_cow_start(m) + m->cow_start.nb_bytes != offset) {
>>>>                  continue;
>>>>              }
>>>>                                                                                                              
>>>>              /* The end region must be immediately after the data (middle)
>>>>               * region */
>>>>              if (m->offset + m->cow_end.offset != offset + bytes) {
>>>>                  continue;
>>>>              }
>>>>
>>>> How is it possible that data doesn't immediately follow start cow
>>>> region or end cow region doesn't immediately follow data region?
>>>
>>> They are sanity checks. They maybe cannot happen in practice and in
>>> that case I suppose they should be replaced with assertions but this
>>> should be checked carefully. If I remember correctly I was wary of
>>> overlooking a case where this could happen.
>>>
>>> In particular, that function receives only one data region but a list
>>> of QCowL2Meta objects. I think you can get more than one QCowL2Meta
>>> if the same request involves a mix of copied and newly allocated
>>> clusters, but that shouldn't be a problem either.
>>
>> OK, thanks. So, intuitively it shouldn't happen, but there should be
>> some careful investigation to change them to assertions.
> 
> I was having a look at this and here's a simple example of how this can
> happen:
> 
> qemu-img create -f qcow2 -o cluster_size=1k img.qcow2 1M
> qemu-io -c 'write 0 3k' img.qcow2
> qemu-io -c 'discard 0 1k' img.qcow2
> qemu-io -c 'discard 2k 1k' img.qcow2
> qemu-io -c 'write 512 2k' img.qcow2
> 
> The last write request can be performed with one single write operation
> but it needs to allocate clusters #0 and #2.
> 
> This means that merge_cow() is called with offset=512, bytes=2k and two
> QCowL2Meta structures:
> 
>    - The first one with cow_start={0, 512} and cow_end={1k, 0}
>    - The second one with cow_start={2k, 0} and cow_end={2560, 512}
> 
> In theory it should be possible to combine both into one that has
> cow_start={0, 512} and cow_end={2560, 512}, but I don't think this
> situation happens very often so I wouldn't go that way.
> 
> In any case, the checks have to remain and they cannot be turned into
> assertions.
> 

Hmm, very interesting, thanks! So, at least "empty" cow regions are possible inside data region. It's good to keep in mind. I'm sure that some good refactoring is possible here.. Maybe in the distant bright future :)


-- 
Best regards,
Vladimir

