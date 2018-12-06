Received: from eggs.gnu.org ([2001:4830:134:3::10]:39941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gUqLz-0003AK-JK
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:54:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gUqLu-0004CJ-Kg
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:53:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gUqLu-0004By-F5
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:53:50 -0500
Date: Thu, 6 Dec 2018 09:53:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181206095343.GD29540@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1543845937-300-1-git-send-email-thuth@redhat.com>
	<1543845937-300-2-git-send-email-thuth@redhat.com>
	<31b42ffd-40bb-47c8-4ad4-e8e696596473@redhat.com>
	<8d2072f0-d497-5e56-f0aa-2ec17d6f896d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8d2072f0-d497-5e56-f0aa-2ec17d6f896d@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 1/7] configure: Add a test for the
 minimum compiler version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>

On Thu, Dec 06, 2018 at 06:34:25AM +0100, Thomas Huth wrote:
> On 2018-12-05 18:30, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 12/3/18 3:05 PM, Thomas Huth wrote:
> >> So far we only had implicit requirements for the minimum compiler ve=
rsion,
> >> e.g. we require at least GCC 4.1 for the support of atomics. However=
,
> >> such old compiler versions are not tested anymore by the developers,=
 so
> >> they are not really supported anymore. Since we recently declared ex=
plicitly
> >> what platforms we intend to support, we can also get more explicit o=
n the
> >> compiler version now. The supported distributions use the following =
version
> >> of GCC:
> >>
> >>       RHEL-7: 4.8.5
> >>       Debian (Stretch): 6.3.0
> >>       Debian (Jessie): 4.8.4
> >>       OpenBSD (ports): 4.9.4
> >>       FreeBSD (ports): 8.2.0
> >>       OpenSUSE Leap 15: 7.3.1
> >>       Ubuntu (Xenial): 5.3.1
> >>       macOS (Homebrew): 8.2.0
> >=20
> > I'd like to track this in a machine parsable format, but sure where i=
t
> > better fits however, I'd prefer the git repo, and having the wiki
> > pointing to the git repo.
>=20
> I don't think that it makes sense to put fixed version numbers into the
> git or wiki - the information will expire soon, and it is additional
> maintenance to keep them up to date. We already got the generic
> description here:
>=20
> https://qemu.weilnetz.de/doc/qemu-doc.html#Supported-build-platforms
>=20
> So you just have to follow these instructions to get to the supported
> versions.

Agreed, I don't really see a benefit in tracking the per-distro versions
in QEMU - they're only useful for informing us abuot what min version
to pick, which then goes into configure.

If we absolutely wanted to, we could use a standard variable name in
configure to make it easy to grep for min versions.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
