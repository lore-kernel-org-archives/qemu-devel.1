Received: from eggs.gnu.org ([2001:4830:134:3::10]:37590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWIpE-0001sa-D2
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 05:57:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWIpD-0005fe-Kg
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 05:57:52 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:34176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWIpD-0005eo-6I
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 05:57:51 -0400
Received: by mail-ot0-x244.google.com with SMTP id r18-v6so6903068otk.1
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 02:57:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621145749.191944-1-eblake@redhat.com>
References: <20180621145749.191944-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 10:57:29 +0100
Message-ID: <CAFEAcA_6aJ705HdAD6b4m3fsGBGa6gEQXet5dkgc5aELxeknBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/9] bitmap export over NBD
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

On 21 June 2018 at 15:57, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit 46012db666990ff2eed1d3dc199ab8006439a93b:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180619' into staging (2018-06-20 09:51:30 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-06-20-v2
>
> for you to fetch changes up to bc37b06a5cde24fb24c2a2cc44dd86756034ba9d:
>
>   nbd/server: introduce NBD_CMD_CACHE (2018-06-21 09:41:39 -0500)
>
> Only sending the new patches (2, 9) and the changed patch (6, was 5/7
> in v1)
>
> ----------------------------------------------------------------
> nbd patches for 2018-06-20
>
> Add experimental x-nbd-server-add-bitmap to expose a disabled
> bitmap over NBD, in preparation for a pull model incremental
> backup scheme. Also fix a corner case protocol issue with
> NBD_CMD_BLOCK_STATUS, and add new NBD_CMD_CACHE.
>
> - Eric Blake: tests: Simplify .gitignore
> - Eric Blake: nbd/server: Reject 0-length block status request
> - Vladimir Sementsov-Ogievskiy: 0/6 NBD export bitmaps
> - Vladimir Sementsov-Ogievskiy: nbd/server: introduce NBD_CMD_CACHE
>
Applied, thanks.

-- PMM
