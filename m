Received: from eggs.gnu.org ([2001:4830:134:3::10]:60280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYwla-0007Q5-5X
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:28:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYwlZ-0001qE-0r
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:28:46 -0500
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:43831)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYwlY-0001pR-Ro
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:28:44 -0500
Received: by mail-oi0-x230.google.com with SMTP id t16so5644240oif.10
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 08:28:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180108153137.5195-1-eblake@redhat.com>
References: <20180108153137.5195-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jan 2018 16:28:23 +0000
Message-ID: <CAFEAcA_OF3VfavtQAvLHx3uisx5960JVK1XgdmiPNisBF56jNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] NBD patches through 2018-01-08
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

On 8 January 2018 at 15:31, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit 799044b6a3a0fc63e1e020e4d9266786a2dc7a0b:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2018-01-08 13:44:01 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-01-08
>
> for you to fetch changes up to c4365735a7d38f4355c6f77e6670d3972315f7c2:
>
>   block/nbd: fix segmentation fault when .desc is not null-terminated (2018-01-08 09:12:23 -0600)
>
> Careful readers may note that I'm abondoning my earlier pull
> request from 20 Dec:
> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg04517.html
> This pull request includes the first two patches from that one,
> but the second half of that request has a v2 posted by Vladimir,
> which I'm letting bake a bit longer rather than including today.
>
> ----------------------------------------------------------------
> nbd patches for 2018-01-08
>
> - Eric Blake: 0/2 Optimize sparse reads over NBD
> - Murilo Opsfelder Araujo: block/nbd: fix segmentation fault when .desc is not null-terminated
>
> ----------------------------------------------------------------
> Eric Blake (2):
>       nbd/server: Implement sparse reads atop structured reply
>       nbd/server: Optimize final chunk of sparse read
>
> Murilo Opsfelder Araujo (1):
>       block/nbd: fix segmentation fault when .desc is not null-terminated

Applied, thanks.

-- PMM
