Received: from eggs.gnu.org ([209.51.188.92]:39126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gj7Nb-0007mM-8l
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 13:54:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gj7NY-0000WI-Ch
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 13:54:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gj7NW-0000Uu-8q
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 13:54:32 -0500
Date: Mon, 14 Jan 2019 16:54:20 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190114185420.GD28115@habkost.net>
References: <cover.1546399191.git.yi.z.zhang@linux.intel.com>
	<51ba6d7d0333a5517d824a870dd20887156dd15a.1546399191.git.yi.z.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51ba6d7d0333a5517d824a870dd20887156dd15a.1546399191.git.yi.z.zhang@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH V8 1/5] numa: Fixed the memory leak of numa
 error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Yi <yi.z.zhang@linux.intel.com>
Cc: xiaoguangrong.eric@gmail.com, stefanha@redhat.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, mst@redhat.com, imammedo@redhat.com, dan.j.williams@intel.com, qemu-devel@nongnu.org

On Wed, Jan 02, 2019 at 01:25:56PM +0800, Zhang Yi wrote:
> object_get_canonical_path_component() returns a string which
> must be freed using g_free().
> 
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> Reviewed-by: Pankaj gupta <pagupta@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Queued, thanks.

-- 
Eduardo
