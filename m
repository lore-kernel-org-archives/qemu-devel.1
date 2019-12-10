Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDCCC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 05:22:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9FC1206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 05:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PklgXqRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9FC1206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieXyn-00049n-1I
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 00:22:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ieXy8-0003ZY-Vp
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 00:21:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ieXy7-0002eZ-ND
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 00:21:56 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:41017 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ieXy7-0002dc-1y; Tue, 10 Dec 2019 00:21:55 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47X7ht6sqjz9sRH; Tue, 10 Dec 2019 16:21:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1575955310;
 bh=je4TsKW4sQlSjlta6GGP8OnupoTV/5a59LbiC0URCGs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PklgXqRF/kvuY6WGDP0FDf0Ph4reBsUEHC6sokk08pZFVxtW3S3FrZoKlgGU+Zruq
 na6kacHY5Pv+WBR+QkFlSFjpeHVYHZs+MJEwREvLMijdC3fTGCbO2sIJ+a1zTKQR7+
 6KrYmIimMZv4QioYRlWqIrqzmScgnZ9kuRy4uNYQ=
Date: Tue, 10 Dec 2019 16:05:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH v1 ppc-for-5.0 2/2] ppc/spapr: Support reboot of secure
 pseries guest
Message-ID: <20191210050536.GH207300@umbus.fritz.box>
References: <20191209070012.14766-1-bharata@linux.ibm.com>
 <20191209070012.14766-3-bharata@linux.ibm.com>
 <20191210032851.GC207300@umbus.fritz.box>
 <20191210035038.GB17552@in.ibm.com>
 <dd94f089-7df8-1a13-f4a6-631e765f6339@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ewQ5hdP4CtoTt3oD"
Content-Disposition: inline
In-Reply-To: <dd94f089-7df8-1a13-f4a6-631e765f6339@ozlabs.ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: qemu-ppc@nongnu.org, linuxram@us.ibm.com, qemu-devel@nongnu.org,
 bharata@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ewQ5hdP4CtoTt3oD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2019 at 03:03:01PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 10/12/2019 14:50, Bharata B Rao wrote:
> > On Tue, Dec 10, 2019 at 02:28:51PM +1100, David Gibson wrote:
> >> On Mon, Dec 09, 2019 at 12:30:12PM +0530, Bharata B Rao wrote:
> >>> A pseries guest can be run as a secure guest on Ultravisor-enabled
> >>> POWER platforms. When such a secure guest is reset, we need to
> >>> release/reset a few resources both on ultravisor and hypervisor side.
> >>> This is achieved by invoking this new ioctl KVM_PPC_SVM_OFF from the
> >>> machine reset path.
> >>>
> >>> As part of this ioctl, the secure guest is essentially transitioned
> >>> back to normal mode so that it can reboot like a regular guest and
> >>> become secure again.
> >>>
> >>> This ioctl has no effect when invoked for a normal guest.
> >>>
> >>> Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
> >>> ---
> >>>  hw/ppc/spapr.c       | 1 +
> >>>  target/ppc/kvm.c     | 7 +++++++
> >>>  target/ppc/kvm_ppc.h | 6 ++++++
> >>>  3 files changed, 14 insertions(+)
> >>>
> >>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>> index f11422fc41..4c7ad3400d 100644
> >>> --- a/hw/ppc/spapr.c
> >>> +++ b/hw/ppc/spapr.c
> >>> @@ -1597,6 +1597,7 @@ static void spapr_machine_reset(MachineState *m=
achine)
> >>>      void *fdt;
> >>>      int rc;
> >>> =20
> >>> +    kvmppc_svm_off();
> >>
> >> If you're going to have this return an error value, you should really
> >> check it here.
> >=20
> > I could, by spapr_machine_reset() and the callers don't propagate the
> > errors up. So may be I could print a warning instead when ioctl fails?
>=20
> An error here means you cannot restart the machine and should probably
> suspend, or try until it is not EBUSY (=3D=3Dall threads have stopped?).

Right, if this fails, something has gone badly wrong.  You should
absolutely print a message, and in fact it might be appropriate to
quit outright.  IIUC the way PEF resets work, a failure here means you
won't be able to boot after the reset, since the guest memory will
still be inaccessible to the host.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ewQ5hdP4CtoTt3oD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3vJ6AACgkQbDjKyiDZ
s5JIuw//QJllw5PSOSJXqNHi5qGgUCt2pjekBLgP/Jb/uTUHaMKj5XIJZycU5PBm
BLeEk471wA9+tos2f4+aXvKSEjtqtNvGi+WKaM0Gh0/lOxa6M+CsWytEzHD1TgaR
C/DQ2+/0yznDvSXlVPCP2Usf2RLKhfDtH5O9uLSaTdARLeX+eggfV4fH9nVqvAoJ
LTog77qOIMPBbbw6aPFl8LtlzoDM7kqPLBlpCSpm39Jzqs//X8FH2x2KPKO2UXfb
jCL1LnH70SQOXXchuhUyLlV+aeMwfh/kGcQJi1+c52mqgKVD1aTBmnQ2vTvm4i1N
mgFmK6RrtdmZUrISeZmh2N86WrPzGURBMjihc0d1MEtmvlZov2rvoUPuwmZi2ejE
o5PesAFMEQEaOE51h6ww/NbDdX4XzHzeF/Ze3L0pxJhOqKNLibkqnIOd/MjxjNjw
I03kUtj+FQS6kOlzKTjNVARS/sdoGcy9IYV6u5GFyMJ+aGZ7iazvrWg972npWM2F
tBF4wbOULldA2NMWjOLMKW6fH6ViR1+DRbCYdRsU1kMthR6DVZLAE5AF/W4+D77V
zs6swBJHiOf6fUrTRlaYWrg3fhk8NivlLmhA0ey00P81uqmMobEWXzbiEi1ugV7p
/PA5Y+NHIh2P6P3Ll6VmauqkgYq46sKt4dJMVwM2thW9cIzaKSE=
=n9M6
-----END PGP SIGNATURE-----

--ewQ5hdP4CtoTt3oD--

