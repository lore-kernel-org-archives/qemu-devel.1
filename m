Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4E0C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 23:20:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3357208CB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 23:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IE1R1h4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3357208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hh0Ag-0007PX-3m
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 19:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50801)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hh074-0004Nw-VM
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 19:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hh072-0003jg-Dg
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 19:17:02 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:39147)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hh072-0003hA-3l; Fri, 28 Jun 2019 19:17:00 -0400
Received: by mail-lf1-x144.google.com with SMTP id p24so4984282lfo.6;
 Fri, 28 Jun 2019 16:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=JpK8Lwt8b8p9UFL6KUVXrJWkSJM2HNjtFLirM0QdfV4=;
 b=IE1R1h4ol6xl3o0MBXm4vhc1RwrqHqQCVpSGM1RiJwDhAkNd5ZrHyA98qkHG3ylo6y
 3GHF5F+/QBVDOUNFmEdVebZtz+xoTxugo9gsInGuzbRzFplq406AtTuRXzAltE8M4VYu
 nngVq0AEjUZnFTnn8ZAgbZMfgnwsHFExc57/5oYhhmFf0DtUZUVWZQeOuyu1Mp521gpe
 8v2l3H8svNJ15yF9LOQ1aszx4CHjeUCzp9EjgDcAuNiZSN54swENoXZ6FhPJRSKj+3TH
 5DUeghvLYRoTqFNXSmSRaAZoTTBHbiqg/7pfQwHOT/YwSZr8ReZvderK7QOha/TuH+nK
 4++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JpK8Lwt8b8p9UFL6KUVXrJWkSJM2HNjtFLirM0QdfV4=;
 b=g15ctS18RnvDxrict+dkBO+p0W4J+SLJFdbvCjeOdlnL9w7Wpqujiy1CnEmTLXG/Cu
 /IRrArHK7EwkbB5G3udhxS06Fk01a5rVHZyUf8gglOHzfU42sF69dIs6143ql7FjB3Ie
 YRtE4O6AWBzU0PXtl9879488Cd/wLtehjmd06nTphRfjinUzvwosrePgde98c+NuBsu9
 lqA2wQLMYivPZN7CVelsdFHnI3LFchUsVvJnOzWqvjKmtMM5OFnjHdrIpF+PRgyr3z/9
 FwFN3nBIyntWLS5t8ZyJYAZnZKxVhIG0ktgF5X2I8zkTz+cFW86iCal5fqlSKXeRSdyk
 Tt4w==
X-Gm-Message-State: APjAAAVhotf5v3KrQy4o+rOi5QjN3arcorHR0/HkvhRDUy/oEt7RWLU2
 1q3uT2JJGQM3apN65LoAph//FplEbUKOq59Fwv4=
X-Google-Smtp-Source: APXvYqxAhIKzzT8/TuPuBmOTKuIQj93pneUu/kxL6iTqlogSyIH2AY5iITRYzSltnjfz6RaOtj3fnfZt5WujXw8fZys=
X-Received: by 2002:a19:710b:: with SMTP id m11mr6288717lfc.135.1561763817934; 
 Fri, 28 Jun 2019 16:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190627202719.17739-1-philmd@redhat.com>
 <20190627202719.17739-29-philmd@redhat.com>
In-Reply-To: <20190627202719.17739-29-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Jun 2019 16:13:57 -0700
Message-ID: <CAKmqyKNTq3Sj_Fr3rvOccU2DeuZryvJL1=HhjmVWJMGWKz7OHg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
Subject: Re: [Qemu-devel] [PATCH v5 28/28] hw/block/pflash_cfi02: Reduce I/O
 accesses to 16-bit
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Qemu-block <qemu-block@nongnu.org>, John Snow <jsnow@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 27, 2019 at 1:55 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Parallel NOR flashes are limited to 16-bit bus accesses.
> Remove the 32-bit dead code.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/block/pflash_cfi02.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index db9dc7d8fb..d1f28b02b9 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -317,8 +317,6 @@ static uint64_t pflash_read(void *opaque, hwaddr offs=
et, unsigned int width)
>      boff =3D offset & 0xFF;
>      if (pfl->width =3D=3D 2) {
>          boff =3D boff >> 1;
> -    } else if (pfl->width =3D=3D 4) {
> -        boff =3D boff >> 2;
>      }
>      switch (pfl->cmd) {
>      default:
> @@ -449,8 +447,6 @@ static void pflash_write(void *opaque, hwaddr offset,=
 uint64_t value,
>      boff =3D offset;
>      if (pfl->width =3D=3D 2) {
>          boff =3D boff >> 1;
> -    } else if (pfl->width =3D=3D 4) {
> -        boff =3D boff >> 2;
>      }
>      /* Only the least-significant 11 bits are used in most cases. */
>      boff &=3D 0x7FF;
> @@ -710,6 +706,7 @@ static void pflash_write(void *opaque, hwaddr offset,=
 uint64_t value,
>  static const MemoryRegionOps pflash_cfi02_ops =3D {
>      .read =3D pflash_read,
>      .write =3D pflash_write,
> +    .impl.max_access_size =3D 2,
>      .valid.min_access_size =3D 1,
>      .valid.max_access_size =3D 4,
>      .endianness =3D DEVICE_NATIVE_ENDIAN,
> --
> 2.20.1
>
>

