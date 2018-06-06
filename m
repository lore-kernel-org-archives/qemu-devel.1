Received: from eggs.gnu.org ([2001:4830:134:3::10]:53878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQZg1-0002kQ-SH
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQZg0-00082x-PS
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:44:41 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180509165530.29561-1-mreitz@redhat.com>
	<20180509165530.29561-7-mreitz@redhat.com>
	<87po14836b.fsf@dusky.pond.sub.org>
	<87fu2080ag.fsf@dusky.pond.sub.org>
Date: Wed, 06 Jun 2018 16:35:19 +0200
In-Reply-To: <87fu2080ag.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Wed, 06 Jun 2018 16:19:51 +0200")
Message-ID: <878t7s7zko.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 06/13] block: Add block-specific QDict
 header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Markus Armbruster <armbru@redhat.com> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> MAINTAINERS files include/block/qdict.h under "Block layer core".  Let's
>> split qobject/qdict.c as well, so it's there, too.  Obvious patch
>> appended.  Feel free to squash it into yours without giving me credit
>> for it.
>
> Hmm, we should split tests/check-qdict.c for the same reason.  Updated
> patch appended.
>
>> PS: I tried to move block-qdict.c to block/, but totally failed at
>> persuading Make to link it into all programs that need it.  Oh well.
>
>
> From bdb7f6581a3066db853bca6c81cc2c42f6cec8e9 Mon Sep 17 00:00:00 2001
> From: Markus Armbruster <armbru@redhat.com>
> Date: Wed, 6 Jun 2018 15:11:54 +0200
> Subject: [PATCH] qobject: Move block-specific qdict code to block-qdict.c
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  MAINTAINERS               |   1 +
>  qobject/Makefile.objs     |   1 +
>  qobject/block-qdict.c     | 637 ++++++++++++++++++++++++++++++++++++
>  qobject/qdict.c           | 629 ------------------------------------
>  tests/Makefile.include    |   4 +
>  tests/check-block-qdict.c | 657 ++++++++++++++++++++++++++++++++++++++
>  tests/check-qdict.c       | 642 -------------------------------------
>  7 files changed, 1300 insertions(+), 1271 deletions(-)
>  create mode 100644 qobject/block-qdict.c
>  create mode 100644 tests/check-block-qdict.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 41cd3736a9..9f9835e052 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1365,6 +1365,7 @@ F: qemu-img*
>  F: qemu-io*
>  F: tests/qemu-iotests/
>  F: util/qemu-progress.c
> +F: qobject/block-qdict.c
>  T: git git://repo.or.cz/qemu/kevin.git block
>  
>  Block I/O path

Forgot to update MAINTAINERS for tests/check-block-qdict.c.  Fixup:

diff --git a/MAINTAINERS b/MAINTAINERS
index 9f9835e052..21f4bc1806 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1366,6 +1366,7 @@ F: qemu-io*
 F: tests/qemu-iotests/
 F: util/qemu-progress.c
 F: qobject/block-qdict.c
+F: test/check-block-qdict.c
 T: git git://repo.or.cz/qemu/kevin.git block
 
 Block I/O path

[...]
