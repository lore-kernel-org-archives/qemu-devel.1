Received: from eggs.gnu.org ([2001:4830:134:3::10]:47203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVHJc-00041O-DB
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVHJY-0005Aj-0H
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:04:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dVHJX-0005AL-QC
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:04:23 -0400
References: <1499863793-18627-1-git-send-email-thuth@redhat.com>
	<5d875407-37fd-bd27-8a04-619247fc2d91@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9d882fcb-2600-877c-8355-246fb9b30f48@redhat.com>
Date: Wed, 12 Jul 2017 15:04:17 +0200
MIME-Version: 1.0
In-Reply-To: <5d875407-37fd-bd27-8a04-619247fc2d91@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 00/11] Implement network booting in the
 s390-ccw BIOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

On 12.07.2017 15:00, Christian Borntraeger wrote:
> On 07/12/2017 02:49 PM, Thomas Huth wrote:
>> It's already possible to do a network boot of an s390x guest with an
>> external netboot image based on a Linux installation, but it would
>> be much more convenient if the s390-ccw firmware supported network
>> booting right out of the box, without the need to assemble such an
>> external image first.
>>
>> This patch series now introduces a s390-netboot.img that can be used
>> for network booting via DHCP and TFTP by re-using the networking stack
>> from the SLOF firmware (see https://github.com/aik/SLOF/ for details),
>> and adds a driver for virtio-net-ccw devices.
[...]
> thanks applied.
> 
> (will do some testing and rebuilding of the image files on top). Where do
> we want to put the binary result? pc-bios/s390-netboot.img I assume?

Yes. And I guess we need to add a BLOBS entry in main Makefile for this,
too, so that it gets installed properly? Could you please do that, too,
after you've added the binary?

 Thomas
