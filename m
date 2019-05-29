Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B488C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 04:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5162621734
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 04:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="eGksVjai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5162621734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46657 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVppZ-0004vJ-GM
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 00:04:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVpom-0004cT-27
	for qemu-devel@nongnu.org; Wed, 29 May 2019 00:04:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hVpok-0006xh-EV
	for qemu-devel@nongnu.org; Wed, 29 May 2019 00:03:59 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:50847 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1hVpoi-0006lo-R1
	for qemu-devel@nongnu.org; Wed, 29 May 2019 00:03:58 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 45DHBg1vMSz9sB8; Wed, 29 May 2019 14:03:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1559102619;
	bh=/luALfeC8x0Y7FPALvUo4G9a2dSAY/XJEm5Z3sU6+iI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eGksVjaic0ycB2ECzUGKIxoLvvWTfXlmi4ycotOhMslOnCqATIF8g61G9WXaVoQBx
	9OdEt2zxcgRguV8Qad/lmNPWlxqA1romo7BUpLqHyst9hvRmvpcJyoxo2YynbekeD2
	etK/MHxIIiFTknXeI7Yf1FwBKAjiVK8axwhQK5hU=
Date: Wed, 29 May 2019 11:47:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190529014733.GA32028@umbus.fritz.box>
References: <87lfyqla7r.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <87lfyqla7r.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] Headers without multiple inclusion guards
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Chris Wulff <crwulff@gmail.com>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>, James Hogan <jhogan@kernel.org>,
	Anthony Green <green@moxielogic.com>, Palmer Dabbelt <palmer@sifive.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>,
	Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
	"Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Anthony Perard <anthony.perard@citrix.com>,
	Jason Wang <jasowang@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Alistair Francis <alistair@alistair23.me>, Greg Kurz <groug@kaod.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Eric Auger <eric.auger@redhat.com>, Paul Durrant <paul.durrant@citrix.com>,
	Stafford Horne <shorne@gmail.com>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Richard Henderson <rth@twiddle.net>,
	"Daniel P. Berrange" <berrange@redhat.com>,
	Claudio Fontana <claudio.fontana@gmail.com>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Cornelia Huck <cohuck@redhat.com>,
	Claudio Fontana <claudio.fontana@huawei.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
	Michael Walle <michael@walle.cc>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2019 at 08:12:24PM +0200, Markus Armbruster wrote:
> We have a bunch of headers without multiple inclusion guards.  Some are
> clearly intentional, some look accidental.  Too many for me to find out
> by examining each of them, so I'm asking their maintainers.
>=20
> Why do I ask?  I'd like to mark the intentional ones and fix the
> accidental ones, so they don't flunk "make check-headers" from "[RFC v4
> 0/7] Baby steps towards saner headers" just because they lack multiple
> inclusion guards.
>=20
> Just in case: what's a multiple inclusion guard?  It's
>=20
>     #ifndef UNIQUE_GUARD_SYMBOL_H
>     #define UNIQUE_GUARD_SYMBOL_H
>     ...
>     #endif
>=20
> with nothing but comments outside the conditional, so that the header
> can safely be included more than once.
>=20
> I append the alphabetical list of headers without multiple inclusion
> guards (as reported by scripts/clean-header-guards -nv), followed by the
> same list sorted into maintainer buckets.  If you're cc'ed, please find
> your bucket(s), and tell me which headers intentionally lack guards.

[snip]
> PowerPC
> M: David Gibson <david@gibson.dropbear.id.au>
> target/ppc/helper.h

Like the equivalent ARM variants, intentional.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzt5LUACgkQbDjKyiDZ
s5KRHg/9EXoNGPwr+4nyw+b7H62dguDoiHNRG5msf4WewG/wlPrCft6eqcO8+/Kd
PJtlqi6CNprLRoTrPLagGOC8R/GpZ7aWEFhshtqVheIlKS+80VCqAFdIejB/vr9a
/f47qeNmKqMhEfEnJA332nqCOYY1niS+CnOV0+bd7psOQ6TlCnNvdPYYYdX3PXnS
9NTyacoPsWaR1/epuUBXck9WW1JeiNNLHuYN30arvjrcWifmVy5uWUeh2KRJwo5q
8eHzG00B5zQoJswbylAUYacesh+aGgFWVw6LU9Z1qu+gnXphXFfsRzguPcl4WUS9
F/oSKAweNcdAyAr7SzNFyYjsXJPC1SThspD6xN8qMgYyIFBpWmrciBJuD2EjsNzM
OTgFGBnCmGazJ93j8J4mI5OwaZ1eqDkARhUmkT9H+wI1D8ac1lP6l+U7vFsC1xwc
hLRdjR/JfCGfFcqD9e3k1J2bIgOJvaAWaISomBSx7cPeBYG+FJDOsWP+EurMhaaK
7La6D+8WH2GkX0w4HAgXIjgbXRbNK4jUCCd+3+BpUYQWdUrfODoTOixcuv3RaRo+
FiNuPbVSbA6rHw0jMo/oh0glvVjESUnfPNeoAj7e/Sqi0w7MOlop8lLrcl2JGdeO
UoRC9vfijWBLkQw4jkhkwmo8jtGCjqJ3B4LTujjcZuBj3Th7Wx4=
=u5pr
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--

