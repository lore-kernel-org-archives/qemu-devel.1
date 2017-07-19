Received: from eggs.gnu.org ([2001:4830:134:3::10]:54854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXtqV-0007O5-1x
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 14:37:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXtqT-0006vY-7x
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 14:37:15 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:35693)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dXtqT-0006uh-1h
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 14:37:13 -0400
Received: by mail-wm0-x22d.google.com with SMTP id w126so6343305wme.0
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 11:37:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170719044522.21114-1-rth@twiddle.net>
References: <20170719044522.21114-1-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Jul 2017 19:36:51 +0100
Message-ID: <CAFEAcA8DxAD=hBVJDxtDTHRwU19894Mk6NAoqzbNuehgzf+izw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] target/alpha cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 July 2017 at 05:45, Richard Henderson <rth@twiddle.net> wrote:
> The new title holder for perf top is helper_lookup_tb_ptr.
> Those targets that have a complicated cpu_get_tb_cpu_state
> function are going to regret that.
>
> This cleans up the Alpha version of that function such that it is
> just two loads and one mask.  Which is one practically-free mask
> away from being as minimal as one can get.
>
> Also, in anticipation of LLuis' generic translation loop, fix all
> of the temporary leaks.  They all seem to have been on insns that
> end the TB, so in practice they weren't harmful, but...
>
>
> r~
>
>
> The following changes since commit 6887dc6700ccb7820d8a9d370f421ee361c748e8:
>
>   Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20170718' into staging (2017-07-18 21:13:48 +0100)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-axp-20170718
>
> for you to fetch changes up to 8aa5c65fd3d4612d8ab690bef0980d26f30f381d:
>
>   target/alpha: Log temp leaks (2017-07-18 18:42:05 -1000)
>
> ----------------------------------------------------------------
> Queued target/alpha patches
>

Applied, thanks.

-- PMM
