Received: from eggs.gnu.org ([2001:4830:134:3::10]:56759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxCG2-0007kO-Ch
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxCFx-000787-NK
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:20:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dxCFx-00076N-G6
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:20:05 -0400
Date: Wed, 27 Sep 2017 14:19:57 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170927131957.GI12223@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170927130339.21444-1-ehabkost@redhat.com>
	<20170927130339.21444-4-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170927130339.21444-4-ehabkost@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/5] basevm: Call logging.basicConfig()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Cleber Rosa <crosa@redhat.com>

On Wed, Sep 27, 2017 at 10:03:37AM -0300, Eduardo Habkost wrote:
> Just setting level=3DDEBUG when debug is enabled is not enough: we
> need to set up a log handler if we want debug messages generated
> using logging.getLogger(...).debug() to be printed.
>=20
> This was not a problem before because logging.debug() calls
> logging.basicConfig() implicitly, but it's safer to not rely on
> that.
>=20
> Cc: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
> Cc: Fam Zheng <famz@redhat.com>
> Cc: "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  tests/vm/basevm.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
