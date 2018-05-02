Received: from eggs.gnu.org ([2001:4830:134:3::10]:48054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=653480f21=anthony.perard@citrix.com>)
	id 1fDu00-0008Cz-PX
	for qemu-devel@nongnu.org; Wed, 02 May 2018 11:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=653480f21=anthony.perard@citrix.com>)
	id 1fDtzw-0001fX-QU
	for qemu-devel@nongnu.org; Wed, 02 May 2018 11:48:56 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:54066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=653480f21=anthony.perard@citrix.com>)
	id 1fDtzw-0001fP-HG
	for qemu-devel@nongnu.org; Wed, 02 May 2018 11:48:52 -0400
Date: Wed, 2 May 2018 16:48:48 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180502154848.GC14376@perard>
References: <1524664007-12687-1-git-send-email-igor.druzhinin@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1524664007-12687-1-git-send-email-igor.druzhinin@citrix.com>
Subject: Re: [Qemu-devel] [PATCH] xen/hvm: correct reporting of modified
 memory under physmap during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Druzhinin <igor.druzhinin@citrix.com>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, sstabellini@kernel.org, pbonzini@redhat.com, paul.durrant@citrix.com

On Wed, Apr 25, 2018 at 02:46:47PM +0100, Igor Druzhinin wrote:
> When global_log_dirty is enabled VRAM modification tracking never
> worked correctly. The address that is passed to xen_hvm_modified_memory()
> is not the effective PFN but RAM block address which is not the same
> for VRAM.
> 
> We need to make a translation for this address into PFN using
> physmap. Since there is no way to access physmap properly inside
> xen_hvm_modified_memory() let's make it a global structure.
> 
> Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD
