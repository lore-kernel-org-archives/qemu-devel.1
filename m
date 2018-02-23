Received: from eggs.gnu.org ([2001:4830:134:3::10]:37965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1epDTU-0003TP-4N
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:33:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1epDTP-0003ZQ-88
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:33:20 -0500
References: <1519241752-28083-1-git-send-email-walling@linux.vnet.ibm.com>
	<3b160f2d-8c32-7b0a-3afc-0519c02cee81@de.ibm.com>
	<5fd04c0d-ad1e-13a7-4e5a-5f28662479a7@redhat.com>
	<68148fff-0c6e-0470-a0e5-0379ecfd3dd8@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e685de9a-d216-3d73-0ea3-b0d193a7f79e@redhat.com>
Date: Fri, 23 Feb 2018 14:33:10 +0100
MIME-Version: 1.0
In-Reply-To: <68148fff-0c6e-0470-a0e5-0379ecfd3dd8@linux.vnet.ibm.com>
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
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, eblake@redhat.com

On 23.02.2018 12:50, Viktor Mihajlovski wrote:
> On 23.02.2018 11:17, Thomas Huth wrote:
>> On 23.02.2018 09:53, Christian Borntraeger wrote:
>>> Hmmm, on my ubuntu 16.04 guest, I get the boot menu with no timeout even if I do not 
>>> specify loadparm or boot menu:
>>>
>>> qemu-kvm -drive file=/var/lib/libvirt/qemu/image.zhyp140,if=none,id=d1 -device virtio-blk-ccw,drive=d1,bootindex=1 
>>
>> I can reproduce this now, too. FWIW: It only happens with
>> virtio-blk-ccw, not with virtio-scsi-ccw (that's why I did not notice it
>> first). Collin, can you reproduce this, too?
>>
>>  Thomas
>> The idea is to support the zipl boot menu on ECKD disks (which have a timeout by themselves)
> even without switching the boot menu on. This is to have the same behavior as one would see
> on LPAR or z/VM.
> The issue is that the boot code tries to interpret the program table of SCSI bootmaps as if
> a boot menu has been specified.

Ok, thanks for the explanation, makes sense now.

Collin, could you please spin a v9 with the required changes included?

 Thanks,
  Thomas
