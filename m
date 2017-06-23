Received: from eggs.gnu.org ([2001:4830:134:3::10]:54858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dOUEl-000534-O7
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 15:27:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dOUEh-0006SP-RD
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 15:27:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dOUEh-0006S3-KU
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 15:27:19 -0400
References: <20170622033231.19344-1-f4bug@amsat.org>
	<20170622033231.19344-2-f4bug@amsat.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <8cd65b75-db7c-4ca1-31a3-46ae704874a8@redhat.com>
Date: Fri, 23 Jun 2017 15:27:13 -0400
MIME-Version: 1.0
In-Reply-To: <20170622033231.19344-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/21] tests: add missing dependency to
 build QTEST_QEMU_BINARY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>



On 06/21/2017 11:32 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> This allow a one liner from fresh repository clone, i.e.:
>=20
>   ./configure && make -j check-qtest-aarch64
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 77da9b7f4b..f7c8f3eddb 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -823,7 +823,7 @@ GCOV_OPTIONS =3D -n $(if $(V),-f,)
>  # gtester tests, possibly with verbose output
> =20
>  .PHONY: $(patsubst %, check-qtest-%, $(QTEST_TARGETS))
> -$(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: $(check=
-qtest-y)
> +$(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: subdir-=
%-softmmu $(check-qtest-y)
>  	$(if $(CONFIG_GCOV),@rm -f *.gcda */*.gcda */*/*.gcda */*/*/*.gcda,)
>  	$(call quiet-command,QTEST_QEMU_BINARY=3D$*-softmmu/qemu-system-$* \
>  		QTEST_QEMU_IMG=3Dqemu-img$(EXESUF) \
>=20

I'm on board, it's nice to have proper dependencies.

Reviewed-by: John Snow <jsnow@redhat.com>
