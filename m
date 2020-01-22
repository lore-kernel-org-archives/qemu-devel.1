Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F03C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 20:47:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6810524655
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 20:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+3Lb/3T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6810524655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuMuV-0001YE-IC
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 15:47:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rth7680@gmail.com>) id 1iuMtl-00015Y-Ig
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 15:46:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rth7680@gmail.com>) id 1iuMtk-0007Lu-GG
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 15:46:49 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:33381)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1iuMtk-0007LR-AQ
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 15:46:48 -0500
Received: by mail-pl1-x643.google.com with SMTP id ay11so328065plb.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 12:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wybqKnJPhlYDhZ8Ef0C4EWbKWjqIszAbAFW5ofwNpME=;
 b=l+3Lb/3TO4mepjffHh0FoyvlW7Pxz1RAXxGlkyYtmHmkNVYgNDvJ0vW+q3qnyWmLay
 v8rF46YoWDsl/TV095p+r8PaXh4VCpDg4OxE+HG611k7n9jbhcYsBDihVYp4sVisTj21
 +ItoUfTwX86IcPy3LV4dI4sCBMChl8Z/IsHMNvlhINdDL4bq1JkpTRW/Nk5eSFZoQ9xj
 igecNIWOexaYBP0kCHEjZxCGo/v9yhC/dFKtPORW1cRdF5s4Bpekzrl6Ruk0nA4lG/eT
 fKvQwCttlQuuR1+WZMA7WdTVC+f7C8moKtqiew2wSOyvIhmWsZoy4Eo4nXNzqhMJdJWs
 KJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=wybqKnJPhlYDhZ8Ef0C4EWbKWjqIszAbAFW5ofwNpME=;
 b=ReGmpX2Qct9+SJtGg4UH1ZBfLumNCPZeJ3yUxbcXssWKsbpFAyHHz6quWhn41ILKHV
 dUoMZCZd4xPQkz2IS/GdWbOezoaN2FCFnJ0dQjUpAZQ1OgMy67MmcJJa/9B6aIY6b5js
 jbMvvFXQ1cI9kk8TC3K99OTEbeve5dieU8vzfa9RB9Nwd2Q8vTQyWMkXllSJBFbDIXmC
 en1Liw9e5F5TiuDp4bwuUM5ceZTuJMY86LDxmFhXzpbTgEu7etC6Zkj7BMyW9AE7vJgF
 WL/aPB+194P9TAekwjtymT1uP0n7w9OKwBOeoL7hpzbANmQirlXbtMkcdVcaXC/NRAU2
 5xew==
X-Gm-Message-State: APjAAAWt7BFU1PADb3/XcL4Ty83LCI70nYhorWyqpt8lFN4eVeLgurYZ
 FvmgGZpCNHZXJ+aOGa+55Go=
X-Google-Smtp-Source: APXvYqwOEPf/uOAaIdSOidg92HBeTQBE/O2DOCBapwmXnyYgFEol4FsZAY3rnfyAFPRvBRrRuNDXMw==
X-Received: by 2002:a17:90b:355:: with SMTP id
 fh21mr351549pjb.51.1579726006467; 
 Wed, 22 Jan 2020 12:46:46 -0800 (PST)
Received: from ?IPv6:2607:fb90:580:a104:4475:e6b8:8600:af4a?
 ([2607:fb90:580:a104:4475:e6b8:8600:af4a])
 by smtp.googlemail.com with ESMTPSA id d4sm4351082pjz.12.2020.01.22.12.46.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2020 12:46:45 -0800 (PST)
Subject: Re: [PATCH v4 00/18] hw/avr: Introduce few Arduino boards
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20200120220107.17825-1-f4bug@amsat.org>
 <CAK4993jBdx4WniPqLs2YLUnv5rXhGL2SC9bjbjeVmO5bvkRgoQ@mail.gmail.com>
 <CAAdtpL5FdzYga1sA+nsN4+JP2QMO5NMRDtdcJ0v1prHgjxZ+QQ@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Autocrypt: addr=rth@twiddle.net; prefer-encrypt=mutual; keydata=
 mQENBFGuLC8BCADcAoWcnW9lTsDMzbO3MBU+KbiGaj5JPatEUscRDkQYM2fyNjJp2tIWDK5a
 n4yngeXB3eX61WbYR3QraRK8mlYLGxyAdHMEQfPipbqf3TmN043fssT2bc82ApJcs1zvLYgI
 rhMht7Dck7A0wNC1jo+ZjVVFig5gDTN7gOzaAdBtV8tVNUddwkLzzaGpfihhSD6U46NdqKOG
 Wlnn6TrkMy0QGdQ5NaXHkRlUjnnUTSW/nKfoxD+EI+A9V4sYOd8mc/TL4aJh/i/AiU57eLbo
 n17uQI6/VTWDUWl8USiz4x9c8vmqlywLx00tAFxxoRWqk4KVJlj+Sh0up/D/sJ+vPpgBABEB
 AAG0I1JpY2hhcmQgSGVuZGVyc29uIDxydGhAdHdpZGRsZS5uZXQ+iQFYBBMBAgBCAhsDBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgAIZARYhBJyxjdr46EmtKvwWpK0ScMxN0CebBQJdweUY
 BQkP1h/pAAoJEK0ScMxN0CebqDsH/0YyfnXk+Dc++H37VCEKgRet2i1ATFzxRnifkvmdxha0
 V+PVptQ2fwSe+w3KxoFecD8W75nysmUjrU/FicW9yU5YRlGONPZjruG02/KzmhA5PzWJdYO3
 i/t0qRayvWIcX2qA/flsXEbmb/BbAFM05LQIdcOu74eiBFe5CBCOWBDJeneE1urIE0hSYxoh
 nCcG60ULrNj13ohZ4zAEluoY32qIo7/OPWmtR88cPrEbZT8k+RqgZbsotzaPT1/RlL74fL8k
 ofYfTgKAFH7eEy6fF2nzDp2GThVn+3sA62xtpSXUf/X1m75B40KOcq1EQbHypNTmBc1wt13e
 ibhPNEVX2am5AQ0EUa4sLwEIALITHfH3gciRNfQIe7awDTDvn6H3C6gDyCAnv5LiuLTLZiyK
 NZp3lNO3rPowyKrGT2RIDlumlqPgdeHzqEEX91YK0yk2vdFvwU04rJ4D+qRgdUPoeICLD1zo
 PwOv2FaY6Tf8dKYas1RHF5QU5yQNey8j7IYYoE2yGPn2PtBmvtmK4iLataUEvx0U385Zr+jf
 HscqwTiToryeDC8Io/9BsMvAssE5Yf5URS2nJ7LFOvc4njsQJPF1i9egBXaIloqv7p2hVCKJ
 Hl5UWIxitQ9QQIl6iU4LCpz8mVYTXwv48IAVpbUf7+ak9V9Kk3jCeQnlxCJBUHjUhoIzinbS
 JHPHtkkAEQEAAYkBPAQYAQIAJgIbDBYhBJyxjdr46EmtKvwWpK0ScMxN0CebBQJdweVIBQkP
 1iAZAAoJEK0ScMxN0CebGHUH/RtouOlWl6To97tQsTJUq/2YwmRpFOsvV0/zCX4fKBGAbeZi
 VaELSt2+3UEErA+n8HwbQmjJ6IrdhA9GustOpOyCcbLVSMwql/OlAwBtDzCcC8dTU4zcuY2a
 rGG2A8i5krU85G9r1wowVcWZBsdmW7/dKiNoadLQiig4bHNiSaV4ograas5efyEjqTxiY+yG
 hzPw5DK2kbp2co8iDF1vW0LWPeLFBinCgItcI9LvgHWaB3rwjOfvNpMn5m64SoQYHB8wbnid
 erAjOzkBzmqnfS1tAUr8mtESStEwrEmNv0ZoA6S0Wt+c9pyTr+BpG4OFlhj7ZI+Eh7zOrr33
 q9OBIdA=
Message-ID: <dfffa872-86fb-9cac-5738-93e88d5accc8@twiddle.net>
Date: Wed, 22 Jan 2020 10:46:40 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAAdtpL5FdzYga1sA+nsN4+JP2QMO5NMRDtdcJ0v1prHgjxZ+QQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 11:23 AM, Philippe Mathieu-Daudé wrote:
>> 4. There is difference between -bios and -kernel (arduino boars crash when -bios is used, but this seems because I run avr6 on avr5 CPU). I would be happy if you explained what is the difference between these two arguments.
> 
> qemu man page is not very helpful...
> 
>        -bios file
>            Set the filename for the BIOS.
> 
>        -kernel bzImage
>            Use bzImage as kernel image. The kernel can be either a
> Linux kernel or in multiboot format.
> 
> Paolo, Peter, do you have a simple explanation?

It depends on your target board.  They *can* do very different things.

E.g. for "pc" (x86) machine, -bios sets the seabios image to use, and -kernel
loads a kernel image that seabios will invoke.

E.g. for "dp264" (alpha) machine, -bios sets the palcode image to use and
-kernel loads a kernel image.  Note that in this case, the alpha kernel relies
on palcode services, so both must be present for the system to work.

E.g. for "virt" (arm) machine, -bios loads a raw image at which the reset
vector will be pointed, whereas -kernel loads a linux kernel image and follows
the arm-linux kernel boot protocol.  In other words the images are treated very
differently.

I don't know what, if anything, an avr kernel would require from boot services.
 I suspect the two options *could* be treated identically.


r~

