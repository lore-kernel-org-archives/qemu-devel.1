Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA35BC282E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 23:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6885721736
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 23:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j0WvHOAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6885721736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34211 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHcZn-0006Af-MY
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 19:05:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hHcYu-0005mp-T2
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:04:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hHcYt-0005Ec-Oj
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:04:52 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:56153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hHcYt-0005EH-BS
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 19:04:51 -0400
Received: by mail-wm1-x344.google.com with SMTP id o25so7555223wmf.5
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 16:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=6b6QBh4a0Aa0Dodgd0cQnG8CkcAuFjw9/y4l12Y6NWI=;
	b=j0WvHOAIInuz2oiDfb2yGvAo5CO3NpIuRQtQ8Fn3cHbU8OKMGDZ9HmN1IMd3MT0wTN
	E4mSBxz0rkIoyRN8VHzwkEFKynnrTyfg2miljiX2YV21S2tNkPVs48F12GlX8lCbIHPx
	OzxVoDHfvDInmQmdmi0IWwt5uBPbCuoi9nn9OSMJbt32VxHjTC+zVqEvM0XykjHx2zlB
	sIfrv0y7tXudE8TTziDj3qNo/J9qMaZkLq8e3P2XVldtv0gJiJUZlbLBY8qR0JuKnSaM
	LuwYECAZ8kONTGYuzG3u9yGyozrXuri1T77oUOIQk6t4T5I9C5T+FCdob8djvzHhfUZM
	y5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=6b6QBh4a0Aa0Dodgd0cQnG8CkcAuFjw9/y4l12Y6NWI=;
	b=Nan35GHTK7V/vzFr8UdesI9e8xFEinyumqriC156m3NfnBYnigDa+ayRvq8pb/Eqj6
	z9ZiW/RRA6YZFxeFniYPUufAflXDXz9sHkPxE4bKqj9tBiWnAcaXYBoeZQorZORYG21q
	W2wT3qoMOFC2W8ybHoQNpJOh9sLGDNuHrGeqyRksU8LXvCK0gZcrsfMy2dw81H4wNDwI
	AkIpPUwp1A5XDYzKdb2xlRRSbrHJXcY+weXG57DYAkVdzjULGePMHhGafTPYhHggmDA4
	b+tiWjAmvyBoZJwoM4uK6/sucPv8Kkfp9lofV5tPrf74hSQped4R4xZtBB3vg5DRExWE
	dIqQ==
X-Gm-Message-State: APjAAAWKCCtKnzL9Xwt5Sv67SMarJ47xEPYkFgg/04YSLbsIkFbUSk44
	uLi1CZltJecA2+urRT9f3xAlng==
X-Google-Smtp-Source: APXvYqwnhGpuHYz6sMpeGT6sBdkRlPWQ0BaYhvf1PAJlfTtn8ju/aSjknhuXZPO815iUoFfXwgWnEQ==
X-Received: by 2002:a1c:ca06:: with SMTP id a6mr4088133wmg.14.1555715089748;
	Fri, 19 Apr 2019 16:04:49 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id r6sm4613902wmc.11.2019.04.19.16.04.48
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 19 Apr 2019 16:04:49 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id A915E1FF87;
	Fri, 19 Apr 2019 23:04:48 +0000 (UTC)
References: <20190419103722.17062-1-shahab.vahedi@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190419103722.17062-1-shahab.vahedi@gmail.com>
Date: Fri, 19 Apr 2019 23:04:48 +0000
Message-ID: <871s1xha0f.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Shahab Vahedi <shahab.vahedi@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190419230448.XslGDPzbzkP7WiLssQSoKTBM7dm4bqz2t3a3wLW6ksc@z>


Shahab Vahedi <shahab.vahedi@gmail.com> writes:

> This change adapts io_readx() to its input access_type. Currently
> io_readx() treats any memory access as a read, although it has an
> input argument "MMUAccessType access_type". This results in:
>
> 1) Calling the tlb_fill() only with MMU_DATA_LOAD
> 2) Considering only entry->addr_read as the tlb_addr
>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1825359

This bug talks about the distinction between DATA_LOAD and INST_FETCH but...

>
> Signed-off-by: Shahab Vahedi <shahab.vahedi@gmail.com>
> ---
>  accel/tcg/cputlb.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 88cc8389e9..0daac0e806 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -878,10 +878,13 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTL=
BEntry *iotlbentry,
>          CPUTLBEntry *entry;
>          target_ulong tlb_addr;
>
> -        tlb_fill(cpu, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
> +        tlb_fill(cpu, addr, size, access_type, mmu_idx, retaddr);
>
>          entry =3D tlb_entry(env, mmu_idx, addr);
> -        tlb_addr =3D entry->addr_read;
> +        tlb_addr =3D
> +            (access_type =3D=3D MMU_DATA_LOAD ) ? entry->addr_read  :
> +            (access_type =3D=3D MMU_DATA_STORE) ? entry->addr_write :
> +            entry->addr_code;

...why do we care here about MMU_DATA_STORE?

We could just assert (access_type =3D=3D MMU_DATA_LOAD || access_type =3D=3D
MMU_INST_FETCH) and then have:

  (access_type =3D=3D MMU_DATA_LOAD ) ? entry->addr_read  : entry->addr_code


>          if (!(tlb_addr & ~(TARGET_PAGE_MASK | TLB_RECHECK))) {
>              /* RAM access */
>              uintptr_t haddr =3D addr + entry->addend;


--
Alex Benn=C3=A9e

