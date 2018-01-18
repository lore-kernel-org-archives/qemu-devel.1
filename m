Received: from eggs.gnu.org ([2001:4830:134:3::10]:58988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecDOE-0006HQ-6N
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:50:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ecDOD-00050A-Dt
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:50:10 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:37035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ecDOD-0004zy-8t
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:50:09 -0500
Received: by mail-ot0-x243.google.com with SMTP id a24so20652467otd.4
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 08:50:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180118022625.6462-1-eblake@redhat.com>
References: <20180118022625.6462-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jan 2018 16:49:48 +0000
Message-ID: <CAFEAcA-Eai2JWbe79xrrVCBLGdLASdaWBoSW5LKjMz5TkVJxrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/6] NBD patches through 17 Jan
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

On 18 January 2018 at 02:26, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit 8e5dc9ba49743b46d955ec7dacb04e42ae7ada7c:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180116' into staging (2018-01-16 17:36:39 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-01-17
>
> for you to fetch changes up to 1d17922a28f5b9a8adcea3c93f49086e0a751e86:
>
>   nbd/server: structurize option reply sending (2018-01-17 20:14:12 -0600)
>
> I'm still waiting for v3 of Vladimir's "0/6 nbd export qmp interface",
> but it's been a week since my last pull, so it's worth flushing the queue.
>
> ----------------------------------------------------------------
> pull-nbd-2018-01-17
>
> - Vladimir Sementsov-Ogievskiy/Eric Blake: 0/6 NBD server refactoring
>
> ----------------------------------------------------------------
> Eric Blake (4):
>       nbd/server: Hoist nbd_reject_length() earlier
>       nbd/server: Better error for NBD_OPT_EXPORT_NAME failure
>       nbd/server: Add va_list form of nbd_negotiate_send_rep_err()
>       nbd/server: Add helper functions for parsing option payload
>
> Vladimir Sementsov-Ogievskiy (2):
>       nbd/server: refactor negotiation functions parameters
>       nbd/server: structurize option reply sending

Applied, thanks.

-- PMM
