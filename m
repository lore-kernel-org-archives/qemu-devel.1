Received: from eggs.gnu.org ([2001:4830:134:3::10]:49692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g9uFV-00076Q-Kf
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g9uFU-00026l-Mk
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:48:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g9uFU-00026Q-Eh
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:48:40 -0400
References: <20181009145933.18925-1-alex.bennee@linaro.org>
	<20181009145933.18925-4-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5bf2d666-d93b-1154-660c-3eab32350b8e@redhat.com>
Date: Tue, 9 Oct 2018 17:48:27 +0200
MIME-Version: 1.0
In-Reply-To: <20181009145933.18925-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] tests/tcg: disable enterN insn
 tests for test-i386 with clang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: famz@redhat.com, f4bug@amsat.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On 09/10/2018 16:59, Alex Benn=C3=A9e wrote:
> The enter[qwl] instructions aren't supported by clang's inline
> assembler. Apply the hammer to work around it when we re-use our
> system compiler to build tcg tests.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Do you have a bug for this in llvm?  It doesn't seem to be a good idea.

Paolo

> ---
>  tests/tcg/i386/test-i386.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/tests/tcg/i386/test-i386.c b/tests/tcg/i386/test-i386.c
> index c5f67000e4..da632c9b67 100644
> --- a/tests/tcg/i386/test-i386.c
> +++ b/tests/tcg/i386/test-i386.c
> @@ -2098,6 +2098,7 @@ long enter_stack[4096];
> =20
>  static void test_enter(void)
>  {
> +#if !(defined __clang__)
>  #if defined(__x86_64__)
>      TEST_ENTER("q", uint64_t, 0);
>      TEST_ENTER("q", uint64_t, 1);
> @@ -2114,6 +2115,7 @@ static void test_enter(void)
>      TEST_ENTER("w", uint16_t, 1);
>      TEST_ENTER("w", uint16_t, 2);
>      TEST_ENTER("w", uint16_t, 31);
> +#endif
>  }
> =20
>  #ifdef TEST_SSE
>=20
