Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30DBC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 17:43:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A86C2078A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 17:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="DTk8d/Tw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A86C2078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aurel32.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqglL-00037z-Hx
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 13:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1jqgiR-0002Ig-Rv; Wed, 01 Jul 2020 13:40:11 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:40074)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aurelien@aurel32.net>)
 id 1jqgiO-0004Yh-3N; Wed, 01 Jul 2020 13:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
 ; s=202004.hall;
 h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
 Subject:Content-ID:Content-Description:X-Debbugs-Cc;
 bh=dQ+lpWiawIUaKEGu2B3MtRJAssO3E2KG7NJaiQdGxa8=; b=DTk8d/TwKjE1n5L1HJviBn3OG/
 jhZ3NhqyLI/+B556urF2JAbcDtGsh8agP1esOkNIs1P08GL8kZoblAw7pwvyYnFrMJ0JrEIXMM66q
 aH3pQ8N2dvsdu6z1J0tN0hIqKimjbMSkwZ2chC2PMcQFNr+ecUgeWsidd+0ZsR0tsDXiMODrEGvHW
 O6XOCzfcKguMIhrQuabEfdirf1vQky6c+67TSGW8KqqTH/KvwtOpWllITs+WAoTT0CL2opdI9Feha
 ImtOR+t70b9SAIyEvHLUe0cqA8w0mByM2s2e9N2e+QlWRmKyagTOYRc3CtjwjfyDQbIJbSGVay+TY
 S3guHutA==;
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
 by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <aurelien@aurel32.net>)
 id 1jqgi1-0006VE-A1; Wed, 01 Jul 2020 19:39:45 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.94)
 (envelope-from <aurelien@aurel32.net>)
 id 1jqgi0-004ZnP-II; Wed, 01 Jul 2020 19:39:44 +0200
Date: Wed, 1 Jul 2020 19:39:44 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: Re: [PATCH v3 0/5] hw/mips/malta: Add the 'malta-strict' machine,
 matching Malta hardware
Message-ID: <20200701173944.GA1090525@aurel32.net>
References: <20200630195723.1359-1-f4bug@amsat.org>
 <CAHiYmc6d3Q2A237qVqp6s0MagXqgy11aX9r_LuJsGkoJxRhfQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <CAHiYmc6d3Q2A237qVqp6s0MagXqgy11aX9r_LuJsGkoJxRhfQw@mail.gmail.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
Received-SPF: none client-ip=2001:bc8:30d7:100::1;
 envelope-from=aurelien@aurel32.net; helo=hall.aurel32.net
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-trivial@nongnu.org,
 Yunqiang Su <ysu@wavecomp.com>, Laurent Vivier <laurent@vivier.eu>,
 Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Aleksandar,

On 2020-06-30 23:54, Aleksandar Markovic wrote:
> As, in a very clear way, evidenced from the previous versions of this
> series, this series real goal was not not to create some new
> "malta-strict" machine, but to prepare path to creation of some
> imagined "malta-unleashed" machine which will, to the contrary of
> proclaimed goal, create a machine that could never exist in reality.
> That is why I can't accept this series.

I do not understand your opposition to this, and why it is an issue to
support more than 2GiB of RAM for such a board. Supporting more than 2GiB
of memory doesn't prevent people to emulate a real Malta board with less
memory.

In addition to that, the Malta board in QEMU has been supporting for
many years more than the maximum 256MiB that is possible on a physical
board. The QEMU version also supports way more than CPU variants than
the physical board. In other word the existing malta machine in QEMU is
already a "malta-unleashed".

And these possibilities have been used by MIPS* employees to develop
MIPS R6 based distributions. Limiting the board in terms of RAM, CPU or
virtio support would just make our users life more difficult for no
gain.

Regards,
Aurelien

* By MIPS employee, I mean persons that have been employed by companies
owning MIPS over the last few years, including Imagination Technologies
and Wave Computing.



> =D1=83=D1=82=D0=BE, 30. =D1=98=D1=83=D0=BD 2020. =D1=83 21:58 Philippe Ma=
thieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> > Hi,
> >
> > This series add a new 'malta-strict' machine, that aims to properly
> > model the real hardware (which is not what the current 'malta'
> > machine models).
> >
> > Since v2:
> > - Initialize missing malta_machine_types::class_size
> > - Remove RFC patch that confuses Aleksandar
> > - Added examples of 'malta-strict' use
> >
> > $ git backport-diff -u v2
> > Key:
> > [----] : patches are identical
> > [####] : number of functional differences between upstream/downstream p=
atch
> > [down] : patch is downstream-only
> > The flags [FC] indicate (F)unctional and (C)ontextual differences, resp=
ectively
> >
> > 001/5:[----] [--] 'hw/mips/malta: Trivial code movement'
> > 002/5:[----] [--] 'hw/mips/malta: Register the machine as a TypeInfo'
> > 003/5:[0001] [FC] 'hw/mips/malta: Introduce MaltaMachineClass::max_rams=
ize'
> > 004/5:[----] [--] 'hw/mips/malta: Introduce the 'malta-strict' machine'
> > 005/5:[----] [--] 'hw/mips/malta: Verify malta-strict machine uses corr=
ect DIMM sizes'
> >
> > Philippe Mathieu-Daud=C3=A9 (5):
> >   hw/mips/malta: Trivial code movement
> >   hw/mips/malta: Register the machine as a TypeInfo
> >   hw/mips/malta: Introduce MaltaMachineClass::max_ramsize
> >   hw/mips/malta: Introduce the 'malta-strict' machine
> >   hw/mips/malta: Verify malta-strict machine uses correct DIMM sizes
> >
> >  hw/mips/malta.c | 105 +++++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 91 insertions(+), 14 deletions(-)
> >
> > --
> > 2.21.3
> >
> >
>=20

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEUryGlb40+QrX1Ay4E4jA+JnoM2sFAl78yl4ACgkQE4jA+Jno
M2tbaQ/+O2V8yfw6m3hg398XENivUMWei7eMOstlOZ+L47rflFNuzhnsEwUdVUp3
bbq2TjXg/hY7NSQqVAzn0TmofkvQXSARqmFGV382P7vcUuQX4//xNSh0j6il4rgH
01k7T0sNn8hDxZwcK0NVKqmdZvwVA3hLD3vjpzkaje6ejz6Pr3YNxqndcDO0BsoL
wtCeteZdotdetoNge9Dc6cpTSYjrh23Lnq5DwkdtlhQl8IzFd+QeGVI5aPCYQfmi
dDalt0QaXBUgHvf8atdRcs6ufnwQ7LNkjF/uCxrk6HAfK3g3TkmCJxICLJwiTRmT
1s4ssxd4wl8XfAqKOTlHjlV7z+KrjjhpSYr5gWlV5etnok49S0/gEDSacKmhfjyL
28U05MtyhO0y8fJZSYQC81eZxRDiAa/8kEmiOvAdHO23BtKb83gCDnFpbdjZNaGb
DzumgrUL08x9c0nlNi1VbG5teG3QguTvzRHMLqSPa272Z/ji/D+76MD633dC2tyT
RVTyHW3ZHxn2WanIxLHig9LyEJN6h9KXB22m32v6J/vb5IG9zZTVWGgKP6nXHpRX
CwxRr1rzDaTGGNhKSc3Lq4SHiFzljZqIBNH4a1QqnGaXh8dL9Sgi6Xy29EbQU1Oy
p+yCmOAnbSbUIlismZtDLxSECZmBZBs+uk973IDjnWDBiNQUwls=
=1i3+
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--

