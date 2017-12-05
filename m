Received: from eggs.gnu.org ([2001:4830:134:3::10]:40437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eMCyp-00066h-Dh
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:09:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eMCyo-0005Vq-DS
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:09:47 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171120201004.14999-24-mreitz@redhat.com>
References: <20171120201004.14999-1-mreitz@redhat.com>
	<20171120201004.14999-24-mreitz@redhat.com>
Date: Tue, 05 Dec 2017 14:09:36 +0100
Message-ID: <w514lp5723z.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 for-2.12 23/25] block: Fix FIXME from
 "Add BDS.backing_overridden"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

On Mon 20 Nov 2017 09:10:02 PM CET, Max Reitz wrote:
> Said commit introduced a FIXME stating that bdrv_open_backing_file()
> should set bs->backing_overridden to true not only if the file.filename
> option was set, but if the "options" QDict contained any option that is
> significant for any node in the BDS tree emerging from the backing BDS.
> This behavior is implemented by this patch.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
