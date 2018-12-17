Received: from eggs.gnu.org ([2001:4830:134:3::10]:52232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gZ2jF-00048J-In
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:55:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gZ2Zm-0002Ii-Ij
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:45:31 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:34705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gZ2Zm-0002I9-CP
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:45:30 -0500
Received: by mail-oi1-x234.google.com with SMTP id h25so539362oig.1
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 15:45:30 -0800 (PST)
MIME-Version: 1.0
References: <20181217033501.18073-1-richard.henderson@linaro.org>
In-Reply-To: <20181217033501.18073-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Dec 2018 23:45:18 +0000
Message-ID: <CAFEAcA_6vbgXcZ-7FQGRc+iVCiz+pWx2zBvdaK3nhTtAk_s1eg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/33] tcg patch queue
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

On Mon, 17 Dec 2018 at 03:35, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Now include a patch to address
>
> qemu-system-x86_64: /home/pm215/qemu/tcg/sparc/tcg-target.inc.c:319:
> patch_reloc: Assertion `check_fit_ptr(value, 13)' failed.
>
> I believe it was the change to bswap64 to use the constant pool more
> often that exposed the latent problem.
>
> Only re-posting the new patch.
>
>
> r~
>
>
> The following changes since commit 58b1f0f21edcab13f78a376b1d90267626be1275:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2018-12-16 12:49:06 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20181216
>
> for you to fetch changes up to b7c2cd08a6f68010ad27c9c0bf2fde02fb743a0e:
>
>   xxhash: match output against the original xxhash32 (2018-12-17 06:04:44 +0300)
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
