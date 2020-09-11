Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27F1C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 21:51:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C77A22208
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 21:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WF14OhWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C77A22208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGqxU-0006zs-Sf
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 17:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGqwT-0006Pl-C0
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 17:50:49 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d]:54776)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGqwR-0002qg-Jb
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 17:50:48 -0400
Received: by mail-pj1-x102d.google.com with SMTP id mm21so2347270pjb.4
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 14:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=NTZM+wV0HB/YM5BpXqx/Ybr8bd57c5/esG8wW7Ijvo8=;
 b=WF14OhWiG+q+VhRbPHJLVKucjHAaOtuSksIFFNKxHJNTIsN2dzHJmhW4+VDTexgTsu
 H2xFHLGAvziP05KCWuC9EeOaSZIEVbcCO7H+fV9aikUONUdxUZbjVcbUOdtfJbJJaJfE
 CWo8fb9qKdu/zKtu6KMKxJvbU96bkBx6mAmzAWNXwyTnR6tE7ToVmYEl4k/sO9UAaRKd
 v2t5vGBYz+dC+hcXshGeBhLEmbYWNPFQ5AR9hswpMvKMqEDlQ5cNVUUcJ4Nv78F+t6t4
 +euPT3XvRN0meFnKpbx+3l4F9s/G5hRRhLy0CN9lBPBe8zjFTDgvziXD5t9bCn1c0LZQ
 72jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NTZM+wV0HB/YM5BpXqx/Ybr8bd57c5/esG8wW7Ijvo8=;
 b=semEZsSCB0YpQC2OXqB7vDN5oISkbmRf/ib9o4LuFFT3gw4JMD8/yOUaeKu7ncIfct
 SiDyCbBgIXWj7jzTVXs68cLu97GKp+bSU0ATupTTR4f6OXGV2k+9L7czE04siO5DpV2o
 Eqz9KMQXvjb98zK1uvT/JCTjDtnL0esbtfs/Y0A6t7+IZFIhTPDQ2Q787b1+LeBSrtqX
 8RMNpsMq3k2eapksbUoVgpGIYVj8zlB0LCLcvvYtReaD8xeh0r0HCwprZ4E1y+wd6Xrk
 VSMedyACVDOruPYeq4AEFxlOKPpu9JZDqhyQeML2R0NaYYGRLmIAUPrQpgF4S+nYD5z7
 QzjQ==
X-Gm-Message-State: AOAM530cKYGSqIL+uEz21u2DWJk5ndDh9/O6bBUPSguoLbdoXsaioThE
 92cmphSqh02n9NraVkQummrHxfMSCNZ6vg==
X-Google-Smtp-Source: ABdhPJzwsm9LEPeWv6++gjpSYmNsmY32R7U2XK42WKMfVdx2jE97pbcbgt5Z9ga4z9XaUlo1VBltfw==
X-Received: by 2002:a17:90a:77c1:: with SMTP id
 e1mr3811556pjs.39.1599861045077; 
 Fri, 11 Sep 2020 14:50:45 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id k7sm2731628pjs.9.2020.09.11.14.50.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 14:50:44 -0700 (PDT)
Subject: Re: qemu disassembler status
To: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
References: <CAFEAcA8yfPdJLmek=+1VOWY4DQGP0yhmbtTiARw+qMuENKet+w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bb48e978-71e3-8ea8-44da-36c7d540ec1b@linaro.org>
Date: Fri, 11 Sep 2020 14:50:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8yfPdJLmek=+1VOWY4DQGP0yhmbtTiARw+qMuENKet+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.469,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Taking this to the mailing list, since there are others who have expressed
interest in the topic.


On 9/7/20 11:36 AM, Peter Maydell wrote:
> Hi; I have a feeling we've discussed this on irc at some point
> in the past, but I've forgotten the details, so I figured if I
> wrote an email I might be able to find it again later...
> 
> So, currently we have:
>  * some disassemblers in the tree (old binutils, and some other
>    things)
>  * in particular one of those is the aarch64 libvixl, which is
>    3rd-party code that we occasionally manually import/update
>  * capstone, which is a submodule
> 
> Am I right in thinking that you've suggested that ideally we should
> use libllvm directly as our disassembler (with the hope that that
> will have better coverage of different architectures and be more
> up-to-date than capstone)?

I've spent a couple of days poking at the llvm disassembler.

As a general-purpose disassembler, it's less than ideal.

(1) The disassembler is not "inclusive".  You present it with
    a specific cpu configuration, and anything that cpu does
    not support is considered invalid.  There is no "maximum"
    configuration that attempts to decode any insn in the ISA.

(2) All configuration is done via strings, so you can't
    programatically tell what's supported.  I think they're
    expecting all of these strings to come from the
    command line.

(3) If you include a unrecognized cpu feature, an error is
    printed to stderr.  Which suggests that we would easily
    wind up with problems between llvm versions.

(4) "Probing" what is supported with a particular version is
    done via "+help", which prints what is supported to stdout.


>> For llvm, I would most definitely not use a submodule.  Disassembly is for
>> developers, not end users, and I think we can insist on support libraries being
>> installed.
> 
> Disassembly is for end users too.  I think we need a submodule.
> (This also means we can have newer versions than whatever
> Ubuntu LTS ships so we get useful disassembly for architecture
> extensions that postdate that.)

If we have a submodule, is it possible to have a local branch of that?  The
only thing I can see that would fix any of the above is to modify llvm to give
us a more usable interface.

In the short-term, I guess I'll look into updating our capstone branch.  And
possibly reject using the system version -- either use the git submodule or
nothing.

Thoughts?


r~

