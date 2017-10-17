Received: from eggs.gnu.org ([2001:4830:134:3::10]:56800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e4Mzd-0006Kb-U8
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 04:12:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e4Mza-0005NU-Od
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 04:12:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1e4Mza-0005Me-Hp
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 04:12:50 -0400
Date: Tue, 17 Oct 2017 16:12:42 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171017081242.GB13504@lemon>
References: <20171017071247.32355-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171017071247.32355-1-peterx@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docker: cleanup temp directory after test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Tue, 10/17 15:12, Peter Xu wrote:
> There are temp directories named "docker-src.*" after doing docker
> tests.  I don't see much point in keeping that (it only contains the
> qemu.tar which is exactly current tree, and the copied "run" file).
> Let's remove it after test finished.
>=20
> CC: "Alex Benn=E9e" <alex.bennee@linaro.org>
> CC: Fam Zheng <famz@redhat.com>
> CC: "Philippe Mathieu-Daud=E9" <f4bug@amsat.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tests/docker/Makefile.include | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index 6f9ea196a7..c8fbd37127 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -151,6 +151,8 @@ docker-run: docker-qemu-src
>  			$(IMAGE) 					\
>  			/var/tmp/qemu/run 				\
>  			$(TEST), "  RUN $(TEST) in ${IMAGE}")
> +	$(call quiet-command, rm -r $(DOCKER_SRC_COPY), \
> +		"  CLEANUP $(DOCKER_SRC_COPY)")
> =20
>  # Run targets:
>  #
> --=20
> 2.13.5
>=20
>=20

Reviewed-by: Fam Zheng <famz@redhat.com>
