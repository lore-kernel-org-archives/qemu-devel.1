Received: from eggs.gnu.org ([2001:4830:134:3::10]:47348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fcYQk-00063c-Mp
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:50:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fcYQh-0008IV-Cg
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:50:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1fcYQg-0008Hd-PE
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:50:23 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com
	[10.5.11.25])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B429030820EC
	for <qemu-devel@nongnu.org>; Mon,  9 Jul 2018 15:50:21 +0000 (UTC)
Date: Mon, 9 Jul 2018 16:50:17 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180709155017.GG16293@redhat.com>
References: <20180705123929.GB16293@redhat.com>
	<20180705125231.GD16293@redhat.com>
	<20180705165348-mutt-send-email-mst@kernel.org>
	<20180705141132.GM1455@redhat.com>
	<20180709073647.GF16293@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709073647.GF16293@redhat.com>
Subject: Re: [Qemu-devel] Byte ordering of VM Generation ID in Windows VMs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jferlan@redhat.com, lersek@redhat.com, qemu-devel@nongnu.org, mxie@redhat.com

On Mon, Jul 09, 2018 at 08:36:47AM +0100, Richard W.M. Jones wrote:
> On Thu, Jul 05, 2018 at 03:11:32PM +0100, Richard W.M. Jones wrote:
> > VMware represents these internally as two signed 64 bit integers, eg:
> > 
> >   vm.genid = "-570734802784577186"
> >   vm.genidx = "-5042519231342505152"
> > 
> > I am still trying to get verification, but I believe the first is the
> > low 64 bit word and the second is the high 64 bit word.
> 
> I have now been able to verify how this works using a real VMware
> hypervisor (thanks to help from Ming Xie).  For the record, here is
> how it maps, since I could not find any documentation about this.
> 
> VMX file contains:
> 
>   vm.genid = "7344585841658099715"
>   vm.genidX = "-8483171368186442967"

As a follow-on, here is some code which can convert VMware's VMX
numbers into a qemu-style UUID.  Note for both of these I mean the
textual representation, not the in-memory representation.

  https://github.com/libguestfs/libguestfs/blob/b11b870166b7ae27f728dbb58b6498788bf97329/v2v/input_vmx.ml#L430-L449

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v
