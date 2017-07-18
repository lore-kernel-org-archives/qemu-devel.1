Received: from eggs.gnu.org ([2001:4830:134:3::10]:42859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXWJR-0004KB-Rg
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:29:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXWJQ-0004Oj-Sx
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:29:33 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:35192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dXWJQ-0004OO-Lk
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:29:32 -0400
Received: by mail-wr0-x234.google.com with SMTP id w4so37939824wrb.2
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 10:29:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170717212446.15268-1-rth@twiddle.net>
References: <20170717212446.15268-1-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jul 2017 18:29:10 +0100
Message-ID: <CAFEAcA_BqoX6q8DRD0jMjRWLDg9P+pY_B0NcvR9LTaeg7xo7ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/8] target/s390x tcg improvements
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

On 17 July 2017 at 22:24, Richard Henderson <rth@twiddle.net> wrote:
> Instructions implementing another missing facility,
> getting us a bit closer to being able to upgrade the
> default tcg cpu.
>
> Plus one bug fix for an existing instruction that
> isn't used unless we upgrade the tcg cpu.
>
> v2: Adjust the CSST patch to work when CONFIG_ATOMIC64
> is not defined, as seen with clang 3.8.
>
>
> r~
>
>
> The following changes since commit ca4e667dbf431d4a2a5a619cde79d30dd2ac3eb2:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20170717-pull-request' into staging (2017-07-17 17:54:17 +0100)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-s390-20170717
>
> for you to fetch changes up to dbdaaff43adc49f1debd935b1fd58e2b47ba7676:
>
>   target/s390x: Fix risbg handling (2017-07-17 14:13:17 -0700)
>
> ----------------------------------------------------------------
> Queued s390x tcg patches, v2
>

Applied, thanks.

-- PMM
