Received: from eggs.gnu.org ([2001:4830:134:3::10]:33610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eD5Qq-00081J-8E
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 04:17:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eD5Qp-0008Bc-D3
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 04:17:00 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20171004152553.30263-1-mreitz@redhat.com>
Date: Fri, 10 Nov 2017 10:16:52 +0100
In-Reply-To: <20171004152553.30263-1-mreitz@redhat.com> (Max Reitz's message
	of "Wed, 4 Oct 2017 17:25:47 +0200")
Message-ID: <87zi7u4hob.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 0/6] block: Don't compare strings in
 bdrv_reopen_prepare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

Max Reitz <mreitz@redhat.com> writes:

> bdrv_reopen_prepare() assumes that all BDS options are strings, which is
> not necessarily correct. This series introduces a new qobject_is_equal()
> function which can be used to test whether any options have changed,
> independently of their type.

Series looks ready to me.  It touches QAPI to achieve its purpose in the
block layer; I'd be fine with merging it via a block tree.
