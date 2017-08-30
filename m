Received: from eggs.gnu.org ([2001:4830:134:3::10]:54253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nt_mahmood@yahoo.com>) id 1dn1LG-0001bA-9d
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 07:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nt_mahmood@yahoo.com>) id 1dn1LD-0002Cn-4p
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 07:39:30 -0400
Received: from sonic307-8.consmr.mail.gq1.yahoo.com ([98.137.64.32]:41806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nt_mahmood@yahoo.com>)
	id 1dn1LC-0002CQ-Sm
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 07:39:27 -0400
Date: Wed, 30 Aug 2017 11:38:58 +0000 (UTC)
From: Mahmood <nt_mahmood@yahoo.com>
Reply-To: Mahmood <nt_mahmood@yahoo.com>
Message-ID: <838020276.255029.1504093138506@mail.yahoo.com>
In-Reply-To: <1735515901.247981.1504090406495@mail.yahoo.com>
References: <1915302638.2814146.1504030043465.ref@mail.yahoo.com>
	<1915302638.2814146.1504030043465@mail.yahoo.com>
	<14033890-2a35-666c-2fa7-5a8727090801@tuxfamily.org>
	<1075529669.195794.1504079702032@mail.yahoo.com>
	<bc7bacd9-fec7-c193-6de0-99d1f7fd0f6f@tuxfamily.org>
	<2061420835.208824.1504085337258@mail.yahoo.com>
	<20170830121109.7fab5559@bahia>
	<61cd0715-27e4-7e50-1e85-9da3b4a48bb1@posteo.de>
	<1735515901.247981.1504090406495@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-discuss] Accessing a shared folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <th.huth@posteo.de>, Greg Kurz <groug@kaod.org>
Cc: Thomas Huth <huth@tuxfamily.org>, "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>

Hello again,I installed 2.5.0 quickly and it was pretty straight forward!

Here is the error message I get regarding the 'virtio-9p-pci'



mahmood@cluster:qemu-vm$ qemu-system-x86_64 -m 4000 -cpu Opteron_G5 -smp 2 =
-hda centos7.img -boot c=C2=A0 -usbdevice tablet -enable-kvm -device e1000,=
netdev=3Dhost_files -netdev user,net=3D10.0.2.0/24,id=3Dhost_files -virtfs =
local,id=3Dshared,path=3D/home/mahmood/Downloads,mount_tag=3DDownloads
warning: host doesn't support requested feature: CPUID.40000001H:EAX.kvm_as=
yncpf [bit 4]
warning: host doesn't support requested feature: CPUID.40000001H:EAX.kvm_as=
yncpf [bit 4]
qemu-system-x86_64: -virtfs local,id=3Dshared,path=3D/home/mahmood/Download=
s,mount_tag=3DDownloads: 'virtio-9p-pci' is not a valid device model name
mahmood@cluster:qemu-vm$ qemu-system-x86_64 -m 4000 -cpu Opteron_G5 -smp 2 =
-hda centos7.img -boot c=C2=A0 -usbdevice tablet -enable-kvm -device e1000,=
netdev=3Dhost_files -netdev user,net=3D10.0.2.0/24,id=3Dhost_files -fsdev l=
ocal,id=3Dshared,path=3D/home/mahmood/Downloads -device virtio-9p-pci,fsdev=
=3Dshared,mount_tag=3DDownloads
warning: host doesn't support requested feature: CPUID.40000001H:EAX.kvm_as=
yncpf [bit 4]
warning: host doesn't support requested feature: CPUID.40000001H:EAX.kvm_as=
yncpf [bit 4]
qemu-system-x86_64: -device virtio-9p-pci,fsdev=3Dshared,mount_tag=3DDownlo=
ads: 'virtio-9p-pci' is not a valid device model name
mahmood@cluster:qemu-vm$ qemu-system-x86_64 -version
QEMU emulator version 2.5.0, Copyright (c) 2003-2008 Fabrice Bellard






I appreciate if you help. Thanks.


Regards,
Mahmood
