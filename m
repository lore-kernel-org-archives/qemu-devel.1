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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF7FC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:07:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCF9B2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqYK6DSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF9B2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hguLF-0004SR-12
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 13:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33243)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hgtGC-0006yj-T6
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hgtGB-0003Sv-KC
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:58:00 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:36792)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hgtGB-0003Rf-9r; Fri, 28 Jun 2019 11:57:59 -0400
Received: by mail-lj1-x242.google.com with SMTP id i21so6505493ljj.3;
 Fri, 28 Jun 2019 08:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6P2AsnQVf0FQrkcwCPwcdNXTqIcjVBDpEya1qSDIhME=;
 b=hqYK6DSLbuR64O2JlOY5sCrC29/pficIv92hR/FXfa1OHCwAII5SdgI4U2XEMidVn7
 cr9VE6Vs7f4tj3jXUKmtEwRNWLHcJhhXGVf+86Y+XsgEYIceOsepKZUz6KtDGKlRWlse
 X0kwTVTryufGgbpsbtH3sNhrx5fG4+K+cZYI/XgWVUfVzUFu1tf/GzEIgwn+jGatJZkm
 kFezjEPu4DC+0Ny8gzQRfZS2ZEUbtUpKvHPTdku6K92wPmw/fG9rqbsUBpyxB/z+NhrL
 le61Yh2zBL2B0JOooETvBQG8yVpydqwZHgfBQxV+Ee5BnQM3ECFIryoUPGkg4T3zNw2j
 piXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6P2AsnQVf0FQrkcwCPwcdNXTqIcjVBDpEya1qSDIhME=;
 b=NOBmagp5lWg0iqmAIZba2WWtCiRf6v5OwrnotCkDCVAOuvaefhnsxaknkhcKOrw4Np
 O3YGc6VJER4f0A2qWCIUEk9S/cnPqIr6vmkPi8vdD0YkLKqKOy0HTxQu+RXTYgk/0xNw
 AuBI0a3EAVUJ5x86vCvs5J0k+XPzYSAwJOgzKUuONoWhJEhEAFiS0WKlsMkOfbLXkp97
 iL/FIYOlFwMylH1Jhl9Jxc3ThztIxWHkRNGC6bAPesiywnHkcMgVkIeVkX1GXnWEeyS/
 eomv1Fy0AP4DdURoZOGcxWksOCe7xMeOOAZI6D2WsSvN8YdTYMe7CbaRX/k6DxE/n6Ie
 VS8g==
X-Gm-Message-State: APjAAAUHk0sLD8Pe4MFNSnmrlvbGbSG/dlEoG8V6hqmnRfhsDTQz8qMe
 eBy406sQhMjLd+ZgDpz7J4iiUtDIis4iF10RNKM=
X-Google-Smtp-Source: APXvYqxpNef68QMH7CiWEYfWfTzzEtLyB0MkaOvf56shyakrmsPL7Jd9RxlUGmxnISZjOKT00/jyAndxv5VjSegmWjE=
X-Received: by 2002:a2e:9188:: with SMTP id f8mr1092767ljg.33.1561737477909;
 Fri, 28 Jun 2019 08:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190627202719.17739-1-philmd@redhat.com>
 <20190627202719.17739-4-philmd@redhat.com>
In-Reply-To: <20190627202719.17739-4-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Jun 2019 08:54:57 -0700
Message-ID: <CAKmqyKPQEV=p1PDM75S0QOB6z-f-P2jBLv5EzZpj+6S5dyKzEg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v5 03/28] hw/block/pflash: Simplify
 trace_pflash_data_read/write()
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

On Thu, Jun 27, 2019 at 1:30 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Use a field width format to have a single function to log
> the different width accesses.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/block/pflash_cfi01.c | 6 ++----
>  hw/block/pflash_cfi02.c | 6 ++----
>  hw/block/trace-events   | 6 ++----
>  3 files changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 74fc1bc2da..db4a246b22 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -248,7 +248,6 @@ static uint32_t pflash_data_read(PFlashCFI01 *pfl, hw=
addr offset,
>      switch (width) {
>      case 1:
>          ret =3D p[offset];
> -        trace_pflash_data_read8(offset, ret);
>          break;
>      case 2:
>          if (be) {
> @@ -258,7 +257,6 @@ static uint32_t pflash_data_read(PFlashCFI01 *pfl, hw=
addr offset,
>              ret =3D p[offset];
>              ret |=3D p[offset + 1] << 8;
>          }
> -        trace_pflash_data_read16(offset, ret);
>          break;
>      case 4:
>          if (be) {
> @@ -272,12 +270,12 @@ static uint32_t pflash_data_read(PFlashCFI01 *pfl, =
hwaddr offset,
>              ret |=3D p[offset + 2] << 16;
>              ret |=3D p[offset + 3] << 24;
>          }
> -        trace_pflash_data_read32(offset, ret);
>          break;
>      default:
>          DPRINTF("BUG in %s\n", __func__);
>          abort();
>      }
> +    trace_pflash_data_read(offset, width << 1, ret);
>      return ret;
>  }
>
> @@ -415,7 +413,7 @@ static inline void pflash_data_write(PFlashCFI01 *pfl=
, hwaddr offset,
>  {
>      uint8_t *p =3D pfl->storage;
>
> -    trace_pflash_data_write(offset, value, width, pfl->counter);
> +    trace_pflash_data_write(offset, width << 1, value, pfl->counter);
>      switch (width) {
>      case 1:
>          p[offset] =3D value;
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index f05cd507b3..6cdfc85264 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -172,7 +172,6 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr =
offset,
>          switch (width) {
>          case 1:
>              ret =3D p[offset];
> -            trace_pflash_data_read8(offset, ret);
>              break;
>          case 2:
>              if (be) {
> @@ -182,7 +181,6 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr =
offset,
>                  ret =3D p[offset];
>                  ret |=3D p[offset + 1] << 8;
>              }
> -            trace_pflash_data_read16(offset, ret);
>              break;
>          case 4:
>              if (be) {
> @@ -196,9 +194,9 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwaddr =
offset,
>                  ret |=3D p[offset + 2] << 16;
>                  ret |=3D p[offset + 3] << 24;
>              }
> -            trace_pflash_data_read32(offset, ret);
>              break;
>          }
> +        trace_pflash_data_read(offset, width << 1, ret);
>          break;
>      case 0x90:
>          /* flash ID read */
> @@ -343,7 +341,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr off=
set,
>              /* We need another unlock sequence */
>              goto check_unlock0;
>          case 0xA0:
> -            trace_pflash_data_write(offset, value, width, 0);
> +            trace_pflash_data_write(offset, width << 1, value, 0);
>              p =3D pfl->storage;
>              if (!pfl->ro) {
>                  switch (width) {
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index f637fe918e..13d1b21dd4 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -10,10 +10,8 @@ pflash_reset(void) "reset"
>  pflash_timer_expired(uint8_t cmd) "command 0x%02x done"
>  pflash_io_read(uint64_t offset, int width, int fmt_width, uint32_t value=
, uint8_t cmd, uint8_t wcycle) "offset:0x%04"PRIx64" width:%d value:0x%0*x =
cmd:0x%02x wcycle:%u"
>  pflash_io_write(uint64_t offset, int width, int fmt_width, uint32_t valu=
e, uint8_t wcycle) "offset:0x%04"PRIx64" width:%d value:0x%0*x wcycle:%u"
> -pflash_data_read8(uint64_t offset, uint32_t value) "data offset:0x%04"PR=
Ix64" value:0x%02x"
> -pflash_data_read16(uint64_t offset, uint32_t value) "data offset:0x%04"P=
RIx64" value:0x%04x"
> -pflash_data_read32(uint64_t offset, uint32_t value) "data offset:0x%04"P=
RIx64" value:0x%08x"
> -pflash_data_write(uint64_t offset, uint32_t value, int width, uint64_t c=
ounter) "data offset:0x%04"PRIx64" value:0x%08x width:%d counter:0x%016"PRI=
x64
> +pflash_data_read(uint64_t offset, int width, uint32_t value) "data offse=
t:0x%04"PRIx64" value:0x%0*x"
> +pflash_data_write(uint64_t offset, int width, uint32_t value, uint64_t c=
ounter) "data offset:0x%04"PRIx64" value:0x%0*x counter:0x%016"PRIx64
>  pflash_manufacturer_id(uint16_t id) "Read Manufacturer ID: 0x%04x"
>  pflash_device_id(uint16_t id) "Read Device ID: 0x%04x"
>  pflash_device_info(uint64_t offset) "Read Device Information offset:0x%0=
4"PRIx64
> --
> 2.20.1
>
>

