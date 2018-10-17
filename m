Received: from eggs.gnu.org ([2001:4830:134:3::10]:49682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCffj-0007mg-Hr
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 02:51:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCffi-0004tt-Qa
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 02:51:11 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181015172817.19796-1-mreitz@redhat.com>
	<20181015172817.19796-2-mreitz@redhat.com>
Date: Wed, 17 Oct 2018 08:50:57 +0200
In-Reply-To: <20181015172817.19796-2-mreitz@redhat.com> (Max Reitz's message
	of "Mon, 15 Oct 2018 19:28:13 +0200")
Message-ID: <8736t5nk1a.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/5] option: Make option help nicer to read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Max Reitz <mreitz@redhat.com> writes:

> This adds some whitespace into the option help (including indentation)
> and replaces '=' by ': ' (not least because '=' should be used for
> values, not types).  Furthermore, the list name is no longer printed as
> part of every line, but only once in advance, and only if the caller did
> not print a caption already.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  include/qemu/option.h      |   2 +-
>  qemu-img.c                 |   4 +-
>  util/qemu-option.c         |  31 +-
>  tests/qemu-iotests/082.out | 956 ++++++++++++++++++-------------------
>  4 files changed, 505 insertions(+), 488 deletions(-)

082 fails for me in master (dddb37495b8).  If this patch fixes the
failure, its commit message should mention it.

091 and 142 also fail, but look unrelated.
