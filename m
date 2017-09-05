Received: from eggs.gnu.org ([2001:4830:134:3::10]:58429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dp8eH-0005b0-OK
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dp8eD-0007MB-5t
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:51:53 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dp8eC-0007B7-Fk
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 03:51:49 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Tue, 5 Sep 2017 07:51:27 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA39F15C@DGGEMA505-MBX.china.huawei.com>
References: <589C099A.9090605@huawei.com>
	<AF60004D-7133-44D1-8A9F-7DB9822D84AF@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA1B4379@DGGEMA505-MBX.china.huawei.com>
	<105e5774-38c3-0683-ca08-64f6ed53c643@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA1B6988@DGGEMA505-MBX.china.huawei.com>
	<2127602137.20489688.1486827559449.JavaMail.zimbra@redhat.com>
	<1486980300.17184.28.camel@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA1BD1CA@DGGEMA505-MBX.china.huawei.com>
	<ea1dbe94-7343-ef9e-56e1-9c6d8bcd78d6@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA1C13C3@DGGEMA505-MBX.china.huawei.com>
	<43632326-97a1-1f60-39f4-1044cd596b66@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA1C1608@DGGEMA505-MBX.china.huawei.com>
	<ec45f714-66f7-ba93-70c2-e2a033ad4ccd@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA1C16C5@DGGEMA505-MBX.china.huawei.com>
	<b6daba68-f3e2-74ff-6fa8-fab6a04d9813@redhat.com>
In-Reply-To: <b6daba68-f3e2-74ff-6fa8-fab6a04d9813@redhat.com>
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
To: Vadim Rozenfeld <vrozenfe@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Yan Vugenfirer <yvugenfi@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Radim Krcmar <rkrcmar@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>


> -----Original Message-----
> From: Vadim Rozenfeld [mailto:vrozenfe@redhat.com]
> Sent: Tuesday, September 05, 2017 2:33 PM
> To: Gonglei (Arei); Paolo Bonzini
> Cc: Hangaohuai; Yan Vugenfirer; qemu-devel@nongnu.org;
> kvm@vger.kernel.org; Radim Krcmar
> Subject: Re: [Qemu-devel] [Help] Windows2012 as Guest 64+cores on KVM
> Halts
>=20
>=20
>=20
> On 21/02/17 00:18, Gonglei (Arei) wrote:
> >>
> >> On 20/02/2017 12:54, Gonglei (Arei) wrote:
> >>>> On 20/02/2017 10:19, Gonglei (Arei) wrote:
> >>>>> Hi Paolo,
> >>>>>
> >>>>>>
> >>>>>> On 16/02/2017 02:31, Gonglei (Arei) wrote:
> >>>>>>> And the below patch works for me, I can support max 255 vcpus for
> >>>> WS2012
> >>>>>>> with hyper-v enlightenments.
> >>>>>>>
> >>>>>>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> >>>>>>> index 27fd050..efe3cbc 100644
> >>>>>>> --- a/target/i386/kvm.c
> >>>>>>> +++ b/target/i386/kvm.c
> >>>>>>> @@ -772,7 +772,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
> >>>>>>>
> >>>>>>>           c =3D &cpuid_data.entries[cpuid_i++];
> >>>>>>>           c->function =3D HYPERV_CPUID_IMPLEMENT_LIMITS;
> >>>>>>> -        c->eax =3D 0x40;
> >>>>>>> +        c->eax =3D -1;
> >>>>>>>           c->ebx =3D 0x40;
> >>>>>>>
> >>>>>>>           kvm_base =3D KVM_CPUID_SIGNATURE_NEXT;
> >>>>>> This needs to depend on the machine type, but apart from that I th=
ink
> >>>>> I don't know why. Because the negative effects for this change don'=
t
> exist
> >>>>> on current QEMU IIUC, and we don't have compatible problems for liv=
e
> >>>> migration.
> >>>>
> >>>> CPUID should never change with the same machine type and command
> line.
> >>>>
> >>> OK, then how do we add compat code for the CPUID change? It's not a
> visible
> >> property.
> >>
> >> You can add a new property, something like hv-cpuid-limits-eax.
> >>
> > Sounds good. Let me try.  :)
> >
> > Thanks,
> > -Gonglei
> Hi Gonglei,
> Any update on this issue?
>=20
> We've found that SVVP on WS2016  is passing successfully with the above
> change
> and more than 64 vCPUs defined.
>=20
> Vadim.

Thanks for reminding me :)

I'll send this patch this evening, and welcome to test it then.


Regards,
-Gonglei
=20
