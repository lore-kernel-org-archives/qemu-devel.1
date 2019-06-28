Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BAFC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 23:19:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E8CD208CB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 23:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3idFe96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8CD208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hh092-0005kE-RU
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 19:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50673)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hh06a-00049F-D7
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 19:16:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hh06Y-00035Y-F7
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 19:16:32 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:34276)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hh06Y-00032i-5u; Fri, 28 Jun 2019 19:16:30 -0400
Received: by mail-lj1-x244.google.com with SMTP id p17so7536592ljg.1;
 Fri, 28 Jun 2019 16:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=c2cFcUEayjaeyZAvgWneP1t9vQDYrLkELQ3ZZtuA75o=;
 b=B3idFe96yPaMeYbsHUIunZHTHxWUnv7Y58hqpK71SaQucbEWxZoQpacUlgfPeFhMp8
 QoTz8sq3HkIzsHisaXVc4KfCLyQBN+eFOBLDhIN9JofQRDeY73hdW8lFC4+2oV+hgErl
 pywsJqFH2ThY4A+DfOscSGXAYtSqxuI98myKQIUNhn+2+8UhOghpjj3Twqcv2KMLav5r
 sZ/9WzTzZNkA0aZp7fzp3NOVoMzbH56PAPNUFH0tdiPTxn1YV3dmgTNjl4KdONoRxEVb
 PcpL1OB5totbmpg6ze+MfmfBExHqKO0fN4izdH0gkxdcfl0OKKGUq3D4ecDABzirTiPX
 zjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=c2cFcUEayjaeyZAvgWneP1t9vQDYrLkELQ3ZZtuA75o=;
 b=kebmay9PwT97kQsoa+DnjnhtWnG/efCaqVv1vKh9Gi99r4KPLHi17h80t2FZMeopdK
 moGsNoytEYJ1d67hrGBpDWBFz4NKqlAvMJelWaWMT40VHXzGGgaLmfBBmSB+5ZNFRv9S
 hvnYqp4KRmIW1F2IQXdNj4KyoqjSggrZORSX2UMY2Wg0EN6IKmxwpXajNQaRyKHuSXmq
 L05IrZC56edfvNBd+zViNCLpZmFFag66YYc/eWJC4ndXNOqlD6XDsa/AMaNzHGJFNjIT
 LHSMzZT0PsOumsI7F1KxPtPkiLCNRxqzYFPkFq3mM19lHavKV/R8pEyE2kPAj3ULksK+
 POtw==
X-Gm-Message-State: APjAAAWHE3MFsyfqCtmXPWZm26dBf/ScmRODly6rTdJI78P4hRM7qVG9
 Eao4MpEkWveYIQvt3NQhfrYvIbsCw1gObzZXUSc=
X-Google-Smtp-Source: APXvYqwyY2pAKqzC4W2lxDU+l6q/Ho4sYLvSjXnnNIHdW1V21QK2JZegpRv97vLVCJ6+JqrbCjUDri9skTJEFYX8/b4=
X-Received: by 2002:a2e:86cc:: with SMTP id n12mr7518196ljj.146.1561763787756; 
 Fri, 28 Jun 2019 16:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190627202719.17739-1-philmd@redhat.com>
 <20190627202719.17739-28-philmd@redhat.com>
In-Reply-To: <20190627202719.17739-28-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Jun 2019 16:13:27 -0700
Message-ID: <CAKmqyKNK8FUyGwxQPJ47jjeRDETyFZx1t7+YFGc8JvTdzoaa6w@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v5 27/28] hw/block/pflash_cfi02: Document
 commands
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

On Thu, Jun 27, 2019 at 1:58 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/block/pflash_cfi02.c | 40 +++++++++++++++++++---------------------
>  1 file changed, 19 insertions(+), 21 deletions(-)
>
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index e9519cbae8..db9dc7d8fb 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -327,7 +327,7 @@ static uint64_t pflash_read(void *opaque, hwaddr offs=
et, unsigned int width)
>          pfl->wcycle =3D 0;
>          pfl->cmd =3D 0;
>          /* fall through to the read code */
> -    case 0x80:
> +    case 0x80: /* Erase (unlock) */
>          /* We accept reads during second unlock sequence... */
>      case 0x00:
>          if (pflash_erase_suspend_mode(pfl) &&
> @@ -342,8 +342,7 @@ static uint64_t pflash_read(void *opaque, hwaddr offs=
et, unsigned int width)
>          /* Flash area read */
>          ret =3D pflash_data_read(pfl, offset, width);
>          break;
> -    case 0x90:
> -        /* flash ID read */
> +    case 0x90: /* flash ID read */
>          switch (boff) {
>          case 0x00:
>          case 0x01:
> @@ -364,11 +363,11 @@ static uint64_t pflash_read(void *opaque, hwaddr of=
fset, unsigned int width)
>          }
>          DPRINTF("%s: ID " TARGET_FMT_plx " %" PRIx64 "\n", __func__, bof=
f, ret);
>          break;
> -    case 0x10:
> -    case 0x30:
> +    case 0x10: /* Chip Erase */
> +    case 0x30: /* Sector Erase */
>          /* Toggle bit 2 during erase, but not program. */
>          toggle_dq2(pfl);
> -    case 0xA0:
> +    case 0xA0: /* Program */
>          /* Toggle bit 6 */
>          toggle_dq6(pfl);
>          /* Status register read */
> @@ -470,7 +469,7 @@ static void pflash_write(void *opaque, hwaddr offset,=
 uint64_t value,
>              return;
>          }
>          /* Handle erase resume in erase suspend mode, otherwise reset. *=
/
> -        if (cmd =3D=3D 0x30) {
> +        if (cmd =3D=3D 0x30) { /* Erase Resume */
>              if (pflash_erase_suspend_mode(pfl)) {
>                  /* Resume the erase. */
>                  timer_mod(&pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRT=
UAL) +
> @@ -485,7 +484,7 @@ static void pflash_write(void *opaque, hwaddr offset,=
 uint64_t value,
>              goto reset_flash;
>          }
>          /* Ignore erase suspend. */
> -        if (cmd =3D=3D 0xB0) {
> +        if (cmd =3D=3D 0xB0) { /* Erase Suspend */
>              return;
>          }
>          if (boff !=3D pfl->unlock_addr0 || cmd !=3D 0xAA) {
> @@ -516,9 +515,9 @@ static void pflash_write(void *opaque, hwaddr offset,=
 uint64_t value,
>          case 0x20:
>              pfl->bypass =3D 1;
>              goto do_bypass;
> -        case 0x80:
> -        case 0x90:
> -        case 0xA0:
> +        case 0x80: /* Erase */
> +        case 0x90: /* Autoselect */
> +        case 0xA0: /* Program */
>              pfl->cmd =3D cmd;
>              DPRINTF("%s: starting command %02x\n", __func__, cmd);
>              break;
> @@ -529,10 +528,10 @@ static void pflash_write(void *opaque, hwaddr offse=
t, uint64_t value,
>          break;
>      case 3:
>          switch (pfl->cmd) {
> -        case 0x80:
> +        case 0x80: /* Erase */
>              /* We need another unlock sequence */
>              goto check_unlock0;
> -        case 0xA0:
> +        case 0xA0: /* Program */
>              if (pflash_erase_suspend_mode(pfl) &&
>                  pflash_sector_is_erasing(pfl, offset)) {
>                  /* Ignore writes to erasing sectors. */
> @@ -562,7 +561,7 @@ static void pflash_write(void *opaque, hwaddr offset,=
 uint64_t value,
>              if (pfl->bypass)
>                  goto do_bypass;
>              goto reset_flash;
> -        case 0x90:
> +        case 0x90: /* Autoselect */
>              if (pfl->bypass && cmd =3D=3D 0x00) {
>                  /* Unlock bypass reset */
>                  goto reset_flash;
> @@ -585,11 +584,11 @@ static void pflash_write(void *opaque, hwaddr offse=
t, uint64_t value,
>          }
>      case 4:
>          switch (pfl->cmd) {
> -        case 0xA0:
> +        case 0xA0: /* Program */
>              /* Ignore writes while flash data write is occurring */
>              /* As we suppose write is immediate, this should never happe=
n */
>              return;
> -        case 0x80:
> +        case 0x80: /* Erase */
>              goto check_unlock1;
>          default:
>              /* Should never happen */
> @@ -604,7 +603,7 @@ static void pflash_write(void *opaque, hwaddr offset,=
 uint64_t value,
>              goto reset_flash;
>          }
>          switch (cmd) {
> -        case 0x10:
> +        case 0x10: /* Chip Erase */
>              if (boff !=3D pfl->unlock_addr0) {
>                  DPRINTF("%s: chip erase: invalid address " TARGET_FMT_pl=
x "\n",
>                          __func__, offset);
> @@ -621,8 +620,7 @@ static void pflash_write(void *opaque, hwaddr offset,=
 uint64_t value,
>              timer_mod(&pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)=
 +
>                        (1ULL << pfl->cfi_table[0x22]) * SCALE_MS);
>              break;
> -        case 0x30:
> -            /* Sector erase */
> +        case 0x30: /* Sector erase */
>              pflash_sector_erase(pfl, offset);
>              break;
>          default:
> @@ -633,10 +631,10 @@ static void pflash_write(void *opaque, hwaddr offse=
t, uint64_t value,
>          break;
>      case 6:
>          switch (pfl->cmd) {
> -        case 0x10:
> +        case 0x10: /* Chip Erase */
>              /* Ignore writes during chip erase */
>              return;
> -        case 0x30:
> +        case 0x30: /* Sector erase */
>              if (cmd =3D=3D 0xB0) {
>                  /*
>                   * If erase suspend happens during the erase timeout (so=
 DQ3 is
> --
> 2.20.1
>
>

