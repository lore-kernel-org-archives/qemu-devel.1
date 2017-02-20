Received: from eggs.gnu.org ([2001:4830:134:3::10]:47046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cfqP1-0003xp-PU
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:01:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cfqOw-0004Hz-Su
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:01:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:53881)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1cfqOw-0004Hm-Mb
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:01:22 -0500
References: <20170220141943.8426-1-cornelia.huck@de.ibm.com>
	<9b1118e8-8b00-fa68-a3f8-9a8af2346e17@redhat.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <77cdf172-3321-7031-0e6e-f485c23393f2@suse.de>
Date: Mon, 20 Feb 2017 08:01:15 -0800
MIME-Version: 1.0
In-Reply-To: <9b1118e8-8b00-fa68-a3f8-9a8af2346e17@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] s390x: network boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, jfrei@linux.vnet.ibm.com



On 20/02/2017 07:43, Thomas Huth wrote:
> On 20.02.2017 15:19, Cornelia Huck wrote:
>> This patchset implements network boot for s390x. You need to build
>> a s390-netboot.img to actually perform the work (not included).
>
> Do you plan to include this into the upstream QEMU repository later, or
> will this stay an external binary?
>
>> Basically, we add support for virtio-net devices into the ipl code
>> and update the ccw bios to handle this as well.
>
> Just out of curiosity: What's the reason for shipping an additional
> binary here? Couldn't it be linked into the ccw bios as well (so that
> it's easier for the user to select a different version with the -bios
> parameter)?

The "other binary" (s390-netboot.img) is the equivalent of grub or 
pxelinux in an x86 network boot environment. That one usually comes from 
a different entity and different department :).

I haven't looked at the patches in detail, but do they follow the 
"normal" PXE boot flow? Do they do a DHCP request, send a proper 
Vendor-Class-Identifier for s390x, fetch the binary described by the 
"filename" property in the DHCP ack via TFTP from next-server and run 
that one then?

It would be very good to stick to that flow, so that you don't confuse 
your network admins :).


Alex
