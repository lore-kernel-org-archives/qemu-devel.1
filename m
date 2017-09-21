Received: from eggs.gnu.org ([2001:4830:134:3::10]:33950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1duzvh-0003De-8a
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 07:46:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1duzvg-0008Ji-E0
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 07:46:05 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170916185123.29255-2-mreitz@redhat.com>
References: <20170916185123.29255-1-mreitz@redhat.com>
	<20170916185123.29255-2-mreitz@redhat.com>
Date: Thu, 21 Sep 2017 13:45:16 +0200
Message-ID: <w51mv5o6zsj.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 1/6] qapi/qnull: Add own
 header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On Sat 16 Sep 2017 08:51:18 PM CEST, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  include/qapi/qmp/qdict.h    |  1 +
>  include/qapi/qmp/qnull.h    | 30 ++++++++++++++++++++++++++++++
>  include/qapi/qmp/qobject.h  | 12 ------------
>  include/qapi/qmp/types.h    |  1 +
>  qapi/qapi-clone-visitor.c   |  1 +
>  qapi/string-input-visitor.c |  1 +
>  qobject/qnull.c             |  2 +-
>  tests/check-qnull.c         |  2 +-
>  8 files changed, 36 insertions(+), 14 deletions(-)
>  create mode 100644 include/qapi/qmp/qnull.h

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
