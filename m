Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6098AC4321A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 21:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DD412063F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 21:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin.edu header.i=@oberlin.edu header.b="Fi2uJbY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD412063F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgcIY-0000e0-76
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 17:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35831)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stephen.checkoway@oberlin.edu>) id 1hgcHO-0007yr-Gt
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 17:50:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stephen.checkoway@oberlin.edu>) id 1hgcHM-000458-2x
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 17:50:06 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:46612)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
 id 1hgcHL-00043T-P8
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 17:50:03 -0400
Received: by mail-qt1-x843.google.com with SMTP id h21so4134008qtn.13
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 14:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oberlin.edu; s=google;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=QbnBPwpArp8APmHkjaYDxx4xjV+LBRD7FucskNM64kU=;
 b=Fi2uJbY03hYKyOPrcwR82UCikqesbMv+jJJ3UifFghjxq0SDCKmNQafJMmzEtIoj47
 5jSxC7+lmFJU6KBdvvZQAeHnDeroh7lq5IlTV0m7v/9X5ddZJjUmaYE3/+/LuaFl+rpn
 Y6pF5RrTdJcRysd+2DMqVC+au3BnJ/5UY4rPsUC/Uts0WqZMjpDGKTYHh9/0z1lmfJky
 FuXnO2sop0RwIfTuzVmT+ZzoOndJ5NZP5xwN9hN/NGsFfxk71outwnDV+hg15ckz1+dr
 vlwGjuafDRbubxJrLWzCrOI6TD6ebGVnVuAbbsHru4LjdCXxAxcEaXjcniQ8O9o/X6gb
 dKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=QbnBPwpArp8APmHkjaYDxx4xjV+LBRD7FucskNM64kU=;
 b=NY18Yq219BFwmmrpYSHiZSNUej2CLIwoXoru52gNctPwac1SMRDQ1J3+LLZ1iLYWZq
 14BPUFN5LSSgA1j06qMOeblPn9TqNzYidpcOo+P3w1LWmtn3MzrisGFsDR1QemFCJPlD
 vCy6QwM2iVCBjm5CbF/aeOnHHDQtWq4fkpozt9jbmU6Km2JCMZiEdNqnme8FQ+C0widg
 vBUtxVUSf65Q04lWK4xLOTAxJFreq4UTUIDFgYhOuvykLDLzWJEheB6Y69mmDHwEMYT7
 N8JC8oSlt5fjHtoZ25rKfTqEuPE/U/u8g4vFxeV834F56EogMCyTGCyBATlXPD/s6E1q
 6/Ow==
X-Gm-Message-State: APjAAAX3KwX8JQ7ll1UuIp2ipSrd0OFHNPKXmPMnkIQDy0VAY6DVreI2
 iQ8RfLoHB5z9Fw6qiInwsEwt3g==
X-Google-Smtp-Source: APXvYqyF0HrHO7l587Wqzi5qawdfv2YTHeAxa+pAKH4pUPpmcChWNSQitWPT4FWUCfw4yDp6ztiwrA==
X-Received: by 2002:ac8:2baa:: with SMTP id m39mr5294131qtm.242.1561672202323; 
 Thu, 27 Jun 2019 14:50:02 -0700 (PDT)
Received: from [192.168.1.7] (ip-210-181.oberlin.net. [208.66.210.181])
 by smtp.gmail.com with ESMTPSA id z63sm153712qkb.136.2019.06.27.14.49.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Jun 2019 14:50:01 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
In-Reply-To: <20190627202719.17739-3-philmd@redhat.com>
Date: Thu, 27 Jun 2019 17:49:57 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <BCB1CC45-F457-4F8B-8F9E-DC70CF9CE35A@oberlin.edu>
References: <20190627202719.17739-1-philmd@redhat.com>
 <20190627202719.17739-3-philmd@redhat.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
Subject: Re: [Qemu-devel] [PATCH v5 02/28] hw/block/pflash: Simplify
 trace_pflash_io_read/write()
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Magnus Damm <magnus.damm@gmail.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Walle <michael@walle.cc>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Antony Pavlov <antonynpavlov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Jan Kiszka <jan.kiszka@web.de>,
 John Snow <jsnow@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Phil,

Thanks for pushing this forward! I'll try to get to the rest of these =
early next week.

> On Jun 27, 2019, at 16:26, Philippe Mathieu-Daud=C3=A9 =
<philmd@redhat.com> wrote:
>=20
> Call the read() trace function after the value is set, so we can
> log the returned value.
> Rename the I/O trace functions with '_io_' in their name.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> hw/block/pflash_cfi01.c | 5 +++--
> hw/block/pflash_cfi02.c | 6 ++----
> hw/block/trace-events   | 4 ++--
> 3 files changed, 7 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 35080d915f..74fc1bc2da 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -288,7 +288,6 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, =
hwaddr offset,
>     uint32_t ret;
>=20
>     ret =3D -1;
> -    trace_pflash_read(offset, pfl->cmd, width, pfl->wcycle);
>     switch (pfl->cmd) {
>     default:
>         /* This should never happen : reset state & treat it as a read =
*/
> @@ -391,6 +390,8 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, =
hwaddr offset,
>=20
>         break;
>     }
> +    trace_pflash_io_read(offset, width, width << 1, ret, pfl->cmd, =
pfl->wcycle);

width * 2 might make it more clear what is going on.

> +
>     return ret;
> }
>=20
> @@ -453,7 +454,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr =
offset,
>=20
>     cmd =3D value;
>=20
> -    trace_pflash_write(offset, value, width, pfl->wcycle);
> +    trace_pflash_io_write(offset, width, width << 1, value, =
pfl->wcycle);

Same here.

>     if (!pfl->wcycle) {
>         /* Set the device in I/O access mode */
>         memory_region_rom_device_set_romd(&pfl->mem, false);
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index eb106f4996..f05cd507b3 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -145,7 +145,6 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, =
hwaddr offset,
>     uint8_t *p;
>=20
>     ret =3D -1;
> -    trace_pflash_read(offset, pfl->cmd, width, pfl->wcycle);
>     /* Lazy reset to ROMD mode after a certain amount of read accesses =
*/
>     if (!pfl->rom_mode && pfl->wcycle =3D=3D 0 &&
>         ++pfl->read_counter > PFLASH_LAZY_ROMD_THRESHOLD) {
> @@ -241,6 +240,7 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, =
hwaddr offset,
>         }
>         break;
>     }
> +    trace_pflash_io_read(offset, width, width << 1, ret, pfl->cmd, =
pfl->wcycle);

And here.

>=20
>     return ret;
> }
> @@ -267,6 +267,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr =
offset,
>     uint8_t *p;
>     uint8_t cmd;
>=20
> +    trace_pflash_io_write(offset, width, width << 1, value, =
pfl->wcycle);

And here.

>     cmd =3D value;
>     if (pfl->cmd !=3D 0xA0 && cmd =3D=3D 0xF0) {
> #if 0
> @@ -275,11 +276,8 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr =
offset,
> #endif
>         goto reset_flash;
>     }
> -    trace_pflash_write(offset, value, width, pfl->wcycle);
>     offset &=3D pfl->chip_len - 1;
>=20
> -    DPRINTF("%s: offset " TARGET_FMT_plx " %08x %d\n", __func__,
> -            offset, value, width);
>     boff =3D offset & (pfl->sector_len - 1);
>     if (pfl->width =3D=3D 2)
>         boff =3D boff >> 1;
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 97a17838ed..f637fe918e 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -7,9 +7,9 @@ fdc_ioport_write(uint8_t reg, uint8_t value) "write =
reg 0x%02x val 0x%02x"
> # pflash_cfi02.c
> # pflash_cfi01.c
> pflash_reset(void) "reset"
> -pflash_read(uint64_t offset, uint8_t cmd, int width, uint8_t wcycle) =
"offset:0x%04"PRIx64" cmd:0x%02x width:%d wcycle:%u"
> -pflash_write(uint64_t offset, uint32_t value, int width, uint8_t =
wcycle) "offset:0x%04"PRIx64" value:0x%03x width:%d wcycle:%u"
> pflash_timer_expired(uint8_t cmd) "command 0x%02x done"
> +pflash_io_read(uint64_t offset, int width, int fmt_width, uint32_t =
value, uint8_t cmd, uint8_t wcycle) "offset:0x%04"PRIx64" width:%d =
value:0x%0*x cmd:0x%02x wcycle:%u"
> +pflash_io_write(uint64_t offset, int width, int fmt_width, uint32_t =
value, uint8_t wcycle) "offset:0x%04"PRIx64" width:%d value:0x%0*x =
wcycle:%u"
> pflash_data_read8(uint64_t offset, uint32_t value) "data =
offset:0x%04"PRIx64" value:0x%02x"
> pflash_data_read16(uint64_t offset, uint32_t value) "data =
offset:0x%04"PRIx64" value:0x%04x"
> pflash_data_read32(uint64_t offset, uint32_t value) "data =
offset:0x%04"PRIx64" value:0x%08x"
> --=20
> 2.20.1
>=20

Either way,

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>

(And please let me know if I'm doing code review incorrectly or if that =
should be Reviewed-by or whatever.)

Cheers,

Steve=20

--=20
Stephen Checkoway






