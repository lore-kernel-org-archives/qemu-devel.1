Received: from eggs.gnu.org ([209.51.188.92]:33269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gobU6-0005i7-4c
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 17:03:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gobU5-0002Yp-B4
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 17:03:58 -0500
References: <20190129175403.18017-1-philmd@redhat.com>
	<20190129175403.18017-6-philmd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <95df2572-6c6e-ac38-0f7f-2f46ac00671e@redhat.com>
Date: Tue, 29 Jan 2019 16:03:43 -0600
MIME-Version: 1.0
In-Reply-To: <20190129175403.18017-6-philmd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cYKOwRzosgYMEovJsOa8hCa7RH4hjTMar"
Subject: Re: [Qemu-devel] [PATCH v2 05/18] qemu-iotests: Add dependency to
 qemu-nbd tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cYKOwRzosgYMEovJsOa8hCa7RH4hjTMar
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>
Message-ID: <95df2572-6c6e-ac38-0f7f-2f46ac00671e@redhat.com>
Subject: Re: [PATCH v2 05/18] qemu-iotests: Add dependency to qemu-nbd tool
References: <20190129175403.18017-1-philmd@redhat.com>
 <20190129175403.18017-6-philmd@redhat.com>
In-Reply-To: <20190129175403.18017-6-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/29/19 11:53 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Since a9660664fde, some iotests use qemu-nbd.
> Add a dependency to build it before using it.
> This fixes:
>=20
>   $ gmake check-block
>           CHK version_gen.h
>     GEN     qemu-img-cmds.h
>     CC      qemu-img.o
>     LINK    qemu-img
>     CC      qemu-io.o
>     LINK    qemu-io
>   tests/qemu-iotests-quick.sh
>   tests/qemu-iotests-quick.sh[6]: ./check: No such file or directory
>   gmake: *** [/tmp/qemu-test.9GLXBk/tests/Makefile.include:1059: check-=
tests/qemu-iotests-quick.sh] Error 1
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>


> +++ b/tests/Makefile.include
> @@ -1055,7 +1055,7 @@ clean-tcg: $(CLEAN_TCG_TARGET_RULES)
>  QEMU_IOTESTS_HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) =3D=
 tests/qemu-iotests/socket_scm_helper$(EXESUF)
> =20
>  .PHONY: check-tests/qemu-iotests-quick.sh
> -check-tests/qemu-iotests-quick.sh: tests/qemu-iotests-quick.sh qemu-im=
g$(EXESUF) qemu-io$(EXESUF) $(QEMU_IOTESTS_HELPERS-y)
> +check-tests/qemu-iotests-quick.sh: tests/qemu-iotests-quick.sh qemu-im=
g$(EXESUF) qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y)

Worth using backslash-newline to wrap this into a series of shorter lines=
?


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--cYKOwRzosgYMEovJsOa8hCa7RH4hjTMar
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxQzb8ACgkQp6FrSiUn
Q2oengf/TujfJQXOLO4LeO98muxvaq9bFQF+vzLUPN4va8Lc/9EtMY8qxr/tqSL2
sLJBejlCawQctC7VBZx9HJrSswnMsSH1LAK9xiAGCIB+GEsHrGNMWGSN9KzLhsrv
tC7VdTSiAa6D5BXPSVvGLG1CwclzMyn6FYoTR1hHidiMpjgk/9ausZTg/+mY4cqu
AcF2BluWjNKeJ6PwCpOr3yueBVYMUml+Zay85CI3fPZPTROYhkm4o7wVOgg1IEZk
+Cc+7YnVW4/p99LF7ZKmoYWErdRQNI7Z/LcLwVemWm5QIdxa3XhOBP+JfvwlcHMX
gakH+6IyoMHpMZkQwZ5dE4rxvfRlFA==
=9K33
-----END PGP SIGNATURE-----

--cYKOwRzosgYMEovJsOa8hCa7RH4hjTMar--
