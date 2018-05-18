Received: from eggs.gnu.org ([2001:4830:134:3::10]:43841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fJe7e-0008Sl-Sw
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fJe7c-0006RN-8H
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:04:34 -0400
References: <20180517174718.10107-1-alex.bennee@linaro.org>
	<20180517174718.10107-37-alex.bennee@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b7dda2b4-e871-2ece-d350-9f8cb971cc44@redhat.com>
Date: Fri, 18 May 2018 14:04:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180517174718.10107-37-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v4 36/49] tests/tcg: enable
 building for s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: "open list:S390" <qemu-s390x@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org

On 17.05.2018 19:47, Alex Benn=C3=A9e wrote:
> This doesn't add any additional tests but enables building the
> multiarch tests for s390x.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/tcg/s390x/Makefile.include | 2 ++
>  1 file changed, 2 insertions(+)
>  create mode 100644 tests/tcg/s390x/Makefile.include
>=20
> diff --git a/tests/tcg/s390x/Makefile.include b/tests/tcg/s390x/Makefil=
e.include
> new file mode 100644
> index 0000000000..1f58115d96
> --- /dev/null
> +++ b/tests/tcg/s390x/Makefile.include
> @@ -0,0 +1,2 @@
> +DOCKER_IMAGE=3Ddebian-s390x-cross
> +DOCKER_CROSS_COMPILER=3Ds390x-linux-gnu-gcc
>=20

Reviewed-by: David Hildenbrand <david@redhat.com>

--=20

Thanks,

David / dhildenb
