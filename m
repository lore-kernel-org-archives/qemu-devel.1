Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F5EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:44:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73D33207D8
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aASms8hl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D33207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGNx-0006rs-Ma
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 13:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rth7680@gmail.com>) id 1jhGIM-00052Y-KH
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:38:18 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:36900)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rth7680@gmail.com>) id 1jhGIL-00044A-Js
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:38:18 -0400
Received: by mail-pj1-x1044.google.com with SMTP id m2so3121246pjv.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 10:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W+u0mIGq1c+Skf67+UcAHZmr6EIMkKR2QDsTNw8eLjk=;
 b=aASms8hlPhZdasCPBgXFDuSx2wLSFMbR49/jVM91jMMC0E1Adysk5iiUVAscIdbHqp
 wDAF/UyT1WRcCvtWsrOhOCGi4/Yk13Zt//2IuPAnAGAlpP4amPdilK4FSXSEfyA4vd2Y
 yEWYzijsLafUP1cpCW7+5ZlKIUEhoNnRf0+Ul5zgOClFgN0zxh9zLoyEvoxrRTLPfUU3
 kasDlEwJOKCl0mzgFNOYtbsd5avi7xqlw7EBuFWFT6qMgy4pXVcZ7/SK9cHTKOdDKqKK
 db2XOZhax7/ZUBUxm7/ILRKzOv1jR0lq/ThQ+CmrWED873yJQOkH7cgd1Vp1XYBWSv2f
 vfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=W+u0mIGq1c+Skf67+UcAHZmr6EIMkKR2QDsTNw8eLjk=;
 b=bxagnCo2Q5RtO57Wo+OKEguPDtdROntCO+obd9wf6hXVHiA1qTQOJCDkKJNZVEMpW1
 I7UvbR2XwUERodz4igUscA+Pd6IkVginLH/uJqZ7pCmuxRjoaJCAl1Tqm52EGH/iBz2J
 +e8acU7MUMyrFhdwizA6W/YzKpdGQ45g7u7TKWzIiCBYqXU+YRS+ZdS8bcdj75T4EnNe
 xOt2U1HmrvKtml50Vgz7JwZmHl0zJOZp94i7WNka4bYlfgqw4F12aZjQ7uO/zGo/5iP8
 Ateq8IKr5yGVBfOMZVwdw0gCB9yKWysQXdNFu1EN03i9sPzG2IbLx/w44f6pXSNQxV8s
 FfHw==
X-Gm-Message-State: AOAM531s7zvyULYZifHfMKLWVQJssRWEaLQDryrm03RbdOx2PEUHSq1c
 3EUR6ClHhqcPJdV9zf9z8pKdRv7W
X-Google-Smtp-Source: ABdhPJxrxcoE298v3xEuYR9Jh77Dw0zubBvNFW+o+KQhhwFyv70m35XFWrX8hUK6AS/P6rwes/Y88Q==
X-Received: by 2002:a17:90a:5889:: with SMTP id
 j9mr4310610pji.40.1591378695841; 
 Fri, 05 Jun 2020 10:38:15 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.googlemail.com with ESMTPSA id x12sm219056pfo.72.2020.06.05.10.38.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2020 10:38:15 -0700 (PDT)
Subject: Re: [PULL v2 05/13] accel/tcg: Relax va restrictions on 64-bit guests
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <20200515144405.20580-1-alex.bennee@linaro.org>
 <20200515144405.20580-6-alex.bennee@linaro.org>
 <843d72a9-22a7-b0b5-0a92-edf1dcd290d2@vivier.eu> <87zh9i4u1f.fsf@linaro.org>
 <87h7vp4n6w.fsf@linaro.org>
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
Message-ID: <f8c9afba-4c7c-a410-f42c-c63aa2128ef6@twiddle.net>
Date: Fri, 5 Jun 2020 10:38:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87h7vp4n6w.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=rth7680@gmail.com; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/20 7:11 AM, Alex Bennée wrote:
> @@ -467,7 +467,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
>           * It can fail only on 64-bit host with 32-bit target.
>           * On any other target/host host mmap() handles this error correctly.
>           */
> -        if (!guest_range_valid(start, len)) {
> +        if (end < start || !guest_range_valid(start, len)) {
>              errno = ENOMEM;
>              goto fail;
>          }

Interesting.  I was adjusting guest_range_valid tagged pointers yesterday, and
thought that it looked buggy.


r~

