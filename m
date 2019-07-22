Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96146C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 09:17:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6605221BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 09:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brQO0UTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6605221BF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpURH-0001Pa-KY
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 05:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39070)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mrolnik@gmail.com>) id 1hpUR6-00011K-N3
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1hpUR5-0001u5-DB
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:16:48 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a]:42014)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hpUR5-0001ta-4H
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:16:47 -0400
Received: by mail-qt1-x82a.google.com with SMTP id h18so37753042qtm.9
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 02:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZPKacjI/eAgYb1GKJ3O3vLS61NP16gF80SIN29aONLI=;
 b=brQO0UTrMoQYDmD4ZNRQjOx8qPuCASKeB+vttBhEdMcvMHgMrKeamwLgEtQEAPh8l4
 l4T9I2OI0N8SwThLXdnWYkLJ7jcWSGZatGV3UAd5AHmzbmBsBwp10mYDCMtkyRdKxYrw
 +6GvJVuoaExIyy12m+VylLHAta1W1lINrObIgXbci//vUGFl8PynEYlrodoDBkXhdOFR
 UFg0xkvwMg5iLmeJ1HgfDQPByesWMTjgtab3L4q2QMgic4BRAty6wAONi6opXWQsXebQ
 Fag4aAGS8/LUGQx6lwjXT20qYJQQdyUOIAGtbh01Yv8TjudpsbRuhHguts2mOpIJ5oO2
 jWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZPKacjI/eAgYb1GKJ3O3vLS61NP16gF80SIN29aONLI=;
 b=JxPeVg3LLBkAoNn00iTlhkCbcaSIkHRbdmgLNcaNeqphxCWBjQql1Klh2O1uyT13/k
 imSO5mxZTmeX5bdzv8Y2NNu55Oh/VLsaemkjZL54vZZYnPzl4d+1F3KFjkhD9BlfzxbZ
 t7Ux7xlp7mmCl3wVTR6Muo0vyFHFStZY+w1PpP/VYceE+Fa6MekcoCJ41XBmE2DxaiMq
 DSeuo6/umbFXndun5ytWcUHB62aWyxcfQzyz6PHLSGSQ2oFyY+WZAG+P5qW/ueB5CfU+
 yyx0QAgp3KX2BRgTYwM3AA++WcRgi88UL4tEIXssYcK3nPHN1fuq0fDgGy0nULcby9TD
 ea4w==
X-Gm-Message-State: APjAAAWRz38EULRNO6W7F/KIMAhV2aKcGl8VRnTVLV+7MjTSB2ita43D
 3pdPSkBO2Zmw3Rm+KPGz94J3Dvv+sL6mb4UHgPA=
X-Google-Smtp-Source: APXvYqzwzZy/3RWXPYT62bCGm/DGvyNghw8qwePTrq0wThfYeKsPgIlFQhp+WMT+R9SYhQHt2wuKg2US7bFyva9TPAE=
X-Received: by 2002:a05:6214:13a1:: with SMTP id
 h1mr47639865qvz.190.1563787005987; 
 Mon, 22 Jul 2019 02:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190719082647.18113-1-mrolnik@gmail.com>
 <20190719082647.18113-9-mrolnik@gmail.com>
 <da64fd46-c0f0-b6b6-3b8f-d3da9041605d@redhat.com>
 <aa9f5be1-3451-7f58-a868-bd31bf2af236@redhat.com>
In-Reply-To: <aa9f5be1-3451-7f58-a868-bd31bf2af236@redhat.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Mon, 22 Jul 2019 12:16:08 +0300
Message-ID: <CAK4993ggAtRYDHUe3KpdC8UfSmofNuoeT346inD7_AG45xFMDw@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::82a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v27 8/8] target/avr: Add tests
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Thomas.
where should I specify this command?

On Sun, Jul 21, 2019 at 10:13 AM Thomas Huth <thuth@redhat.com> wrote:

> On 19/07/2019 15.26, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 7/19/19 10:26 AM, Michael Rolnik wrote:
> [...]
> >> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> >> index 24852d4c7d..73d273b73f 100644
> >> --- a/tests/boot-serial-test.c
> >> +++ b/tests/boot-serial-test.c
> >> @@ -16,6 +16,17 @@
> >>  #include "qemu/osdep.h"
> >>  #include "libqtest.h"
> >>
> >> +static const uint8_t bios_avr[] =3D {
> >> +    0x89, 0xe1,             /* ldi r24, 0x19   */
> >> +    0x80, 0x93, 0xc5, 0x00, /* sts 0x00C5, r24 ; set baud rate to
> 38400 */
> >
> > FWIW we can remove the previous two lines, we don't care about the
> > baudrate in this test.
> >
> >> +    0x88, 0xe0,             /* ldi r24, 0x08   */
> >> +    0x80, 0x93, 0xc1, 0x00, /* sts 0x00C1, r24 ; Enable tx */
> >> +    0x86, 0xe0,             /* ldi r24, 0x06   */
> >> +    0x80, 0x93, 0xc2, 0x00, /* sts 0x00C2, r24 ; Set the data bits to
> 8 */
> >> +    0x84, 0xe5,             /* ldi r24, 0x54   */
> >> +    0x80, 0x93, 0xc6, 0x00, /* sts 0x00C6, r24 ; Output 'T' */
> >> +};
> >> +
> >>  static const uint8_t kernel_mcf5208[] =3D {
> >>      0x41, 0xf9, 0xfc, 0x06, 0x00, 0x00,     /* lea 0xfc060000,%a0 */
> >>      0x10, 0x3c, 0x00, 0x54,                 /* move.b #'T',%d0 */
> >> @@ -92,6 +103,7 @@ typedef struct testdef {
> >>
> >>  static testdef_t tests[] =3D {
> >>      { "alpha", "clipper", "", "PCI:" },
> >> +    { "avr", "sample", "", "T", sizeof(bios_avr), NULL, bios_avr },
> >>      { "ppc", "ppce500", "", "U-Boot" },
> >>      { "ppc", "40p", "-vga none -boot d", "Trying cd:," },
> >>      { "ppc", "g3beige", "", "PowerPC,750" },
> >>
> >
> > Testing shows:
> >
> >   TEST    check-qtest-avr: tests/boot-serial-test
> > qemu-system-avr: Unable to load /tmp/qtest-boot-serial-cOndewD as ELF,
> > trying again as raw binary
> >
> > I wonder if this might fail Peter's testing, so Cc'ing Thomas.
>
> Such messages are quite a bit anoying during "make check", indeed. Could
> you please fence the message with qtest_enabled() ?
>
>  Thanks,
>    Thomas
>


--=20
Best Regards,
Michael Rolnik
