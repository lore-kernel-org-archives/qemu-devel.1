Received: from eggs.gnu.org ([2001:4830:134:3::10]:52671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhcYf-0006Xu-1a
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 11:15:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhcYd-0002ci-SU
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 11:15:32 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:36990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fhcYd-0002cF-Ao
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 11:15:31 -0400
Received: by mail-oi0-x243.google.com with SMTP id k81-v6so1759440oib.4
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 08:15:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180723131356.27466-1-armbru@redhat.com>
References: <20180723131356.27466-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jul 2018 16:15:10 +0100
Message-ID: <CAFEAcA_WL0C6Z7OgNneufOJu69wvYzdsDewVcfKVe-vG3t2pGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] QAPI and monitor patches for 2018-07-23
 (3.0.0-rc2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23 July 2018 at 14:13, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit 6598f0cdad6acc6674c4f060fa46e537228c2c47:
>
>   po: Don't include comments with location (2018-07-23 10:50:54 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2018-07-23
>
> for you to fetch changes up to 62aa1d887ff9fc76adb488d31447d126a78f4b8f:
>
>   monitor: Fix unsafe sharing of @cur_mon among threads (2018-07-23 14:00:03 +0200)
>
> ----------------------------------------------------------------
> QAPI and monitor patches for 2018-07-23 (3.0.0-rc2)
>
> This pull request consists of a late external interface tweak and a
> thread safety fix, both related to QMP out-of-band execution.
>
> ----------------------------------------------------------------
> Markus Armbruster (1):
>       qapi: Make 'allow-oob' optional in SchemaInfoCommand
>
> Peter Xu (1):
>       monitor: Fix unsafe sharing of @cur_mon among threads
>
>  include/monitor/monitor.h  |  2 +-
>  monitor.c                  |  2 +-
>  qapi/introspect.json       |  6 +++---
>  scripts/qapi/introspect.py | 10 +++++-----
>  stubs/monitor.c            |  2 +-
>  tests/test-util-sockets.c  |  2 +-
>  6 files changed, 12 insertions(+), 12 deletions(-)

Applied, thanks.

> armbru@dusky:~/work/qemu$ rm *patch
> armbru@dusky:~/work/qemu$ git-format-patch --subject-prefix PULL master
> 0000-cover-letter.patch
> 0001-qapi-Make-allow-oob-optional-in-SchemaInfoCommand.patch
> 0002-monitor-Fix-unsafe-sharing-of-cur_mon-among-threads.patch

...stray cut-n-paste? :-)

-- PMM
