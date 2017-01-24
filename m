Received: from eggs.gnu.org ([2001:4830:134:3::10]:35861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cVz7N-0000ka-JQ
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:18:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cVz7M-0005nG-Jp
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:18:29 -0500
Received: from mail-vk0-x22a.google.com ([2607:f8b0:400c:c05::22a]:34438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cVz7M-0005n0-F5
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:18:28 -0500
Received: by mail-vk0-x22a.google.com with SMTP id r136so109682386vke.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 03:18:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170121084600.5860-2-ale+qemu@clearmind.me>
References: <20170121084600.5860-1-ale+qemu@clearmind.me>
	<20170121084600.5860-2-ale+qemu@clearmind.me>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jan 2017 11:18:07 +0000
Message-ID: <CAFEAcA-52cjhLWWVGQ0qPeF3uKA67-ZBk=EQT2ARL1tjATWMkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] Factor out {linux, bsd}-user/qemu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alessandro Di Federico <ale+qemu@clearmind.me>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 January 2017 at 08:45, Alessandro Di Federico
<ale+qemu@clearmind.me> wrote:
> A quite large part of {linux,bsd}-user/qemu.h is shared, this patch
> introduces qemu-user-common.h which factors it out. This shared part is
> also the bare minimum required to build a linux-user-like target, and,
> in particular, it will be useful for the libtcg targets.
> ---
>  bsd-user/qemu.h    | 193 +----------------------------------------------------
>  linux-user/qemu.h  | 176 +-----------------------------------------------
>  qemu-user-common.h | 180 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 182 insertions(+), 367 deletions(-)
>  create mode 100644 qemu-user-common.h

So my issue with this is that currently linux-user is pretty
well maintained and tested, but bsd-user is basically unmaintained
and not even compile tested. So it's convenient to have bsd-user
code be basically its own distinct standalone thing, because
then when we fix linux-user we don't have to care too much
about whether bsd-user might be accidentally broken by our
changes.

If we had more active testing of bsd-user I'd be a bit keener
about removing some of the code duplication.

thanks
-- PMM
