Received: from eggs.gnu.org ([2001:4830:134:3::10]:59539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cc9tJ-0001K3-Lp
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:01:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cc9tF-0001Py-RB
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:01:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47932)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cc9tF-0001Pg-LZ
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:01:25 -0500
References: <589C099A.9090605@huawei.com>
	<AF60004D-7133-44D1-8A9F-7DB9822D84AF@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA1B4379@DGGEMA505-MBX.china.huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <105e5774-38c3-0683-ca08-64f6ed53c643@redhat.com>
Date: Fri, 10 Feb 2017 13:01:22 +0100
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA1B4379@DGGEMA505-MBX.china.huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Help] Windows2012 as Guest 64+cores on KVM Halts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, Yan Vugenfirer <yvugenfi@redhat.com>, Hangaohuai <hangaohuai@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Radim Krcmar <rkrcmar@redhat.com>, "vrozenfe@redhat.com" <vrozenfe@redhat.com>



On 10/02/2017 10:31, Gonglei (Arei) wrote:
> But We tested the same cases on Xen platform and VMware, and
> the guest booted successfully.

Were these two also tested with enlightenments enabled?  TCG surely isn't.

Paolo

> Today I also tested on tcg, the guest also boots successfully.
> 
> BTW, if we disable hyper-v, there isn't problem on boot for the case.
> 
> QEMU command line (enable hyper-v with hv_relaxed):
> 
> # ./qemu-system-x86_64 -name win2012 -machine accel=kvm,usb=off -cpu qemu64,hv_relaxed -m 4001 -realtime mlock=off -smp 68,sockets=1,cores=68,threads=1 \
> -drive file=/mnt/sdb/gonglei/win2012_r2_dc_64_raw,if=none,id=drive-ide0-0-0 -device ide-hd,bus=ide.0,unit=0,drive=drive-ide0-0-0,id=ide0-0-0,bootindex=1 \
> -boot menu=on -device piix3-usb-uhci,id=uhci -chardev file,id=seabios,path=/home/seabios.log -device isa-debugcon,iobase=0x402,chardev=seabios \
> -monitor stdio -device cirrus-vga,id=video0,vgamem_mb=16 -vnc 0.0.0.0:10
> 
> So, I think it's possible a KVM bug on Hyper-V enlightenments support. 
> 
> Any help will be appreciated!
> 
> CC'ing Paolo, Radim and Vadim.
