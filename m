Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7552CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 443F720772
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I+Z4Yath"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443F720772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfhy7-00085h-Hc
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 06:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfhx9-00077W-88
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:45:59 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:33126)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfhx8-0005SS-2g
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:45:58 -0400
Received: by mail-oo1-xc43.google.com with SMTP id q6so1317894oot.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 03:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=P8oanKv6ySihFAuQFSVe2IXsbtNjLXc3uCG4fPgHb0k=;
 b=I+Z4Yathuh8v8CfqHlZWYAXiL78S051sjFCFc5+VvNzN9uLauDTceBJP6TUC2fc4u5
 /R4Y1sGn5D6QNo+LxZHua10THni3b44AVG75fpoA70Nb+OxQWlk3tgoG0Kzd/7bIxwCh
 m/ez4adAp+R91akPug4n8EtD7m/epCDMBilpjZTyfJzp/4jfOAfDedVQtRatK4/c1J+M
 7QSxXM32ouq7Y6CFMMJLc7eshQ2UnMGX6WytjFkSw2lDbjER7+rj34Xoniqt+///WNJa
 0hL8qBkLxKyvpXh1qUz2oMAvQpJ0/F1R31PJNXaurQBg9nN68Ez2+pFk12DflF/H2FqE
 5ITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=P8oanKv6ySihFAuQFSVe2IXsbtNjLXc3uCG4fPgHb0k=;
 b=WrxfVDnff3kakIABQR0BpKu4gwobOJW52/s8EAAyTNm4YZkoBWNu4R2NHxvbR4yhgf
 +FCLthfR7mYN6A2aGx8RQrbTXC3SNW/6VIq6QwxqlIGuHo1j03lWWJBk9dDrPXo9HBrH
 NZHsQf1jDQkGdpNirm1XI5C1SpjS5R9ubwFGS/mpbBpv6KzPy+DG+hUPocW/NzeOJZ3j
 e0ictrbFSclyOXFhWAP+wbbfI15bE3BsRjrcmod9eyzuxKd1iY3r7N2iVQa5fWZ5lgor
 TRKB5yoLebUzTR9GU0pZz+bFz0UtTD5hqpKO8R/qb5MY7UZB/21UJpFUBLXtqUT4R41x
 8+DA==
X-Gm-Message-State: AOAM531YFmoBFzCSICxquvx0YRFRxE6v6Enmmj0mUEn1EEmnuLhmjr+U
 bqWK5D7tQFO0PqgF8ypohugeOj7PGshQ/SHqH2CzuQ==
X-Google-Smtp-Source: ABdhPJxFG4BOggZZlFHYpd6O+wltuzcRoVa5itWLrlIGLc522D1dSkOieJVt+TURQom6aGGaYeMzPc1LNE6gsOC6WJY=
X-Received: by 2002:a4a:a2c4:: with SMTP id r4mr15206136ool.20.1591008356696; 
 Mon, 01 Jun 2020 03:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200531175425.10329-1-f4bug@amsat.org>
 <20200531175425.10329-6-f4bug@amsat.org>
 <CAFEAcA9CkBy=e3EmJhKko9XGbL7A_E_vedm8jt_H3+Gr6yzbhA@mail.gmail.com>
 <2e78619d-543b-55b7-f241-7652274fcf4a@amsat.org>
In-Reply-To: <2e78619d-543b-55b7-f241-7652274fcf4a@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jun 2020 11:45:45 +0100
Message-ID: <CAFEAcA-zcNUEoSS0was=Sd4d7VUDZGEhV5aDinkxKi_z2NHF2w@mail.gmail.com>
Subject: Re: [PATCH 5/6] exec: Restrict 32-bit CPUs to 32-bit address space
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 1 Jun 2020 at 09:09, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> On 5/31/20 9:09 PM, Peter Maydell wrote:
> > [*] Strictly speaking, it would depend on the
> > maximum physical address size used by any transaction
> > master in the system -- in theory you could have a
> > 32-bit-only CPU and a DMA controller that could be
> > programmed with 64-bit addresses. In practice the
> > CPU can generally address at least as much of the
> > physical address space as any other transaction master.
>
> Yes, I tried the Malta with 32-bit core, while the GT64120 northbridge
> addresses 64-bit:

> From "In practice the CPU can generally address at least as much of the
> physical address space as any other transaction master." I understand
> for QEMU @system address space must be as big as the largest transaction
> a bus master can do".

That depends on what happens for transactions that are off the end
of the range, I suppose -- usually a 32-bit CPU system design will
for obvious reasons not put ram or devices over 4GB, so if the
behaviour for a DMA access past 4GB is the same whether there's
nothing mapped there or whether the access is just off-the-end then
it doesn't matter how QEMU models it. I haven't tested to see what an
off-the-end transaction does, though.

I'm inclined to say that since 'hwaddr' is always a 64-bit type we should
stick to having the system memory address space be64 bits.

> I think what confuse me is what QEMU means by 'system-memory', I
> understand it historically as the address space of the first CPU core.

Historically I think it was more "there is only one address space and
this is it": it wasn't the first CPU's address space, it was what *every*
CPU saw, and what every DMA device used, because the APIs
pre-MemoryRegion had no concept of separate address spaces at all.
So system-memory starts off as a way to continue to provide those
old semantics in an AddressSpace/MemoryRegion design, and we've
then gradually increased the degree to which different transaction
masters use different AddressSpaces. Typically system-memory
today is often "whatever's common to all CPUs" (and then you
overlay per-CPU devices etc on top of that), but it might have
less stuff than that in it (I have a feeling the arm-sse SoCs put
less stuff into system-memory than you might expect). How much
freedom you have to not put stuff into the system-memory address
space depends on things like whether the guest architecture's
target/foo code or some DMA device model on the board still uses
APIs that don't specify the address space and instead use the
system address space.

thanks
-- PMM

