Received: from eggs.gnu.org ([2001:4830:134:3::10]:51284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1drjD8-0007wp-A9
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 07:18:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1drjD5-0008Oj-0j
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 07:18:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1drjD4-0008OP-Qj
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 07:18:30 -0400
Date: Tue, 12 Sep 2017 13:18:23 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170912131823.1f7a9e03.cohuck@redhat.com>
In-Reply-To: <b0cd3b7a-fcc8-03ed-55dd-cbdba2ff59ec@linux.vnet.ibm.com>
References: <b0cd3b7a-fcc8-03ed-55dd-cbdba2ff59ec@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Suggested Wiki Update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Tue, 12 Sep 2017 10:57:14 +0200
Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:

> Hi,
> 
> the content of https://wiki.qemu.org/index.php/Features/S390xNetworkBoot
> is slightly outdated since proper DHCP based netboot support for s390x
> has been implemented by the series ending with commit 29d1221.
> 
> As it is still desirable to provide some instructions on building
> network bootable images for the s390x architecture, I'd like to suggest
> that the text is replaced (see proposal below). Conny, could I once more
> request your help in that matter?
> 
> == Building a s390 network bootable binary ==
> 
> Since 2.10 QEMU offers network boot support which allows to load a
> binary from a TFTP server and boot it. As s390 network bootable images
> are not very common, this document gives a brief overview on how to
> build one.
> 
> A s390 network bootable image can be built by bundling some shell
> scripts, busybox and the kexec binary bundled into an initial ramdisk
> and append that to a kernel image. An existing s390 system can be used
> as source.
> 
> One way to do that is to take a kernel and an installer initial ramdisk
> from a distribution's DVD/ISO and concatenate them. Some fixups are
> necessary int the new binary, which can be done by using the script in
> [https://github.com/ibm-s390-tools/s390-tools/blob/master/netboot/mk-s390image].
> Booting this image would then start the installation process as if
> booted from the DVD.
> 
> Another possible way is to build a binary that behaves similar to the
> PXELINUX boot loader. In this case an initial ramdisk with an init
> process triggering the PXELINUX-like processing has to be built as
> described in
> [https://github.com/ibm-s390-tools/s390-tools/tree/master/netboot]. The
> site also contains a script assisting in the creation of such an initial
> ramdisk.
> 

Looks good.

Can you perhaps add a sentence that the base support is available with
2.9 and netboot with 2.10? ('Overview' looks like a good place for
that.)
