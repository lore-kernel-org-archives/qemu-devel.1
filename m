Received: from eggs.gnu.org ([2001:4830:134:3::10]:38273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1epAQj-0006MI-4M
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 05:18:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1epAQf-0005UN-Vh
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 05:18:17 -0500
References: <1519241752-28083-1-git-send-email-walling@linux.vnet.ibm.com>
	<3b160f2d-8c32-7b0a-3afc-0519c02cee81@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5fd04c0d-ad1e-13a7-4e5a-5f28662479a7@redhat.com>
Date: Fri, 23 Feb 2018 11:17:51 +0100
MIME-Version: 1.0
In-Reply-To: <3b160f2d-8c32-7b0a-3afc-0519c02cee81@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 00/13] Interactive Boot Menu for DASD
 and SCSI Guests on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, eblake@redhat.com, mihajlov@linux.vnet.ibm.com

On 23.02.2018 09:53, Christian Borntraeger wrote:
> Hmmm, on my ubuntu 16.04 guest, I get the boot menu with no timeout even if I do not 
> specify loadparm or boot menu:
> 
> qemu-kvm -drive file=/var/lib/libvirt/qemu/image.zhyp140,if=none,id=d1 -device virtio-blk-ccw,drive=d1,bootindex=1 

I can reproduce this now, too. FWIW: It only happens with
virtio-blk-ccw, not with virtio-scsi-ccw (that's why I did not notice it
first). Collin, can you reproduce this, too?

 Thomas
