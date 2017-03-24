Received: from eggs.gnu.org ([2001:4830:134:3::10]:57741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1crRQ0-0008QA-5T
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:46:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1crRPx-000161-1j
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:46:24 -0400
Received: from 3.mo7.mail-out.ovh.net ([46.105.34.113]:56181)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1crRPw-00013x-Rf
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:46:20 -0400
Received: from player788.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id EFF4F48FA3
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 16:46:18 +0100 (CET)
References: <20170322092818.25605.49354.malonedeb@gac.canonical.com>
	<20170322133509.30547.6423.malone@soybean.canonical.com>
	<69a94326-4115-cac7-7f0f-1f455896fd2c@redhat.com>
	<e7be24c8-dbc6-0e32-5b18-73cd5454fc64@kaod.org>
	<AM5P194MB01291ABD7713F7A68E517AB6C83C0@AM5P194MB0129.EURP194.PROD.OUTLOOK.COM>
	<4c420daf-83f4-8f4e-160f-a880041b2c51@kaod.org>
	<AM5P194MB01297823A835C4F56CE786AAC83C0@AM5P194MB0129.EURP194.PROD.OUTLOOK.COM>
	<2f2d5717-6b28-ea35-ceba-f005a2ce13ef@kaod.org>
	<AM5P194MB0129DD9D4ADC6D711725D4D8C83E0@AM5P194MB0129.EURP194.PROD.OUTLOOK.COM>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <8b068f22-16fe-371a-76f3-37a7d8de306e@kaod.org>
Date: Fri, 24 Mar 2017 16:46:14 +0100
MIME-Version: 1.0
In-Reply-To: <AM5P194MB0129DD9D4ADC6D711725D4D8C83E0@AM5P194MB0129.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [Bug 1674925] Re: Qemu PPC64 kvm no
 display if --device virtio-gpu-pci is selected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: luigi burdo <intermediadc@hotmail.com>, Thomas Huth <thuth@redhat.com>, Bug 1674925 <1674925@bugs.launchpad.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemU-ppc@nongnu.org" <qemU-ppc@nongnu.org>

On 03/24/2017 12:31 PM, luigi burdo wrote:
> Hi C=E8dric,
>=20
> first of all thanks for your relpy.
>=20
>=20
>=20
>=20
>>I have some difficulty sorting out what is going on and what
>>could be considered a regression :/ you are reporting many
>>issues at the same time with a home made kernel.
>=20
>>Could you please use the kernel shipped with the distro to
>>start with ?
>=20
> I can do it and report.
>=20
>> yes usually with 2.8 i  boot  the VM without issue on G5 Quad  with th=
e option
>> -M  pseries from 2.1 to 2.5 with kvm-pr enabled.
>> i did the tests and with all pseries now on 2.9 i have the same issue.
>> example:
>> qemu-system-ppc64 --enable-kvm -cpu 970fx_v2.0 -m 1024 -M pseries-2.1
>> qemu-system-ppc64: KVM and IRQ_XICS capability must be present for in-=
kernel XICS
>=20
>>This error message is because your host kernel lacks in-kernel XICS,
>>but you are saying that was not an issue with QEMU-2.8. Correct ?=20
>=20
> Exactly i have the same on Qoriq too.

I will look at the problem but I think you should recompile your kernel=20
with in-kernel XICS or use the kernel shipped by the distro you use.
=20
>>Here is the command line I used on a 17.04 host :
>>qemu-system-ppc64 -M pseries-2.[1-8],accel=3Dkvm,kvm-type=3DPR -cpu 970=
fx_v2.0 -m 1024 -nographic
>=20
> I will try your same command line and see what will exit on me.
> I cant use qemu on 17.04 host because there is no more support=20
> for PPC32, PPC64 dead line is 16.10 and last working version
> of qemu on PPC  is 2.6.1  i dint try 2.9 there if needed i can=20
> do i have ubuntu mate 17.04 installed too.

Also please try with a core supported by pseries :=20

    /* 970 */
    "970_v2.2",

    /* 970MP variants */
    "970MP_v1.0",
    "970mp_v1.0",
    "970MP_v1.1",
    "970mp_v1.1",

you should be fine with these.

Thanks,

C.


>>Did we introduce a regression in compatibility in QEMU 2.9 ?  or=20
> Im facing many issue on this last update im try to help how i can befor=
e all come upstream.
> i like really much qemu. i can help in testing on PPC64 Be if need with=
 my hw.
>>was it bogus before ? That needs a little digging. I did not work
>>on that part.
> dont worry you did much=20
>=20
> Thanks=20
> Luigi=20
>=20
>=20
>=20
