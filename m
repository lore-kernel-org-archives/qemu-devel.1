Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CBBC31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 13:35:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72CD5214C6
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 13:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72CD5214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw53a-0004PT-Nb
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 09:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60227)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hw53C-0003y1-HU
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 09:35:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hw53A-0001Ug-SS
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 09:35:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29789)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hw53A-0001UB-L3
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 09:35:20 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 60C79C085537;
 Fri,  9 Aug 2019 13:35:19 +0000 (UTC)
Received: from redhat.com (ovpn-112-57.ams2.redhat.com [10.36.112.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F2BC1001E91;
 Fri,  9 Aug 2019 13:35:17 +0000 (UTC)
Date: Fri, 9 Aug 2019 14:35:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190809133514.GF13660@redhat.com>
References: <87r25vd5y1.fsf@dusky.pond.sub.org>
 <CAFEAcA-3X0s-mxaD27HWQa7ysiEb6Uo-BD+Yxo0QhBV_yb9WLA@mail.gmail.com>
 <CAFEAcA-e2aW33GeuganVSnu9epuqt57rnZ_KgEHwDNqrWrTHuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-e2aW33GeuganVSnu9epuqt57rnZ_KgEHwDNqrWrTHuA@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 09 Aug 2019 13:35:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Does i386-linux-user build on an i686 host?
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Laurent Vivier <Laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 09, 2019 at 01:49:07PM +0100, Peter Maydell wrote:
> On Fri, 9 Aug 2019 at 13:22, Peter Maydell <peter.maydell@linaro.org> w=
rote:
> >
> > On Thu, 8 Aug 2019 at 16:37, Markus Armbruster <armbru@redhat.com> wr=
ote:
> > >
> > > Fails for me, but perhaps I'm doing it wrong:
> >
> >
> > > NOTE: cross-compilers enabled:  'cc'
> > > $ make
> > >   CC      i386-linux-user/linux-user/syscall.o
> > > /home/armbru/qemu/linux-user/ioctls.h:306:9: error: =E2=80=98SNDCTL=
_DSP_MAPINBUF=E2=80=99 undeclared here (not in a function)
> > >    IOCTL(SNDCTL_DSP_MAPINBUF, IOC_R, MK_PTR(MK_STRUCT(STRUCT_buffme=
m_desc)))
> > >          ^
> > > /home/armbru/qemu/linux-user/syscall.c:5023:23: note: in definition=
 of macro =E2=80=98IOCTL=E2=80=99
> > >      { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
> > >                        ^
> > > /home/armbru/qemu/linux-user/ioctls.h:307:9: error: =E2=80=98SNDCTL=
_DSP_MAPOUTBUF=E2=80=99 undeclared here (not in a function)
> > >    IOCTL(SNDCTL_DSP_MAPOUTBUF, IOC_R, MK_PTR(MK_STRUCT(STRUCT_buffm=
em_desc)))
> > >          ^
> > > /home/armbru/qemu/linux-user/syscall.c:5023:23: note: in definition=
 of macro =E2=80=98IOCTL=E2=80=99
> > >      { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
> > >                        ^
> > > /home/armbru/qemu/linux-user/ioctls.h:362:9: error: =E2=80=98SOUND_=
MIXER_ACCESS=E2=80=99 undeclared here (not in a function)
> > >    IOCTL(SOUND_MIXER_ACCESS, 0, TYPE_PTRVOID)
> > >          ^
> > > /home/armbru/qemu/linux-user/syscall.c:5023:23: note: in definition=
 of macro =E2=80=98IOCTL=E2=80=99
> > >      { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
> > >                        ^
> >
> > We expect these to be provided by the system's "linux/soundcard.h".
> > For my Debian system that's provided by the linux-libc-dev package,
> > but I imagine you have that installed or you wouldn't have got
> > this far in the configure/compile process...
>=20
> Further investigation shows that this is because the system has
> the 'oss4-dev' package installed, which diverts /usr/include/linux/soun=
dcard.h
> and installs its own version which doesn't provide all the symbols
> that the kernel one does.
>=20
> Easy fix: uninstall oss4-dev.

Perhaps also make 'configure' exit with an error if it detects the
broken soundcard.h ?

> Better fix: patch QEMU to provide its own versions of these constants
> if the system headers don't.
>=20
> Utopian fix: I've wondered occasionally whether for cases like this
> where the constant is known to be the same for the host and the guest
> we should have some sort of approach which lets us use the QEMU
> copies of the linux kernel headers rather than having to rely on
> the host system, which might have an older version that restricts
> us unnecessarily on what we could support...
>=20
> Issue previously reported in 2016:
> https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg01421.html
>=20
> thanks
> -- PMM
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

