Received: from eggs.gnu.org ([2001:4830:134:3::10]:60765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQrWM-0001J3-Qf
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 05:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQrWJ-0003T0-PI
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 05:47:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53592 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fQrWJ-0003Sn-JZ
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 05:47:51 -0400
Date: Thu, 7 Jun 2018 10:47:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180607094747.GA12019@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180514171913.17664-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180514171913.17664-1-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] i386: fix handling of multiboot modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Markus Armbruster <armbru@redhat.com>

ping...

On Mon, May 14, 2018 at 06:19:10PM +0100, Daniel P. Berrang=C3=A9 wrote:
> This short series fixes a flaw identified by coverity which broke the
> handling of multiboot modules.
>=20
> Daniel P. Berrang=C3=A9 (3):
>   i386: fix regression parsing multiboot initrd modules
>   i386: only parse the initrd_filename once for multiboot modules
>   opts: remove redundant check for NULL parameter
>=20
>  hw/i386/multiboot.c | 35 ++++++++++++++++-------------------
>  util/qemu-option.c  |  8 +++-----
>  2 files changed, 19 insertions(+), 24 deletions(-)
>=20
> --=20
> 2.17.0
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
