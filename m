Received: from eggs.gnu.org ([2001:4830:134:3::10]:46596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ehFgj-00062R-PB
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:18:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ehFge-00083q-3V
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:18:05 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180120154412.9990-6-mreitz@redhat.com>
References: <20180120154412.9990-1-mreitz@redhat.com>
	<20180120154412.9990-6-mreitz@redhat.com>
Date: Thu, 01 Feb 2018 15:17:46 +0100
Message-ID: <w51lggc6bg5.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 5/6] block: Handle null backing link
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Sat 20 Jan 2018 04:44:11 PM CET, Max Reitz wrote:
> Instead of converting all "backing": null instances into "backing": "",
> handle a null value directly in bdrv_open_inherit().
>
> This enables explicitly null backing links for json:{} filenames.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
