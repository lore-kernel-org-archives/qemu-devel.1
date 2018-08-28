Received: from eggs.gnu.org ([2001:4830:134:3::10]:35877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fuctJ-0002RV-FH
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fuctD-0005Fw-NG
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:14:37 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180809213528.14738-2-mreitz@redhat.com>
References: <20180809213528.14738-1-mreitz@redhat.com>
	<20180809213528.14738-2-mreitz@redhat.com>
Date: Tue, 28 Aug 2018 14:13:41 +0200
Message-ID: <w51in3usn7u.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.1 v10 01/31] block: Use
 bdrv_refresh_filename() to pull
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

On Thu 09 Aug 2018 11:34:58 PM CEST, Max Reitz wrote:
> Before this patch, bdrv_refresh_filename() is used in a pushing manner:
> Whenever the BDS graph is modified, the parents of the modified edges
> are supposed to be updated (recursively upwards).  However, that is
> nonviable, considering that we want child changes not to concern
> parents.
>
> Also, in the long run we want a pull model anyway: Here, we would have a
> bdrv_filename() function which returns a BDS's filename, freshly
> constructed.
>
> This patch is an intermediate step.  It adds bdrv_refresh_filename()
> calls before every place a BDS.filename value is used.  The only
> exceptions are protocol drivers that use their own filename, which
> clearly would not profit from refreshing that filename before.
>
> Also, bdrv_get_encrypted_filename() is removed along the way (as a user
> of BDS.filename), since it is completely unused.
>
> In turn, all of the calls to bdrv_refresh_filename() before this patch
> are removed, because we no longer have to call this function on graph
> changes.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
