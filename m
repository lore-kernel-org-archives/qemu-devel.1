Received: from eggs.gnu.org ([2001:4830:134:3::10]:41532)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dBBKC-0004P1-HL
	for qemu-devel@nongnu.org; Wed, 17 May 2017 22:38:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dBBK8-0007MK-Ft
	for qemu-devel@nongnu.org; Wed, 17 May 2017 22:38:00 -0400
Received: from mout.gmx.net ([212.227.15.15]:50984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dBBK8-0007M3-33
	for qemu-devel@nongnu.org; Wed, 17 May 2017 22:37:56 -0400
References: <149500755798.25192.15465936284699398425.malonedeb@gac.canonical.com>
	<f3f455ae-756d-ae8a-c551-09fb6c095116@redhat.com>
	<8181e90f-99a2-18b3-8dfd-6e404f8cdef6@gmx.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <6f73123b-d235-3680-89cc-8ed5b02a7040@gmx.com>
Date: Thu, 18 May 2017 04:29:14 +0200
MIME-Version: 1.0
In-Reply-To: <8181e90f-99a2-18b3-8dfd-6e404f8cdef6@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SlH3SGQ4QD0TDDmrPMVKU6dnNnGULFv1S"
Subject: Re: [Qemu-devel] [Bug 1691379] [NEW] NetBSD evbmips64el port
 installation doesn't work with qemu-system-mips64el.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Bug 1691379 <1691379@bugs.launchpad.net>, qemu-devel@nongnu.org
Cc: Yongbok Kim <yongbok.kim@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SlH3SGQ4QD0TDDmrPMVKU6dnNnGULFv1S
From: Kamil Rytarowski <n54@gmx.com>
To: Thomas Huth <thuth@redhat.com>, Bug 1691379 <1691379@bugs.launchpad.net>,
 qemu-devel@nongnu.org
Cc: Yongbok Kim <yongbok.kim@imgtec.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <6f73123b-d235-3680-89cc-8ed5b02a7040@gmx.com>
Subject: Re: [Qemu-devel] [Bug 1691379] [NEW] NetBSD evbmips64el port
 installation doesn't work with qemu-system-mips64el.
References: <149500755798.25192.15465936284699398425.malonedeb@gac.canonical.com>
 <f3f455ae-756d-ae8a-c551-09fb6c095116@redhat.com>
 <8181e90f-99a2-18b3-8dfd-6e404f8cdef6@gmx.com>
In-Reply-To: <8181e90f-99a2-18b3-8dfd-6e404f8cdef6@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.05.2017 19:58, Kamil Rytarowski wrote:
> On 17.05.2017 10:10, Thomas Huth wrote:
>> On 17.05.2017 09:52, Utkarsh Anand wrote:
>>> Public bug reported:
>>>
>>> I successfully installed the NetBSD evbmips64el port on gxemul but wa=
s
>>> unable to install it on qemu. Trying to boot it on qemu takes me to t=
he
>>> 'db>' prompt. Here's the output and backtrace:
>>>
>>> panic: pcib_isa_intr_string: bogus isa irq 0x0
>>> kernel: breakpoint trap
>>> Stopped in pid 0.1 (system) at  netbsd:cpu_Debugger+0x4:        jr   =
   ra
>>>                 bdslot: nop
>>> db> bt
>>> 0xffffffff805977f0: cpu_Debugger+4 (63061,90000000180003f8,6,ffffffff=
804c2290) ra ffffffff8030acd0 sz 0
>>> 0xffffffff805977f0: vpanic+158 (63061,90000000180003f8,6,ffffffff804c=
2290) ra ffffffff8030ad7c sz 64
>>> 0xffffffff80597830: panic+34 (63061,ffffffff803d65b0,0,40) ra fffffff=
f80109784 sz 96
>>> 0xffffffff80597890: pcib_isa_intr_string+6c (63061,ffffffff803d65b0,0=
,40) ra ffffffff80149bfc sz 16
>>> 0xffffffff805978a0: uhci_pci_attach+16c (63061,ffffffff803d65b0,0,40)=
 ra ffffffff802f0400 sz 176
>>> 0xffffffff80597950: config_attach_loc+1c8 (63061,ffffffff803d65b0,0,4=
0) ra ffffffff802f053c sz 64
>>> 0xffffffff80597990: config_found_sm_loc+5c (63061,ffffffff803d65b0,0,=
40) ra ffffffff80121354 sz 64
>>> 0xffffffff805979d0: pci_probe_device+524 (63061,ffffffff803d65b0,0,0)=
 ra ffffffff80121548 sz 288
>>> 0xffffffff80597af0: pci_enumerate_bus+1d0 (63061,ffffffff803d65b0,0,0=
) ra ffffffff8012167c sz 160
>>> 0xffffffff80597b90: pcirescan+5c (63061,ffffffff803d65b0,0,0) ra ffff=
ffff801218c4 sz 32
>>> 0xffffffff80597bb0: pciattach+19c (63061,ffffffff803d65b0,0,0) ra fff=
fffff802f0400 sz 80
>>> 0xffffffff80597c00: config_attach_loc+1c8 (63061,ffffffff803d65b0,0,0=
) ra ffffffff802f053c sz 64
>>> 0xffffffff80597c40: config_found_sm_loc+5c (63061,ffffffff803d65b0,0,=
0) ra ffffffff80108934 sz 64
>>> 0xffffffff80597c80: gt_attach+7c (63061,ffffffff803d65b0,0,0) ra ffff=
ffff802f0400 sz 112  =20
>>> 0xffffffff80597cf0: config_attach_loc+1c8 (63061,ffffffff803d65b0,0,0=
) ra ffffffff802f053c sz 64
>>> 0xffffffff80597d30: config_found_sm_loc+5c (63061,ffffffff803d65b0,0,=
0) ra ffffffff801086ac sz 64
>>> 0xffffffff80597d70: mainbus_attach+dc (63061,ffffffff803d65b0,0,0) ra=
 ffffffff802f0400 sz 96
>>> 0xffffffff80597dd0: config_attach_loc+1c8 (63061,ffffffff803d65b0,0,0=
) ra ffffffff80104bf8 sz 64
>>> 0xffffffff80597e10: cpu_configure+28 (63061,ffffffff803d65b0,0,0) ra =
ffffffff803d5f30 sz 16
>>> 0xffffffff80597e20: main+3a0 (63061,ffffffff803d65b0,0,0) ra ffffffff=
801000dc sz 128      =20
>>> 0xffffffff80597ea0: kernel_text+dc (63061,ffffffff803d65b0,0,0) ra 0 =
sz 0
>>> User-level: pid 0.1
>>>
>>> Here's the command that I used:
>>>
>>> Build evbmips64el from source and then launch it from qemu (replace t=
he
>>> paths relative to your system):
>>>
>>> qemu-system-mips64el -cdrom
>>> /extra/evbmips64/distrib/evbmips/cdroms/installcd/NetBSD-7.99.71
>>> -evbmips-mips64el.iso -hda /extra/evbmips64.img -kernel
>>> /extra/evbmips64/releasedir/evbmips/installation/netbsd-INSTALL_MALTA=
64
>>> -nographic -M malta
>>>
>>> (I've decompressed the kernel)
>>>
>>> Here's the output for qemu-system-mips64el --version :
>>>
>>> QEMU emulator version 2.7.1(qemu-2.7.1-6.fc25), Copyright (c) 2003-20=
16
>>> Fabrice Bellard and the QEMU Project developers
>>>
>>> This doesn't look like a NetBSD bug. I've attached a screenshot of th=
e
>>> working installation using gxemul in the attachments.
>>
>> When reporting such issues, please always use the latest release of QE=
MU
>> first, so could you please try again with the latest upstream release =
of
>> QEMU (currently v2.9.0)? Thanks!
>>
>>  Thomas
>>
>=20
> 7.99.71 is the most recent kernel ABI version (NetBSD-current).
>=20
> Release engineering builds of NetBSD-current are hosted on nyftp.netbsd=
=2Eorg.
>=20
> kernel:
>=20
> http://nyftp.netbsd.org/pub/NetBSD-daily/HEAD/201705170540Z/evbmips-mip=
s64el/installation/
>=20
> installation medium:
>=20
> http://nyftp.netbsd.org/pub/NetBSD-daily/HEAD/201705170540Z/images/
>=20
> [In future there will be need to switch 201705170540Z to a newer
> snapshot, as this one will be removed.]
>=20
> I will have to a look tonight and try to reproduce locally (and take
> MIPS 64-bit crash course).
>=20

I've reproduced it locally with qemu/NetBSD-7.99.71 ver. 2.9 git HEAD
(rev. cdece0467c00007cf8e3).

    464 const char *
    465 pcib_isa_intr_string(void *v, int irq, char *buf, size_t len)
    466 {
    467 	if (irq =3D=3D 0 || irq >=3D ICU_LEN || irq =3D=3D 2)
    468 		panic("%s: bogus isa irq 0x%x", __func__, irq);
    469
    470 	snprintf(buf, len, "isa irq %d", irq);
    471 	return buf;
    472 }

Generates: "panic: pcib_isa_intr_string: bogus isa irq 0x0".

https://nxr.netbsd.org/xref/src/sys/arch/evbmips/malta/pci/pcib.c?r=3D1.1=
8#464

I will try to see if it ever worked (older NetBSD kernel / older qemu)
and if so, bisect. If it never worked I will see what I can do with it.


--SlH3SGQ4QD0TDDmrPMVKU6dnNnGULFv1S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZHQcEAAoJEEuzCOmwLnZs388P/RLryDz3UafxaYRc1fNiblp8
hgqo88nsHEeVQe+ly6Bp9cAGyBk1SPFERioinoBF38ex2hvsRiduIGpwiGqlTKda
XtxzHRiILU9M8pfcLzIvocytvEtiyF0ISEDBJM+m8jlONjA88TzzkDgVbRA5hy/t
O9VoHmtkFWt7fc/uBGKrdrwOLDLFRrLvfuWFjWmvPzxZb0hQanT5ujkyHmlbMs23
25URn/6RHG/Y/q6ZZ2J9DHRJxkabtTqN8EVjOs2mcNizNp0NlFY8cvDqzLzNPA27
zhxasCwR98rKi23wSg+HgXF70QVNLXR3+0FTRsIf8qYfaezJtwyMSPu+3BQNF04Y
LLf2GcMWZ07Gk/pozNs/hyi/Q+BR/9PKoXmBEC1TZTMiVmffG37PPz/fafeEcrJB
IwLvMh+zQnkMZSN+oGTU4YNUJ/RcRFY6/6ke07t3Lm5BIJ+kra3OhxPdjiPf5Hpo
EPkPP4ENOkhEvHgeefCK9BZSLH5yThQrgSvoF8h3YZ7AWglUp186Hr4Rpvs+Eubh
2SN+Cjuto4PNCjWFwQ3PU++1w38EwNR1uiOQ9ODSuDiLGEXcbmDQPct4BlSGV3oL
p7887oqSuAnIpgSi3i/eSFs+md7d0NEpPtjj50cEVnT5GTy+eS/2Qn8WciDgq619
bfM8k6l61OILZyVIAzdH
=BRZn
-----END PGP SIGNATURE-----

--SlH3SGQ4QD0TDDmrPMVKU6dnNnGULFv1S--
