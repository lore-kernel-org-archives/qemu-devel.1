Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A95FC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 12:05:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 175752086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 12:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Wekzw6zx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175752086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyazR-0005Gi-4u
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 08:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1hyayd-0004Se-5d
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:05:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hyayc-0004dJ-2Q
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:05:03 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:45421 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hyayV-0004XL-9N; Fri, 16 Aug 2019 08:04:56 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46927M0thdz9sML; Fri, 16 Aug 2019 22:04:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1565957087;
 bh=1OQXK0o9OvoNPapWpbimPbhqPrE5Qa0PGQHKlRYcMkI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Wekzw6zxxq4IvC7+Zbnwqdia1xVqewDn7eX7Ht9Y83gQasjzBhjYu5PoAd/WiLpW0
 0PKntAaqTZcpID4Z8EVVQ0BYFf4MjOJ+3toNPAxMyQTRRcgQcAbv4eU/EBfCSgFmWB
 Crykn4dJVY56dnF3V1Dz6Ofl/uRZ25H6HxZL3I/0=
Date: Fri, 16 Aug 2019 21:43:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190816114305.GB2259@umbus.fritz.box>
References: <43bc5e07ac614d0e8e740bf6007ff77b@tpw09926dag18e.domain1.systemhost.net>
 <a7d6eede-b152-4c06-8945-9607c663b99c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Content-Disposition: inline
In-Reply-To: <a7d6eede-b152-4c06-8945-9607c663b99c@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v7 00/42] Invert Endian bit in SPARCv9 MMU
 TTE
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
Cc: frederic.konrad@adacore.com, berto@igalia.com, qemu-block@nongnu.org,
 arikalo@wavecomp.com, pasic@linux.ibm.com, hpoussin@reactos.org,
 anthony.perard@citrix.com, xen-devel@lists.xenproject.org, jasowang@redhat.com,
 jiri@resnulli.us, ehabkost@redhat.com, b.galvani@gmail.com,
 eric.auger@redhat.com, alex.williamson@redhat.com, stefanha@redhat.com,
 jsnow@redhat.com, rth@twiddle.net, kwolf@redhat.com, andrew@aj.id.au,
 claudio.fontana@suse.com, crwulff@gmail.com, laurent@vivier.eu,
 sundeep.lkml@gmail.com, michael@walle.cc, qemu-ppc@nongnu.org,
 kbastian@mail.uni-paderborn.de, imammedo@redhat.com, fam@euphon.net,
 peter.maydell@linaro.org, david@redhat.com, palmer@sifive.com,
 keith.busch@intel.com, jcmvbkbc@gmail.com, hare@suse.com,
 sstabellini@kernel.org, andrew.smirnov@gmail.com, deller@gmx.de,
 magnus.damm@gmail.com, atar4qemu@gmail.com, minyard@acm.org, sw@weilnetz.de,
 yuval.shaia@oracle.com, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 peter.chubb@nicta.com.au, clg@kaod.org, shorne@gmail.com,
 qemu-riscv@nongnu.org, i.mitsyanko@gmail.com, cohuck@redhat.com,
 amarkovic@wavecomp.com, jan.kiszka@web.de, aurelien@aurel32.net,
 pburton@wavecomp.com, sagark@eecs.berkeley.edu, green@moxielogic.com,
 kraxel@redhat.com, edgar.iglesias@gmail.com, gxt@mprc.pku.edu.cn,
 robh@kernel.org, borntraeger@de.ibm.com, joel@jms.id.au,
 antonynpavlov@gmail.com, chouteau@adacore.com, lersek@redhat.com,
 Andrew.Baumann@microsoft.com, mreitz@redhat.com, walling@linux.ibm.com,
 dmitry.fleytman@gmail.com, mst@redhat.com, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org, jslaby@suse.cz, marex@denx.de, proljc@gmail.com,
 marcandre.lureau@redhat.com, alistair@alistair23.me, paul.durrant@citrix.com,
 tony.nguyen@bt.com, xiaoguangrong.eric@gmail.com, huth@tuxfamily.org,
 jcd@tribudubois.net, pbonzini@redhat.com, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2019 at 11:58:05AM +0200, Philippe Mathieu-Daud=E9 wrote:
> Hi Tony,
>=20
> On 8/16/19 8:28 AM, tony.nguyen@bt.com wrote:
> > This patchset implements the IE (Invert Endian) bit in SPARCv9 MMU TTE.
> >=20
> > v7:
> [...]
> > - Re-declared many native endian devices as little or big endian. This =
is why
> >   v7 has +16 patches.
>=20
> Why are you doing that? What is the rational?
>=20
> Anyhow if this not required by your series, you should split it out of
> it, and send it on your principal changes are merged.
> I'm worried because this these new patches involve many subsystems (thus
> maintainers) and reviewing them will now take a fair amount of time.
>=20
> > For each device declared with DEVICE_NATIVE_ENDIAN, find the set of
> > targets from the set of target/hw/*/device.o.
> >
> > If the set of targets are all little or all big endian, re-declare
> > the device endianness as DEVICE_LITTLE_ENDIAN or DEVICE_BIG_ENDIAN
> > respectively.
>=20
> If only little endian targets use a device, that doesn't mean the device
> is designed in little endian...
>=20
> Then if a big endian target plan to use this device, it will require
> more work and you might have introduced regressions...

Uh.. only if they make the version of the device on a big endian
target big endian.  Which is a terrible idea - if you know a hardware
designer planning to do this, please slap them.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1WlskACgkQbDjKyiDZ
s5K9oQ//Uuo9cWWmd396i/MdQyddqKELOko009vf2k8wlEaysKrMpuKkkj7EV4Lz
x+MQYyqEBAZMLC5KoTeSRYHynyRTPSBOURxhQNkH4Nqj3Skxr9buvX4pqhNLhmLE
A8tSn3paa4N5GKXbgt4fOiNwBXxnrcAQgmruCbyvO7NKXPmZyTSQxJkR8VHE/qxK
LWKEgA/bjyloFI7OwpWW0rc0LdqmDljy4NKmfHsFxlZdc+TlcM2PgkYPBdRMf5SH
Nlj3YvXrsxa1gfrGLou/tlS9WHyKxl7K1DSbh42ObtrBKtc6z9aPY9+mi1moAJLi
/CpHM3SbdY4j1mGPk5/TZBul+m7spkoJfDB0A/mwb5pTLsZKO0fIOThUkjlCD32D
It90f2Y2I+omAnGOs8nX52SOoNfUwB6vtA4ThBEXzKSOOepPuL5dgSmJ8sGUn1GY
eckRx2z4Emap23L0WavytQ+oaQW8PrhfMFUBWS1DSh/uPVUs1m4Zcs2Q8siBRXZJ
J70alEhGvbhch2+S5q69iYIvljVoMcA1DjHc06WTwZOatjUdjJAQpMLidpH03+UC
AKeSvwpEA5yvuxCfLuThYD+6MeEGyVtH/IEKqSLE7IFVp2VBeqZ4tNKN41Fw/aQH
t3Q5LKmwmLKiyzHZSFM5JmNuyjmdwG56N4INLGlLEAPy9F40PR0=
=nw08
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--

