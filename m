Received: from eggs.gnu.org ([2001:4830:134:3::10]:35785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cjYXp-00070J-0v
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 16:45:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cjYXo-0004BL-4R
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 16:45:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cjYXn-0004B1-V0
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 16:45:52 -0500
Date: Thu, 2 Mar 2017 23:45:49 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170302234513-mutt-send-email-mst@kernel.org>
References: <20170302213650.86211-1-ben@skyportsystems.com>
	<24c55319-20af-fbe2-366b-e3bda17f6f94@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24c55319-20af-fbe2-366b-e3bda17f6f94@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Bugfix: Handle error if VM Generation ID
 device not present
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: ben@skyportsystems.com, qemu-devel@nongnu.org, peter.maydell@linaro.org, armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, imammedo@redhat.com, lersek@redhat.com

On Thu, Mar 02, 2017 at 03:41:33PM -0600, Eric Blake wrote:
> On 03/02/2017 03:36 PM, ben@skyportsystems.com wrote:
> > From: Ben Warren <ben@skyportsystems.com>
> > 
> > This was crashing due to NULL-pointer dereference
> > 
> > QMP Test case:
> > ==============
> > 
> > (QEMU) query-vm-generation-id
> > {"error": {"class": "GenericError", "desc": "VM Generation ID device not
> > found"}}
> > 
> > HMP Test case:
> > ==============
> > virsh # qemu-monitor-command --hmp 3 info vm-generation-id
> > VM Generation ID device not found
> > 
> > Signed-off-by: Ben Warren <ben@skyportsystems.com>
> > ---
> >  hmp.c             | 4 +++-
> >  hw/acpi/vmgenid.c | 1 +
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> However, hw/acpi/vmgenid.c is not part of the tree yet, so it may be
> better to just respin the pull request to incorporate this into the
> problematic patch that introduced the problem, rather than needing a
> followup patch.
> 
> -- 
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
> 

The issue seems minor enough.
I don't plan to re-spin unless there are more issues.

-- 
MST
