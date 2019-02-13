Received: from eggs.gnu.org ([209.51.188.92]:57638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gtqbV-00041s-Nn
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:13:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gtqbU-0005eg-W5
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:13:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gtqbU-0005dA-Oi
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:13:16 -0500
Date: Wed, 13 Feb 2019 09:13:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190213091311.GC13960@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190212212917.26977-1-mdroth@linux.vnet.ibm.com>
	<20190212212917.26977-3-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190212212917.26977-3-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] qga-win: fix VSS build breakage due to
 unintended gnu99 C++ flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org

On Tue, Feb 12, 2019 at 03:29:17PM -0600, Michael Roth wrote:
> Commit 7be41675f7c set -std=3Dgnu99 for C code via QEMU_CFLAGS. Current=
ly
> we generate a "custom" QEMU_CXXFLAGS for VSS DLL C++ build by
> filtering out some options from QEMU_CFLAGS and adding some others.
> Since we don't filter out -std=3Dgnu99 currently this breaks builds whe=
n
> VSS support is enabled.
>=20
> We could keep the existing approach, filter out -std=3Dgnu99 from
> QEMU_CFLAGS, and add -std=3Dgnu++98, like configure currently does for
> QEMU_CXXFLAGS, but as it turns out our resulting QEMU_CXXFLAGS would
> be exactly what configure already generates, just with these filtered
> out:
>=20
>   -fstack-protector-all -fstack-protector-strong
>=20
> and these added:
>=20
>   -Wno-unknown-pragmas -Wno-delete-non-virtual-dtor
>=20
> So fix the issue by re-using configure-generated QEMU_CXXFLAGS and
> just handling these specific changes.
>=20
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
>  qga/vss-win32/Makefile.objs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

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
