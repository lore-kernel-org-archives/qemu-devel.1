Received: from eggs.gnu.org ([2001:4830:134:3::10]:60039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ejLj7-0006Ca-6V
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 04:09:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ejLj3-0007g6-Vw
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 04:09:13 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56048 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ejLj3-0007di-Qj
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 04:09:09 -0500
References: <CAEZT4RNYVuFvwyp9VR94HAgVmz-_MFyd0yjEDRP8_iJ=D5XcKQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d82e7abb-9f6d-0ed3-6c4d-05dd99d98450@redhat.com>
Date: Wed, 7 Feb 2018 10:08:56 +0100
MIME-Version: 1.0
In-Reply-To: <CAEZT4RNYVuFvwyp9VR94HAgVmz-_MFyd0yjEDRP8_iJ=D5XcKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Regarding Network interface on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Arun raj <krarun88@gmail.com>, qemu-devel@nongnu.org

On 07.02.2018 09:55, Arun raj wrote:
> Hi,
>=20
> I'm new to QEMU and using latest QEMU-2.11.50 version. i installed ubun=
tu
> 16.04 in QEMU and my host system has 4.4 kernel
>=20
> following command is i'm using to run the QEMU :
>=20
> qemu-system-x86_64 -machine q35,kernel_irqchip=3Dsplit -m 1G -enable-kv=
m -smp
> 4 -device intel-iommu,intremap=3Don,x-buggy-eim=3Don -cpu
> kvm64,-kvm_pv_eoi,-kvm_steal_time,-kvm_asyncpf,-kvmclock,+vmx -drive
> file=3Dtesting.img,format=3Draw,id=3Ddisk,if=3Dnone -device ide-hd,driv=
e=3Ddisk
> -serial stdio -serial vc -netdev user,id=3Dnet -device
> e1000e,addr=3D2.0,netdev=3Dnet -device intel-hda,addr=3D1b.0 -device hd=
a-duplex
>=20
> But in QEMU i can't able to access the internet and ping also not worki=
ng.

It's normal that "ping" (or rather ICMP) is not working by default with
the "-netdev user" backend. The "user" backend is using NAT. But you
should be able to get to the outside via TCP. See this URL for details:

https://wiki.qemu.org/Documentation/Networking#User_Networking_.28SLIRP.2=
9

Do you see a network interface in the guest? Does it have an IP address?
I.e. what's the output of "ifconfig" or "ip addr" in the guest? Does it b=
ehave
behave differently if you use another type of NIC, e.g. "virtio-net-pci"
instead of "e1000e"?

 Thomas
