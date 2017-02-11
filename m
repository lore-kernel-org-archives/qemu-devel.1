Received: from eggs.gnu.org ([2001:4830:134:3::10]:37050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ccZlv-0003zk-H4
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 10:39:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ccZlq-0006Fe-KZ
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 10:39:35 -0500
Received: from mx4-phx2.redhat.com ([209.132.183.25]:47453)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ccZlq-0006Eb-Bk
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 10:39:30 -0500
Date: Sat, 11 Feb 2017 10:39:19 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2127602137.20489688.1486827559449.JavaMail.zimbra@redhat.com>
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA1B6988@DGGEMA505-MBX.china.huawei.com>
References: <589C099A.9090605@huawei.com>
	<AF60004D-7133-44D1-8A9F-7DB9822D84AF@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA1B4379@DGGEMA505-MBX.china.huawei.com>
	<105e5774-38c3-0683-ca08-64f6ed53c643@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA1B6988@DGGEMA505-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Yan Vugenfirer <yvugenfi@redhat.com>, Hangaohuai <hangaohuai@huawei.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, Radim Krcmar <rkrcmar@redhat.com>, vrozenfe@redhat.com

> 
> > On 10/02/2017 10:31, Gonglei (Arei) wrote:
> > > But We tested the same cases on Xen platform and VMware, and
> > > the guest booted successfully.
> > 
> > Were these two also tested with enlightenments enabled?  TCG surely isn't.
> 
> About TCG, I just remove ' accel=kvm,' and 'hy_releaxed' from the below QEMU
> Command line, I thought the hyper-V enabled then. Sorry about that.
> 
> But for Xen, we set 'viridian=1' which be thought the Hyper-V is enabled.
> 
> For VMWare we also enabled the Hyper-V enlightenments.

Ok, thanks for the clarifications!

Paolo
