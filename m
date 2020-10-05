Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B17C4363D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:33:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 061C7208C7
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nghIAoav"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061C7208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPSUd-0005oN-W6
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 11:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPSSw-0004jp-2O; Mon, 05 Oct 2020 11:31:54 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129]:45354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPSSm-00060F-QV; Mon, 05 Oct 2020 11:31:53 -0400
Received: by mail-lf1-x129.google.com with SMTP id r127so6849573lff.12;
 Mon, 05 Oct 2020 08:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=/kd3h6Lk0txhbpOzzK0wE+D/MA9izizv8l3Jkb17SBw=;
 b=nghIAoavzaIFJmtH9PQ9hMLzAx9AqmwiMUPuJa6VHO9UEV6N56cUchBtqbjdXhxg+h
 PMOBFc1Dii5PAHA838nLsWxk5kAjBmSlcfwTrx7KiX76Lhw+rdl725VMkFkBuH/Ix9d2
 8JK33T5Ft3UnYhPrfvwWSlynuEaSR4ZIo0eXwD/tPJFHCMc5viIi9qiYWM3+2Q0/KujE
 1DRWQoXusmR09aI8k08TSRV5mXe+KKfot7fDdRAs2ZfjJPZl1+qp5cas/Vc5wvtd4O2j
 reiBfqr2dgPfy5xj0dw4kvYld9O0VLgzu8MSzal7gLpOVsH8YJhBKE8Iy4wi2LMALX7W
 Xmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=/kd3h6Lk0txhbpOzzK0wE+D/MA9izizv8l3Jkb17SBw=;
 b=oCB1QZRsVLIbU9IwlWDHyLrCz5YJHao/TMmhzBNgEaXoa4uE9U1qpsCgKfdwqCWtY/
 BziZV+JMonDT0eKQDrKVR80EWt+qBTuEf+uNk1rWXNZjopRyRlNKeVuuDT/rayZvHNwb
 6L4QeAATKnAYxHUzcGjx+Giy8Prz7OWmWcqIwWENn2DkO4bkh+IadR/qJZanLvZjZXai
 6W7o6zh0meXe+xOxnMpkijw4EfpIZ+hEOcgkBjLdshKydkwpcHYkdbo6bgnEeXlXmqM2
 WlHBb6jj0aA1slTRLxS8KtDcLqgrdeq/svqwoHNyE1tPLeXa/HUIYUkiFk8vwzsB5Bm2
 9J2Q==
X-Gm-Message-State: AOAM5310aNflq/G5OzIRrqHx4KU9rwdLb8XpO6YWwvZD/5t7VGGys+pu
 qgP8UdYT0LFs0WfEp5Bjiy7S7Zqz23gtsGDfdiE=
X-Google-Smtp-Source: ABdhPJwMtauOd3cIruCKrazEbadOkkD7ZHj/scRsBUQ38KUDOWBYsv3QzHm2FLHwTwxsCY9noekAOzmft4f+j3TNm1s=
X-Received: by 2002:a19:9141:: with SMTP id y1mr6647lfj.554.1601911898126;
 Mon, 05 Oct 2020 08:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201002180838.2047-1-luoyonggang@gmail.com>
 <20201005082254.GE2385272@redhat.com>
In-Reply-To: <20201005082254.GE2385272@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 5 Oct 2020 23:31:28 +0800
Message-ID: <CAE2XoE9Ss7K0Q-sgQ268Ww7X1wmgmSRMk3-4byChn5_4GVYARA@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] Fixes curses on msys2/mingw
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a63e0005b0ee2dc0"
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x129.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a63e0005b0ee2dc0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2020 at 4:23 PM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
>
wrote:
>
> Only one of the 4 patches in this series appears to have been sent.
All other are revied and preserve the same, I prefer not disturb by re
sending same patches
as other contributor suggested
>
> On Sat, Oct 03, 2020 at 02:08:37AM +0800, Yonggang Luo wrote:
> > V6-V7
> > Update the configure script for
> > * curses: Fixes compiler error that complain don't have langinfo.h on
msys2/m=3D
> > ingw
> >
> > V5-V6
> > Dropping configure: Fixes ncursesw detection under msys2/mingw by
convert the=3D
> > m to meson first.
> > That need the meson 0.56 upstream to fixes the curses detection.
> > Add
> > * configure: fixes indent of $meson setup
> >
> > Yonggang Luo (4):
> >   configure: fixes indent of $meson setup
> >   curses: Fixes compiler error that complain don't have langinfo.h on
> >     msys2/mingw
> >   curses: Fixes curses compiling errors.
> >   win32: Simplify gmtime_r detection not depends on if  _POSIX_C_SOURCE
> >     are defined on msys2/mingw
> >
> >  configure                 | 47 +++++----------------------------------
> >  include/sysemu/os-win32.h |  4 ++--
> >  ui/curses.c               | 14 ++++++------
> >  util/oslib-win32.c        |  4 ++--
> >  4 files changed, 16 insertions(+), 53 deletions(-)
> >
> > --=3D20
> > 2.28.0.windows.1
> >
> >
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-
https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
https://www.instagram.com/dberrange :|
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000a63e0005b0ee2dc0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Mon, Oct 5, 2020 at 4:23 PM Daniel P. Berrang=
=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&g=
t; wrote:<br>&gt;<br>&gt; Only one of the 4 patches in this series appears =
to have been sent.<div>All other are revied and preserve the same, I prefer=
 not disturb=C2=A0by re sending same patches</div><div>as other contributor=
 suggested<br>&gt;<br>&gt; On Sat, Oct 03, 2020 at 02:08:37AM +0800, Yongga=
ng Luo wrote:<br>&gt; &gt; V6-V7<br>&gt; &gt; Update the configure script f=
or<br>&gt; &gt; * curses: Fixes compiler error that complain don&#39;t have=
 langinfo.h on msys2/m=3D<br>&gt; &gt; ingw<br>&gt; &gt;<br>&gt; &gt; V5-V6=
<br>&gt; &gt; Dropping configure: Fixes ncursesw detection under msys2/ming=
w by convert the=3D<br>&gt; &gt; m to meson first.<br>&gt; &gt; That need t=
he meson 0.56 upstream to fixes the curses detection.<br>&gt; &gt; Add<br>&=
gt; &gt; * configure: fixes indent of $meson setup<br>&gt; &gt;<br>&gt; &gt=
; Yonggang Luo (4):<br>&gt; &gt; =C2=A0 configure: fixes indent of $meson s=
etup<br>&gt; &gt; =C2=A0 curses: Fixes compiler error that complain don&#39=
;t have langinfo.h on<br>&gt; &gt; =C2=A0 =C2=A0 msys2/mingw<br>&gt; &gt; =
=C2=A0 curses: Fixes curses compiling errors.<br>&gt; &gt; =C2=A0 win32: Si=
mplify gmtime_r detection not depends on if =C2=A0_POSIX_C_SOURCE<br>&gt; &=
gt; =C2=A0 =C2=A0 are defined on msys2/mingw<br>&gt; &gt;<br>&gt; &gt; =C2=
=A0configure =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 47 +=
++++----------------------------------<br>&gt; &gt; =C2=A0include/sysemu/os=
-win32.h | =C2=A04 ++--<br>&gt; &gt; =C2=A0ui/curses.c =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 14 ++++++------<br>&gt; &gt; =C2=A0util/osli=
b-win32.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A04 ++--<br>&gt; &gt; =C2=A04 fi=
les changed, 16 insertions(+), 53 deletions(-)<br>&gt; &gt;<br>&gt; &gt; --=
=3D20<br>&gt; &gt; 2.28.0.windows.1<br>&gt; &gt;<br>&gt; &gt;<br>&gt;<br>&g=
t; Regards,<br>&gt; Daniel<br>&gt; --<br>&gt; |: <a href=3D"https://berrang=
e.com">https://berrange.com</a> =C2=A0 =C2=A0 =C2=A0-o- =C2=A0 =C2=A0<a hre=
f=3D"https://www.flickr.com/photos/dberrange">https://www.flickr.com/photos=
/dberrange</a> :|<br>&gt; |: <a href=3D"https://libvirt.org">https://libvir=
t.org</a> =C2=A0 =C2=A0 =C2=A0 =C2=A0 -o- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0<a href=3D"https://fstop138.berrange.com">https://fstop138.berran=
ge.com</a> :|<br>&gt; |: <a href=3D"https://entangle-photo.org">https://ent=
angle-photo.org</a> =C2=A0 =C2=A0-o- =C2=A0 =C2=A0<a href=3D"https://www.in=
stagram.com/dberrange">https://www.instagram.com/dberrange</a> :|<br>&gt;<b=
r><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=
=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<=
br>Yonggang Luo</div></div>

--000000000000a63e0005b0ee2dc0--

