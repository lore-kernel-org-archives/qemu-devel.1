Received: from eggs.gnu.org ([2001:4830:134:3::10]:44429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cV7xc-00036e-6u
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 21:32:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cV7xX-0003VK-Am
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 21:32:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cV7xX-0003V5-5b
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 21:32:47 -0500
Date: Sun, 22 Jan 2017 10:32:41 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170122023241.GC13810@pxdev.xzpeter.org>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-2-git-send-email-peterx@redhat.com>
	<f2cc041f-21a5-5ec8-c55a-de7a1a34d575@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f2cc041f-21a5-5ec8-c55a-de7a1a34d575@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 01/14] IOMMU: add option to enable
 VTD_CAP_CM to vIOMMU capility exposoed to guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com

On Fri, Jan 20, 2017 at 09:42:25AM -0600, Eric Blake wrote:
> On 01/12/2017 09:06 PM, Peter Xu wrote:
> > From: Aviv Ben-David <bd.aviv@gmail.com>
> 
> Long subject line, please try to keep it around 60 or so characters
> (look at 'git shortlog -30' for comparison).  Also, fix the typos:
> s/capility exposoed/capability exposed/

Will fix this and repost this single patch as v4.1 based on v4 series.

Thanks!

> 
> > 
> > This capability asks the guest to invalidate cache before each map operation.
> > We can use this invalidation to trap map operations in the hypervisor.
> > 
> > Signed-off-by: Aviv Ben-David <bd.aviv@gmail.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> 
> -- 
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
> 

-- peterx
