Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15221C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 05:02:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D456B2085A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 05:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UrEj0Bg3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D456B2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53684 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd6Fw-0007a6-O1
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 01:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48191)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hd6EN-00073v-2R
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 01:00:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hd6EK-00047W-SA
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 01:00:26 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46249)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hd6EK-000425-Jk
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 01:00:24 -0400
Received: by mail-pg1-x542.google.com with SMTP id v9so6960346pgr.13
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 22:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ds9XUIn3L4/5QLGo7B7E7e5AZsy/o97x7KpSJKj7hQk=;
 b=UrEj0Bg3BSL8XM6RKrUZ1skYrtwycWJclexilCSwlByWpyDcPsk5RC8fB1woY+V460
 lIy+b7/iNVN8wd50XjrO8n2uKKfgv64DjObKJ/em1njaQggJ6xdBDg47pWkiset5vvPw
 WtrEhYIhL0I/gtkdn5XfHHWM/KELN4GT8t2M7dHqc9n43jVc/O09ZZAcf21ETx4J+qgk
 +YPpBC+0D7eUnhSm5KvVys90cIdZiK7KlrR+TsxwMDtAEUiFMHxhLWJY8dmc/5tXa7E+
 F6FctM8Cxaf+MOjZVBPIHi7tY+YAxjqghqCwCakGvFwdDnbjHJd/Fpx4hycSpd/IjqrB
 n5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ds9XUIn3L4/5QLGo7B7E7e5AZsy/o97x7KpSJKj7hQk=;
 b=pYdmlPjz5oSceVD31PHPLF5AXW+RXPfpH9ESfexzm+MRlE1VTvKejLwvL/Otk2jOoz
 87E/VCLen/1PXzjUgpixFpgCz06kRAYWusg/cA+7EGrq7cVAjklex8ZSoYXOTVIJfECB
 RgDjukU41PyI1cuqKsYBVXMA3Ih9gWRgEEEAu1xRkEPSNR0DjAdZS5v3JK/rJwxHxvWg
 kKVrAVM8eNoAtgzGpT/Nz/3qlrsrbsvQ6k1+qRhPJCHHfiOyCQrf52e22oMPz2Iem25f
 +fHVKxRKRk6VmH8V6sdN2cIuwOsO74Ri8N6Zixwtc1GZoJ2PLKk+Ebp1QASpnfWSHsyK
 2cbA==
X-Gm-Message-State: APjAAAUCHzfYSAAViQCLXORfmqwR/1rFZdj5Qb/mvCry8+QD2NjQle9f
 kv6cOmTNgyDbhd4Fl8WZu5WCMi0ImVg=
X-Google-Smtp-Source: APXvYqwVj1YXj/bycEZ/zRkuE7RYVyy8EdFUIWufpii7NLTLftwuGnaz3LkBji8s4WkXasxozcftkg==
X-Received: by 2002:a63:484d:: with SMTP id x13mr849501pgk.448.1560834022291; 
 Mon, 17 Jun 2019 22:00:22 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id 201sm18709557pfz.24.2019.06.17.22.00.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 22:00:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20190519041522.12327-1-richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <8f28d008-2608-a579-7505-4546b08deb41@linaro.org>
Date: Mon, 17 Jun 2019 22:00:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190519041522.12327-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v4 0/7] tcg/ppc: Add vector opcodes
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
Cc: mark.cave-ayland@ilande.co.uk, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping.  Otherwise I'll include it in my next tcg pull.


r~

On 5/18/19 9:15 PM, Richard Henderson wrote:
> Based-on: <20190518190157.21255-1-richard.henderson@linaro.org>
> Aka "tcg: misc gvec improvements".
> 
> Version 3 was last posted in March,
> https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg05859.html
> 
> Changes since v3:
>   * Add support for bitsel, with the vsx xxsel insn.
>   * Rely on the new relocation overflow handling, so
>     we don't require 3 insns for a vector load.
> 
> Changes since v2:
>   * Several generic tcg patches to improve dup vs dupi vs dupm.
>     In particular, if a global temp (like guest r10) is not in
>     a host register, we should duplicate from memory instead of
>     loading to an integer register, spilling to stack, loading
>     to a vector register, and then duplicating.
>   * I have more confidence that 32-bit ppc host should work
>     this time around.  No testing on that front yet, but I've
>     unified some code sequences with 64-bit ppc host.
>   * Base altivec now supports V128 only.  Moved V64 support to
>     Power7 (v2.06), which has 64-bit load/store.
>   * Dropped support for 64-bit vector multiply using Power8.
>     The expansion was too large compared to using integer regs.
> 
> 
> r~
> 
> 
> Richard Henderson (7):
>   tcg/ppc: Initial backend support for Altivec
>   tcg/ppc: Support vector shift by immediate
>   tcg/ppc: Support vector multiply
>   tcg/ppc: Support vector dup2
>   tcg/ppc: Update vector support to v2.06
>   tcg/ppc: Update vector support to v2.07
>   tcg/ppc: Update vector support to v3.00
> 
>  tcg/ppc/tcg-target.h     |   39 +-
>  tcg/ppc/tcg-target.opc.h |   11 +
>  tcg/ppc/tcg-target.inc.c | 1077 +++++++++++++++++++++++++++++++++++---
>  3 files changed, 1063 insertions(+), 64 deletions(-)
>  create mode 100644 tcg/ppc/tcg-target.opc.h
> 


