Received: from eggs.gnu.org ([2001:4830:134:3::10]:56979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f920R-0000Ht-0b
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 01:21:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f920N-0004MV-Qb
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 01:21:14 -0400
References: <1524054707-20663-1-git-send-email-thuth@redhat.com>
	<1524054707-20663-2-git-send-email-thuth@redhat.com>
	<1170d2d8-a77e-1839-ae64-81f791b3d4e1@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5dd02aa8-b3de-affd-cec8-52aed0552763@redhat.com>
Date: Thu, 19 Apr 2018 07:20:53 +0200
MIME-Version: 1.0
In-Reply-To: <1170d2d8-a77e-1839-ae64-81f791b3d4e1@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 for-2.13 1/4]
 pc-bios/s390-ccw/net: Split up net_load() into init, load and uninit parts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org

On 18.04.2018 20:11, Farhan Ali wrote:
>=20
>=20
> On 04/18/2018 08:31 AM, Thomas Huth wrote:
>> When we want to support pxelinux-style network booting later, we've go=
t
>> to do several TFTP transfers - and we do not want to apply for a new I=
P
>> address via DHCP each time. So split up net_load into three parts:
>>
>> 1. net_init(), which initializes virtio-net, gets an IP address via DH=
CP
>> =C2=A0=C2=A0=C2=A0 and prints out the related information.
>>
>> 2. The tftp_load call is now moved directly into the main() function
>>
>> 3. A new net_uninit() function which should tear down the network stac=
k
>> =C2=A0=C2=A0=C2=A0 before we are done in the firmware.
>>
>> This will make it easier to extend the code in the next patches.
>>
>> Signed-off-by: Thomas Huth<thuth@redhat.com>
>=20
>=20
> Just a minor nit, if we could rename *_uninit functions to
> destroy/release? I think it's just easier to read

Sure. Completely unrepresentative statistics from my QEMU repository:

$ grep -r uninit . | wc -l
212
$ grep -r destroy . | wc -l
904
$ grep -r release . | wc -l
1133

So I think I'll go with "release".

 Thomas
