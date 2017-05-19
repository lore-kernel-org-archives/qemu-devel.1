Received: from eggs.gnu.org ([2001:4830:134:3::10]:45813)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dBWGE-0005uR-0e
	for qemu-devel@nongnu.org; Thu, 18 May 2017 20:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dBWGA-00089X-2h
	for qemu-devel@nongnu.org; Thu, 18 May 2017 20:59:18 -0400
Received: from mout.gmx.net ([212.227.15.19]:50750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dBWG9-00089E-N8
	for qemu-devel@nongnu.org; Thu, 18 May 2017 20:59:14 -0400
References: <149500755798.25192.15465936284699398425.malonedeb@gac.canonical.com>
	<f3f455ae-756d-ae8a-c551-09fb6c095116@redhat.com>
	<8181e90f-99a2-18b3-8dfd-6e404f8cdef6@gmx.com>
	<6f73123b-d235-3680-89cc-8ed5b02a7040@gmx.com>
	<20170518105413.35nurpeltmtj7l3q@aurel32.net>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <910015d5-3f29-92cf-dba6-40b0dedd7a06@gmx.com>
Date: Fri, 19 May 2017 02:50:26 +0200
MIME-Version: 1.0
In-Reply-To: <20170518105413.35nurpeltmtj7l3q@aurel32.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ttdskhAh67x3BupmrPhOb9MKGeBDH4mfb"
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
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: Bug 1691379 <1691379@bugs.launchpad.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ttdskhAh67x3BupmrPhOb9MKGeBDH4mfb
From: Kamil Rytarowski <n54@gmx.com>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: Bug 1691379 <1691379@bugs.launchpad.net>,
 Yongbok Kim <yongbok.kim@imgtec.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <910015d5-3f29-92cf-dba6-40b0dedd7a06@gmx.com>
Subject: Re: [Qemu-devel] [Bug 1691379] [NEW] NetBSD evbmips64el port
 installation doesn't work with qemu-system-mips64el.
References: <149500755798.25192.15465936284699398425.malonedeb@gac.canonical.com>
 <f3f455ae-756d-ae8a-c551-09fb6c095116@redhat.com>
 <8181e90f-99a2-18b3-8dfd-6e404f8cdef6@gmx.com>
 <6f73123b-d235-3680-89cc-8ed5b02a7040@gmx.com>
 <20170518105413.35nurpeltmtj7l3q@aurel32.net>
In-Reply-To: <20170518105413.35nurpeltmtj7l3q@aurel32.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 18.05.2017 12:54, Aurelien Jarno wrote:
> On 2017-05-18 04:29, Kamil Rytarowski wrote:
>> On 17.05.2017 19:58, Kamil Rytarowski wrote:
>>> On 17.05.2017 10:10, Thomas Huth wrote:
>>>> On 17.05.2017 09:52, Utkarsh Anand wrote:
>>>>> Public bug reported:
>>>>>
>>>>> I successfully installed the NetBSD evbmips64el port on gxemul but =
was
>>>>> unable to install it on qemu. Trying to boot it on qemu takes me to=
 the
>>>>> 'db>' prompt. Here's the output and backtrace:
>>>>>
>>>>> panic: pcib_isa_intr_string: bogus isa irq 0x0
>>>>> kernel: breakpoint trap
>>>>> Stopped in pid 0.1 (system) at  netbsd:cpu_Debugger+0x4:        jr =
     ra
>>>>>                 bdslot: nop
>>>>> db> bt
>>>>> 0xffffffff805977f0: cpu_Debugger+4 (63061,90000000180003f8,6,ffffff=
ff804c2290) ra ffffffff8030acd0 sz 0
>>>>> 0xffffffff805977f0: vpanic+158 (63061,90000000180003f8,6,ffffffff80=
4c2290) ra ffffffff8030ad7c sz 64
>>>>> 0xffffffff80597830: panic+34 (63061,ffffffff803d65b0,0,40) ra fffff=
fff80109784 sz 96
>>>>> 0xffffffff80597890: pcib_isa_intr_string+6c (63061,ffffffff803d65b0=
,0,40) ra ffffffff80149bfc sz 16
>>>>> 0xffffffff805978a0: uhci_pci_attach+16c (63061,ffffffff803d65b0,0,4=
0) ra ffffffff802f0400 sz 176
>>>>> 0xffffffff80597950: config_attach_loc+1c8 (63061,ffffffff803d65b0,0=
,40) ra ffffffff802f053c sz 64
>>>>> 0xffffffff80597990: config_found_sm_loc+5c (63061,ffffffff803d65b0,=
0,40) ra ffffffff80121354 sz 64
>>>>> 0xffffffff805979d0: pci_probe_device+524 (63061,ffffffff803d65b0,0,=
0) ra ffffffff80121548 sz 288
>>>>> 0xffffffff80597af0: pci_enumerate_bus+1d0 (63061,ffffffff803d65b0,0=
,0) ra ffffffff8012167c sz 160
>>>>> 0xffffffff80597b90: pcirescan+5c (63061,ffffffff803d65b0,0,0) ra ff=
ffffff801218c4 sz 32
>>>>> 0xffffffff80597bb0: pciattach+19c (63061,ffffffff803d65b0,0,0) ra f=
fffffff802f0400 sz 80
>>>>> 0xffffffff80597c00: config_attach_loc+1c8 (63061,ffffffff803d65b0,0=
,0) ra ffffffff802f053c sz 64
>>>>> 0xffffffff80597c40: config_found_sm_loc+5c (63061,ffffffff803d65b0,=
0,0) ra ffffffff80108934 sz 64
>>>>> 0xffffffff80597c80: gt_attach+7c (63061,ffffffff803d65b0,0,0) ra ff=
ffffff802f0400 sz 112  =20
>>>>> 0xffffffff80597cf0: config_attach_loc+1c8 (63061,ffffffff803d65b0,0=
,0) ra ffffffff802f053c sz 64
>>>>> 0xffffffff80597d30: config_found_sm_loc+5c (63061,ffffffff803d65b0,=
0,0) ra ffffffff801086ac sz 64
>>>>> 0xffffffff80597d70: mainbus_attach+dc (63061,ffffffff803d65b0,0,0) =
ra ffffffff802f0400 sz 96
>>>>> 0xffffffff80597dd0: config_attach_loc+1c8 (63061,ffffffff803d65b0,0=
,0) ra ffffffff80104bf8 sz 64
>>>>> 0xffffffff80597e10: cpu_configure+28 (63061,ffffffff803d65b0,0,0) r=
a ffffffff803d5f30 sz 16
>>>>> 0xffffffff80597e20: main+3a0 (63061,ffffffff803d65b0,0,0) ra ffffff=
ff801000dc sz 128      =20
>>>>> 0xffffffff80597ea0: kernel_text+dc (63061,ffffffff803d65b0,0,0) ra =
0 sz 0
>>>>> User-level: pid 0.1
>>>>>
>>>>> Here's the command that I used:
>>>>>
>>>>> Build evbmips64el from source and then launch it from qemu (replace=
 the
>>>>> paths relative to your system):
>>>>>
>>>>> qemu-system-mips64el -cdrom
>>>>> /extra/evbmips64/distrib/evbmips/cdroms/installcd/NetBSD-7.99.71
>>>>> -evbmips-mips64el.iso -hda /extra/evbmips64.img -kernel
>>>>> /extra/evbmips64/releasedir/evbmips/installation/netbsd-INSTALL_MAL=
TA64
>>>>> -nographic -M malta
>>>>>
>>>>> (I've decompressed the kernel)
>>>>>
>>>>> Here's the output for qemu-system-mips64el --version :
>>>>>
>>>>> QEMU emulator version 2.7.1(qemu-2.7.1-6.fc25), Copyright (c) 2003-=
2016
>>>>> Fabrice Bellard and the QEMU Project developers
>>>>>
>>>>> This doesn't look like a NetBSD bug. I've attached a screenshot of =
the
>>>>> working installation using gxemul in the attachments.
>>>>
>>>> When reporting such issues, please always use the latest release of =
QEMU
>>>> first, so could you please try again with the latest upstream releas=
e of
>>>> QEMU (currently v2.9.0)? Thanks!
>>>>
>>>>  Thomas
>>>>
>>>
>>> 7.99.71 is the most recent kernel ABI version (NetBSD-current).
>>>
>>> Release engineering builds of NetBSD-current are hosted on nyftp.netb=
sd.org.
>>>
>>> kernel:
>>>
>>> http://nyftp.netbsd.org/pub/NetBSD-daily/HEAD/201705170540Z/evbmips-m=
ips64el/installation/
>>>
>>> installation medium:
>>>
>>> http://nyftp.netbsd.org/pub/NetBSD-daily/HEAD/201705170540Z/images/
>>>
>>> [In future there will be need to switch 201705170540Z to a newer
>>> snapshot, as this one will be removed.]
>>>
>>> I will have to a look tonight and try to reproduce locally (and take
>>> MIPS 64-bit crash course).
>>>
>>
>> I've reproduced it locally with qemu/NetBSD-7.99.71 ver. 2.9 git HEAD
>> (rev. cdece0467c00007cf8e3).
>>
>>     464 const char *
>>     465 pcib_isa_intr_string(void *v, int irq, char *buf, size_t len)
>>     466 {
>>     467 	if (irq =3D=3D 0 || irq >=3D ICU_LEN || irq =3D=3D 2)
>>     468 		panic("%s: bogus isa irq 0x%x", __func__, irq);
>>     469
>>     470 	snprintf(buf, len, "isa irq %d", irq);
>>     471 	return buf;
>>     472 }
>>
>> Generates: "panic: pcib_isa_intr_string: bogus isa irq 0x0".
>=20
> I haven't look in details, but it looks like that the PCI initializatio=
n
> hasn't been done. This should be the responsibility of the firmware, bu=
t
> the Malta emulation doesn't use any firmware when booting with -kernel.=
 It
> works with the Linux kernel because there is some fixup code which does=

> the work if it hasn't been done in the firmware. See:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/arch/mips/pci/fixup-malta.c
>=20
> One option would be to implement the same on the NetBSD side. The other=

> option is to use YAMON or U-Boot to load the NetBSD kernel.
>=20
> Aurelien
>=20

Thanks, this makes sense. I have forwarded this message to NetBSD
developers:

http://gnats.netbsd.org/52238


--ttdskhAh67x3BupmrPhOb9MKGeBDH4mfb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZHkFhAAoJEEuzCOmwLnZsVJ0P/0fm19XDLU5TqlaMmNoRhEnN
XQZ7wpJKp7+vncb+XeBFDGzDqZIp0DiaJ5FXpbX5f32rsIgFLH1qVk+cl2XAVfK8
tjCiicrVH6UuT7W0a0/GZAak4zFbMFSqN4uBt7WHynqmmpIdNNa9PCvfCJgMH/pg
VqzZnkcVofTP1zdhXdCGOtQefMwk8DPUZYob62ZS0AAZtoQ/HF/0xf7xAFELRgM0
EdzHgX6Nv8MosXFXFeLZpy/hXZJNaPd4/bzygSyeyfHFJQWo+b0YwD0OXz7ilVXi
kZsoY/EcnTmlUpusqoFRTtKk8N6Z+en3a4B3LpY+qxoaRAyM7Oh5OMCzc3c2NpXF
oVG1x0LvD1SKfMcL5p7L51lNGR47voLfFZzjAugs+WtGGHsJj42F4bcBwYXB1heZ
Qy1paDIs5phx7S1CQSYlaSYno7VRYyDihOykoxbTc3n8zcnYV4UFGZNXrx3ECQMr
KCZqlpkzcC+jZTmlZOw2XU7kmfLAs9PoLBAeLDqwjp44XWI6YSAH9tu6OVAlmAAm
/tt+p1CGUaAZN6DwHc0Z77titTInQMAapSg5biAV9BTkIJwu7RV+R/EBAHC50Qky
FTJdk4VkT/PIVlqambgpHO6DGCKvDrxlKLgNntd6LusDGrw1p1VMsBmK/MNrEivd
iiGlo3hWAIAoi1zZCh4P
=ICQR
-----END PGP SIGNATURE-----

--ttdskhAh67x3BupmrPhOb9MKGeBDH4mfb--
