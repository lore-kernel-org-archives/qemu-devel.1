Received: from eggs.gnu.org ([2001:4830:134:3::10]:52598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vrozenfe@redhat.com>) id 1cdDVV-000476-4L
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 05:05:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vrozenfe@redhat.com>) id 1cdDVN-0006av-BD
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 05:05:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vrozenfe@redhat.com>) id 1cdDVN-0006Zr-5e
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 05:05:09 -0500
Message-ID: <1486980300.17184.28.camel@redhat.com>
From: Vadim Rozenfeld <vrozenfe@redhat.com>
Date: Mon, 13 Feb 2017 21:05:00 +1100
In-Reply-To: <2127602137.20489688.1486827559449.JavaMail.zimbra@redhat.com>
References: <589C099A.9090605@huawei.com>
	<AF60004D-7133-44D1-8A9F-7DB9822D84AF@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA1B4379@DGGEMA505-MBX.china.huawei.com>
	<105e5774-38c3-0683-ca08-64f6ed53c643@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA1B6988@DGGEMA505-MBX.china.huawei.com>
	<2127602137.20489688.1486827559449.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Help] Windows2012 as Guest 64+cores on KVM Halts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Yan Vugenfirer <yvugenfi@redhat.com>, Hangaohuai <hangaohuai@huawei.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, Radim Krcmar <rkrcmar@redhat.com>

On Sat, 2017-02-11 at 10:39 -0500, Paolo Bonzini wrote:
> >=20
> >=20
> > >=20
> > > On 10/02/2017 10:31, Gonglei (Arei) wrote:
> > > >=20
> > > > But We tested the same cases on Xen platform and VMware, and
> > > > the guest booted successfully.
> > >=20
> > > Were these two also tested with enlightenments enabled?=C2=A0=C2=A0=
TCG
> > > surely isn't.
> >=20
> > About TCG, I just remove ' accel=3Dkvm,' and 'hy_releaxed' from the
> > below QEMU
> > Command line, I thought the hyper-V enabled then. Sorry about that.
> >=20
> > But for Xen, we set 'viridian=3D1' which be thought the Hyper-V is
> > enabled.
> >=20
> > For VMWare we also enabled the Hyper-V enlightenments.
If I'm not mistaken, even Hyper-V server doesn't allow specify more
than 64 vCPUs for Generation 1 VMs.
In any case, if you are only interested in hv_relaxed, you can drop it
off for WS2012 as long as you have cpu hypervisor flag
(CPUID.1:ECX=C2=A0[bit=C2=A031]=3D1) turned on.

Best regards,
Vadim.
=C2=A0
>=20
> Ok, thanks for the clarifications!
>=20
> Paolo
