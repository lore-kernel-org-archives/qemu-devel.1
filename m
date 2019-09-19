Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD032C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 09:42:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50F3E21927
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 09:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F3E21927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAsxA-000472-8F
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 05:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAswN-0003Yc-GM
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 05:41:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAswM-0002I0-CW
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 05:41:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49622)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAswM-0002HS-4A
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 05:41:30 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3296F36955
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 09:41:29 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id h6so817700wrh.6
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 02:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h9HHlig8dLzd5KxA/tK1sT4QqAGLjioELXR/YMG0H8c=;
 b=NydJmn7FmQ+9KGqEBIIq/GzQSulwTg/rRHCWtMhh0FaUESpZsVDOtdYvWuyrI4bX5f
 k+MkQPN11QN6e6P093wsEMo9hu+OA6xcOrQbof2sdYN8VFPUsuxC5rSFowv150vGTCz0
 47njXWD5ERqfAzVfdGkxQ4+uwNpWwWAJFHYMLZkbD8xRdXxntMsltRzmlKrIO7ldw725
 X7UekBE1Qviq5PLc6HwaCpSa6a1hJk9PjeIOAAIdoa+nuZNr+hk9Be/B9OUGOPG1Xt00
 LO/xfhJJPWr7Y8nHIRF9ehdHChDYPOvjIUWBJ06GYwiTcsKn8ci4HGTMrVx25wLCTOlh
 AtRg==
X-Gm-Message-State: APjAAAVmCRFy6Za8KxzPIvXgkCaHD0Bsm6wLSnzEWeZ8y1ITlU+TWXAk
 L1OX87SUMMUExZ/XZMolnIyo/6kG13LH8mujPHLtPaO0i52kvWTNyZSOTAfhPc4N98S+0sttg1J
 k4L0z0mVjY3UJDqs=
X-Received: by 2002:a1c:cf8c:: with SMTP id f134mr2075401wmg.174.1568886087605; 
 Thu, 19 Sep 2019 02:41:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwR4d4UUFagd2m9KLtuCOJ423ElWzu9ebmSPfhC7lkrUfrC1hbtznNfC2ls17/GS9hXOwABYA==
X-Received: by 2002:a1c:cf8c:: with SMTP id f134mr2075346wmg.174.1568886086656; 
 Thu, 19 Sep 2019 02:41:26 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id b62sm8491520wmc.13.2019.09.19.02.41.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2019 02:41:25 -0700 (PDT)
To: Tao Xu <tao3.xu@intel.com>, pbonzini@redhat.com, rth@twiddle.net,
 ehabkost@redhat.com
References: <20190919020629.26530-1-tao3.xu@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <03994df5-69b7-8663-fc19-0f551a9b29d6@redhat.com>
Date: Thu, 19 Sep 2019 11:41:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190919020629.26530-1-tao3.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] target/i386: Correct extra enter and
 spaces in comment
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Tao,

On 9/19/19 4:06 AM, Tao Xu wrote:
> There is an extra line in comment of CPUID_8000_0008_EBX_WBNOINVD,
> remove the extra enter and spaces.
> 
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>  target/i386/cpu.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 5f6e3a029a..71b6193390 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -695,8 +695,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>  
>  #define CPUID_7_1_EAX_AVX512_BF16 (1U << 5) /* AVX512 BFloat16 Instruction */
>  
> -#define CPUID_8000_0008_EBX_WBNOINVD  (1U << 9)  /* Write back and
> -                                                                             do not invalidate cache */
> +#define CPUID_8000_0008_EBX_WBNOINVD (1U << 9) /* Write back and do not invalidate cache */

The QEMU CODING_STYLE [*] recommend a 80 chars per line limit:

Line width
==========

Lines should be 80 characters; try not to make them longer.

Sometimes it is hard to do, especially when dealing with QEMU subsystems
that use long function or symbol names.  Even in that case, do not make
lines much longer than 80 characters.

Rationale:

* Some people like to tile their 24" screens with a 6x4 matrix of 80x24
  xterms and use vi in all of them.  The best way to punish them is to
  let them keep doing it.
* Code and especially patches is much more readable if limited to a sane
  line length.  Eighty is traditional.
* The four-space indentation makes the most common excuse ("But look
  at all that white space on the left!") moot.
* It is the QEMU coding style.

[*]
https://git.qemu.org/?p=qemu.git;a=blob;f=CODING_STYLE.rst;h=427699e0e425431ea99d4046e40543bdcc22e9c5;hb=HEAD#l82

Can you repost using correct lenght comments?

>  #define CPUID_8000_0008_EBX_IBPB    (1U << 12) /* Indirect Branch Prediction Barrier */
>  
>  #define CPUID_XSAVE_XSAVEOPT   (1U << 0)
> 

