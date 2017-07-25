Received: from eggs.gnu.org ([2001:4830:134:3::10]:45824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da01U-0006BK-9p
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:37:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da01Q-0005fJ-DQ
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:37:16 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1da01Q-0005f0-6Y
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 09:37:12 -0400
Received: by mail-wm0-x241.google.com with SMTP id c184so3808082wmd.1
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 06:37:12 -0700 (PDT)
Date: Tue, 25 Jul 2017 14:37:08 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170725133708.GE23343@stefanha-x1.localdomain>
References: <20170724124438.27344-1-apahim@redhat.com>
	<20170724124438.27344-2-apahim@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="47eKBCiAZYFK5l32"
Content-Disposition: inline
In-Reply-To: <20170724124438.27344-2-apahim@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/2] qemu.py: make 'args' public
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amador Pahim <apahim@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, ldoktor@redhat.com, ehabkost@redhat.com, armbru@redhat.com, mreitz@redhat.com, crosa@redhat.com, famz@redhat.com


--47eKBCiAZYFK5l32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 24, 2017 at 02:44:37PM +0200, Amador Pahim wrote:
> Let's make args public so users can extend it without feeling like
> abusing the internal API.

Nothing is abusing an internal API.  PEP8 describes the difference
between public (no underscore), protected aka subclass API (single
underscore), and private fields (single or double underscore):

  https://www.python.org/dev/peps/pep-0008/

_args is a protected field.  It is perfectly normal for a subclass to
access a protected field in its parent class.

> Signed-off-by: Amador Pahim <apahim@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> ---
>  scripts/qemu.py               | 10 +++++-----
>  tests/qemu-iotests/iotests.py | 18 +++++++++---------
>  2 files changed, 14 insertions(+), 14 deletions(-)

Please don't do this, it encourages code duplication.  Now arbitrary
users can start accessing the public field directly instead of adding a
reusable interfaces like add_monitor_telnet(), add_fd(), etc.

--47eKBCiAZYFK5l32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZd0mEAAoJEJykq7OBq3PI8tQIALBZxAhD900bOP1ePk5+XRyK
TDhzRLPrugvVi/zSiATgs+GwFJR9OqA6P9klD89NQPKl3I7PxxhjkOx6U7vlg58d
YMgtnHmtSK5wXAaT7qZIud88ObwAK00SJt/l63ZSoQEw2nJidUy0hmYARWSg78sM
TbifEO1QgOluNF4Kfb5eC7kU2Cr365muccFvinKos4Hb7VBAOdojQVU/OTw+UPx4
3qJvNWTTbrtBHH7i9kgs7HUHNFUO0i7qYRRzK5Gzb5ByB10chs77B1FhrpiMtKSr
AJRioYoKCPiCAJNzlejdp4DZywPNCYbir0AjDyIDAAuVrcmnUhOVZ15ngr1t4FU=
=/kmA
-----END PGP SIGNATURE-----

--47eKBCiAZYFK5l32--
