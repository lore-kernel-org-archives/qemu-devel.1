Received: from eggs.gnu.org ([2001:4830:134:3::10]:46520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNzRk-00036s-8i
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNzRj-000299-Dh
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:34:44 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:34610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNzRj-00028v-6N
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:34:43 -0400
Received: by mail-wr0-x234.google.com with SMTP id 77so17414604wrb.1
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 03:34:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170619181839.25249-1-rth@twiddle.net>
References: <20170619181839.25249-1-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Jun 2017 11:34:21 +0100
Message-ID: <CAFEAcA9uCiEswdyt-eBtm-zfPMYtufUwr7KP+1g=Nr_JaqSiLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/12] TCG queued patches
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

On 19 June 2017 at 19:18, Richard Henderson <rth@twiddle.net> wrote:
> This contains Emilio's moving the TB struct into code_gen_buffer,
> my taking advantage of that in the aa64 and aa32 tcg backends,
> and the communal fixes for the goto_ptr hangs.
>
> I've droppped the target/mips goto_ptr patch from Paolo, as Aurelien
> has said he'd come up with a more complete fix.
>
> I've dropped the "-accel tcg,thread=*" fix as it is apparently also
> in Paolo's misc patches tree.
>
>
> r~
>
>
> The following changes since commit cef8fd68364ad754d4f0050a215376cdf0ec744a:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/pull-usb-20170614-1' into staging (2017-06-19 17:54:30 +0100)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-tcg-20170619
>
> for you to fetch changes up to 8da54b2507c1cabf60c2de904cf0383b23239231:
>
>   target/arm: Exit after clearing aarch64 interrupt mask (2017-06-19 11:11:26 -0700)
>
> ----------------------------------------------------------------
> Queued TCG patches
>

Applied, thanks.

-- PMM
