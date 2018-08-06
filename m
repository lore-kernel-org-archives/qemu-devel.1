Received: from eggs.gnu.org ([2001:4830:134:3::10]:54709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fmizZ-0007aT-Um
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:08:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fmizX-0008RU-69
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:08:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48650 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fmizX-0008Qd-01
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:08:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F06F5401EF09
	for <qemu-devel@nongnu.org>; Mon,  6 Aug 2018 17:08:21 +0000 (UTC)
Date: Mon, 6 Aug 2018 18:08:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180806170818.GG20807@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180718120334.27138-1-berrange@redhat.com>
	<20180718120334.27138-2-berrange@redhat.com>
	<21544428-4494-da5c-41c6-e72056db2bca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21544428-4494-da5c-41c6-e72056db2bca@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] crypto: require gnutls >= 3.1.18 for
 building QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Aug 06, 2018 at 11:58:41AM -0500, Eric Blake wrote:
> On 07/18/2018 07:03 AM, Daniel P. Berrang=C3=A9 wrote:
> > gnutls 3.0.0 was released in 2011 and all the distros that are build
> > target platforms for QEMU [1] include it:
> >=20
> >    RHEL-7: 3.1.18
> >    Debian (Stretch): 3.5.8
> >    Debian (Jessie): 3.3.8
> >    OpenBSD (ports): 3.5.18
> >    FreeBSD (ports): 3.5.18
> >    OpenSUSE Leap 15: 3.6.2
> >    Ubuntu (Xenial): 3.4.10
> >    macOS (Homebrew): 3.5.19
> >=20
> > Based on this, it is reasonable to require gnutls >=3D 3.1.18 in QEMU
> > which allows for all conditional version checks in the code to be
> > removed.
>=20
> Looks reasonable.
>=20
> >=20
> > [1] https://qemu.weilnetz.de/doc/qemu-doc.html#Supported-build-platfo=
rms
> >=20
>=20
> Any chance we can get http builds of the docs hosted directly on qemu.o=
rg
> someday?  But unrelated to your patch.
>=20
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> > @@ -2675,79 +2674,28 @@ fi
> >   ##########################################
> >   # GNUTLS probe
> > -gnutls_works() {
> > -    # Unfortunately some distros have bad pkg-config information for=
 gnutls
> > -    # such that it claims to exist but you get a compiler error if y=
ou try
> > -    # to use the options returned by --libs. Specifically, Ubuntu fo=
r --static
> > -    # builds doesn't work:
> > -    # https://bugs.launchpad.net/ubuntu/+source/gnutls26/+bug/147803=
5
>=20
> This bug is still in state NEW, but targets Ubuntu 14.04 and "Package:
> libgnutls-dev 2.12.23-12ubuntu2.2", so is probably indeed old enough th=
at it
> is hopefully a non-issue for gnutls > 3 in the versions of Ubuntu we
> specifically support. However, I'm not enough of an Ubuntu user myself =
to
> confirm whether things still work, so you'll probably want to collect
> additional R-b or Tested-by before accepting this for qemu 3.1.

FYI, I checked the pkg-config file with gnutls 3 on ubuntu and it did not
appear to have the bug that existed in gnutls 2, so I believe removing
this cruft is safe.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
