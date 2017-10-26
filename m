Received: from eggs.gnu.org ([2001:4830:134:3::10]:56426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e7bKU-0000hA-4U
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 02:07:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e7bKT-0001Zq-29
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 02:07:46 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:50863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e7bKS-0001Zf-Pk
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 02:07:44 -0400
Received: by mail-wm0-x22a.google.com with SMTP id s66so554757wmf.5
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 23:07:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171025123056.3165-1-richard.henderson@linaro.org>
References: <20171025123056.3165-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Oct 2017 07:07:23 +0100
Message-ID: <CAFEAcA99zpvcgk2EuXkrcOY+8rHeRkJhH4GqViJkEgQV3bdWFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/11] Disassembler patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 25 October 2017 at 13:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Support for Capstone, plus an arm32 fix.
>
>
> r~
>
>
> The following changes since commit 3d7196d43bfe12efe98568cb60057e273652b99b:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20171023-pull-request' into staging (2017-10-24 16:05:57 +0100)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-dis-20171025
>
> for you to fetch changes up to 383b90bc6a15f4b18ec34f9c0287b26f9a89fcb8:
>
>   disas: Add capstone as submodule (2017-10-25 11:55:21 +0200)
>
> ----------------------------------------------------------------
> Capstone disassembler


Hi. This failed to build for Windows:

make[1]: *** No rule to make target
'/home/petmay01/linaro/qemu-for-merges/build/w32-new/capstone/libcapstone.a'.
Stop.
Makefile:399: recipe for target 'subdir-capstone' failed

FreeBSD ar also prints a warning:
  AR      libcapstone.a
ar: warning: creating /root/qemu/build/all/capstone/libcapstone.a

though the build otherwise succeeds. Is it possible to silence this?
(Otherwise it shows up in my build output scripts; I could silence it
there but it would be neater if it just wasn't emitted.)

thanks
-- PMM
