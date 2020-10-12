Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB01C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:08:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3140E20735
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErwhKJzy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3140E20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRwdF-0000J7-4A
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 08:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRwJn-00057A-Ft; Mon, 12 Oct 2020 07:48:43 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44454)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRwJl-0000Pw-Tv; Mon, 12 Oct 2020 07:48:43 -0400
Received: by mail-wr1-x444.google.com with SMTP id t9so18816210wrq.11;
 Mon, 12 Oct 2020 04:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wk6H6LW7B03MEmC1dnThRIOnlITtkeGE9GcFSrl9Gpw=;
 b=ErwhKJzyH5QchiirOA+/mNsiJEG7v0ao5UmShFNZJLyB7ftGoyr/cfFlGKNOb9GUFr
 xCThZchmQrlAnQ7mvT3jdH6kx4qONv7RGgPoC39WenTfTRYErzmQHG0+z8q5HEyDIEQ/
 0xCDzYrRbFXfaOz2DPdjGeRsnITK3FLZVtXLNbaaaW9iXk5pxrDXy+Xjl5FFPTZLGKQA
 qE5xJjboCjjd3WkKm2O9sTGVJDjBTQmRZxx7t+iiMCGGo9zuIKh5E7E14a1CqmrmfJ6P
 ZzUPXAfdI7zCLT+vDsKL4YxoWTYZp91/wMSx7kmD8U61ORRETC2V7AYMghSRqj+/bn0/
 sKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wk6H6LW7B03MEmC1dnThRIOnlITtkeGE9GcFSrl9Gpw=;
 b=Os3wgqD2aa48lGlpGhcCE6P4vYhuMv8xtUA1+yVg5hVbalJ9FMIvDRIKPWHfALFtez
 uA4B27kGktP+bFjX/cTEJ1eRMdYmzpIQ6xKu7u78sjgAzssuMMCEcJw/90Ny5DQ1Nla1
 N9rdY9R+Whmtx6SZcykH3VHCYntiJNDJkZ7U+pZ42CGoSaWt5aUsZlIpNCH35M3//kAa
 kbnKwe0zt3ZvflSkQC1hYcPVbcI97A0ifl1PrLvh5If7VPA85IYkfexNy7c46imws8Ph
 OrtDODPKhllQnPWoFPJYhbI9XQ4Ul0mSiX7dObmUMVyL86abs6D1ARphccvz47zjLSNj
 mtmQ==
X-Gm-Message-State: AOAM532blYk78rO7V+3boqjSyljdy/i0/N8TiOJ9XvNX7l0UGR/ioHW3
 rPTfP7giRS+WkmPay6hi+47kVH7H9m0=
X-Google-Smtp-Source: ABdhPJw3zoroa62LapV1i3nMoYy6jspx55eUYatONlPE4JbdggE1OQSlNKvdCQ7ZWJDOhytQijKKNg==
X-Received: by 2002:a5d:4843:: with SMTP id n3mr6373140wrs.416.1602503319211; 
 Mon, 12 Oct 2020 04:48:39 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id b189sm21686008wmb.37.2020.10.12.04.48.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2020 04:48:37 -0700 (PDT)
Subject: Re: [PATCH] hw/net: move allocation to the heap due to very large
 stack frame
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 Elena Afanasova <eafanasova@gmail.com>
References: <8f07132478469b35fb50a4706691e2b56b10a67b.camel@gmail.com>
 <20201010060745.GK1025389@yekko.fritz.box>
 <a329006c-ed11-2f1b-5766-7480c19c0462@amsat.org>
Message-ID: <ce1e6d92-1eb9-847b-8b3f-e29a23b36639@amsat.org>
Date: Mon, 12 Oct 2020 13:48:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <a329006c-ed11-2f1b-5766-7480c19c0462@amsat.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, jasowang@redhat.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/20 1:09 PM, Philippe Mathieu-Daudé wrote:
> On 10/10/20 8:07 AM, David Gibson wrote:
>> On Fri, Oct 09, 2020 at 07:02:56AM -0700, Elena Afanasova wrote:
>>> >From 09905773a00e417d3a37c12350d9e55466fdce8a Mon Sep 17 00:00:00 2001
>>> From: Elena Afanasova <eafanasova@gmail.com>
>>> Date: Fri, 9 Oct 2020 06:41:36 -0700
>>> Subject: [PATCH] hw/net: move allocation to the heap due to very 
>>> large stack
>>>   frame
>>
>> Patch looks fine, but some more details of the motivation would be
>> nice.  I wouldn't have thought that the size of a network packet
>> counted as a "very large" stack frame by userspace standards.
> 
> Maybe academia doing research on "super jumbo frames"?
> 
> "Super jumbo frames ... increase the path MTU of high-performance
> national research and education networks from 1500 bytes to 9000
> bytes or so, a subsequent increase, possibly to 64,000 bytes"
> 
> (https://en.wikipedia.org/wiki/Jumbo_frame#Super_jumbo_frames)

The one I was actually looking for is the IPv6 jumbogram:

"An optional feature of IPv6, the jumbo payload option, allows the 
exchange of packets with payloads of up to one byte less than 4 GiB,
by making use of a 32-bit length field."

(https://en.wikipedia.org/wiki/Jumbogram)

