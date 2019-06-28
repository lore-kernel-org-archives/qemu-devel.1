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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DA7C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:59:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65EED20828
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frjSw4OI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65EED20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgtHw-000087-Ia
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 11:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33048)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hgtF7-0006AZ-GI
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:56:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hgtF5-0002We-8t
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:56:53 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:45270)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hgtEo-0002Iy-Ux; Fri, 28 Jun 2019 11:56:35 -0400
Received: by mail-lj1-x243.google.com with SMTP id m23so6455512lje.12;
 Fri, 28 Jun 2019 08:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=djfep1qt1pkv+oao2jPAzEOqrTllL9U3SoshfePHyo4=;
 b=frjSw4OI3t4yMsUeUcGiiH09WNqNRmqbnWSYMauqN8x5uwSH6PQpBvwXdQ1wDyMrwM
 i16r7+hFz15TKRHGXz8xB3zZRH0b/cL/H0PP8nkO/qoDspd5JkqwJvQBfjMa6vX/cizI
 Jfb2h74wYVkOk08rj896dTqm8aGg4HQhxrWVnfmlK3WtWk3+08YoYbHC4KvmDvyUewD+
 AAcuNCbgi4dH9bH7yPVPjJGl3H2WLFcWBUT9MBAH79/1TmYbt1quN97sOjcLfpPsYxRU
 tNlRlYypScA9jwqR1slwj+jK9MxXeA9LuaPX8H1DuQj63kuZvTe0K6Rdf0gCTu6FEvu1
 aMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=djfep1qt1pkv+oao2jPAzEOqrTllL9U3SoshfePHyo4=;
 b=gR+yD6DEwP+emfmMCSQhdKT7pFDBDmhmYHSfzy9+rahMH6nLNMgpQRXmmBacjL+o02
 LAaPgTNyxXEB+bE18efei2RNZzLtkndNlO1I46MCSN4DKarIAetovTEs++1Vm/T6STZN
 jr+RUS/0d1bIjmy5QGyKu2baQCiwuUx/6AT2vF4MdISTTgfZ9DEygFDOzUkgVZNIQ4n3
 +o2Cjp8nHe1XHcIrlB9dn9eTfn8hnnURFaosWFz37+gBVsICp0Q70dnqcpCzWkkZzmQs
 tNTo9FMhvkPxeDe6N3UuHGBM77h6viZ8S4wUFZY6ibOv5yE0E6W8DwICOlXAdS/iKOXj
 p+Cg==
X-Gm-Message-State: APjAAAWWnVLJIsmslXEnYSqoUaO1CiemlVyWdNKd/URX8HsNF0QzGvwe
 EBlt7eaWnlikn/J7/A6OYU5JNT9GRXN3gnnJDcY=
X-Google-Smtp-Source: APXvYqy9+fdEhUfvMi7it8dL3t1svIO2yLX/8+k1ADHDmT/tv5i6B7gugQVe+MbHWni5pEJz9jKZb0jpYMrQTLDp1Ek=
X-Received: by 2002:a2e:5d5a:: with SMTP id r87mr6642435ljb.196.1561737392514; 
 Fri, 28 Jun 2019 08:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190627202719.17739-1-philmd@redhat.com>
 <20190627202719.17739-3-philmd@redhat.com>
 <BCB1CC45-F457-4F8B-8F9E-DC70CF9CE35A@oberlin.edu>
In-Reply-To: <BCB1CC45-F457-4F8B-8F9E-DC70CF9CE35A@oberlin.edu>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Jun 2019 08:53:32 -0700
Message-ID: <CAKmqyKNQ0pMiHMLHTcj_R9FwaoPSEA8nS9qh_CxviJZfPe9ijA@mail.gmail.com>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Qemu-block <qemu-block@nongnu.org>, John Snow <jsnow@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 27, 2019 at 2:50 PM Stephen Checkoway
<stephen.checkoway@oberlin.edu> wrote:
>
> Hi Phil,
>
> Thanks for pushing this forward! I'll try to get to the rest of these ear=
ly next week.
>
> > On Jun 27, 2019, at 16:26, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
> >
> > Call the read() trace function after the value is set, so we can
> > log the returned value.
> > Rename the I/O trace functions with '_io_' in their name.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> > hw/block/pflash_cfi01.c | 5 +++--
> > hw/block/pflash_cfi02.c | 6 ++----
> > hw/block/trace-events   | 4 ++--
> > 3 files changed, 7 insertions(+), 8 deletions(-)
> >
> > diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> > index 35080d915f..74fc1bc2da 100644
> > --- a/hw/block/pflash_cfi01.c
> > +++ b/hw/block/pflash_cfi01.c
> > @@ -288,7 +288,6 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hwadd=
r offset,
> >     uint32_t ret;
> >
> >     ret =3D -1;
> > -    trace_pflash_read(offset, pfl->cmd, width, pfl->wcycle);
> >     switch (pfl->cmd) {
> >     default:
> >         /* This should never happen : reset state & treat it as a read =
*/
> > @@ -391,6 +390,8 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hwadd=
r offset,
> >
> >         break;
> >     }
> > +    trace_pflash_io_read(offset, width, width << 1, ret, pfl->cmd, pfl=
->wcycle);
>
> width * 2 might make it more clear what is going on.
>
> > +
> >     return ret;
> > }
> >
> > @@ -453,7 +454,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr o=
ffset,
> >
> >     cmd =3D value;
> >
> > -    trace_pflash_write(offset, value, width, pfl->wcycle);
> > +    trace_pflash_io_write(offset, width, width << 1, value, pfl->wcycl=
e);
>
> Same here.
>
> >     if (!pfl->wcycle) {
> >         /* Set the device in I/O access mode */
> >         memory_region_rom_device_set_romd(&pfl->mem, false);
> > diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> > index eb106f4996..f05cd507b3 100644
> > --- a/hw/block/pflash_cfi02.c
> > +++ b/hw/block/pflash_cfi02.c
> > @@ -145,7 +145,6 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwadd=
r offset,
> >     uint8_t *p;
> >
> >     ret =3D -1;
> > -    trace_pflash_read(offset, pfl->cmd, width, pfl->wcycle);
> >     /* Lazy reset to ROMD mode after a certain amount of read accesses =
*/
> >     if (!pfl->rom_mode && pfl->wcycle =3D=3D 0 &&
> >         ++pfl->read_counter > PFLASH_LAZY_ROMD_THRESHOLD) {
> > @@ -241,6 +240,7 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwadd=
r offset,
> >         }
> >         break;
> >     }
> > +    trace_pflash_io_read(offset, width, width << 1, ret, pfl->cmd, pfl=
->wcycle);
>
> And here.
>
> >
> >     return ret;
> > }
> > @@ -267,6 +267,7 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr o=
ffset,
> >     uint8_t *p;
> >     uint8_t cmd;
> >
> > +    trace_pflash_io_write(offset, width, width << 1, value, pfl->wcycl=
e);
>
> And here.
>
> >     cmd =3D value;
> >     if (pfl->cmd !=3D 0xA0 && cmd =3D=3D 0xF0) {
> > #if 0
> > @@ -275,11 +276,8 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr =
offset,
> > #endif
> >         goto reset_flash;
> >     }
> > -    trace_pflash_write(offset, value, width, pfl->wcycle);
> >     offset &=3D pfl->chip_len - 1;
> >
> > -    DPRINTF("%s: offset " TARGET_FMT_plx " %08x %d\n", __func__,
> > -            offset, value, width);
> >     boff =3D offset & (pfl->sector_len - 1);
> >     if (pfl->width =3D=3D 2)
> >         boff =3D boff >> 1;
> > diff --git a/hw/block/trace-events b/hw/block/trace-events
> > index 97a17838ed..f637fe918e 100644
> > --- a/hw/block/trace-events
> > +++ b/hw/block/trace-events
> > @@ -7,9 +7,9 @@ fdc_ioport_write(uint8_t reg, uint8_t value) "write reg=
 0x%02x val 0x%02x"
> > # pflash_cfi02.c
> > # pflash_cfi01.c
> > pflash_reset(void) "reset"
> > -pflash_read(uint64_t offset, uint8_t cmd, int width, uint8_t wcycle) "=
offset:0x%04"PRIx64" cmd:0x%02x width:%d wcycle:%u"
> > -pflash_write(uint64_t offset, uint32_t value, int width, uint8_t wcycl=
e) "offset:0x%04"PRIx64" value:0x%03x width:%d wcycle:%u"
> > pflash_timer_expired(uint8_t cmd) "command 0x%02x done"
> > +pflash_io_read(uint64_t offset, int width, int fmt_width, uint32_t val=
ue, uint8_t cmd, uint8_t wcycle) "offset:0x%04"PRIx64" width:%d value:0x%0*=
x cmd:0x%02x wcycle:%u"
> > +pflash_io_write(uint64_t offset, int width, int fmt_width, uint32_t va=
lue, uint8_t wcycle) "offset:0x%04"PRIx64" width:%d value:0x%0*x wcycle:%u"
> > pflash_data_read8(uint64_t offset, uint32_t value) "data offset:0x%04"P=
RIx64" value:0x%02x"
> > pflash_data_read16(uint64_t offset, uint32_t value) "data offset:0x%04"=
PRIx64" value:0x%04x"
> > pflash_data_read32(uint64_t offset, uint32_t value) "data offset:0x%04"=
PRIx64" value:0x%08x"
> > --
> > 2.20.1
> >
>
> Either way,
>
> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
>
> (And please let me know if I'm doing code review incorrectly or if that s=
hould be Reviewed-by or whatever.)

For code review it should be Reviewed-by (or Acked-by if you are less sure)=
.

Alistair

>
> Cheers,
>
> Steve
>
> --
> Stephen Checkoway
>
>
>
>
>
>

