Received: from eggs.gnu.org ([2001:4830:134:3::10]:52670)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dB3Bs-0003SH-H8
	for qemu-devel@nongnu.org; Wed, 17 May 2017 13:56:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dB3Bn-0006rI-Fr
	for qemu-devel@nongnu.org; Wed, 17 May 2017 13:56:52 -0400
Received: from mout.gmx.net ([212.227.17.20]:61674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dB3BW-0006iD-Ae
	for qemu-devel@nongnu.org; Wed, 17 May 2017 13:56:47 -0400
References: <149500755798.25192.15465936284699398425.malonedeb@gac.canonical.com>
	<f3f455ae-756d-ae8a-c551-09fb6c095116@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <8181e90f-99a2-18b3-8dfd-6e404f8cdef6@gmx.com>
Date: Wed, 17 May 2017 19:58:08 +0200
MIME-Version: 1.0
In-Reply-To: <f3f455ae-756d-ae8a-c551-09fb6c095116@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="049eP9UrvPR6OMAbkuutGXJ3HOjCHoDa2"
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
Cc: Yongbok Kim <yongbok.kim@imgtec.com>, Kamil Rytarowski <kamil@netbsd.org>, Aurelien Jarno <aurelien@aurel32.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--049eP9UrvPR6OMAbkuutGXJ3HOjCHoDa2
From: Kamil Rytarowski <n54@gmx.com>
To: Thomas Huth <thuth@redhat.com>, Bug 1691379 <1691379@bugs.launchpad.net>,
 qemu-devel@nongnu.org
Cc: Yongbok Kim <yongbok.kim@imgtec.com>, Kamil Rytarowski
 <kamil@netbsd.org>, Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <8181e90f-99a2-18b3-8dfd-6e404f8cdef6@gmx.com>
Subject: Re: [Qemu-devel] [Bug 1691379] [NEW] NetBSD evbmips64el port
 installation doesn't work with qemu-system-mips64el.
References: <149500755798.25192.15465936284699398425.malonedeb@gac.canonical.com>
 <f3f455ae-756d-ae8a-c551-09fb6c095116@redhat.com>
In-Reply-To: <f3f455ae-756d-ae8a-c551-09fb6c095116@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.05.2017 10:10, Thomas Huth wrote:
> On 17.05.2017 09:52, Utkarsh Anand wrote:
>> Public bug reported:
>>
>> I successfully installed the NetBSD evbmips64el port on gxemul but was=

>> unable to install it on qemu. Trying to boot it on qemu takes me to th=
e
>> 'db>' prompt. Here's the output and backtrace:
>>
>> panic: pcib_isa_intr_string: bogus isa irq 0x0
>> kernel: breakpoint trap
>> Stopped in pid 0.1 (system) at  netbsd:cpu_Debugger+0x4:        jr    =
  ra
>>                 bdslot: nop
>> db> bt
>> 0xffffffff805977f0: cpu_Debugger+4 (63061,90000000180003f8,6,ffffffff8=
04c2290) ra ffffffff8030acd0 sz 0
>> 0xffffffff805977f0: vpanic+158 (63061,90000000180003f8,6,ffffffff804c2=
290) ra ffffffff8030ad7c sz 64
>> 0xffffffff80597830: panic+34 (63061,ffffffff803d65b0,0,40) ra ffffffff=
80109784 sz 96
>> 0xffffffff80597890: pcib_isa_intr_string+6c (63061,ffffffff803d65b0,0,=
40) ra ffffffff80149bfc sz 16
>> 0xffffffff805978a0: uhci_pci_attach+16c (63061,ffffffff803d65b0,0,40) =
ra ffffffff802f0400 sz 176
>> 0xffffffff80597950: config_attach_loc+1c8 (63061,ffffffff803d65b0,0,40=
) ra ffffffff802f053c sz 64
>> 0xffffffff80597990: config_found_sm_loc+5c (63061,ffffffff803d65b0,0,4=
0) ra ffffffff80121354 sz 64
>> 0xffffffff805979d0: pci_probe_device+524 (63061,ffffffff803d65b0,0,0) =
ra ffffffff80121548 sz 288
>> 0xffffffff80597af0: pci_enumerate_bus+1d0 (63061,ffffffff803d65b0,0,0)=
 ra ffffffff8012167c sz 160
>> 0xffffffff80597b90: pcirescan+5c (63061,ffffffff803d65b0,0,0) ra fffff=
fff801218c4 sz 32
>> 0xffffffff80597bb0: pciattach+19c (63061,ffffffff803d65b0,0,0) ra ffff=
ffff802f0400 sz 80
>> 0xffffffff80597c00: config_attach_loc+1c8 (63061,ffffffff803d65b0,0,0)=
 ra ffffffff802f053c sz 64
>> 0xffffffff80597c40: config_found_sm_loc+5c (63061,ffffffff803d65b0,0,0=
) ra ffffffff80108934 sz 64
>> 0xffffffff80597c80: gt_attach+7c (63061,ffffffff803d65b0,0,0) ra fffff=
fff802f0400 sz 112  =20
>> 0xffffffff80597cf0: config_attach_loc+1c8 (63061,ffffffff803d65b0,0,0)=
 ra ffffffff802f053c sz 64
>> 0xffffffff80597d30: config_found_sm_loc+5c (63061,ffffffff803d65b0,0,0=
) ra ffffffff801086ac sz 64
>> 0xffffffff80597d70: mainbus_attach+dc (63061,ffffffff803d65b0,0,0) ra =
ffffffff802f0400 sz 96
>> 0xffffffff80597dd0: config_attach_loc+1c8 (63061,ffffffff803d65b0,0,0)=
 ra ffffffff80104bf8 sz 64
>> 0xffffffff80597e10: cpu_configure+28 (63061,ffffffff803d65b0,0,0) ra f=
fffffff803d5f30 sz 16
>> 0xffffffff80597e20: main+3a0 (63061,ffffffff803d65b0,0,0) ra ffffffff8=
01000dc sz 128      =20
>> 0xffffffff80597ea0: kernel_text+dc (63061,ffffffff803d65b0,0,0) ra 0 s=
z 0
>> User-level: pid 0.1
>>
>> Here's the command that I used:
>>
>> Build evbmips64el from source and then launch it from qemu (replace th=
e
>> paths relative to your system):
>>
>> qemu-system-mips64el -cdrom
>> /extra/evbmips64/distrib/evbmips/cdroms/installcd/NetBSD-7.99.71
>> -evbmips-mips64el.iso -hda /extra/evbmips64.img -kernel
>> /extra/evbmips64/releasedir/evbmips/installation/netbsd-INSTALL_MALTA6=
4
>> -nographic -M malta
>>
>> (I've decompressed the kernel)
>>
>> Here's the output for qemu-system-mips64el --version :
>>
>> QEMU emulator version 2.7.1(qemu-2.7.1-6.fc25), Copyright (c) 2003-201=
6
>> Fabrice Bellard and the QEMU Project developers
>>
>> This doesn't look like a NetBSD bug. I've attached a screenshot of the=

>> working installation using gxemul in the attachments.
>=20
> When reporting such issues, please always use the latest release of QEM=
U
> first, so could you please try again with the latest upstream release o=
f
> QEMU (currently v2.9.0)? Thanks!
>=20
>  Thomas
>=20

7.99.71 is the most recent kernel ABI version (NetBSD-current).

Release engineering builds of NetBSD-current are hosted on nyftp.netbsd.o=
rg.

kernel:

http://nyftp.netbsd.org/pub/NetBSD-daily/HEAD/201705170540Z/evbmips-mips6=
4el/installation/

installation medium:

http://nyftp.netbsd.org/pub/NetBSD-daily/HEAD/201705170540Z/images/

[In future there will be need to switch 201705170540Z to a newer
snapshot, as this one will be removed.]

I will have to a look tonight and try to reproduce locally (and take
MIPS 64-bit crash course).


--049eP9UrvPR6OMAbkuutGXJ3HOjCHoDa2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZHI82AAoJEEuzCOmwLnZsIMoQAItZedT2fYXbF0C/9YlaV3P7
0Zv11c/uNp7uiowQKSTxUfUHLDPQbE4j4ktoJQg3qzh05/9gyAOBxE9/hohu4ZtJ
7YpJgxsBqmpGwlt4fMVGf3Iudq5zvHTydRCfChctNC4jD7Xr2WfNnvrXz2ewhnPU
zaUYHjVwYrng1LjbjucPYmDoap392wBKSYrFVCdvcfda3xHRhRB52Ll3qtahE06C
pQAhZYsQv3mt9IBd7LRLfacCQI/DehHhyKsjTiJ7u9SQn/i2LSAJQXwS1hvwAr1Q
W80q0oKYF5JkDsqF/Pck4gJDISjijrxiW0pGpckOhVTMg0a/4wLNhpT+zZ7WuOlf
Jz/+m9moBcLzKjGgNXD33hlCCnVxCxm04GdscNRMv2KKyHpLY70qU9WgbwnnyU8X
6bfe772CR6+vmF5aODzDFeQSuirrI7gQwqTALi1n3XXqDr12oSUX7HnT1nBf+tRW
EnhjrFb6Yd86TqNMU6GtucTTXqoLI8bdKwI9/U1KMDS0c+fiV8xUOcuO+NWpoPt2
Iyp2HVcHIz9Hd1ywHjN4prSSZota56OoQWvklZ1AFjlxJuVzKcH3/Tghal9+IURR
QWT2R50bOWKA5oYBE4Gh9nTjFqJmsfTAwfNvYUsh3/1lAGUCddH2Grnb5fa8/Fbh
OLhqja9IeW2JUecnWZCI
=AcS1
-----END PGP SIGNATURE-----

--049eP9UrvPR6OMAbkuutGXJ3HOjCHoDa2--
