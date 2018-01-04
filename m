Received: from eggs.gnu.org ([2001:4830:134:3::10]:42972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1eX176-0004dD-3M
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 03:43:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1eX171-00060D-Q1
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 03:43:00 -0500
Received: from mailpro.odiso.net ([89.248.211.110]:36312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aderumier@oxygem.tv>) id 1eX171-0005kd-Gl
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 03:42:55 -0500
Date: Thu, 4 Jan 2018 09:35:01 +0100 (CET)
From: Alexandre DERUMIER <aderumier@odiso.com>
Message-ID: <130240891.820052.1515054901352.JavaMail.zimbra@oxygem.tv>
In-Reply-To: <cb656289-97ee-d45e-cfcc-51e86b9a11ce@profihost.ag>
References: <6d95cc4b-155c-44cb-1fc0-18ba848741ac@profihost.ag>
	<446087972.818501.1515050674109.JavaMail.zimbra@oxygem.tv>
	<1548618960.818551.1515050828217.JavaMail.zimbra@oxygem.tv>
	<cb656289-97ee-d45e-cfcc-51e86b9a11ce@profihost.ag>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] CVE-2017-5715: relevant qemu patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Stefan Priebe, Profihost AG" <s.priebe@profihost.ag>
Cc: qemu-devel <qemu-devel@nongnu.org>

>>So you need:=20
>>1.) intel / amd cpu microcode update=20
>>2.) qemu update to pass the new MSR and CPU flags from the microcode upda=
te=20
>>3.) host kernel update=20
>>4.) guest kernel update=20

are you sure we need to patch guest kernel if we are able to patch qemu ?
I have some pretty old guest (linux and windows)



If I understand, patching the host kernel, should avoid that a vm is readin=
g memory of another vm.
(the most critical)


patching the guest kernel, to avoid that a process from the vm have access =
to memory of another process of same vm.


right ?



----- Mail original -----
De: "Stefan Priebe, Profihost AG" <s.priebe@profihost.ag>
=C3=80: "aderumier" <aderumier@odiso.com>
Cc: "qemu-devel" <qemu-devel@nongnu.org>
Envoy=C3=A9: Jeudi 4 Janvier 2018 09:17:41
Objet: Re: [Qemu-devel] CVE-2017-5715: relevant qemu patches

Am 04.01.2018 um 08:27 schrieb Alexandre DERUMIER:=20
> does somebody have a redhat account to see te content of:=20
>=20
> https://access.redhat.com/solutions/3307851=20
> "Impacts of CVE-2017-5754, CVE-2017-5753, and CVE-2017-5715 to Red Hat Vi=
rtualization products"=20

i don't have one but the content might be something like this:=20
https://www.suse.com/de-de/support/kb/doc/?id=3D7022512=20

So you need:=20
1.) intel / amd cpu microcode update=20
2.) qemu update to pass the new MSR and CPU flags from the microcode update=
=20
3.) host kernel update=20
4.) guest kernel update=20

The microcode update and the kernel update is publicly available but i'm=20
missing the qemu one.=20

Greets,=20
Stefan=20

> ----- Mail original -----=20
> De: "aderumier" <aderumier@odiso.com>=20
> =C3=80: "Stefan Priebe, Profihost AG" <s.priebe@profihost.ag>=20
> Cc: "qemu-devel" <qemu-devel@nongnu.org>=20
> Envoy=C3=A9: Jeudi 4 Janvier 2018 08:24:34=20
> Objet: Re: [Qemu-devel] CVE-2017-5715: relevant qemu patches=20
>=20
>>> Can anybody point me to the relevant qemu patches?=20
>=20
> I don't have find them yet.=20
>=20
> Do you known if a vm using kvm64 cpu model is protected or not ?=20
>=20
> ----- Mail original -----=20
> De: "Stefan Priebe, Profihost AG" <s.priebe@profihost.ag>=20
> =C3=80: "qemu-devel" <qemu-devel@nongnu.org>=20
> Envoy=C3=A9: Jeudi 4 Janvier 2018 07:27:01=20
> Objet: [Qemu-devel] CVE-2017-5715: relevant qemu patches=20
>=20
> Hello,=20
>=20
> i've seen some vendors have updated qemu regarding meltdown / spectre.=20
>=20
> f.e.:=20
>=20
> CVE-2017-5715: QEMU was updated to allow passing through new MSR and=20
> CPUID flags from the host VM to the CPU, to allow enabling/disabling=20
> branch prediction features in the Intel CPU. (bsc#1068032)=20
>=20
> Can anybody point me to the relevant qemu patches?=20
>=20
> Thanks!=20
>=20
> Greets,=20
> Stefan=20
>=20
