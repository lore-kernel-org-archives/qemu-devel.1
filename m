Received: from eggs.gnu.org ([2001:4830:134:3::10]:34724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dHql9-0006lA-Kf
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dHql8-0006oq-Fh
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:05:23 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:38583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dHql8-0006no-8P
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:05:22 -0400
Received: by mail-wm0-x231.google.com with SMTP id n195so73988392wmg.1
	for <qemu-devel@nongnu.org>; Mon, 05 Jun 2017 05:05:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
References: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Jun 2017 13:05:00 +0100
Message-ID: <CAFEAcA-ZWhrFHqoEGuvsigTYRvQcXTOOD3UnhtxhBSFZQJHWTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/22] Trivial patches for 2017-06-04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 4 June 2017 at 16:45, Michael Tokarev <mjt@tls.msk.ru> wrote:
> Trivial patches for 04 Jun 2017. Please consider applying.
>
> /mjt
>
> The following changes since commit c6e84fbd447a51e1161d74d71566a5f67b47eac5:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-06-02 17:46:22 +0100)
>
> are available in the git repository at:
>
>   git://git.corpit.ru/qemu.git tags/trivial-patches-fetch
>
> for you to fetch changes up to 070ccceda3b23f85d048bbcf3c0040252a9a793a:
>
>   hw/core: nmi.c can be compiled as common-obj nowadays (2017-06-04 18:43:09 +0300)
>
> ----------------------------------------------------------------
> trivial patches for 2017-06-04
>
> ----------------------------------------------------------------

Hi. I'm afraid this doesn't build in the all-linux-static config
(configure '--cc=ccache gcc' '--enable-debug' '--static' '--disable-system'):

$ make -C build/all-linux-static/ V=1
make: Entering directory
'/home/petmay01/linaro/qemu-for-merges/build/all-linux-static'
(cd /home/petmay01/linaro/qemu-for-merges; printf '#define
QEMU_PKGVERSION '; if test -n ""; then printf '""\n'; else if test -d
.git; then printf '" ('; git describe --match 'v*' 2>/dev/null | tr -d
'\n'; if ! git diff-index --quiet HEAD &>/dev/null; then printf --
'-dirty'; fi; printf ')"\n'; else printf '""\n'; fi; fi) >
qemu-version.h.tmp
if ! cmp -s qemu-version.h qemu-version.h.tmp; then mv
qemu-version.h.tmp qemu-version.h; else rm qemu-version.h.tmp; fi
c++ -I/usr/include/pixman-1  -Werror -pthread -I/usr/include/glib-2.0
-I/usr/lib/x86_64-linux-gnu/glib-2.0/include -D_GNU_SOURCE
-I/usr/include/ncursesw -m64 -mcx16 -D_GNU_SOURCE
-D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes
-Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes
-fno-strict-aliasing -fno-common -fwrapv  -Wendif-labels
-Wno-missing-include-dirs -Wempty-body -Wnested-externs
-Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
-Wold-style-declaration -Wold-style-definition -Wtype-limits
-fstack-protector-strong    -I/usr/include/libpng12
-I/usr/include/libusb-1.0
-I/home/petmay01/linaro/qemu-for-merges/tests -g  -Wl,--warn-common
-m64 -static -g  -o ivshmem-client   libqemuutil.a libqemustub.a   -lm
-lgthread-2.0 -pthread -lglib-2.0 -pthread -lpcre -pthread  -lz -lrt
-lz -lcap-ng -lvdeplug -lnettle  -lutil
/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/crt1.o: In
function `_start':
(.text+0x20): undefined reference to `main'
collect2: error: ld returned 1 exit status
Makefile:473: recipe for target 'ivshmem-client' failed

Looks like the makefile is trying to build ivshmem-client even though
it has no .o files in the link line. Similarly for ivshmem-server.

thanks
-- PMM
