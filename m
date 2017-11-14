Received: from eggs.gnu.org ([2001:4830:134:3::10]:50533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eEbrt-0006oY-79
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:07:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eEbrp-0007OV-Cj
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:07:13 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171110221329.24176-3-mreitz@redhat.com>
References: <20171110221329.24176-1-mreitz@redhat.com>
	<20171110221329.24176-3-mreitz@redhat.com>
Date: Tue, 14 Nov 2017 15:06:23 +0100
Message-ID: <w51a7zp0xb4.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.12 2/3] block: Handle
 null backing link
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

On Fri 10 Nov 2017 11:13:28 PM CET, Max Reitz wrote:
> Instead of converting all "backing": null instances into "backing": "",
> handle a null value directly in bdrv_open_inherit().
>
> This enables explicitly null backing links for json:{} filenames.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
