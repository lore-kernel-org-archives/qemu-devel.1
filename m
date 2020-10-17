Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778F2C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 06:47:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF9A320756
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 06:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="T17/vC2E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9A320756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTg0S-0004nt-1n
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 02:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kTfyb-0003Lr-9c; Sat, 17 Oct 2020 02:46:01 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38993 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kTfyY-00036s-Cb; Sat, 17 Oct 2020 02:46:00 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CCtnj1MsSz9sTm; Sat, 17 Oct 2020 17:45:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602917145;
 bh=tznvDlDw1Lt9msRsr9/Dg2vqCnCa3egQaOESL6bg8h0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T17/vC2EIlrl5gL/rSfvfzMRj19x7RBBYI3v2aaxPNJP+4kgPce9FQXq4ac/YABV/
 ulLaIqgraMCRkXbMqYVAKlTNfuc20mREsQD4spjhW9UivXfBkkCbG+lhvuHVg+EoGW
 bkx/+iIYV5xmrvnyeI83k/V5EBI8vyEgy2x82/94=
Date: Sat, 17 Oct 2020 17:20:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v2 2/3] grackle: use qdev gpios for PCI IRQs
Message-ID: <20201017062000.GA285896@yekko.fritz.box>
References: <20201013114922.2946-1-mark.cave-ayland@ilande.co.uk>
 <20201013114922.2946-3-mark.cave-ayland@ilande.co.uk>
 <20201016001803.GC7078@yekko.fritz.box>
 <CABLmASE+GzEhSgqqJmum+Xu7DkyQX6PtboKLhA4LyaOY7PYoSA@mail.gmail.com>
 <67efe378-7979-9a51-7c66-8d8c3f55e335@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <67efe378-7979-9a51-7c66-8d8c3f55e335@ilande.co.uk>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 02:45:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2020 at 07:53:10AM +0100, Mark Cave-Ayland wrote:
> On 16/10/2020 07:45, Howard Spoelstra wrote:
>=20
> > Hi,
> >=20
> > I see compilation of the current ppc-for-5.2 branch fail with:
> >=20
> > ../hw/pci-host/grackle.c: In function =E2=80=98grackle_realize=E2=80=99:
> > ../hw/pci-host/grackle.c:68:11: error: =E2=80=98GrackleState=E2=80=99 h=
as no member named =E2=80=98pic=E2=80=99
> >  =C2=A0 =C2=A068 | =C2=A0 =C2=A0 if (!s->pic) {
> >  =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~
> > make: *** [Makefile.ninja:1741: libcommon.fa.p/hw_pci-host_grackle.c.o]=
 Error 1
> >=20
> > Best,
> > Howard
>=20
> I see - as per the cover letter, my series is a replacement for Phil's
> original patch at
> https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg02988.html (the =
PIC
> link is now completely removed), so the solution here is to drop patch
> 7daac97 "hw/pci-host/grackle: Verify PIC link is properly set".

Ok, I've removed that from my ppc-for-5.2 tree.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+KjQ4ACgkQbDjKyiDZ
s5IESxAApOxHIF7ev/27uBRMeYGF15rL+o8+Bsto4tjSLQ0QbaDNwzjXPPR/vMh+
tU0u/Fcd/KW4B0yWamUmWOy8gxm6S4nWTVdFiqHLY4Gjz1BUi2a5wfBzIp2O1Ne7
H0D7kfH1a0qGLu7BuzFU5FczPTKR/L1M8ka3IDHu+B8mAVFYD5BuOnxvXoOtj/7O
aBU9PRot9KwB/Jsrme/iG2gLoRQwfrE589Nl3HwaegAJGV1vVYGHReucQn0RKY49
HoNM6DjdC7mQn+RY/SK5AdacjTSd/NPRcePdwGFab1FdeQMpax+l/LSVkLc+8GJR
GpU9fTlWRV35rua92YUbUc8Jh57So+uh5DjIchxO8g5A5Z3/S7PyKclvJw1zmg6q
3RaLXzVYFIAnJ0aylhre2iMo8NOL1Us0oCMJ7+obXcmaC9diLC1yApafsm2MuML9
wpDTzsmaC5K7B8beIwNXuOv2NB87ERl5/IeDdEW+4DRhVLsEb1DaqtKqDfhB+toO
iJyfLfYLNVj76jfuxA32LZR7urPGK8Dpeq6PdfUprKknW3Jzbqbyk6ne5+wgMOZ5
IRW/rTyCa5X6OiLp+dqC77Cb0lGCadjslQZbE1GaBqyB7cyu4yWQf+mNAFdHakSN
UKEc3NQsYFcL6Mh5VDfSLcNJgJtsAPKFORKYgcye+jGfaDj2Dio=
=spcA
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--

