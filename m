Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD95C35250
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BB8520720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcXGMdrW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB8520720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j05u8-0001CM-PP
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 10:50:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rth7680@gmail.com>) id 1j05t8-0000GM-OX
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:49:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rth7680@gmail.com>) id 1j05t7-0003b0-FW
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:49:50 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44644)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1j05t7-0003aa-7z
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:49:49 -0500
Received: by mail-wr1-x441.google.com with SMTP id m16so3212110wrx.11
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 07:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oee+JdNnhZYyfazJdVh7iGH+DDhH5Uximbky84eCSVs=;
 b=kcXGMdrWR3IhrHDdYD/d0fCYy/TXCNAEjuIJQAGuQw7agLxOtRDlk3XBW2NTHohRUN
 1hD1ut6AbdF1newR4VEskYAN5RHhHZuYdZExrzEc3BDPdXNXFvQ1g/O3ulftpdcB4XR0
 3DxE84LpEKTPTC8gQmliIR9jg2X9K42ozZtdHY8owecgT7aZ3zSrwKNFMx0GgIY3YvZg
 t0mwmlzFPgEcoGxQNoBvSurssNZB3RsVPYyjvZriY89N57gFZbF7LrvxOxTV7EjXJZV/
 dthGcnMF9IWZ/u3wVmWGss60XdQgn6M5y56HV2qd/9F26pn/tKMRKP0Ksq0XtIPXGFRs
 3LjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=oee+JdNnhZYyfazJdVh7iGH+DDhH5Uximbky84eCSVs=;
 b=JAatTB5n55RSB0PwePRgVF+Lp0Um9k51iTh+2GnVZY/wn3kdedhRWHOUJ9MMikkzBx
 /UOQ5M0+UNgXjLyGV7y7Lmhb2DIar9CX7p9p9H+9exZb9a7uKkLFYHHz0FHuV8JM9EIH
 8gX0lXyUPe6REXrQUGTbGEhOAAXtC4jwcKhuUSJDRqhxdMfK+0CF5t4K05OYIgLQM9Hi
 nRTZqA+35oEf518l8rPgAi6ktP8RxIlLXLgxMO/uL8Er6DNOdKU3PFBq3Dg94OVU38rK
 MOorfJiWw+VRE2KIoTAMuEoNDZidSxDpgxqGeCXf100b+7NRzGdr3PrLci/EsPZc6MYi
 JoFw==
X-Gm-Message-State: APjAAAWfvZ8xDDA4tAt7LDCULqv5H7CT2nPkiJvHrZzxKXgHkOljjZqx
 3GSszEu8AAy64D5yCVQ8tzw=
X-Google-Smtp-Source: APXvYqxh+olM3IUEZQ5BydHdrYuFCKFKXPFtUEAFGQ+c0TmWqJONlK6B0Aqqr3E2GybGICw2Yr/5mQ==
X-Received: by 2002:adf:fd8d:: with SMTP id d13mr5426950wrr.208.1581090587597; 
 Fri, 07 Feb 2020 07:49:47 -0800 (PST)
Received: from [10.43.13.93] ([135.196.99.211])
 by smtp.googlemail.com with ESMTPSA id t81sm3848380wmg.6.2020.02.07.07.49.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2020 07:49:46 -0800 (PST)
Subject: Re: [PATCH] Add support for a helper with 7 arguments
To: Taylor Simpson <tsimpson@quicinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1580942510-2820-1-git-send-email-tsimpson@quicinc.com>
 <b308434a-1ee8-4fb5-0e60-4dfdd047c959@linaro.org>
 <BYAPR02MB4886E14CC87B1169B2F6BE2BDE1C0@BYAPR02MB4886.namprd02.prod.outlook.com>
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
Message-ID: <a01b3358-a598-9d01-f3c8-d9a84fb7dd28@twiddle.net>
Date: Fri, 7 Feb 2020 15:49:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB4886E14CC87B1169B2F6BE2BDE1C0@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/7/20 12:43 PM, Taylor Simpson wrote:
> 
>> -----Original Message-----
>> From: Richard Henderson <richard.henderson@linaro.org>
>>
>> But I encourage you to re-think your purely mechanical approach to the 
>> hexagon port.  It seems to me that you should be doing much more during
>> the translation phase so that you can minimize the number of helpers that
>> you require.
> 
> There are a couple of things we could do
> - Short term: Add #ifdef's to the generated code so that the helper isn't
>   compiled when there is a fWRAP_<tag> defined.  There are currently ~500
>   instructions where this is the case.

Definitely.


> - Long term: Integrate rev.ng's approach that uses flex/bison to parse the
> semantics and generate TCG code.
There is perhaps an intermediate step that merely special-cases the load/store
insns.  With rare exceptions (hah!) these are the cases that will most often
raise an exception.  Moreover, they are the *only* cases that can raise an
exception without requiring a helper call anyway.

There are a number of cases that I can think of:

	{
	  r6 = memb(r1)
	  r7 = memb(r2)
	}

	qemu_ld   t0, r1, MO_UB, mmu_idx
	qemu_ld   t1, r2, MO_UB, mmu_idx
	mov       r6, t0
	mov       r7, t1

	{
	  r6 = memb(r1)
	  memb(r2) = r7
	}

	qemu_ld   t0, r1, MO_UB, mmu_idx
	qemu_st   r7, r2, MO_UB, mmu_idx
	mov       r6, t0

These being the "normal" case wherein the memops are unconditional, and can
simply use a temp for semantics.  Similarly for MEMOP, NV, or SYSTEM insns in
slot0.

	{
	  r6 = memb(r1)
	  if (p0) r7 = memb(r7)
	}

	qemu_ld   l0, r1, MO_UB, mmu_idx
	andi      t1, p0, 1
        brcondi   t1, 0, L1
        qemu_ld   r7, r2, MO_UB, mmu_idx
 L1:
	mov       r6, l0

For a conditional load in slot 0, we can load directly into the final
destination register and skip the temporary.

Because TCG doesn't do global register allocation, any temporary crossing a
basic block boundary gets flushed to stack.  So this avoids sending the r7
value through an unnecessary round trip.

This works because (obviously) nothing can raise an exception after slot0, and
the only thing that comes after is the commit phase.  This can be extended to a
conditional load in slot1, when we notice that the insn in slot0 cannot raise
an exception.

	{
	  memb(r1) = r3
	  memb(r2) = r4
	}

	call     helper_probe_access, r1, MMU_DATA_STORE, 1
	call     helper_probe_access, r2, MMU_DATA_STORE, 1
	qemu_st  r3, r1, MO_UB, mmu_idx
	qemu_st  r4, r2, MO_UB, mmu_idx

	{
	  memb(r1) = r3
	  r4 = memb(r2)
	}

	call     helper_probe_access, r1, MMU_DATA_STORE, 1
	call     helper_probe_access, r2, MMU_DATA_LOAD, 1
	qemu_st  r3, r1, MO_UB, mmu_idx
	qemu_ld  r4, r2, MO_UB, mmu_idx

These cases with a store in slot1 are irritating, because I see that (1) all
exceptions must be recognized before anything commits, and (2) slot1 exceptions
must have preference over slot0 exceptions.  But we can probe them easily enough.


> - Long long term: A much more general approach will be to turn the C
> semantics code into LLVM IR and generate TCG from the IR.
Why would you imagine this to be more interesting than using flex/bison?


r~


