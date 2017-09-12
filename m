Received: from eggs.gnu.org ([2001:4830:134:3::10]:42380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1drikF-0005y0-1G
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:48:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1drikA-00083E-2K
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:48:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47520
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1drik9-00082d-Sm
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:48:38 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8CAhhEV098893
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 06:48:37 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cxc536ayd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 06:48:37 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 12 Sep 2017 11:48:35 +0100
References: <b0cd3b7a-fcc8-03ed-55dd-cbdba2ff59ec@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 12 Sep 2017 12:48:32 +0200
MIME-Version: 1.0
In-Reply-To: <b0cd3b7a-fcc8-03ed-55dd-cbdba2ff59ec@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <af68fe00-1a59-54d3-e06e-123a19ff9495@de.ibm.com>
Subject: Re: [Qemu-devel] Suggested Wiki Update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>

Looks good to me. I somehow lost my wiki password, so maybe Conny can do the
update until this is fixed....

On 09/12/2017 10:57 AM, Viktor Mihajlovski wrote:
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
