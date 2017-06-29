Received: from eggs.gnu.org ([2001:4830:134:3::10]:39938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dQUw0-0000zu-Il
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:36:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dQUvw-000851-KY
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:36:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dQUvw-00084M-Er
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:36:16 -0400
Date: Thu, 29 Jun 2017 09:36:08 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170629083608.GB19941@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170629010300.2848-1-f4bug@amsat.org>
	<20170629010300.2848-8-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170629010300.2848-8-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 7/8] tcg/tci: time to remove it :(
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Stefan Weil <sw@weilnetz.de>, Peter Maydell <peter.maydell@linaro.org>, Pranith Kumar <bobby.prani@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Sergey Fedorov <serge.fdrv@gmail.com>

On Wed, Jun 28, 2017 at 10:02:59PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> "./configure --disable-tcg-interpreter" generates a warning:
>   ./configure: --disable-tcg-interpreter is obsolete, Experimental TCG =
interpreter has been removed"
>=20
> "./configure --enable-tcg-interpreter" generates an error:
>=20
>   Experimental TCG interpreter has been removed

configure will already complain about any unknown command line arguments
it is given, so you could just delete --enable-tcg-interpreter support
and rely on it saying the option does not exist.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
