Received: from eggs.gnu.org ([2001:4830:134:3::10]:50699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nt_mahmood@yahoo.com>) id 1dmzJ3-0000ix-Ez
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 05:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nt_mahmood@yahoo.com>) id 1dmzIz-0002pS-Ck
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 05:29:05 -0400
Received: from sonic301-21.consmr.mail.gq1.yahoo.com ([98.137.64.147]:33515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nt_mahmood@yahoo.com>)
	id 1dmzIz-0002ot-56
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 05:29:01 -0400
Date: Wed, 30 Aug 2017 09:28:57 +0000 (UTC)
From: Mahmood <nt_mahmood@yahoo.com>
Reply-To: Mahmood <nt_mahmood@yahoo.com>
Message-ID: <2061420835.208824.1504085337258@mail.yahoo.com>
In-Reply-To: <bc7bacd9-fec7-c193-6de0-99d1f7fd0f6f@tuxfamily.org>
References: <1915302638.2814146.1504030043465.ref@mail.yahoo.com>
	<1915302638.2814146.1504030043465@mail.yahoo.com>
	<14033890-2a35-666c-2fa7-5a8727090801@tuxfamily.org>
	<1075529669.195794.1504079702032@mail.yahoo.com>
	<bc7bacd9-fec7-c193-6de0-99d1f7fd0f6f@tuxfamily.org>
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
To: Thomas Huth <huth@tuxfamily.org>, "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>
Cc: Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

>Could you please try to replace the -virtfs option with these two options:
>
 >-fsdev local,id=3Dshared,path=3D/home/mahmood/Downloads \
 >-device virtio-9p-pci,fsdev=3Dshared,mount_tag=3DDownloads




Still get the same error!

mahmood@cluster:qemu-vm$ qemu-system-x86_64 -m 4000 -cpu Opteron_G5 -smp 2 =
-hda centos7server.img -boot c=C2=A0 -usbdevice tablet -enable-kvm -device =
e1000,netdev=3Dhost_files -netdev user,net=3D10.0.2.0/24,id=3Dhost_files -f=
sdev local,id=3Dshared,path=3D/home/mahmood/Downloads -device virtio-9p-pci=
,fsdev=3Dshared,mount_tag=3DDownloads
qemu-system-x86_64: -device virtio-9p-pci,fsdev=3Dshared,mount_tag=3DDownlo=
ads: Parameter 'driver' expects device type
mahmood@cluster:qemu-vm$




Regards,
Mahmood
