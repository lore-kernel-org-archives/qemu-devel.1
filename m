Received: from eggs.gnu.org ([2001:4830:134:3::10]:49746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7gu4-0001DL-B3
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:32:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7gu1-0001tn-7o
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:32:36 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:32929)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d7gu1-0001sj-15
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:32:33 -0400
Received: by mail-wr0-x234.google.com with SMTP id w50so41090155wrc.0
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 04:32:32 -0700 (PDT)
References: <20170426105027.10666-1-n54@gmx.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170426105027.10666-1-n54@gmx.com>
Date: Mon, 08 May 2017 12:33:15 +0100
Message-ID: <87shkf8txg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] configure: Detect native NetBSD curses(3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Kamil Rytarowski <n54@gmx.com> writes:

> NetBSD ships with traditional BSD curses with compatibility with ncurses.
> qemu works nicely with the basesystem version of curses(3) from NetBSD.
>
> The only mismatch between curses(3) and ncurses is the lack of
> curses_version() in the NetBSD version. This function is used solely in
> the configure script, therefore eliminate it from the curses(3) detection.
>
> With this change applied, configure detects correctly curses frontend.
>
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  configure | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/configure b/configure
> index c35acf1192..17dc7224f7 100755
> --- a/configure
> +++ b/configure
> @@ -3034,14 +3034,13 @@ if test "$curses" != "no" ; then
>  #include <curses.h>
>  #include <wchar.h>
>  int main(void) {
> -  const char *s = curses_version();
>    wchar_t wch = L'w';
>    setlocale(LC_ALL, "");
>    resize_term(0, 0);
>    addwstr(L"wide chars\n");
>    addnwstr(&wch, 1);
>    add_wch(WACS_DEGREE);
> -  return s != 0;
> +  return 0;
>  }
>  EOF
>    IFS=:


--
Alex Bennée
