Received: from eggs.gnu.org ([2001:4830:134:3::10]:34162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYemI-0000KA-Fd
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:48:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYemH-0005Tl-GQ
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 17:48:34 -0400
References: <20180628000745.4477-1-mreitz@redhat.com>
	<20180628000745.4477-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6a7f4509-3a89-f35e-9505-c2a3481b9a2c@redhat.com>
Date: Thu, 28 Jun 2018 16:48:27 -0500
MIME-Version: 1.0
In-Reply-To: <20180628000745.4477-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 01/31] block: Use
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On 06/27/2018 07:07 PM, Max Reitz wrote:
> Before this patch, bdrv_refresh_filename() is used in a pushing manner:
> Whenever the BDS graph is modified, the parents of the modified edges
> are supposed to be updated (recursively upwards).  However, that is
> unviable, considering that we want child changes not to concern parents.

s/unviable/nonviable/

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
> ---
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
