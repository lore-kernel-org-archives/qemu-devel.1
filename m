Received: from eggs.gnu.org ([209.51.188.92]:56765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBBz4-0005OL-IC
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 01:29:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBBz3-00035F-FN
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 01:29:18 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:37859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hBBz3-000353-7A
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 01:29:17 -0400
Received: by mail-oi1-x235.google.com with SMTP id v84so9422669oif.4
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 22:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190401140903.19186-1-eblake@redhat.com>
In-Reply-To: <20190401140903.19186-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Apr 2019 05:29:05 +0000
Message-ID: <CAFEAcA-bLOJBKzborVxwyxGR8Mpy9ODZh3crL2241j6Rhp8DZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/14] NBD patches for 4.0-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, 1 Apr 2019 at 21:14, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit 230ce19814ecc6bff8edac3b5b86e7c82f422c6c:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-axp-20190325' into staging (2019-03-29 19:29:00 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-04-01
>
> for you to fetch changes up to 75d34eb98ca0bb2f49d607fcaefd9c482e56b15d:
>
>   nbd/client: Trace server noncompliance on structured reads (2019-04-01 08:58:04 -0500)
>
> ----------------------------------------------------------------
> nbd patches for 2019-04-01
>
> - Better behavior of qemu-img map on NBD images
> - Fixes for NBD protocol alignment corner cases:
>  - the server has fewer places where it sends reads or block status
>    not aligned to its advertised block size
>  - the client has more cases where it can work around server
>    non-compliance present in qemu 3.1
>  - the client now avoids non-compliant requests when interoperating
>    with nbdkit or other servers not advertising block size

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
