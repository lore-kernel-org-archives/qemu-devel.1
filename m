Received: from eggs.gnu.org ([2001:4830:134:3::10]:57626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fufDI-0003U8-Jv
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 10:43:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fufDH-00070m-P1
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 10:43:24 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180809213528.14738-22-mreitz@redhat.com>
References: <20180809213528.14738-1-mreitz@redhat.com>
	<20180809213528.14738-22-mreitz@redhat.com>
Date: Tue, 28 Aug 2018 16:43:11 +0200
Message-ID: <w51va7ur1q8.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.1 v10 21/31] block: Add
 strong_runtime_opts to BlockDriver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On Thu 09 Aug 2018 11:35:18 PM CEST, Max Reitz wrote:
> This new field can be set by block drivers to list the runtime options
> they accept that may influence the contents of the respective BDS. As of
> a follow-up patch, this list will be used by the common
> bdrv_refresh_filename() implementation to decide which options to put
> into BDS.full_open_options (and consequently whether a JSON filename has
> to be created), thus freeing the drivers of having to implement that
> logic themselves.
>
> Additionally, this patch adds the field to all of the block drivers that
> need it and sets it accordingly.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
