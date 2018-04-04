Received: from eggs.gnu.org ([2001:4830:134:3::10]:34376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f3eew-0004vA-5K
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:24:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f3ees-0007hK-8L
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:24:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33288 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f3ees-0007hD-2i
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:24:46 -0400
Date: Wed, 4 Apr 2018 10:24:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180404092433.GE3186@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180404025201.11921-1-famz@redhat.com>
	<20180404025201.11921-2-famz@redhat.com>
	<20180404082331.GD3186@redhat.com>
	<20180404090756.GJ12052@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180404090756.GJ12052@lemon.usersys.redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] archive-source.sh: Drop submodule code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, pbonzini@redhat.com, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Wed, Apr 04, 2018 at 05:07:56PM +0800, Fam Zheng wrote:
> On Wed, 04/04 09:23, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Apr 04, 2018 at 10:51:59AM +0800, Fam Zheng wrote:
> > > ./configure and make now take care of submodules, we only need to c=
lone
> > > the top tree.
> >=20
> > If you don't include the submodules in the tar.gz archive, then the
> > test system needs to be able to clone them from qemu.org, which
> > requires networking.
> >=20
> > The VM tests have networking by default, but the docker tests do
> > not have networking - you need to opt-in by setting NETWORK=3D1
> > make variable. So AFAICT, this will break docker tests.
>=20
> Yes, I'll revise the patch.

BTW, I can't help feeling that scripts/archive-source.sh should not even
exist. We already have scripts/make-release that has significant overlap
of functionality and is used by 'make dist'. Ideally imho we should be
able to either invoke 'make dist' for testing, or call make-release.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
