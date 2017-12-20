Received: from eggs.gnu.org ([2001:4830:134:3::10]:41534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRbKa-0001Lh-32
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:10:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRbKW-0005o5-1p
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:10:32 -0500
Date: Wed, 20 Dec 2017 10:10:01 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171220101001.GK21216@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171219173425.8113-1-f4bug@amsat.org>
	<20171219173425.8113-10-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171219173425.8113-10-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 9/9] iotests.py: use io.StringIO with
 python3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Nir Soffer <nirsof@gmail.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Ishani Chugh <chugh.ishani@research.iiit.ac.in>

On Tue, Dec 19, 2017 at 02:34:25PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/qemu-iotests/iotests.py | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


>=20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
.py
> index 4c515d2e6c..0e1b8ab6e6 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -459,13 +459,16 @@ def main(supported_fmts=3D[], supported_oses=3D['=
linux']):
> =20
>      # We need to filter out the time taken from the output so that qem=
u-iotest
>      # can reliably diff the results against master output.
> -    import StringIO
>      if debug:
>          output =3D sys.stdout
>          verbosity =3D 2
>          sys.argv.remove('-d')
>      else:
> -        output =3D StringIO.StringIO()
> +        try:
> +            from StringIO import StringIO
> +        except ImportError:
> +            from io import StringIO
> +        output =3D StringIO()

If it was nit-picking I'd put the py3 'io' import first and the py2
'StringIO' as the fallback, but doesn't honestly matter

> =20
>      logging.basicConfig(level=3D(logging.DEBUG if debug else logging.W=
ARN))
> =20
> --=20
> 2.15.1
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
