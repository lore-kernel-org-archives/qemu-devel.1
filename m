Received: from eggs.gnu.org ([2001:4830:134:3::10]:38997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fBLm5-0004P6-SA
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fBLm1-0007CU-K9
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:52:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1fBLm1-0007Bu-Ba
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:51:57 -0400
Date: Wed, 25 Apr 2018 10:51:54 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <1327760552.22648230.1524667914875.JavaMail.zimbra@redhat.com>
In-Reply-To: <79f72139-0fcb-3d5e-a16c-24f3b5ee1a07@redhat.com>
References: <152465613714.2268.4576822049531163532@71c20359a636>
	<1558768042.22416958.1524657509446.JavaMail.zimbra@redhat.com>
	<79f72139-0fcb-3d5e-a16c-24f3b5ee1a07@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2] qemu: Add virtio pmem device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jack@suse.cz, kvm@vger.kernel.org, david@redhat.com, linux-nvdimm@ml01.01.org, ross zwisler <ross.zwisler@intel.com>, lcapitulino@redhat.com, linux-mm@kvack.org, niteshnarayanlal@hotmail.com, mst@redhat.com, hch@infradead.org, marcel@redhat.com, nilal@redhat.com, haozhong zhang <haozhong.zhang@intel.com>, famz@redhat.com, riel@surriel.com, stefanha@redhat.com, pbonzini@redhat.com, dan j williams <dan.j.williams@intel.com>, kwolf@redhat.com, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, linux-kernel@vger.kernel.org, imammedo@redhat.com



> > Hi,
> > 
> > Compile failures are because Qemu 'Memory-Device changes' are not yet
> > in qemu master. As mentioned in Qemu patch message patch is
> > dependent on 'Memeory-device' patches by 'David Hildenbrand'.
> 
> 
> On 04/25/2018 06:24 AM, Pankaj Gupta wrote:
> > This PV device code is dependent and tested
> > with 'David Hildenbrand's ' patchset[1] to
> > map non-PCDIMM devices to guest address space.
> > There is still upstream discussion on using
> > among PCI bar vs memory device, will update
> > as per concensus.
> >
> > [1] https://marc.info/?l=qemu-devel&m=152450249319168&w=2
> 
> Then let's spell that in a way that patchew understands (since patchew
> does not know how to turn marc.info references into Message-IDs):
> 
> Based-on: <20180423165126.15441-1-david@redhat.com>

o.k

Thank you!

> 
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 
> 
