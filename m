Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0191C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 09:19:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BECA2072A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 09:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hI+Qmmoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BECA2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA98U-0002tN-Ju
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 04:19:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jA97q-0002PV-Qk
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:18:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jA97p-0006Wd-Oo
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 04:18:34 -0500
Received: from mail-eopbgr70112.outbound.protection.outlook.com
 ([40.107.7.112]:57798 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jA97m-00067q-9V; Fri, 06 Mar 2020 04:18:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvGpG+d52L8loygRotQdeAIErqcXn/FGN/40eTCFei6RyuMnHXIysxtLREbU0Ge4jzNP6f4uPnLilJnPiRvrtJ8CtFeYCd+I+3Ieo5I8Yg8dpD/AYidx1WvgpRLiQNBF3uf+eWi0RWnGEQLh80VLRaU/X8D8Hix0kSJKLHusRVbcN1HwwjL5nsxHYiNS8R4wxC/QvFlnykN0oL+BP+DPzM7d8GI1a3LCP++bn7AfeEhe4hR5BrSUuP8qZtV0nvmdknbvLSHSWBg6Fd7zdhVjwsYkEm5X45zq6Jpb2vwWH7OGWiIqCl0ibtJOcemIFHKnWyDAcoZ8SHmofWjXjF8vCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95jCxrGKzOtPnhruszenmv4/DYv3dPCtLMe3bX3oBmY=;
 b=i7PsQaKlcqYNfgBQvEBYPopS7DNB+Dtg1o9jGL4NmLloIxzJbuayG++YHsWxqNtr+acVpXeQuCrMARxr8cQ7oGfIkNTvYAnzWq5chXWr9hPPFnrWaeUttuSvcl5Wq8uZsTzRgZS8R2TKOrohK/42aOZELenoRqcSIahsu+8Oi2Yart+2xg5CD1ROkSqj/rIPUweqRc4PBhkXgqnJHgFkwVjdVstEeXWDUAImoeejprUIntn4cGkQGJ/OiPF6mgOz3zJD3SpK7JrDwPWVTiJwq0C7KE/JKuVNugBEonw5oFpkYViyIZmDTeybLCAx7aBGuxg7CkJOBwu7I9Gz1aOpEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95jCxrGKzOtPnhruszenmv4/DYv3dPCtLMe3bX3oBmY=;
 b=hI+Qmmoq6hq1OjjQ5PFO8qzbx0fgE+HQBi0rICvcz+mDmiY7789wLXS3S1GLvixJHDKPhOdU5KpiBHh/z3/Bt1skm+/jAnCSa2AdJv6Nd1yRkJQnRupCZjxEdPocXbgoOwfr9nlODZhoa6us39dArqxRurp2aoFa51bhGcLhFFM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4440.eurprd08.prod.outlook.com (20.179.6.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Fri, 6 Mar 2020 09:18:26 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::e05a:63af:818c:b664%4]) with mapi id 15.20.2793.013; Fri, 6 Mar 2020
 09:18:26 +0000
Subject: Re: [PATCH v8 10/10] xen: introduce ERRP_AUTO_PROPAGATE
To: Paul Durrant <paul@xen.org>
References: <20200306051536.27803-1-vsementsov@virtuozzo.com>
 <20200306051536.27803-11-vsementsov@virtuozzo.com>
 <CACCGGhAdx_OX-V59omuSQZccUWBNft063BO4-TPAw=JHNbuGoQ@mail.gmail.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200306121823677
Message-ID: <fcb2a459-8732-8bb9-26f9-498526dedb28@virtuozzo.com>
Date: Fri, 6 Mar 2020 12:18:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <CACCGGhAdx_OX-V59omuSQZccUWBNft063BO4-TPAw=JHNbuGoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0371.eurprd05.prod.outlook.com
 (2603:10a6:7:94::30) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.200] (185.231.240.5) by
 HE1PR05CA0371.eurprd05.prod.outlook.com (2603:10a6:7:94::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.16 via Frontend Transport; Fri, 6 Mar 2020 09:18:26 +0000
X-Tagtoolbar-Keys: D20200306121823677
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4594aebe-1a5d-449c-5143-08d7c1af53e0
X-MS-TrafficTypeDiagnostic: AM6PR08MB4440:
X-Microsoft-Antispam-PRVS: <AM6PR08MB4440558EA80B61CE000DE1BFC1E30@AM6PR08MB4440.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 0334223192
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(376002)(396003)(39850400004)(136003)(199004)(189003)(66476007)(478600001)(66556008)(5660300002)(86362001)(66946007)(6916009)(6486002)(52116002)(8676002)(81156014)(81166006)(8936002)(2616005)(16576012)(2906002)(31696002)(956004)(31686004)(4326008)(316002)(54906003)(26005)(186003)(16526019)(7416002)(6666004)(36756003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4440;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: au3Fa8KfyZwfRn1C3SalMLxrobilb7/tDfCyR4Lyr0ru8YQa1m3R/7rQ9OKo5PnD+jZbdDLJV6SPfCdcbrSH9ge0euNXXIT02bUIF2HdSsnEBHo3a5zIgz9TIoVt664QrZuzBRw2VqkF78a9o5PT6cbIUAALB/YaKQdDPW+XbN/dmCF1ugN1OenG61Ew344+aAA9KfzT5caY0By4jgB6UANIa3uj2ShvwbytqhmBxbbPRkzd/8OtwoWBFGmetEQ2mia6rItsc+9Keh21B/YrSdGjI+mkIjur4t4J6oXl/JqNRLKxIaVh0rLel2MvR7hywvQbskI4RwjVThA2PNJvx/pWBspx/4/jFqOPX/AFWFTXB+gol+yijiNLb8Vg9ZfT3avh3e0WYiWoOjlbJ5d3PfcuvB5xDDLZ07SJtze2nHy+qLpcGRtzhuM1d7yIUobc
X-MS-Exchange-AntiSpam-MessageData: GkM21RfFf77biS5ejrlIrWBR1tZTjjniFHsvQ3FglnAIgAkVahYTwtJf3/UNXMB9DBMjE0RI92wJYqY3AcqXUA3BqzxXzH0j3XGU/8Nj4y9D7UZR1jbuU6k+EQtYIMQMRjxY4MVVZRHtL7Y3jgBkXQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4594aebe-1a5d-449c-5143-08d7c1af53e0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 09:18:26.8051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CvnbU0KZ154UtsLVnFY8P9QIbIi+F/2HxLNdyEbFH2Hx+m+A3Xphftrf8Yw5g6MFCFKSVKVtCx1rb+s4ujqVLGCRjFTlKpEynqNpo6H5sac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4440
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.112
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
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Greg Kurz <groug@kaod.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 xen-devel <xen-devel@lists.xenproject.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

06.03.2020 12:12, Paul Durrant wrote:
> On Fri, 6 Mar 2020 at 05:16, Vladimir Sementsov-Ogievskiy
> <vsementsov@virtuozzo.com> wrote:
>>
>> If we want to add some info to errp (by error_prepend() or
>> error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
>> Otherwise, this info will not be added when errp == &error_fatal
>> (the program will exit prior to the error_append_hint() or
>> error_prepend() call).  Fix such cases.
>>
>> If we want to check error after errp-function call, we need to
>> introduce local_err and then propagate it to errp. Instead, use
>> ERRP_AUTO_PROPAGATE macro, benefits are:
>> 1. No need of explicit error_propagate call
>> 2. No need of explicit local_err variable: use errp directly
>> 3. ERRP_AUTO_PROPAGATE leaves errp as is if it's not NULL or
>>     &error_fatal, this means that we don't break error_abort
>>     (we'll abort on error_set, not on error_propagate)
>>
>> This commit is generated by command
>>
>>      sed -n '/^X86 Xen CPUs$/,/^$/{s/^F: //p}' MAINTAINERS | \
>>      xargs git ls-files | grep '\.[hc]$' | \
>>      xargs spatch \
>>          --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>>          --macro-file scripts/cocci-macro-file.h \
>>          --in-place --no-show-diff --max-width 80
>>
>> Reported-by: Kevin Wolf <kwolf@redhat.com>
>> Reported-by: Greg Kurz <groug@kaod.org>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> 
> Reviewed-by: Paul Durrant <paul@xen.org>
> 


Thanks for reviewing!

-- 
Best regards,
Vladimir

