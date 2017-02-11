Received: from eggs.gnu.org ([2001:4830:134:3::10]:37417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1ccUhb-0004bi-7P
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 05:14:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1ccUhY-0004dU-3K
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 05:14:47 -0500
Received: from [45.249.212.188] (port=2465 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1ccUhW-0004cp-SS
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 05:14:44 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Sat, 11 Feb 2017 10:12:47 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA1B6988@DGGEMA505-MBX.china.huawei.com>
References: <589C099A.9090605@huawei.com>
	<AF60004D-7133-44D1-8A9F-7DB9822D84AF@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA1B4379@DGGEMA505-MBX.china.huawei.com>
	<105e5774-38c3-0683-ca08-64f6ed53c643@redhat.com>
In-Reply-To: <105e5774-38c3-0683-ca08-64f6ed53c643@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Help] Windows2012 as Guest 64+cores on KVM Halts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>, Hangaohuai <hangaohuai@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Radim Krcmar <rkrcmar@redhat.com>, "vrozenfe@redhat.com" <vrozenfe@redhat.com>

Hi Paolo,

>=20
>=20
> On 10/02/2017 10:31, Gonglei (Arei) wrote:
> > But We tested the same cases on Xen platform and VMware, and
> > the guest booted successfully.
>=20
> Were these two also tested with enlightenments enabled?  TCG surely isn't=
.
>=20
About TCG, I just remove ' accel=3Dkvm,' and 'hy_releaxed' from the below Q=
EMU
Command line, I thought the hyper-V enabled then. Sorry about that.

But for Xen, we set 'viridian=3D1' which be thought the Hyper-V is enabled.

For VMWare we also enabled the Hyper-V enlightenments.

Thanks,
-Gonglei

> Paolo
>=20
> > Today I also tested on tcg, the guest also boots successfully.
> >
> > BTW, if we disable hyper-v, there isn't problem on boot for the case.
> >
> > QEMU command line (enable hyper-v with hv_relaxed):
> >
> > # ./qemu-system-x86_64 -name win2012 -machine accel=3Dkvm,usb=3Doff -cp=
u
> qemu64,hv_relaxed -m 4001 -realtime mlock=3Doff -smp
> 68,sockets=3D1,cores=3D68,threads=3D1 \
> > -drive
> file=3D/mnt/sdb/gonglei/win2012_r2_dc_64_raw,if=3Dnone,id=3Ddrive-ide0-0-=
0
> -device ide-hd,bus=3Dide.0,unit=3D0,drive=3Ddrive-ide0-0-0,id=3Dide0-0-0,=
bootindex=3D1 \
> > -boot menu=3Don -device piix3-usb-uhci,id=3Duhci -chardev
> file,id=3Dseabios,path=3D/home/seabios.log -device
> isa-debugcon,iobase=3D0x402,chardev=3Dseabios \
> > -monitor stdio -device cirrus-vga,id=3Dvideo0,vgamem_mb=3D16 -vnc 0.0.0=
.0:10
> >
> > So, I think it's possible a KVM bug on Hyper-V enlightenments support.
> >
> > Any help will be appreciated!
> >
> > CC'ing Paolo, Radim and Vadim.
