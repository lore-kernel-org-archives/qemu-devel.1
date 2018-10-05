Received: from eggs.gnu.org ([2001:4830:134:3::10]:44169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8RfE-0001tv-63
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:05:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8RfB-0004NB-Tc
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:05:12 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g8RfB-0004LB-Ex
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:05:09 -0400
Received: by mail-oi1-x242.google.com with SMTP id w81-v6so10623290oiw.9
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 08:05:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181004143328.955729-1-eblake@redhat.com>
References: <20181004143328.955729-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Oct 2018 16:04:46 +0100
Message-ID: <CAFEAcA9WursRmSQ4MEcqNX7-vYHzg6e2YRW-DCdcqZL0fZ_G-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/6] NBD patches through 2018-10-03
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

On 4 October 2018 at 15:33, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit dafd95053611aa14dda40266857608d12ddce658:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-10-02 18:27:18 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-10-03-v2
>
> for you to fetch changes up to df91328adab8490367776d2b21b35d790a606120:
>
>   nbd: fix NBD_FLAG_SEND_CACHE value (2018-10-04 09:08:56 -0500)
>
> Since v1 pull request:
> - add one more patch for another NBD_CMD_CACHE bug
> (only sending the new content in the v2 thread)
>
> ----------------------------------------------------------------
> nbd patches for 2018-10-03
>
> Fix bugs in NBD_CMD_CACHE, drop support for oldstyle NBD server,
> minor build and doc fixes
>
> - Denis V. Lunev: nbd: fix NBD_CMD_CACHE negitiation... [retitled]
> - Vladimir Sementsov-Ogievskiy: 0/2 server: drop old-style negotiation
> - Eric Blake: qemu-nbd: Document --tls-creds
> - Vladimir Sementsov-Ogievskiy: nbd/server: fix NBD_CMD_CACHE
> - Peter Maydell: nbd: Don't take address of fields in packed structs
>
Applied, thanks.

-- PMM
