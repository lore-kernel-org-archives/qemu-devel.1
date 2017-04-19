Received: from eggs.gnu.org ([2001:4830:134:3::10]:34876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d0f5T-0008Gq-KJ
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 22:11:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d0f5O-0004At-Qc
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 22:11:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d0f5O-0004Ak-KN
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 22:11:14 -0400
Date: Wed, 19 Apr 2017 10:10:59 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170419021059.GH22226@pxdev.xzpeter.org>
References: <1491562755-23867-1-git-send-email-peterx@redhat.com>
	<1491562755-23867-2-git-send-email-peterx@redhat.com>
	<20170410043922.GI27571@umbus>
	<20170410070950.GK3981@pxdev.xzpeter.org>
	<dc26790e-8200-bbde-a7c3-70852f625424@redhat.com>
	<20170418173054.GC7078@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170418173054.GC7078@thinpad.lan.raisama.net>
Subject: Re: [Qemu-devel] [PATCH v9 1/9] memory: add section range info for
 IOMMU notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, qemu-devel@nongnu.org, alex.williamson@redhat.com, bd.aviv@gmail.com

On Tue, Apr 18, 2017 at 02:30:54PM -0300, Eduardo Habkost wrote:
> On Tue, Apr 18, 2017 at 06:20:11PM +0300, Marcel Apfelbaum wrote:
> > On 04/10/2017 10:09 AM, Peter Xu wrote:
> > > On Mon, Apr 10, 2017 at 02:39:22PM +1000, David Gibson wrote:
> > > > On Fri, Apr 07, 2017 at 06:59:07PM +0800, Peter Xu wrote:

[...]

> > Hi Peter,
> > I asked Eduardo to merge the series through this machine tree
> > since I don't have a tree yet.
> > He already squashed the change, thanks Eduardo!
> > Marcel
> 
> The series is queued at:
> 
> git://github.com/ehabkost/qemu-hacks.git machine-next
> 
> (Including the vhost_iommu_region_del() fixup below).
> 
> v2.9.0-rc5 was tagged today, v2.9.0 is expected to be tagged in 2
> days. I plan to submit a pull request as soon as it is tagged.

Thanks Marcel and Edurado for your help on the merging!

-- 
Peter Xu
