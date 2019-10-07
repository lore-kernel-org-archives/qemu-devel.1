Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URI_NOVOWEL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764E9ECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 18:21:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CBDF206BB
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 18:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBDF206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHXdT-0007YO-Cp
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 14:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <benh@debian.org>) id 1iHWpL-0008Eg-6N
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 13:29:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <benh@debian.org>) id 1iHWpJ-0006M1-OS
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 13:29:43 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:57578)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <benh@debian.org>) id 1iHWpJ-0006Kw-Hw
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 13:29:41 -0400
Received: from [192.168.4.242] (helo=deadeye)
 by shadbolt.decadent.org.uk with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <benh@debian.org>)
 id 1iHWp6-00031H-EF; Mon, 07 Oct 2019 18:29:28 +0100
Received: from ben by deadeye with local (Exim 4.92.2)
 (envelope-from <benh@debian.org>)
 id 1iHWp6-0003It-8j; Mon, 07 Oct 2019 18:29:28 +0100
Message-ID: <0243ea3a388f77dd8002853310081af23a7d787b.camel@debian.org>
Subject: Re: [Qemu-devel] Bug#919921: qemu-user Linux ELF loader fails to
 handle pure BSS segments
From: Ben Hutchings <benh@debian.org>
To: Richard Henderson <richard.henderson@linaro.org>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Michael Tokarev
 <mjt@tls.msk.ru>, 919921@bugs.debian.org,  Laurent Vivier
 <laurent@vivier.eu>
Date: Mon, 07 Oct 2019 18:29:19 +0100
In-Reply-To: <0fd131fc-3802-dde3-e21c-6c3ea5a444e3@linaro.org>
References: <154800690066.11444.6761064786302350654.reportbug@deadeye.wl.decadent.org.uk>
 <4caef357-e49b-2314-ee19-3ae31f8e4c30@msgid.tls.msk.ru>
 <d78c26dc-727c-b58b-9536-a715aa44da77@redhat.com>
 <0fd131fc-3802-dde3-e21c-6c3ea5a444e3@linaro.org>
Organization: Debian project
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-zTHr+PFSR+lcNmLiBOyy"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: benh@debian.org
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk);
 SAEximRunCond expanded to false
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 88.96.1.126
X-Mailman-Approved-At: Mon, 07 Oct 2019 14:17:27 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--=-zTHr+PFSR+lcNmLiBOyy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-01-22 at 21:31 -0800, Richard Henderson wrote:
> On 1/22/19 1:39 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi Ben,
> >=20
> > On 1/22/19 6:43 AM, Michael Tokarev wrote:
> > > Forwarding to qemu-devel@
> > > http://bugs.debian.org/919921
> > >=20
> > > Thanks!
> > >=20
> > > 20.01.2019 20:55, Ben Hutchings wrote:
> > > > Package: qemu-user
> > > > Version: 1:3.1+dfsg-2
> > > > Severity: normal
> > > > Tags: patch
> > > >=20
> > > > I've been building and testing klibc across many architectures usin=
g
> > > > qemu-user, and I found that qemu-user fails to load a few programs =
on
> > > > a few architectures, reporting an EINVAL error code.  Here's the
> > > > "readelf -l" output for one such program:
> > > >=20
> > > >      Elf file type is EXEC (Executable file)
> > > >      Entry point 0x10000100
> > > >      There are 5 program headers, starting at offset 52
> > > >           Program Headers:
> > > >        Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz=
=20
> > > > Flg Align
> > > >        PHDR           0x000034 0x10000034 0x10000034 0x000a0 0x000a=
0
> > > > R   0x4
> > > >        INTERP         0x0000d4 0x100000d4 0x100000d4 0x0002a 0x0002=
a
> > > > R   0x1
> > > >            [Requesting program interpreter:
> > > > /lib/klibc-R7FVdnsTBUFpWPgCV6FR07b-mf8.so]
> > > >        LOAD           0x000000 0x10000000 0x10000000 0x002f8 0x002f=
8 R
> > > > E 0x10000
> > > >        LOAD           0x010000 0x10020000 0x10020000 0x00000 0x0800=
0
> > > > RW  0x10000
> > > >        GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x0000=
0
> > > > RWE 0x10
> > > >            Section to Segment mapping:
> > > >        Segment Sections...
> > > >         00
> > > >         01     .interp
> > > >         02     .interp .text .rodata .eh_frame
> > > >         03     .bss
> > > >         04
> > > >=20
> > > > The unusual feature of this program, and all the others that failed=
,
> > > > is that there is a LOAD segment with a file-size of 0 (i.e.  only B=
SS,
> > > > no initialised data).  load_elf_image() will try to mmap() initiali=
sed
> > > > data for this section even though there is none and a length of 0 i=
s
> > > > invalid.
> > > >=20
> > > > The change that seems to fix this is to skip the mmap() in this cas=
e:

Is there a reason why my fix can't be applied?  Do I need to open a bug
report in Launchpad for this?

Ben.

> > > > --- a/linux-user/elfload.c
> > > > +++ b/linux-user/elfload.c
> > > > @@ -2316,11 +2316,13 @@ static void load_elf_image(const char *i
> > > >               vaddr_ps =3D TARGET_ELF_PAGESTART(vaddr);
> > > >               vaddr_len =3D TARGET_ELF_PAGELENGTH(eppnt->p_filesz +
> > > > vaddr_po);
> > > >   -            error =3D target_mmap(vaddr_ps, vaddr_len,
> > > > -                                elf_prot, MAP_PRIVATE | MAP_FIXED,
> > > > -                                image_fd, eppnt->p_offset - vaddr_=
po);
> > > > -            if (error =3D=3D -1) {
> > > > -                goto exit_perror;
> > > > +            if (vaddr_len !=3D 0) {
> >=20
> > This is probably not the good fix, since now your process doesn't have
> > anything mapped to use his BSS :)
>=20
> Not true.  The mapping happens in zero_bss.
>=20
> > What about this fix instead, using the segment memory size rather than
> > the file size:
> >=20
> > -- >8 --
> > @@ -2314,7 +2314,7 @@ static void load_elf_image(const char *image_name=
,
> > int image_fd,
> >              vaddr =3D load_bias + eppnt->p_vaddr;
> >              vaddr_po =3D TARGET_ELF_PAGEOFFSET(vaddr);
> >              vaddr_ps =3D TARGET_ELF_PAGESTART(vaddr);
> > -            vaddr_len =3D TARGET_ELF_PAGELENGTH(eppnt->p_filesz + vadd=
r_po);
> > +            vaddr_len =3D TARGET_ELF_PAGELENGTH(eppnt->p_memsz + vaddr=
_po);
> >=20
> >              error =3D target_mmap(vaddr_ps, vaddr_len,
> >                                  elf_prot, MAP_PRIVATE | MAP_FIXED,
>=20
> No, there's only filesz bytes in the file.  I'd expect zero_bss to map ov=
er the
> extra that you just mapped, but it doesn't help.
>=20
>=20
> r~
--=20
Ben Hutchings - Debian developer, member of kernel, installer and LTS teams

--=-zTHr+PFSR+lcNmLiBOyy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAl2bde8ACgkQ57/I7JWG
EQnDvw/+ODBVBHlpYprG4j90iwvt1UArW3fN3tK6T95WoR0h7AB3cLoVpG/KU4cm
CvZAqfrouxDcsfLXSbzAvf8SImGpLBonPwaPEQkXHJ0hJKUSNYHPWbn7TONTGDKG
R2ivmhix+ydH+g1veMVFDT53zcMtrVaIZYhRtx3oFZJco5QBRO3ug77XF9OHPD1n
Eg4k9mCuJ0yRXPyOBCsYSK39B2pysyPOP9L/+TL4NmpWh8HV9YRX7PFxY7GbQbLi
MekzsMODbvMBj1L5o2n/jN7fiwcy0AAj0zz3u/CLRDau/TLHU2c5yg7Uh0rFXOMT
YtEHOjZmRGP2dS2ja+nCRlN3D+ui9r1odQvpkgL8vIhwu56rkekwuyim5sw7GZ+U
MhJmvM3OhW67CsqT1q694MhFsMpmogIKDEFvXlrBKZ5UTHq9IuJTR59ubzM1dglU
oL5f/GOgxsPA0TqPKV6QYzrXiZVE5/r3N//seXxjyn2qCU9vlXCiMI2hsXlCekz0
bX4oUnFL0nzZryvJPl+c9qeZZ9QQRtnrWWoM2u3KJc0ZgZxTPPyZPOqhM15RtQTs
K49luGccTpKDa0lZb57lYRD8tN4Rp+Xagx/8gTvE+KpR+QqRfWZ5vycVOYA3QaEp
LxQb9Xgyq0ihxc+gLx06KUzMroqYCSQVAPbDgi68MHn7d4HtXLg=
=ioHX
-----END PGP SIGNATURE-----

--=-zTHr+PFSR+lcNmLiBOyy--

