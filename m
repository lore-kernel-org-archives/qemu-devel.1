Received: from eggs.gnu.org ([2001:4830:134:3::10]:37459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1cgAbw-0006Qp-36
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:36:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1cgAbs-0002B5-Vw
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:36:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40629
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1cgAbs-0002Al-PH
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:36:04 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1LDXcP5134590
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 08:36:03 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28rm7sxenu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 08:36:03 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Tue, 21 Feb 2017 13:36:02 -0000
References: <20170220141943.8426-1-cornelia.huck@de.ibm.com>
	<9b1118e8-8b00-fa68-a3f8-9a8af2346e17@redhat.com>
	<77cdf172-3321-7031-0e6e-f485c23393f2@suse.de>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Tue, 21 Feb 2017 14:35:57 +0100
MIME-Version: 1.0
In-Reply-To: <77cdf172-3321-7031-0e6e-f485c23393f2@suse.de>
Content-Type: text/plain; charset=utf-8
Message-Id: <27bf83d8-cfd0-c704-358b-2c7674b07448@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/5] s390x: network boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, jfrei@linux.vnet.ibm.com

On 20.02.2017 17:01, Alexander Graf wrote:
>=20
>=20
> On 20/02/2017 07:43, Thomas Huth wrote:
>> On 20.02.2017 15:19, Cornelia Huck wrote:
>>> This patchset implements network boot for s390x. You need to build
>>> a s390-netboot.img to actually perform the work (not included).
>>
>> Do you plan to include this into the upstream QEMU repository later, o=
r
>> will this stay an external binary?
>>
>>> Basically, we add support for virtio-net devices into the ipl code
>>> and update the ccw bios to handle this as well.
>>
>> Just out of curiosity: What's the reason for shipping an additional
>> binary here? Couldn't it be linked into the ccw bios as well (so that
>> it's easier for the user to select a different version with the -bios
>> parameter)?
>=20
> The "other binary" (s390-netboot.img) is the equivalent of grub or
> pxelinux in an x86 network boot environment. That one usually comes fro=
m
> a different entity and different department :).
I'd rather compare the other binary to an option ROM.
At this point in time we there's no netboot ROM, but a set of
instructions on how to build a netboot binary from a kernel and a
ramdisk, the series coverletter contains a brief version of that.

>=20
> I haven't looked at the patches in detail, but do they follow the
> "normal" PXE boot flow? Do they do a DHCP request, send a proper
> Vendor-Class-Identifier for s390x, fetch the binary described by the
> "filename" property in the DHCP ack via TFTP from next-server and run
> that one then?
It's currently not described with that level of detail, but the idea is
to skip the step of loading a syslinux equivalent, and to immediately
fetch the PXELINUX config file from the TFT next server aka siaddr and
load the kernel and ramdisk specified therein.
I.e. a simulation of the PXELINUX process is done in a similar fashion
to petitboot PXE boot.
>=20
> It would be very good to stick to that flow, so that you don't confuse
> your network admins :).
>=20
>=20
> Alex
>=20


--=20

Mit freundlichen Gr=C3=BC=C3=9Fen/Kind Regards
   Viktor Mihajlovski

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martina K=C3=B6deritz
Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
