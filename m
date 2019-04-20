Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F2BC282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 18:58:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DCC920833
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 18:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LeBxfL5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DCC920833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44405 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHvC6-000249-4g
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 14:58:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hHvBM-0001lG-Ci
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 14:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hHvBL-0006PV-8K
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 14:57:48 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hHvBL-0006OL-2W
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 14:57:47 -0400
Received: by mail-ot1-x341.google.com with SMTP id e5so6646002otk.12
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 11:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=a+RAiziL7iXILNYT0RjXmvaqmPF77RSEjXL7e9L6jmE=;
	b=LeBxfL5r9yBqFc0NUO2S6b6yMvCDHCn7RGotVArctE8BqE6toah/evcArejHafV5+P
	nBYa7BU/IU2XS7olF17hhx6/r5WB1vrd14TruO9msi1IoH+QReo0KcWp4aHWynGEwkyJ
	VbEIrTcVXM7ed7B5sEVE4lJQrpEDjlC15rz+JixfFjYmOKLYk0uOaZmm36RWDacnFSSm
	+391HcwQbl6XMgR4PhF/RC0SIBAL0URkNzCylbERfbX6j9HPHylBGHs0Z1t8o/eSf3nm
	mzHf3kDmqA+oP9QYIiB4JoOEMCrahF8VOLIVVWgyv3oujhMqaRAv2IRLGBGWeMeFOb5W
	MvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=a+RAiziL7iXILNYT0RjXmvaqmPF77RSEjXL7e9L6jmE=;
	b=hU8eNDNZT6XNKOgFTWtoRmnRR6stdk8mmOgTy6cLsHvEFDFCWYYoqTHRWnBxnaQ2O8
	QkpQ/pU5kPaEO+YQgJxnCTj2xoT7ExEQC21Ia280X/H18HihQovJK1mLq6JxxatLPwt7
	+gWkvfgn+BdHWBGps2rIbw90A0upys8gbDbHYuBswkBnSEhFV2x8SERbFv+mvDJlNbYg
	lHfSfASPUJZDxmVORB8X8hjilvw14hXmxes6GQWW7v/SHojX24hv0JHzeiIe+BFnSCDW
	nykJcILCXkobF4ohaWLWOK1R1REZ0aX0QK08ZECl4i4pcvyNhlcER7TyrnNQvEAwKFwG
	mTIA==
X-Gm-Message-State: APjAAAUvkjHxf/7hfff9irxpOYO/QyJilOh4CqdE7F1jwPAzLodBeTfM
	22TnaA1l4EpuHkA8t48amNnGL37njtrK110L3K1hgQ==
X-Google-Smtp-Source: APXvYqz7xLMtg++6gwGO3J/dlDSNj8448Qareb74oEHrzplPduaL8jOAAHFKaejezpnJS6SSwcCjFv5LuuZfy8F/EGM=
X-Received: by 2002:a9d:57c4:: with SMTP id q4mr5919807oti.151.1555786662941; 
	Sat, 20 Apr 2019 11:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190419114502.20388-1-shahab.vahedi@gmail.com>
In-Reply-To: <20190419114502.20388-1-shahab.vahedi@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 20 Apr 2019 19:57:31 +0100
Message-ID:
 <CAFEAcA_2aNt10Ti8HCTbCvHrgFYt7Uw2z=pNWBWyWMsbR6kjoQ@mail.gmail.com>
To: Shahab Vahedi <shahab.vahedi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH] cputlb: Fix io_readx() to respect the
 access_type
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	"open list:Overall" <qemu-devel@nongnu.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190420185731.j3C4K8LdSbH-kZZEtqKDyZgP_15EGTC_VoAo0T7xzOU@z>

On Fri, 19 Apr 2019 at 12:46, Shahab Vahedi <shahab.vahedi@gmail.com> wrote:
>
> This change adapts io_readx() to its input access_type. Currently
> io_readx() treats any memory access as a read, although it has an
> input argument "MMUAccessType access_type". This results in:
>
> 1) Calling the tlb_fill() only with MMU_DATA_LOAD
> 2) Considering only entry->addr_read as the tlb_addr
>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1825359
>
> Signed-off-by: Shahab Vahedi <shahab.vahedi@gmail.com>
> ---
> Changelog:
> - Extra space before closing parenthesis is removed
>
>  accel/tcg/cputlb.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Hi; this patch mostly looks good; thanks for submitting it.

> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 88cc8389e9..4a305ac942 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -878,10 +878,13 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
>          CPUTLBEntry *entry;
>          target_ulong tlb_addr;
>
> -        tlb_fill(cpu, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
> +        tlb_fill(cpu, addr, size, access_type, mmu_idx, retaddr);
>
>          entry = tlb_entry(env, mmu_idx, addr);
> -        tlb_addr = entry->addr_read;
> +        tlb_addr =
> +            (access_type == MMU_DATA_LOAD)  ? entry->addr_read  :
> +            (access_type == MMU_DATA_STORE) ? entry->addr_write :
> +            entry->addr_code;

Here you don't need to handle MMU_DATA_STORE, because
we're in io_readx -- stores will go to io_writex, not here.

Style-wise it's probably better just to use an
  if (...) {
      tlb_addr = ...;
  } else {
      tlb_addr = ...;
  }

rather than a multi-line ?: expression.

>          if (!(tlb_addr & ~(TARGET_PAGE_MASK | TLB_RECHECK))) {
>              /* RAM access */
>              uintptr_t haddr = addr + entry->addend;
> --
> 2.21.0
>

thanks
-- PMM

