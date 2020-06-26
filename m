Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22DFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 11:21:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BFD4206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 11:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ku+xKsTY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFD4206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jomQ6-0001BJ-OV
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 07:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jomPC-0000e8-AQ
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 07:20:26 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:35833)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jomPA-0004F6-Cm
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 07:20:26 -0400
Received: by mail-wr1-x435.google.com with SMTP id g18so9166872wrm.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 04:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=J9C8wU5UTgn3XdjCIR3l7c8f8fF5+LLloG8/KLw6jUM=;
 b=ku+xKsTYIR/CjbMPcQOair9LDET9RNQWX5rlq6g2RsVzQ280AaW++3/9QVyP0rE6ce
 s6DdqIhHoihByj0HunBAOj93/qrQNPZjTnsExqVwCbZRCtXBJfiOzjJwvj51SrJgf+p2
 SBqS5NIPN3E6XnsbwmvVo2OQumRLppfhnngEYaMJTdogkeJ64eoCq8CC19W2D84t28ZS
 F4k2OzeKysSDkIl+DFzoS8iVxjfGCe/eUFYjHCyYSrE4p0mu8KO8AF28jHU234zXcjA7
 Jd5iJopQCV+SyHtU5SMEOnZrgwuxV3DrCGQu26kS6vNQBHwlUD6B7bFBGKhh+9zatTSo
 BG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=J9C8wU5UTgn3XdjCIR3l7c8f8fF5+LLloG8/KLw6jUM=;
 b=CiZ4Ls9+hRxKuh2JLzodIx4L9xM5oBE4guLaEaYXtYBCjmEwyNGdtdURpqJMBONHzK
 JSTllIRRjtJAKkq+R+P/CP6vu1a6NXFX1qcQgvqGKIevOHQQC3IGCP+kDWrLBsVoTmyk
 y6caGz/LeNjWra5oNRCbeZNIcIwq0lZJmUgSaQpckmWlR32tmCdoK7WiDNzvJFy4gd6r
 0uK0BI+gsEBLA4Hm1n/gp8Z991502oo2WHCvk+KfMUX33iYBBipUHDjcg68VNK5GA1SI
 yabEWBi09RDsQNewtEUjzC/+OrZb2wj2XyzDLjyMb38RX1Xjcr+Htr9+c0hq66e48pKQ
 TETg==
X-Gm-Message-State: AOAM5309TrO7CQaCX3UDSt5S4u6uqmMMPwM3ywPxsN7lY/W8mU5XZgK0
 BLgGJVQX5a9dyYYK8eUTsusW5o1ZNL24tb6yi8M=
X-Google-Smtp-Source: ABdhPJyGAmEOXBGE/M9cWLmu5IszzB6DuDfY12wth9Di0QULHaVY0V4Gjlu95nrQoEcMYgjUAO3i2nzhhl9TFXxD8OU=
X-Received: by 2002:adf:8462:: with SMTP id 89mr3150045wrf.420.1593170422186; 
 Fri, 26 Jun 2020 04:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <159315507826.13901.17398620572438937429.malonedeb@wampee.canonical.com>
 <CAHiYmc7_ra2qWJ8mkZ-vqL5vN2BKdWxAZeKNnMEkPtien5-fsw@mail.gmail.com>
 <b34bf27c-3189-addc-0c50-b0c0c533876d@redhat.com>
 <d2657f75-26fe-117b-183d-732d88da2653@redhat.com>
 <32aa7cf6-5f4d-eb79-2ebe-ee463f4389b8@redhat.com>
 <CAP7QCoiuc3ZYXowBi6TahYEoxM3fiUQAwfo=pSUZeG5yOGTY9Q@mail.gmail.com>
In-Reply-To: <CAP7QCoiuc3ZYXowBi6TahYEoxM3fiUQAwfo=pSUZeG5yOGTY9Q@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 26 Jun 2020 13:20:08 +0200
Message-ID: <CAHiYmc7SrqDZQzEdfM7NKt=vPjmXACQF+C45R76yNEgq1VQJxw@mail.gmail.com>
Subject: Re: [Bug 1885247] [NEW] Build error in Intel 32-bit hosts
To: Jon Doron <arilou@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Bug 1885247 <1885247@bugs.launchpad.net>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BF=D0=B5=D1=82, 26. =D1=98=D1=83=D0=BD 2020. =D1=83 12:54 Jon Doron <ar=
ilou@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=
=BB=D0=B0:
>
> Is there a container I can download which has your build environment?
>

Hello, Jon.

I don't know about the container, but, as Peter noted, the following
(non-beautiful) diff fixes the build problem on the real host:

diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index f371240176..9220f7b529 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -383,7 +383,8 @@ static ssize_t gpadl_iter_io(GpadlIter *iter, void
*buf, uint32_t len)
             }
         }

-        p =3D (void *)(((uintptr_t)iter->map & TARGET_PAGE_MASK) | off_in_=
page);
+        p =3D (void *)(uintptr_t)(((uintptr_t)iter->map & TARGET_PAGE_MASK=
) |
+                                off_in_page);
         if (iter->dir =3D=3D DMA_DIRECTION_FROM_DEVICE) {
             memcpy(p, buf, cplen);
         } else {

Not sure if this is an optimal/most-elegant solution though.

Warmly,
Aleksandar


> On Fri, Jun 26, 2020 at 12:27 PM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
> >
> > On 6/26/20 11:20 AM, Thomas Huth wrote:
> > > On 26/06/2020 11.13, Philippe Mathieu-Daud=C3=A9 wrote:
> > >> On 6/26/20 9:37 AM, Aleksandar Markovic wrote:
> > >>> =D0=BF=D0=B5=D1=82, 26. =D1=98=D1=83=D0=BD 2020. =D1=83 09:11 Aleks=
andar Markovic
> > >>> <1885247@bugs.launchpad.net> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> > >>>>
> > >>>> Public bug reported:
> > >>>>
> > >>>> The code base is on master, checked out on Thursday June25th 2020,
> > >>>> 0250c595c9d. The build procedure:
> > >>>>
> > >>>> $ mkdir build-gcc
> > >>>> $ cd build-gcc
> > >>>> $ ../configure
> > >>>> $ make
> > >>>>
> > >>>> The build error message is:
> > >>>>
> > >>>>    CC      x86_64-softmmu/hw/hyperv/hyperv.o
> > >>>>    CC      x86_64-softmmu/hw/hyperv/hyperv_testdev.o
> > >>>>    CC      x86_64-softmmu/hw/hyperv/vmbus.o
> > >>>> /home/rtrk/Build/qemu-master/hw/hyperv/vmbus.c: In function
> > >>>> =E2=80=98gpadl_iter_io=E2=80=99:
> > >>>> /home/rtrk/Build/qemu-master/hw/hyperv/vmbus.c:386:13: error: cast
> > >>>> to pointer from integer of different size [-Werror=3Dint-to-pointe=
r-cast]
> > >>>>           p =3D (void *)(((uintptr_t)iter->map & TARGET_PAGE_MASK)=
 |
> > >>>> off_in_page);
> > >>>>               ^
> > >>>> cc1: all warnings being treated as errors
> > >>>> make[1]: *** [/home/rtrk/Build/qemu-master/rules.mak:69:
> > >>>> hw/hyperv/vmbus.o] Error 1
> > >>>> make: *** [Makefile:527: x86_64-softmmu/all] Error 2
> > >>
> > >> FWIW there is no CI job covering x86 KVM on 32-bit host build.
> > >> Should this be covered? I guess the problem is no CI services
> > >> provide 32-bit x86...
> > >
> > > You can certainly provide either a container, or install the 32-bit
> > > libraries in a 64-bit environment. Then run
> > >
> > > PKG_CONFIG_LIBDIR=3D... ./configure --extra-cflags=3D-m32
> > >
> > > and it should be possible to build 32-bit binaries, too.
> > >
> > > Alternatively, we could add a cross-compilation job that builds with
> > > i686-w64-mingw32 in 32-bit.
> >
> > Oh, this case is covered:
> > https://app.shippable.com/github/qemu/qemu/runs/2437/2/console
> >
> > But this doesn't use KVM ;)
> >

