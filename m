Received: from eggs.gnu.org ([209.51.188.92]:59437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkY4P-00072o-An
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:36:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkY4N-0002j2-HZ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:36:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gkY4N-0002Ql-Ap
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:36:39 -0500
Date: Fri, 18 Jan 2019 15:36:19 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190118173619.GI4136@habkost.net>
References: <cover.1547624239.git.yi.z.zhang@linux.intel.com>
	<5a9ab3832eacb1e4bc6649f72bcf2969074573f1.1547624239.git.yi.z.zhang@linux.intel.com>
	<20190116105547-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116105547-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH V9 1/6] numa: Fixed the memory leak of numa
 error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Zhang Yi <yi.z.zhang@linux.intel.com>, xiaoguangrong.eric@gmail.com, stefanha@redhat.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, qemu-devel@nongnu.org, imammedo@redhat.com, dan.j.williams@intel.com

On Wed, Jan 16, 2019 at 10:56:14AM -0500, Michael S. Tsirkin wrote:
> On Wed, Jan 16, 2019 at 04:10:17PM +0800, Zhang Yi wrote:
> > object_get_canonical_path_component() returns a string which
> > must be freed using g_free().
> > 
> > Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> > Reviewed-by: Pankaj gupta <pagupta@redhat.com>
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Pls post this separately as it's just a bugfix that
> is not a dependency of map_sync.

I have already queued it on machine-next, there's no need to
resubmit.

-- 
Eduardo
