Received: from eggs.gnu.org ([2001:4830:134:3::10]:45430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ciLBl-0006FG-JK
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:18:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ciLBg-0002IP-N5
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:18:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1ciLBg-0002IL-H2
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:18:00 -0500
Date: Mon, 27 Feb 2017 14:17:57 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170227131757.vkf6twqdkzbwnsqc@eukaryote>
References: <CAFrogKUMUSYF4a7gfO3ruO5hSm6qG6oVjp0vxAO-UNRMLxB54A@mail.gmail.com>
	<20170227110106.GE28403@stefanha-x1.localdomain>
	<20170227123356.tgmtbiwcoswdb256@eukaryote>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170227123356.tgmtbiwcoswdb256@eukaryote>
Subject: Re: [Qemu-devel] [libvirt]  Question regarding Snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: libvir-list@redhat.com, Tim Cusack <thagrasshoppa@gmail.com>, qemu-devel@nongnu.org

On Mon, Feb 27, 2017 at 01:33:56PM +0100, Kashyap Chamarthy wrote:

[...]

> > > Can you make a snapshot, then go back to the base and ignore that snapshot
> > > like a closed branch, make another snapshot, and then go back and forth
> > > from each to each?
> 
> If you edit the '--disk' element as above and point to the right
> 'snapshot', you should be able to switch between several of them.

[...]

> And conveniently, you can tell libvirt to not track the metadata:
> 
>   $ virsh snapshot-create-as --domain vm1 guest-state1 \
>       --diskspec vda,file=/export/overlay1.qcow2 \
>       --disk-only --atomic --no-metadata
> 
> This way, libvirt will not track 'overlay1.qcow2'.  But if you do need
> it, as you know, just update the 

Err, unfinished sentence there.  Meant to write: just update the
'source file' attribute in the guest XML, pointing to the said disk.

> For the long answer to the complications involved in reverting to
> external snapshots, refer this (long read):
> 
> https://wiki.libvirt.org/page/I_created_an_external_snapshot,_but_libvirt_will_not_let_me_delete_or_revert_to_it

[...]

-- 
/kashyap
