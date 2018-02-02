Received: from eggs.gnu.org ([2001:4830:134:3::10]:60293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ehf5V-000885-CZ
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 12:26:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ehf4Q-0005vo-71
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 12:25:20 -0500
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:38130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ehf4P-0005uw-Ig
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 12:24:13 -0500
Received: by mail-ot0-x232.google.com with SMTP id v5so21003695oth.5
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 09:24:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180202161935.20803-1-groug@kaod.org>
References: <20180202161935.20803-1-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Feb 2018 17:23:52 +0000
Message-ID: <CAFEAcA-S+tLjgFJqS7pp93u0BfW9bJ=H4Lt=ymGk4Ze-Cyf-3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/10] 9p patches for 2.12 20180202
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2 February 2018 at 16:19, Greg Kurz <groug@kaod.org> wrote:
> The following changes since commit b05631954d6dfe93340d516660397e2c1a2a5dd6:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-hppa-20180131' into staging (2018-01-31 15:50:29 +0000)
>
> are available in the git repository at:
>
>   https://github.com/gkurz/qemu.git tags/for-upstream
>
> for you to fetch changes up to 9ea776ee7d4061c043d0fbf89aa85f86ec0cf8a2:
>
>   tests/virtio-9p: explicitly handle potential integer overflows (2018-02-02 11:15:34 +0100)
>
> ----------------------------------------------------------------
> This series is mostly about 9p request cancellation. It fixes a
> long standing bug (read "specification violation") where the server
> would send an invalid response when the client has cancelled an
> in-flight request. This was causing annoying spurious EINTR returns
> in linux. The fix comes with some related testing in QTEST.
>
> Other patches are code cleanup and improvements.
>
> v2: fix the alignment issue that was presumably causing make check to
>     fail on sparc hosts
>

Applied, thanks.

-- PMM
