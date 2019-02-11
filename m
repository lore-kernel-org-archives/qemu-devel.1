Received: from eggs.gnu.org ([209.51.188.92]:51392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gt9Sm-0003KS-1I
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 06:09:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gt9Sk-000264-4f
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 06:09:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gt9Si-000248-2e
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 06:09:22 -0500
Date: Mon, 11 Feb 2019 11:09:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190211110907.GP27585@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190208181226.24052-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190208181226.24052-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] RFC: net/slirp: link with libslirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, samuel.thibault@ens-lyon.org

On Fri, Feb 08, 2019 at 07:12:26PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Once libslirp has received its first release, we can link with the
> external libslirp library.
>=20
> The migration data should be compatible with current and older qemu
> versions (same compatibility as today). See "slirp: add state
> saving/loading" patch. However, the content should be treated as a
> blob, as the format may change eventually in the future.

How are we going to manage live migration compat if libslirp changes
the blob content ?

Bear in mind that we need to support all existing QEMU releases live
migrating to effectively all future QEMU releases, with all future
libslirp releases, in *both* directions. ie arbitrarily newer
libslirp needs to be able to emit a blob format that can be read
by arbitrarily older slirp inside QEMU.

Normally we tie data format changes to the machine type. How are
we going to achieve such machine type associations with an external
libslirp ?

It seems to me that if a libslirp wants to change live migration
format, it will need to support both the old and new formats
indefinitely, and the new format must be an opt-in. QEMU can
then tell libslirp which migraiton format based on the machine
type.



Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
