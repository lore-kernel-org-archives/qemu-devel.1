Received: from eggs.gnu.org ([2001:4830:134:3::10]:42136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQB3O-000487-6p
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQB3L-0005Wi-0W
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:27:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34742 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fQB3K-0005WL-RQ
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 08:27:06 -0400
Date: Tue, 5 Jun 2018 13:27:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180605122702.GF32286@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180531224911.23725-1-richard.henderson@linaro.org>
	<20180531224911.23725-7-richard.henderson@linaro.org>
	<788ee514-a026-d415-73ce-67cc996e6259@vivier.eu>
	<149da730-950c-a527-2373-9cb0433543b1@linaro.org>
	<CAFEAcA-h7Ef5yfOS3V_kR5_fCmhr-N6okHY9=N87M9Ld+8MVdA@mail.gmail.com>
	<54f54010-ad2d-7df0-8838-b2ddc7668875@vivier.eu>
	<CAFEAcA9b==mGZQUAoPDCt1zbqxT3RmTa0XoQZvuPb17L0NYbMg@mail.gmail.com>
	<18231864-96b1-8f6f-5caa-c3d8613ec20e@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18231864-96b1-8f6f-5caa-c3d8613ec20e@vivier.eu>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/6] linux-user: Use *at functions to
 implement interp_prefix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Evan Green <evgreen@chromium.org>

On Tue, Jun 05, 2018 at 02:23:56PM +0200, Laurent Vivier wrote:
> Le 05/06/2018 =C3=A0 14:14, Peter Maydell a =C3=A9crit=C2=A0:
> > On 5 June 2018 at 13:05, Laurent Vivier <laurent@vivier.eu> wrote:
> >> Le 05/06/2018 =C3=A0 12:52, Peter Maydell a =C3=A9crit :
> >>> On 5 June 2018 at 06:27, Richard Henderson <richard.henderson@linar=
o.org> wrote:
> >>>> On Fedora 28, one can no longer build a static qemu.  We depend on=
 libraries
> >>>> for which Fedora no longer ships static versions.
> >>>
> >>> Do you mean you can't build the system binaries statically (that's
> >>> never really been very supported), or that you can't do a build
> >>> with configure --disable-system --disable-tools --static ?
> >>>
> >>> The latter would be more concerning.
> >>
> >> On Fedora I have also to disable gcrypt, nettle and libiscsi because=
 we
> >> don't have the statically linked libraries, but we don't need them w=
ith
> >> linux-user.
> >=20
> > Do we actually try to link with those for linux-user? If not,
> > maybe we could make configure a bit more helpful about not
> > requiring you to manually --disable-foo them.
>=20
> They are used by tests/qemu-iotests/socket_scm_helper and
> qemu-bridge-helper.
>=20
> Perhaps we can disable qemu-iotests with linux-user only and to not
> build qemu-bridge-helper when tools are disabled?

Actually we should not build qemu-bridge-helper if all system emulator
builds are disabled, since its not intended as a standalone tool.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
