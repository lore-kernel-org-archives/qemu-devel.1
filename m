Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56BFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:48:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 813B3207D8
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 14:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgDD3K0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813B3207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdxLk-0001G8-Mx
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 10:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdxL6-0000cV-Gr; Wed, 27 May 2020 10:47:28 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35876)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdxL5-0002DC-7t; Wed, 27 May 2020 10:47:28 -0400
Received: by mail-wr1-x444.google.com with SMTP id q11so12132281wrp.3;
 Wed, 27 May 2020 07:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GrOGXpO7huguJbiqlss87D9k1iAkerndtQgIwlErOGU=;
 b=SgDD3K0GNnxPXkB645sD03pHKUf5og4Hwslcp9YtSocdYz0bjCpns2EBTYnZROqFA4
 rBEKTX6+Xx1d04onodKDoa1ZVYbzrRhoUyXKEOH8j7KWY4XWWBDVTTgFlLEciX4kghbB
 JDGmZpZfQEWkgUqDF5OOoEa4K2+fpp9mhYl8W0IYXH3RRdSMQNR1Z7YPwZRc+Zm8Jbjw
 QPiDzirM8tvPN2F5CJgJ6OWdtlqxMoYBrH/o6KV++Asq5rhcOOyop/leCtHM37+JRwLN
 90wHe5YG5pYWV0VISU/HrIwwRN/3f1yXVxm1Sa8i1zBTP4x9iALgBBtD0asu2RueUpIv
 HcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GrOGXpO7huguJbiqlss87D9k1iAkerndtQgIwlErOGU=;
 b=QgRhFmvORpMYIylsMkYwaPnXCmyOE4FHdCdGPE/im5pPitBNaT6EupdXfmY7LODrZK
 wiwzFHYKtvFeD8jdIkJI/El1s9IEPLfc9mtrlXb93Tjk2a29GlCg5SmEXsOlojqOSfXg
 sjsJHRYfI/eBte9NCXbpKfrZ7bKp88rhLBFJIfahmDh/ZbIDB2Z230lJwmdannSPht+Q
 IhcLXAwQysm+UmMuVBFnqL9pYeaq4EWhxj+nIBdjzySQz74dTv+tn/VqODwEuDpamEve
 Tut/LjwseVkBEuT/RglzvL7a5irYEPIZaqTXUtx/9bYU9eZuf/Sq8A/MaMfzL3jUWqB2
 qY+Q==
X-Gm-Message-State: AOAM533bH/CGQRQq0/2VJ0jC+hG2W6fksquEuPoseWIRrwH4GP7IND6P
 +r0auWm0ogvlOGaCn230ZWay31PRoDh5CXVYDOo=
X-Google-Smtp-Source: ABdhPJwaqJ9shuwQr9EJYNIOc3MgZCB9FCr7MAjKJ6MKoyoX+KaPDw9zXulTTqKOns75hxzcxIiPjtNKubUzDXFxueM=
X-Received: by 2002:adf:e64b:: with SMTP id b11mr24234086wrn.402.1590590845626; 
 Wed, 27 May 2020 07:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200527100546.29297-1-alex.bennee@linaro.org>
 <20200527100546.29297-3-alex.bennee@linaro.org>
 <CAHiYmc7EJVxKXZ4G96cL-Bm3tT8UR_dgr7y3oisUMnuJ0u3zaw@mail.gmail.com>
In-Reply-To: <CAHiYmc7EJVxKXZ4G96cL-Bm3tT8UR_dgr7y3oisUMnuJ0u3zaw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 27 May 2020 16:47:13 +0200
Message-ID: <CAHiYmc7TYHMcitiG9ELxfz-EC8DSG1b7FeFsxXxTbu-7FSih=Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] linux-user: deal with address wrap for
 ARM_COMMPAGE on 32 bit
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bug 1880225 <1880225@bugs.launchpad.net>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=81=D1=80=D0=B5, 27. =D0=BC=D0=B0=D1=98 2020. =D1=83 14:05 Aleksandar Ma=
rkovic
<aleksandar.qemu.devel@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> =D1=81=D1=80=D0=B5, 27. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:07 Alex Benn=
=C3=A9e <alex.bennee@linaro.org> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> > We rely on the pointer to wrap when accessing the high address of the
> > COMMPAGE so it lands somewhere reasonable. However on 32 bit hosts we
> > cannot afford just to map the entire 4gb address range. The old mmap
> > trial and error code handled this by just checking we could map both
> > the guest_base and the computed COMMPAGE address.
> >
> > We can't just manipulate loadaddr to get what we want so we introduce
> > an offset which pgb_find_hole can apply when looking for a gap for
> > guest_base that ensures there is space left to map the COMMPAGE
> > afterwards.
> >
> > This is arguably a little inefficient for the one 32 bit
> > value (kuser_helper_version) we need to keep there given all the
> > actual code entries are picked up during the translation phase.
> >
> > Fixes: ee94743034b
> > Bug: https://bugs.launchpad.net/qemu/+bug/1880225
>
> For the scenario in this bug report, for today's master, before and after
> applying this patch:
>

I am not sure how significant is this info, but I executed the test
without applying patch 1/3, so only 2/3 was applied in the case
"AFTER".

Aleksandar

> BEFORE:
>
> $ ~/Build/qemu-master/build-gcc/arm-linux-user/qemu-arm ./toupper_string-=
arm
> qemu-arm: /home/rtrk/Build/qemu-master/linux-user/elfload.c:2294:
> probe_guest_base: Assertion `have_guest_base' failed.
> Aborted
>
> AFTER:
>
> $ ~/Build/qemu-master/build-gcc/arm-linux-user/qemu-arm ./toupper_string-=
arm
> CONTROL RESULT: (toupper_string)
>  nwlrbbmqbhcdarz owkkyhiddqscdxr jmowfrxsjybldbe fsarcbynecdyggx xpklorel=
lnmpapq
>  NWLRBBMQBHCDARZ OWKKYHIDDQSCDXR JMOWFRXSJYBLDBE FSARCBYNECDYGGX XPKLOREL=
LNMPAPQ
>
> So, it works in my test bed.
>
> Tested-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>
> > Cc: Bug 1880225 <1880225@bugs.launchpad.net>
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Cc: Richard Henderson <richard.henderson@linaro.org>
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  linux-user/elfload.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> >
> > diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> > index d6027867a1a..31defce95b5 100644
> > --- a/linux-user/elfload.c
> > +++ b/linux-user/elfload.c
> > @@ -2145,7 +2145,7 @@ static uintptr_t pgd_find_hole_fallback(uintptr_t=
 guest_size, uintptr_t brk, lon
> >
> >  /* Return value for guest_base, or -1 if no hole found. */
> >  static uintptr_t pgb_find_hole(uintptr_t guest_loaddr, uintptr_t guest=
_size,
> > -                               long align)
> > +                               long align, uintptr_t offset)
> >  {
> >      GSList *maps, *iter;
> >      uintptr_t this_start, this_end, next_start, brk;
> > @@ -2171,7 +2171,7 @@ static uintptr_t pgb_find_hole(uintptr_t guest_lo=
addr, uintptr_t guest_size,
> >
> >          this_end =3D ((MapInfo *)iter->data)->start;
> >          next_start =3D ((MapInfo *)iter->data)->end;
> > -        align_start =3D ROUND_UP(this_start, align);
> > +        align_start =3D ROUND_UP(this_start + offset, align);
> >
> >          /* Skip holes that are too small. */
> >          if (align_start >=3D this_end) {
> > @@ -2221,6 +2221,7 @@ static void pgb_static(const char *image_name, ab=
i_ulong orig_loaddr,
> >  {
> >      uintptr_t loaddr =3D orig_loaddr;
> >      uintptr_t hiaddr =3D orig_hiaddr;
> > +    uintptr_t offset =3D 0;
> >      uintptr_t addr;
> >
> >      if (hiaddr !=3D orig_hiaddr) {
> > @@ -2234,18 +2235,19 @@ static void pgb_static(const char *image_name, =
abi_ulong orig_loaddr,
> >      if (ARM_COMMPAGE) {
> >          /*
> >           * Extend the allocation to include the commpage.
> > -         * For a 64-bit host, this is just 4GiB; for a 32-bit host,
> > -         * the address arithmetic will wrap around, but the difference
> > -         * will produce the correct allocation size.
> > +         * For a 64-bit host, this is just 4GiB; for a 32-bit host we
> > +         * need to ensure there is space bellow the guest_base so we
> > +         * can map the commpage in the place needed when the address
> > +         * arithmetic wraps around.
> >           */
> >          if (sizeof(uintptr_t) =3D=3D 8 || loaddr >=3D 0x80000000u) {
> >              hiaddr =3D (uintptr_t)4 << 30;
> >          } else {
> > -            loaddr =3D ARM_COMMPAGE & -align;
> > +            offset =3D (128 * KiB);
> >          }
> >      }
> >
> > -    addr =3D pgb_find_hole(loaddr, hiaddr - loaddr, align);
> > +    addr =3D pgb_find_hole(loaddr, hiaddr - loaddr, align, offset);
> >      if (addr =3D=3D -1) {
> >          /*
> >           * If ARM_COMMPAGE, there *might* be a non-consecutive allocat=
ion
> > @@ -2280,7 +2282,7 @@ static void pgb_dynamic(const char *image_name, l=
ong align)
> >           * just above that, and maximises the positive guest addresses=
.
> >           */
> >          commpage =3D ARM_COMMPAGE & -align;
> > -        addr =3D pgb_find_hole(commpage, -commpage, align);
> > +        addr =3D pgb_find_hole(commpage, -commpage, align, 0);
> >          assert(addr !=3D -1);
> >          guest_base =3D addr;
> >      }
> > --
> > 2.20.1
> >
> >

