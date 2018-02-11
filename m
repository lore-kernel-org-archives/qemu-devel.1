Received: from eggs.gnu.org ([2001:4830:134:3::10]:37818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ekoGH-000193-4L
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:49:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ekoGG-0002xP-18
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:49:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44522 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ekoGF-0002wy-SB
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:49:27 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180211004013.10784-1-eblake@redhat.com>
	<20180211004013.10784-3-eblake@redhat.com>
Date: Sun, 11 Feb 2018 10:49:25 +0100
In-Reply-To: <20180211004013.10784-3-eblake@redhat.com> (Eric Blake's message
	of "Sat, 10 Feb 2018 18:40:12 -0600")
Message-ID: <87a7wfj1p6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/3] qapi: Rename QMP and QGA schema files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Eric Blake <eblake@redhat.com> writes:

> Having two files in the tree both named qapi-schema.json just adds
> confusion.  Rename these files, and relocate them into the common
> qapi/ subdirectory.  Update all build rules that refer to the file
> names, and adjust other documentation and comment references to
> either track the new name or be rewritten so as to not mention
> the file name.
>
> Maintainer-wise, this means that qapi/qga-schema.json continues
> to belong to Michael as QGA maintainer, but now also notifies
> Markus and Eric as QAPI maintainers, alongside all the other
> QMP QAPI files, matching how other .json QAPI modules belong
> to multiple maintainer blurbs.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  docs/devel/writing-qmp-commands.txt          | 13 ++++++-----
>  docs/interop/qmp-intro.txt                   |  3 ++-
>  Makefile                                     | 10 ++++----
>  qga/qapi-schema.json => qapi/qga-schema.json |  0

This move is up to the QGA maintainer.  My usual argument for keeping
the schema in one place is weak for the QGA schema: it's maintained
separately, and ususuall grepped separately, too.

>  qapi-schema.json => qapi/qmp-schema.json     | 34 ++++++++++++++--------------

While it was certainly created for QMP, it's now used for non-QMP stuff,
too.  Do we mind?

>  tpm.c                                        |  2 +-
>  MAINTAINERS                                  |  2 +-
>  7 files changed, 33 insertions(+), 31 deletions(-)
>  rename qga/qapi-schema.json => qapi/qga-schema.json (100%)
>  rename qapi-schema.json => qapi/qmp-schema.json (99%)
