Received: from eggs.gnu.org ([2001:4830:134:3::10]:58620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f6D1n-0006bZ-Fd
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 06:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f6D1j-0002oh-E0
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 06:30:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48954 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f6D1j-0002oP-AK
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 06:30:55 -0400
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-13-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e1e71852-591a-550f-b0f6-3f7b204ddfad@redhat.com>
Date: Wed, 11 Apr 2018 12:30:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180410193919.28026-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 12/24] tests/tcg/i386: Build fix for
 hello-i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: famz@redhat.com, cota@braap.org

On 10.04.2018 21:39, Alex Benn=C3=A9e wrote:
> From: Fam Zheng <famz@redhat.com>
>=20
> We have -Werror=3Dmissing-prototype, add a dummy prototype to avoid tha=
t
> warning.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/tcg/i386/hello-i386.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/tests/tcg/i386/hello-i386.c b/tests/tcg/i386/hello-i386.c
> index fa00380de2..cfeb24b2f5 100644
> --- a/tests/tcg/i386/hello-i386.c
> +++ b/tests/tcg/i386/hello-i386.c
> @@ -20,6 +20,7 @@ static inline int write(int fd, const char * buf, int=
 len)
>    return status;
>  }
> =20
> +void _start(void);
>  void _start(void)
>  {
>      write(1, "Hello World\n", 12);
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
