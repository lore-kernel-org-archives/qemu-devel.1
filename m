Received: from eggs.gnu.org ([2001:4830:134:3::10]:47274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gWRCA-0005eh-7P
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 14:26:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gWRC6-0003BQ-6y
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 14:26:22 -0500
MIME-Version: 1.0
References: <03506cf0-a204-f619-8ee4-4990a5e69af5@cea.fr>
In-Reply-To: <03506cf0-a204-f619-8ee4-4990a5e69af5@cea.fr>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 10 Dec 2018 20:26:05 +0100
Message-ID: <CAAdtpL5BdqUvHpVTpKuJ6R+yEHGi7U6T9rUK2PbL3nwC7F_3jA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] Fixes i386 xchgq test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: fabrice.desclaux@cea.fr, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, camille.mougey@cea.fr

Hi Fabrice,

On Fri, Dec 7, 2018 at 5:06 PM <fabrice.desclaux@cea.fr> wrote:
>
> As "xchg" reads and writes both operands, the "+m" is required to avoid
> undefined behavior on -O2 compilation.
>
> Signed-off-by: Fabrice Desclaux <fabrice.desclaux@cea.fr>
> ---
>   tests/tcg/i386/test-i386.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/tcg/i386/test-i386.c b/tests/tcg/i386/test-i386.c
> index a29b41e764..18d5609665 100644
> --- a/tests/tcg/i386/test-i386.c
> +++ b/tests/tcg/i386/test-i386.c
> @@ -1137,7 +1137,7 @@ void test_xchg(void)
>       TEST_XCHG(xchgb, "b", "+q");
>
>   #if defined(__x86_64__)
> -    TEST_XCHG(xchgq, "", "=m");
> +    TEST_XCHG(xchgq, "", "+m");
>   #endif
>       TEST_XCHG(xchgl, "k", "+m");
>       TEST_XCHG(xchgw, "w", "+m");
> --
> 2.19.2

All QEMU patches has to go via the qemu-devel@nongnu.org list (you
only sent it to the trivial list).
I'm also Cc'ing the maintainers:

$ ./scripts/get_maintainer.pl -f tests/tcg/i386/test-i386.c
Paolo Bonzini <pbonzini@redhat.com> (maintainer:X86)
Richard Henderson <rth@twiddle.net> (maintainer:X86)
Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86)
qemu-devel@nongnu.org (open list:All patches CC here)

Regards,

Phil.
