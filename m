Received: from eggs.gnu.org ([2001:4830:134:3::10]:34443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fiBvn-0001t2-EB
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 01:01:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fiBvk-0001Xp-5X
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 01:01:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1fiBvj-0001V5-TO
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 01:01:44 -0400
Date: Wed, 25 Jul 2018 01:01:39 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <399916154.53931292.1532494899706.JavaMail.zimbra@redhat.com>
In-Reply-To: <783786ae-2e85-2376-448c-1e362c3d4d48@redhat.com>
References: <20180713075232.9575-1-pagupta@redhat.com>
	<20180713075232.9575-4-pagupta@redhat.com>
	<783786ae-2e85-2376-448c-1e362c3d4d48@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3] qemu: Add virtio pmem device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, kwolf@redhat.com, haozhong zhang <haozhong.zhang@intel.com>, jack@suse.cz, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, riel@surriel.com, niteshnarayanlal@hotmail.com, david@redhat.com, ross zwisler <ross.zwisler@intel.com>, lcapitulino@redhat.com, hch@infradead.org, mst@redhat.com, stefanha@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, dan j williams <dan.j.williams@intel.com>, nilal@redhat.com


Hi Eric,

> 
> On 07/13/2018 02:52 AM, Pankaj Gupta wrote:
> >   This patch adds virtio-pmem Qemu device.
> > 
> >   This device presents memory address range information to guest
> >   which is backed by file backend type. It acts like persistent
> >   memory device for KVM guest. Guest can perform read and persistent
> >   write operations on this memory range with the help of DAX capable
> >   filesystem.
> > 
> >   Persistent guest writes are assured with the help of virtio based
> >   flushing interface. When guest userspace space performs fsync on
> >   file fd on pmem device, a flush command is send to Qemu over VIRTIO
> >   and host side flush/sync is done on backing image file.
> > 
> > Changes from RFC v2:
> 
> This patch has no n/M in the subject line; but is included in a thread
> that also has a 0/2 cover letter, as well as 1/2 and 2/2 patches in
> separate mails.  Is that intentional?

Yes, kernel series has 0-2 patches and Qemu has this one. I thought its
good to keep separate numbering for both the sets.  
> 
> When sending revision notes on a specific patch, it's best to place them...

Sure.
> 
> > - Use aio_worker() to avoid Qemu from hanging with blocking fsync
> >    call - Stefan
> > - Use virtio_st*_p() for endianess - Stefan
> > - Correct indentation in qapi/misc.json - Eric
> > 
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> 
> ...here, after the --- separator. They are useful to reviewers on the
> list, but are stripped by 'git am' as they don't need to be part of the
> git history (a year from now, we won't care how many iterations the
> patch went through during review, only what actually landed).
> 
> 
> > +++ b/qapi/misc.json
> > @@ -2907,6 +2907,29 @@
> >             }
> >   }
> >   
> > +##
> > +# @VirtioPMemDeviceInfo:
> > +#
> > +# VirtioPMem state information
> > +#
> > +# @id: device's ID
> > +#
> > +# @start: physical address, where device is mapped
> > +#
> > +# @size: size of memory that the device provides
> > +#
> > +# @memdev: memory backend linked with device
> > +#
> > +# Since: 2.13
> 
> There is no 2.13 release, and you've missed the 3.0 window.  Please
> update this and any other version reference to 3.1.

okay.

Thanks,
Pankaj
