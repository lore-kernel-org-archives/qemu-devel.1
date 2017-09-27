Received: from eggs.gnu.org ([2001:4830:134:3::10]:60915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dxCVL-0005GK-GQ
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dxCVH-0007dG-9W
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:35:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dxCVH-0007cw-4J
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 09:35:55 -0400
Date: Wed, 27 Sep 2017 21:35:44 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170927133544.GC8521@lemon.lan>
References: <20170927130339.21444-1-ehabkost@redhat.com>
	<20170927130339.21444-4-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Cc: qemu-devel@nongnu.org, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Cleber Rosa <crosa@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Wed, 09/27 10:03, Eduardo Habkost wrote:
> Just setting level=3DDEBUG when debug is enabled is not enough: we
> need to set up a log handler if we want debug messages generated
> using logging.getLogger(...).debug() to be printed.
>=20
> This was not a problem before because logging.debug() calls
> logging.basicConfig() implicitly, but it's safer to not rely on
> that.
>=20
> Cc: "Alex Benn=E9e" <alex.bennee@linaro.org>
> Cc: Fam Zheng <famz@redhat.com>
> Cc: "Philippe Mathieu-Daud=E9" <f4bug@amsat.org>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  tests/vm/basevm.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 3c863bc237..686d88decf 100755
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -227,8 +227,8 @@ def main(vmcls):
>          if not argv and not args.build_qemu and not args.build_image:
>              print "Nothing to do?"
>              return 1
> -        if args.debug:
> -            logging.getLogger().setLevel(logging.DEBUG)
> +        logging.basicConfig(level=3D(logging.DEBUG if args.debug
> +                                   else logging.WARN))

I find the " ? : " expression in C more readable than this in Python. :)

>          vm =3D vmcls(debug=3Dargs.debug, vcpus=3Dargs.jobs)
>          if args.build_image:
>              if os.path.exists(args.image) and not args.force:
> --=20
> 2.13.5
>=20

Reviewed-by: Fam Zheng <famz@redhat.com>
