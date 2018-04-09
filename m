Received: from eggs.gnu.org ([2001:4830:134:3::10]:40273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5Syn-0003Ok-0U
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5Sym-0003BN-4Y
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:20:48 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:46516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f5Syl-0003AK-Uj
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:20:48 -0400
Received: by mail-oi0-x243.google.com with SMTP id e123-v6so6907738oih.13
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 02:20:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
References: <1523034681-33787-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Apr 2018 10:20:26 +0100
Message-ID: <CAFEAcA87K832wY7t_17CBEYb2p7rso_4XES08yo_C=rSt37VBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/20] Miscellaneous patches for QEMU 2.12-rc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 April 2018 at 18:11, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 0e87fdc966d05f4e5ad868034fcd8ee2a08ca62d:
>
>   Update version for v2.12.0-rc2 release (2018-04-04 20:37:20 +0100)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 0af74e1178c1f4ba495b499b2ba2a8c7c453b72a:
>
>   Add missing bit for SSE instr in VEX decoding (2018-04-06 18:42:49 +0200)
>
> ----------------------------------------------------------------
> Miscellaneous bugfixes, including crash fixes from Alexey, Peter M. and
> Thomas.
>
> ----------------------------------------------------------------

This fails to compile on OSX and the BSDs:
/Users/pm215/src/qemu-for-merges/util/memfd.c:208:19: error: implicit
declaration of function 'memfd_create' is invalid in C99
[-Werror,-Wimplicit-function-declaration]
        int mfd = memfd_create("test", 0);
                  ^


I also got
TEST: tests/boot-serial-test... (pid=15159)
  /sparc64/boot-serial/sun4u:                                          **
ERROR:/home/petmay01/linaro/qemu-for-merges/tests/boot-serial-test.c:139:check_guest_output:
assertion failed: (output_ok)
FAIL

on an x86-64/linux host, but I have a feeling that's one of
our intermittents rather than anything in this patch.

thanks
-- PMM
