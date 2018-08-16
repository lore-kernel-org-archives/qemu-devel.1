Received: from eggs.gnu.org ([2001:4830:134:3::10]:53625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqDzl-0002ek-PW
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqDzi-0004Ws-3I
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:51:04 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:41205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqDzh-0004V9-Hk
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 04:51:01 -0400
Received: by mail-oi0-x236.google.com with SMTP id k12-v6so6689509oiw.8
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 01:50:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180815125537.10651-1-kwolf@redhat.com>
References: <20180815125537.10651-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 09:50:37 +0100
Message-ID: <CAFEAcA-vOac_u5q86fmzLuy9UYPnqB2ZinYtTbt9AWrQd1URvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/21] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 15 August 2018 at 13:55, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit 38441756b70eec5807b5f60dad11a93a91199866:
>
>   Update version for v3.0.0 release (2018-08-14 16:38:43 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to b5fc2d306664c0c1c6c5cf8e164ffa7b8892283e:
>
>   qapi: block: Remove mentions of error types which were removed (2018-08-15 12:50:39 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - Remove deprecated -drive options for geometry/serial/addr
> - luks: Allow shared writers if the parents allow them (share-rw=on)
> - qemu-img: Fix error when trying to convert to encrypted target image
> - mirror: Fail gracefully for source == target
> - I/O throttling: Fix behaviour during drain (always ignore the limits)
> - bdrv_reopen() related fixes for bs->options/explicit_options content
> - Documentation improvements
>

Applied, thanks.

-- PMM
