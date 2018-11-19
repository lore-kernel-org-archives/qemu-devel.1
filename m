Received: from eggs.gnu.org ([2001:4830:134:3::10]:55202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOh1a-0006WX-Qn
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:43:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOh1Z-0000Hu-NZ
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 05:43:26 -0500
Date: Mon, 19 Nov 2018 10:43:16 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181119104316.GM19532@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181116215002.2124581-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181116215002.2124581-1-eblake@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] iotests: Drop use of bash keyword
 'function'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Fri, Nov 16, 2018 at 03:50:02PM -0600, Eric Blake wrote:
> Bash allows functions to be declared with or without the leading
> keyword 'function'; but including the keyword does not comply with
> POSIX syntax, and is confusing to ksh users where the use of the
> keyword changes the scoping rules for functions.  Stick to the
> POSIX form through iotests.
>=20
> Done mechanically with:
>   sed -i 's/^function //' $(git ls-files tests/qemu-iotests)
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---

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
