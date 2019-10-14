Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88604C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:55:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5313120873
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hhcgIYul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5313120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK2h2-00068i-Ge
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 11:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35115)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2g3-0005Fu-NU
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2g2-0004KU-KT
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:54:31 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33995)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2g2-0004KE-Ei
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:54:30 -0400
Received: by mail-oi1-x241.google.com with SMTP id 83so14167757oii.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 08:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=H6UahA8Qmqx5X6+4KairbPWKfNTmCAAiwutW2GNS0RY=;
 b=hhcgIYulXiMjHzMDxoG46K1Q1uZns5X+8jgFXjziAxy0AZ+eWjczBfNORU5BeGveWT
 I5em1Xt1mizThh/fn3eH3HmnrEX3F8mHNVEPeO5YYSrleiYpHKzDALTPn7+PudymFm4S
 +bpoTts7yoX676/Eb7T+CXMaJKDeDNG5uVfG7YGjgdtBDJ2e1ggPH3tES+N8K3RulFDS
 aVjRG2pO0KOW6GH1cPwcjIcUdM9z6yRRNmQlwH5trp529SpQCnXVb7Wnqb+Dimcnm4uY
 FU0ZQEALyVcN0rdQqBgc3z6nyTRDCX6W2YhlOgEi9Oo6yfcgs0H1MKMtxGKWi8gRrGpv
 TnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=H6UahA8Qmqx5X6+4KairbPWKfNTmCAAiwutW2GNS0RY=;
 b=cQQ7F62pvaPY6sv/wkIe81y3xIZ2keZxheHDIdGc2WZAhiymdjbxPRY3FE2h7XaMSB
 Hjz+CP31VZ8BFTHaoevrHDHHGVsB1+jmVtJcJuqTArdGcwA9HeX8f/DXhYc9MIXyieB5
 GSssmlsat6wvfSUwg0owt4jmXaPgj2I0pfEy6WtZfmu4E33oNimq1G3m0cMOSSie8vwl
 Gx+wGHTjjNa/dwrX6j9BB5qyPmwtG4NlROjZT5D8qrjR8ZKs5FlLA9o40v8XJdWjf0lW
 hisBitxggLENFRNo8OogFw13FpStuA3Pi4gs57n4OUz1AsUX5v87HQUCHA+EUZHi4WhZ
 9+mA==
X-Gm-Message-State: APjAAAUKIxU57o8xBw1qqtU/UmPUUkDTOt/BxSDg+2I1b907B0/3raHs
 Akvh9luikEuljy5JrzSg1ceRZpm9RmsExmlMjTCJHg==
X-Google-Smtp-Source: APXvYqzN7rIkm8AJEu8Ndl9rrS+7fLdy/HgGgE2he4IFufXx35DftZ2n8WKoNFpr9Qf+yRR0A0FA4RelqIJ4bcZRDm8=
X-Received: by 2002:a54:4e83:: with SMTP id c3mr25274855oiy.170.1571068469603; 
 Mon, 14 Oct 2019 08:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191014104948.4291-1-alex.bennee@linaro.org>
 <20191014104948.4291-18-alex.bennee@linaro.org>
In-Reply-To: <20191014104948.4291-18-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2019 16:54:18 +0100
Message-ID: <CAFEAcA8u3Srp_Lsucxh0-EaXW5UbETLOPA_KdpzONCaTob0GVA@mail.gmail.com>
Subject: Re: [PATCH v5 17/55] plugins: implement helpers for resolving hwaddr
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: robert.foley@futurewei.com, QEMU Developers <qemu-devel@nongnu.org>,
 peter.puhov@futurewei.com, Aaron Lindsay <aaron@os.amperecomputing.com>,
 "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Oct 2019 at 12:25, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> We need to keep a local per-cpu copy of the data as other threads may
> be running. We use a automatically growing array and re-use the space
> for subsequent queries.
>


> +#ifdef CONFIG_SOFTMMU
> +static __thread struct qemu_plugin_hwaddr hwaddr_info;
> +
> +struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t =
info,
> +                                                  uint64_t vaddr)
> +{
> +    CPUState *cpu =3D current_cpu;
> +    unsigned int mmu_idx =3D info >> TRACE_MEM_MMU_SHIFT;
> +
> +    if (!tlb_plugin_lookup(cpu, vaddr, mmu_idx,
> +                           info & TRACE_MEM_ST, &hwaddr_info)) {
> +        error_report("invalid use of qemu_plugin_get_hwaddr");
> +        return NULL;
> +    }
> +
> +    return &hwaddr_info;
> +}

Apologies for dropping into the middle of this patchset, but
this API looks a bit odd. A hwaddr alone isn't a complete
definition of an access -- you need an (AddressSpace, hwaddr)
tuple for that. So this API looks like it doesn't really cope
with things like TrustZone ?

>  uint64_t qemu_plugin_hwaddr_to_raddr(const struct qemu_plugin_hwaddr *ha=
ddr)
>  {
> +#ifdef CONFIG_SOFTMMU
> +    ram_addr_t ram_addr =3D 0;
> +
> +    if (haddr && !haddr->is_io) {
> +        ram_addr =3D qemu_ram_addr_from_host((void *) haddr->hostaddr);
> +        if (ram_addr =3D=3D RAM_ADDR_INVALID) {
> +            error_report("Bad ram pointer %"PRIx64"", haddr->hostaddr);
> +            abort();
> +        }
> +    }
> +    return ram_addr;
> +#else
>      return 0;
> +#endif
>  }

This looks odd to see in the plugin API -- ramaddrs should
be a QEMU internal concept, shouldn't they?

thanks
-- PMM

