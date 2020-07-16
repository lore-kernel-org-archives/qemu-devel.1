Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD076C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 05:20:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 881AF2071B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 05:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Xn/dBLps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 881AF2071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvwJu-0007Kc-R2
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 01:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jvwIw-0006P1-Ui; Thu, 16 Jul 2020 01:19:35 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57947 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jvwIu-00037I-Iv; Thu, 16 Jul 2020 01:19:34 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B6jH2002jz9sR4; Thu, 16 Jul 2020 15:19:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1594876766;
 bh=GwkMTBL57EXeYKoBAZqO6JqQgDo0e47kQ5hYtukZJ1E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Xn/dBLpsyFj4oSkM5TAlvM+mrwIZn7tjK4WWimAdlLCsZS5qzPTfF3MAB5eQyzUV/
 1wnYuprbJVhpfb65Jo38KhgkFmioRE6eAUX/C8rqoO8rGo9yrxUHpgNoRz9mj1xRsK
 MORBRm1bHn/RhcvGsNrDGYI3PbDJBlE2YbWKgu1o=
Date: Thu, 16 Jul 2020 15:04:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Reza Arbab <arbab@linux.ibm.com>
Subject: Re: [PATCH v3] spapr: Add a new level of NUMA for GPUs
Message-ID: <20200716050459.GM93134@umbus.fritz.box>
References: <1590177213-4513-1-git-send-email-arbab@linux.ibm.com>
 <20200525050550.GA23110@umbus.fritz.box>
 <20200525174927.aky64nw7p7xztqzh@arbab-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mkHYMT4O8DyWoHkb"
Content-Disposition: inline
In-Reply-To: <20200525174927.aky64nw7p7xztqzh@arbab-vm>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 01:19:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Daniel Henrique Barboza <danielhb@linux.ibm.com>,
 Leonardo Augusto Guimaraes Garcia <lagarcia@linux.ibm.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--mkHYMT4O8DyWoHkb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2020 at 12:49:27PM -0500, Reza Arbab wrote:
> On Mon, May 25, 2020 at 03:05:50PM +1000, David Gibson wrote:
> > On Fri, May 22, 2020 at 02:53:33PM -0500, Reza Arbab wrote:
> > > --- a/hw/ppc/spapr_pci_nvlink2.c
> > > +++ b/hw/ppc/spapr_pci_nvlink2.c
> > > @@ -362,7 +362,7 @@ void spapr_phb_nvgpu_ram_populate_dt(SpaprPhbStat=
e *sphb, void *fdt)
> > >          uint32_t associativity[] =3D {
> > >              cpu_to_be32(0x4),
> > >              SPAPR_GPU_NUMA_ID,
> > > -            SPAPR_GPU_NUMA_ID,
> > > +            cpu_to_be32(nvslot->numa_id),
> > >              SPAPR_GPU_NUMA_ID,
> > >              cpu_to_be32(nvslot->numa_id)
> >=20
> >=20
> > This doesn't look quite right.  In the new case we'll get {
> > GPU_NUMA_ID, nvslot->numa_id, GPU_NUMA_ID, nvslot->numa_id }.
>=20
> The associativity reference points are 4 (and now 2), so this is what we
> want. I think what you've noticed is that reference points are 1-based
> ordinals:
>=20
> 	"...the =E2=80=9Cibm,associativity-reference-points=E2=80=9D property in=
dicates
> boundaries between associativity domains presented by the
> =E2=80=9Cibm,associativity=E2=80=9D property containing =E2=80=9Cnear=E2=
=80=9D and =E2=80=9Cfar=E2=80=9D resources. The
> first such boundary in the list represents the 1 based ordinal in the
> associativity lists of the most significant boundary, with subsequent
> entries indicating progressively less significant boundaries."

Right.. AIUI, associativity-reference-points indicates which leves are
"important" from a NUMA distance point of view (though the spec is
very confusing).  But, I'm pretty sure, that ignoring
reference-points, the individual ibm,associativity lists are supposed
to describe a correct hierarchy, even if some levels will get ignored
for distance purposes.  So once you've split up into "numa_id" nodes
at the second level, you can't then go back to just 2 nodes (main
vs. gpu) at the third.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mkHYMT4O8DyWoHkb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8P3/cACgkQbDjKyiDZ
s5KAqBAAoX4G9FhUQ+4Amh/f7yHWWhoN1Sd3DT36h0HvDFG3qPz0Schls2kSSwQ5
uQWvKDKOTdeyrPG0/bCKX3QkJo0FaEyRWHlulgg3CqL6XYPhRD+KlAiy70C6ajeB
f+ajKMNNQyuoewaJnA68n0XrvpbeKaTfU3FE20wg6B5ddn048LYAtE9TB9RSbxuJ
M/eEs+JysM0zcG9n+lTQymnd3iffrqBJtenKtjSOYeMddaQizG/ONjkvBZhhLaUA
2+D3nZT7zH5wXFkMnpFH3h5f2msmeUswCTgI7hkO9nQ1l0afAQMCXTyMxOzlxZYS
P9s5d9OLvz56CDkmh9/BKU03Vz1eAQsLRjxta/UTBC/wg6QTS4/6ivEZ8r1kzMq7
1hssoeO/F9+/HVOaRu64lTDysPv2/QOPTtNE26M/KiaGDC2R+q7/hMwpddbevs09
lzc2kA25n/htdVZh1izx28xNEiXs5nTYFBSbJMaN29UKDJuMBlfYfXekOFS+BQ41
9Q5YPpVZ/tlNSrFaM4Limdjj1R2UaGCXCdwJsnHVy0lKjwkk2EsPdkzBr2C+Kkj6
W3a3WywA48vwxDYXAF98pkZwkWuuC2gnxUMwUpuIlH3/XKHN81nzSlKMFknu9O5Q
JmmgNRi1voiN9oSw/dZ4aXozRkDIzKuvPwXfRZSN+xnVynvtzdg=
=PoO5
-----END PGP SIGNATURE-----

--mkHYMT4O8DyWoHkb--

