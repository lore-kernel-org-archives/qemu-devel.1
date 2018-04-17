Received: from eggs.gnu.org ([2001:4830:134:3::10]:54474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f8Mar-00080y-2B
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 05:08:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f8Maq-0004uH-3d
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 05:08:05 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:46300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1f8Map-0004pl-T2
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 05:08:04 -0400
Received: by mail-wr0-x241.google.com with SMTP id d1so33317326wrj.13
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 02:08:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523900897-6630-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1523900897-6630-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 17 Apr 2018 11:08:01 +0200
Message-ID: <CAJ+F1CJ1NduViyjBw5LqwB4Sqm4TpYnXjNRyOgvPU=cjaLV05Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: request access to locality 0 before
 sending command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

Hi

On Mon, Apr 16, 2018 at 7:48 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> Recent changes to the CRB code now require that access to locality 0
> be requested before the locality can be used for sending a command.
> This patch adds the request to access the locality.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  tests/tpm-util.c | 2 ++

The patch fails to apply, tpm-util is added with your upcoming "tpm:
Add test cases that use the external swtpm with CRB interface" patch,
I guess it could be squashed there (I confirm it fixes the test)


tpm-crb-test.c isn't affected, because you changed it in "tests: Tests
more flags of the CRB interface" already


>  1 file changed, 2 insertions(+)
>
> diff --git a/tests/tpm-util.c b/tests/tpm-util.c
> index 4967a4e..6910503 100644
> --- a/tests/tpm-util.c
> +++ b/tests/tpm-util.c
> @@ -25,6 +25,8 @@ void tpm_util_crb_transfer(QTestState *s,
>      uint64_t caddr =3D qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD=
_LADDR);
>      uint64_t raddr =3D qtest_readq(s, TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP=
_ADDR);
>
> +    qtest_writeb(s, TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL, 1);
> +
>      qtest_memwrite(s, caddr, req, req_size);
>
>      uint32_t sts, start =3D 1;
> --
> 2.5.5
>



--=20
Marc-Andr=C3=A9 Lureau
