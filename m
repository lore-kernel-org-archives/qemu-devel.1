Received: from eggs.gnu.org ([2001:4830:134:3::10]:59433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCkZ-0004ax-3T
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:07:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eSCkV-0000G8-R3
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:07:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eSCkV-0000Fo-KF
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 21:07:47 -0500
References: <20171215184155.2543-1-mark.cave-ayland@ilande.co.uk>
	<afe1431d-7484-88ac-333b-e042fa0fb32d@redhat.com>
	<19ebcc01-3299-2ec9-7089-cba5abde400f@ilande.co.uk>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <040fe249-f3d6-05b5-b7d4-01d757f47e2e@redhat.com>
Date: Fri, 22 Dec 2017 10:07:40 +0800
MIME-Version: 1.0
In-Reply-To: <19ebcc01-3299-2ec9-7089-cba5abde400f@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCHv3 00/13] net: introduce common net_crc32()
 and net_crc32_le() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, sw@weilnetz.de



On 2017=E5=B9=B412=E6=9C=8820=E6=97=A5 16:58, Mark Cave-Ayland wrote:
>> Series looks good to me.
>>
>> A small question is that, is this better to keep compute_mcast_idx()?
>>
>> Thanks
>
> Hi Jason,
>
> I did think about this, however at the very minimum you'd need=20
> big-endian and little-endian variants of compute_mcast_idx(), and then=20
> you see that eepro100 applies a different bitmask/shift which is yet=20
> another variant...
>
> For this reason I moved them all inline to the QEMU driver and that=20
> made it possible to compare the hash calculation directly with the=20
> corresponding Linux driver which found the 3 potential bugs above. So=20
> I think this is a net win (pardon the pun) on all sides :)
>
>
> ATB,

Ok, applied.

Thanks
