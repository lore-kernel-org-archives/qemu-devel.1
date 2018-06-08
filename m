Received: from eggs.gnu.org ([2001:4830:134:3::10]:36219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fRIzI-0006kd-Rw
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:07:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fRIzH-0005DZ-Fu
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:07:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52518 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fRIzH-0005DG-BJ
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:07:35 -0400
Date: Fri, 8 Jun 2018 16:07:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180608150729.GW18233@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180608143026.20167-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180608143026.20167-1-ehabkost@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Require Python 2.7 or newer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>

On Fri, Jun 08, 2018 at 11:30:26AM -0300, Eduardo Habkost wrote:
> All of the supported build platforms documented in qemu-doc.texi
> should already support Python 2.7.
>=20
> Removing support for Python 2.6 will allow us to remove some
> compatibility modules we carry in the QEMU tree:
>=20
> * scripts/argparse.py
> * scripts/ordereddict.py
>=20
> Python 2.6 is also not receiving bug fixes upstream and is not
> supported by pylint, which makes it harder to keep the code
> compatible with both Python 2 and Python 3.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  configure | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

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
