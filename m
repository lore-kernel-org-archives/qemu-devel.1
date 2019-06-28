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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ADBC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E3392083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sz19bV+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3392083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgtqV-0007j0-34
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 12:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41223)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hgtma-0005IE-18
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hgtmY-0001VJ-Mn
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:31:27 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:39841)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hgtmY-0001U9-DW; Fri, 28 Jun 2019 12:31:26 -0400
Received: by mail-lj1-x244.google.com with SMTP id v18so6586613ljh.6;
 Fri, 28 Jun 2019 09:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=l5HEV/3S6TEkQbDw4Fi8zP8mYJAb1w7/BkVTDnxKLHE=;
 b=sz19bV+3v7ZPT4+0mbRybUbbXes2rEfmD2GfFVSetN8RbwLW8oar3Egy4uAAikLBtw
 bMLt3wmLP1bs5S1W/+sOpIHsB+MUO4kZAHBkZ8CgoOUSZNAGkBvE6GcAyJ+QzYweZMcf
 rSW72mDn8rzfb6Ys8U7/f+mFr8CHKsxNtegQcEd76hq7UJ9b9+LY8Pzyh8hjdmM5KUkK
 wmoT/6xnn0UJrRaHoon8zhUSF3JUrpWdoUD6rib6vPmHbD3QnLkzOAXNkCdwIAq24xnp
 ACLhjXwMtB+6b0y2M21LczFdEzCGQygOuzzjDeQOD/9Ra7slSgeA7CqcQVe/KeGgEyjc
 bX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=l5HEV/3S6TEkQbDw4Fi8zP8mYJAb1w7/BkVTDnxKLHE=;
 b=V+kOVzsWas3WKWLe6R71VEIU471RDynB4Lt+bxx2TwwabRY1HxNrPiZCHOdWowDuoN
 tEDMCrULCD8tQURzG5mJ2qA0xpVzJKkmTVq2ObT893lqjQb72XaaNrB9jqga9JZxXNce
 lblwXtVAymP9GA2Qg5tVOxyIMyf2HFLFIzzJeHbZWJo6G+es+KWWMwcAfKhtg3rLIIif
 n4Rkwv9Mps1hJxZrnIrojWAXwW1EERYLGT5zAvBZaqye6hBH5C6v3Sx/gkNbDGqyOjHm
 0atwUhyHCkv1LPD5MnPMXlDeQkOipZU1KHLf4+nShEZGDztueVW63VnwIVzGdUIjYfqV
 C3ZQ==
X-Gm-Message-State: APjAAAVhr/Vjebt5Ya+BIysTFHYpvjZIGdayeJq6+PdfF+QDwG0OHonG
 zdvk6Ww/5WZvkiRvE/6rEKOMSjhWvsZNLHVbjxc=
X-Google-Smtp-Source: APXvYqwxgmOcWKo0EcQhm1m5lXxWlMwqzfHpCI98g2Wjy2Srr1EfwFnV0eUcVg2Ie3jNgDjaCspGp+83xt9liTZZyGE=
X-Received: by 2002:a2e:9758:: with SMTP id f24mr6785310ljj.58.1561739484954; 
 Fri, 28 Jun 2019 09:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190627202719.17739-1-philmd@redhat.com>
 <20190627202719.17739-13-philmd@redhat.com>
In-Reply-To: <20190627202719.17739-13-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Jun 2019 09:28:24 -0700
Message-ID: <CAKmqyKOvSV_MJg1x3EGWVNeMUvvT5gG3mH_LQDVSwVgcWA+YFQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v5 12/28] hw/block/pflash_cfi02: Fix
 command address comparison
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

On Thu, Jun 27, 2019 at 1:42 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
>
> Most AMD commands only examine 11 bits of the address. This masks the
> addresses used in the comparison to 11 bits. The exceptions are word or
> sector addresses which use offset directly rather than the shifted
> offset, boff.
>
> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
> Acked-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20190426162624.55977-4-stephen.checkoway@oberlin.edu>
> [PMD: Prepend 'hw/' in patch subject]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/block/pflash_cfi02.c   |  8 +++++++-
>  tests/pflash-cfi02-test.c | 12 ++++++++++--
>  2 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index e64dc69c6c..4be3837be5 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -281,11 +281,13 @@ static void pflash_write(void *opaque, hwaddr offse=
t, uint64_t value,
>      }
>      offset &=3D pfl->chip_len - 1;
>
> -    boff =3D offset & (pfl->sector_len - 1);
> +    boff =3D offset;
>      if (pfl->width =3D=3D 2)
>          boff =3D boff >> 1;
>      else if (pfl->width =3D=3D 4)
>          boff =3D boff >> 2;
> +    /* Only the least-significant 11 bits are used in most cases. */
> +    boff &=3D 0x7FF;
>      switch (pfl->wcycle) {
>      case 0:
>          /* Set the device in I/O access mode if required */
> @@ -538,6 +540,10 @@ static void pflash_cfi02_realize(DeviceState *dev, E=
rror **errp)
>          }
>      }
>
> +    /* Only 11 bits are used in the comparison. */
> +    pfl->unlock_addr0 &=3D 0x7FF;
> +    pfl->unlock_addr1 &=3D 0x7FF;
> +
>      pflash_setup_mappings(pfl);
>      pfl->rom_mode =3D 1;
>      sysbus_init_mmio(SYS_BUS_DEVICE(dev), &pfl->mem);
> diff --git a/tests/pflash-cfi02-test.c b/tests/pflash-cfi02-test.c
> index e7e16a8dd8..e090b2e3a0 100644
> --- a/tests/pflash-cfi02-test.c
> +++ b/tests/pflash-cfi02-test.c
> @@ -21,8 +21,8 @@
>
>  #define FLASH_WIDTH 2
>  #define CFI_ADDR (FLASH_WIDTH * 0x55)
> -#define UNLOCK0_ADDR (FLASH_WIDTH * 0x5555)
> -#define UNLOCK1_ADDR (FLASH_WIDTH * 0x2AAA)
> +#define UNLOCK0_ADDR (FLASH_WIDTH * 0x555)
> +#define UNLOCK1_ADDR (FLASH_WIDTH * 0x2AA)
>
>  #define CFI_CMD 0x98
>  #define UNLOCK0_CMD 0xAA
> @@ -190,6 +190,14 @@ static void test_flash(void)
>      g_assert_cmphex(flash_read(6), =3D=3D, 0xCDEF);
>      g_assert_cmphex(flash_read(8), =3D=3D, 0xFFFF);
>
> +    /* Test ignored high order bits of address. */
> +    flash_write(FLASH_WIDTH * 0x5555, UNLOCK0_CMD);
> +    flash_write(FLASH_WIDTH * 0x2AAA, UNLOCK1_CMD);
> +    flash_write(FLASH_WIDTH * 0x5555, AUTOSELECT_CMD);
> +    g_assert_cmpint(flash_read(FLASH_WIDTH * 0x0000), =3D=3D, 0x00BF);
> +    g_assert_cmpint(flash_read(FLASH_WIDTH * 0x0001), =3D=3D, 0x236D);
> +    reset();
> +
>      qtest_quit(global_qtest);
>  }
>
> --
> 2.20.1
>
>

