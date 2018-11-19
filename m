Received: from eggs.gnu.org ([2001:4830:134:3::10]:48141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOm3X-0000n6-BV
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 11:05:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOm3W-0002OR-Bb
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 11:05:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gOm3W-0002Nv-62
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 11:05:46 -0500
Date: Mon, 19 Nov 2018 16:05:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181119160542.GS19532@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181119151527.4a925a75@naga> <20181119142059.GP19532@redhat.com>
	<20181119165516.388123be@naga>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181119165516.388123be@naga>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Block format 'raw' does not support the option
 'serial'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: qemu-devel@nongnu.org

On Mon, Nov 19, 2018 at 04:55:16PM +0100, Michal Such=C3=A1nek wrote:
> On Mon, 19 Nov 2018 14:20:59 +0000
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
>=20
> > On Mon, Nov 19, 2018 at 03:15:27PM +0100, Michal Such=C3=A1nek wrote:
> > > Hello,
> > >=20
> > > I tried to run my VM with qemu git and I am greeted with:
> > >=20
> > > Block format 'raw' does not support the option 'serial'
> > >=20
> > > Is there any sensible reason to *not^ support disk serial number? =20
> >=20
> > The 'serial' property on -drive was deprecated in QEMU 2.10, and dele=
ted
> > in 3.1, as it is not a property that makes sense for the backend.
> >=20
> > It should be set on the virtual device instead via the -device arg
>=20
> Is this documented anywhere?
>=20
> Looking at the man page I only see serial property on smbios.

The original deprecation was listed in the qemu man page / online user
guide, but this documentation gets deleted once the feature is actually
removed.

This wouldn't be so bad if we actually published versioned copies of
the qemu manual online, but we just overwrite the manual each time there
is a new release, so we've no historical record of deprecations.

Thirdly the -device properties are not documented at all - you just
have to look for them live with eg '$QEMU -device virtio-blk,help'

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
