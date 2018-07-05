Received: from eggs.gnu.org ([2001:4830:134:3::10]:51447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fayfz-0007Gb-5b
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 03:27:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fayfv-0004cy-VV
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 03:27:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39260 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fayfv-0004b6-Q7
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 03:27:35 -0400
Date: Thu, 5 Jul 2018 08:27:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180705072731.GB3814@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180704181010.GA918@computer>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180704181010.GA918@computer>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] module: Use QEMU_MODULE_DIR as a search
 path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ryang <decatf@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>

On Wed, Jul 04, 2018 at 02:10:10PM -0400, ryang wrote:
> The current paths for modules are CONFIG_QEMU_MODDIR and paths relative
> to the executable. Qemu and its modules can be installed and executed i=
n
> paths that are different from these search paths. This change allows
> a search path to be specified by environment variable.
>=20
> An example usage for this is postmarketOS[1]. This is a build environme=
nt
> for Alpine Linux. It sets up Alpine Linux in a chroot environment.
> Alpine's Qemu packages are installed in the chroot. The Alpine Linux Qe=
mu
> package is used to test compiled Alpine Linux system images. This way t=
here
> isn't a reliance on the which ever version of Qemu the host system / di=
stro
> provides.
>=20
> postmarketOS executes Qemu on host system outside of the chroot
> The Qemu module search path needs to point to the location of the
> chroot relative to the host system.
>=20
> e.g.
> The root of the Alpine Linux chroot is:
> ~/.local/var/pmbootstrap/chroot_native/
>=20
> Alpine's Qemu is installed at
> ~/.local/var/pmbootstrap/chroot_native/usr/bin/
>=20
> The Qemu module search path needs to be:
> QEMU_MODULE_DIR=3D~/.local/var/pmbootstrap/chroot_native/usr/lib/qemu/
>=20
> [1] https://postmarketos.org/
>=20
> Signed-off-by: ryang <decatf@gmail.com>
> ---
>=20
> v2:
>  - fix checkpatch errors
> v3:
>  - initialize n_dirs variable
> v4:
>  - change env variable suffix from _PATH to _DIR
>  - renamed search_path to search_dir and make it const
>=20
>  util/module.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
