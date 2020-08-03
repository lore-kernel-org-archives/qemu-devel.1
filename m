Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E017C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 13:31:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38989206DA
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 13:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpafB5Yx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38989206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2aYb-00088N-Bv
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 09:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k2aXh-0007UX-5a; Mon, 03 Aug 2020 09:30:17 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:40994)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1k2aXe-0004cj-Dt; Mon, 03 Aug 2020 09:30:16 -0400
Received: by mail-qt1-x843.google.com with SMTP id v22so22226966qtq.8;
 Mon, 03 Aug 2020 06:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2xwURtbTIS031dQkfXKStIBCvgjSUHFRoUx4LlQty8U=;
 b=RpafB5Yxo6w549XHZikw5GBGfFagGVNBOFKXNX0MATvaU8tdsBRuqKesSfM2wSJbxm
 TXFgrfxhUchAP6WX1BhAWDTdx3184gw3koL2N8kAbCV4EPJS4QqBZQHdqRdJn1ppnCfD
 Px+uruVLJsnPWxeT1V+z+n0MiCvzzuT7ovQugcixBaw6PCJ918I1fnvrKNUbRZHkIN9w
 J2OuT+GVo8Rn5/IAITfttMRGDUae+/KjkxY9YcjgcPv5e96tVE2eDdc/hRkU67auNF37
 eBzlxONHfVbvcMnZwUydTd6Q4g/15qCiy8zkG9IT0wZiLTBi1zteu+jBJqk6VwTiDB8j
 LY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2xwURtbTIS031dQkfXKStIBCvgjSUHFRoUx4LlQty8U=;
 b=k/BS6MblQfsNyU3+2NogZbBZHBXeXK/fynlOp1hCLTbiCT0u2zeC7mVvt9PD8WdYLr
 YqVN4jlBWk4l5VJjKJ0RM+B/xfC0Uo/FcjWYZ/8QZh8CFzRGHXAUbTYNLOnsCOH/je6F
 E/Q461r7qiJhcFlMBgvjcWCXbeTNCJsYQPITHTE97o/BLfKozj4hj/HQ4Tjka1mdBrfW
 q8JaHjxMNsiKK1Pv8QOO4EDTk/+zloHPebcuwTvf3h8GdNQW4f6bD4EoYxwSvYlPzmXL
 0tQEIqvmaxh7+ZUOEtCMjVONLz0trTCfRdFxI1dlQcNvX4LUp1r5Dd9fmVSCdLjYCNHj
 +h7g==
X-Gm-Message-State: AOAM532bdSv2ackCy9w7D9wILzPnF/GSQfH5bzLaDvZVaOU4szJElwHc
 Z37oBI4HOLBeBUM7mWH76WWmIkvq
X-Google-Smtp-Source: ABdhPJzw+Pi4Oztb2kxDRMAru1WFTnf0GxNIMfz6jdgZvRQbg8UIAPNCCMFPRJu5bSd/kcKks038Ww==
X-Received: by 2002:ac8:38e5:: with SMTP id g34mr16271998qtc.317.1596461412629; 
 Mon, 03 Aug 2020 06:30:12 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c7:fea0:f34f:387b:ebfa:f155?
 ([2804:431:c7c7:fea0:f34f:387b:ebfa:f155])
 by smtp.gmail.com with ESMTPSA id g3sm17665890qtq.70.2020.08.03.06.30.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2020 06:30:11 -0700 (PDT)
Subject: Re: [PATCH 1/1] docs: adding NUMA documentation for pseries
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200729125756.224846-1-danielhb413@gmail.com>
 <20200730005852.GN84173@umbus.fritz.box> <20200803134917.48c5e7a5@bahia.lan>
 <8985209a-427b-1ec5-7d90-6a760e58f1cd@gmail.com>
 <CAFEAcA9hV4+kKO1gggzNjNjMHxt3WiDac2KivjZzLAGExdN7Kw@mail.gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <057db3b9-1a3e-ed80-a5d6-72c82eb5c333@gmail.com>
Date: Mon, 3 Aug 2020 10:30:06 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9hV4+kKO1gggzNjNjMHxt3WiDac2KivjZzLAGExdN7Kw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::843;
 envelope-from=danielhb413@gmail.com; helo=mail-qt1-x843.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/3/20 9:59 AM, Peter Maydell wrote:
> On Mon, 3 Aug 2020 at 13:15, Daniel Henrique Barboza
> <danielhb413@gmail.com> wrote:
>> On 8/3/20 8:49 AM, Greg Kurz wrote:
>>> I'm now hitting this:
>>>
>>> Warning, treated as error:
>>> docs/specs/ppc-spapr-numa.rst:document isn't included in any toctree
>>
>> How are you hitting this? I can't reproduce this error. Tried running
>> ./autogen.sh and 'make' and didn't see it.
> 
> We don't have an autogen.sh...


I intended to say ../configure and by force of habit I mentioned the Libvirt
one :(


> 
> Anyway, 'make' will build the documentation, but only if you have
> the necessary tools installed. If you pass '--enable-docs' to configure
> then it will error out if you're missing something rather than
> its default of quietly not building the docs.

Thanks for the info. I used --enable-docs and discovered that I was missing
one of the doc packages. I'm seeing the error now.

Thanks,


DHB

> 
> thanks
> -- PMM
> 

