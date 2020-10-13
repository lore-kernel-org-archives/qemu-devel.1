Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58381C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 05:36:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F9BA208FE
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 05:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oCFtHRve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F9BA208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSCzT-00051O-8h
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 01:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kSCyh-0004DW-0d; Tue, 13 Oct 2020 01:36:03 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:36245 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kSCye-0006ph-Km; Tue, 13 Oct 2020 01:36:02 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4C9PQy5B5Rz9sTr; Tue, 13 Oct 2020 16:35:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602567354;
 bh=ohphu5M/BSTRL24nVNhXV9XyHODbES+uWCGzWuYevhU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oCFtHRveU0mNRz/klp5jXZvQOnbvOGEYe9FNGCfH09QvV1SUGzGI7aI+9wJxoQaiw
 OIXHoQdJnK1MNV+niMZz41+Pd802aozeBibGNhCG8NVSzbgUtDThbJJa4sotNdhSwU
 m/WWUCTGVFlQDxANYl6NYlHX0inLoIMNjPyJgEXA=
Date: Tue, 13 Oct 2020 16:32:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] hw/net: move allocation to the heap due to very large
 stack frame
Message-ID: <20201013053250.GV71119@yekko.fritz.box>
References: <8f07132478469b35fb50a4706691e2b56b10a67b.camel@gmail.com>
 <20201010060745.GK1025389@yekko.fritz.box>
 <f505c80b88ee665a62883a69bed9d614f6ba2a66.camel@gmail.com>
 <20201012053001.GD4787@yekko.fritz.box>
 <38d5993e-8a10-0fb1-5263-6531a356fefd@redhat.com>
 <ca54ec71-11b4-70c5-6d48-4e58fb90a545@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dRgc669pgRVB2OqT"
Content-Disposition: inline
In-Reply-To: <ca54ec71-11b4-70c5-6d48-4e58fb90a545@redhat.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 jasowang@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Elena Afanasova <eafanasova@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--dRgc669pgRVB2OqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2020 at 03:45:02PM +0200, Paolo Bonzini wrote:
> On 12/10/20 12:44, Thomas Huth wrote:
> > I think this is one of the tasks from:
> >=20
> >  https://wiki.qemu.org/Contribute/BiteSizedTasks#Compiler-driven_cleanu=
ps
> >=20
> > It has been added by Paolo in 2016:
> >=20
> >  https://wiki.qemu.org/index.php?title=3DContribute/BiteSizedTasks&diff=
=3D5368&oldid=3D5367
> >=20
> > ... so maybe Paolo can comment on the size that has been chosen here...?
>=20
> I used 16K, mostly because it is a nice round number.  8k is too small
> due to PATH_MAX-sized variables.  16k seemed to be plenty and triggered
> in few-enough places that the cleanup is viable.

Ok.  Why are large stack frames bad in qemu?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dRgc669pgRVB2OqT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+FPAAACgkQbDjKyiDZ
s5IruA/+JK7ojWXQ59ESgaHBg2dDtFwnSvbOTRQQ42kh7pgvfT7lsQ+UfPJMc/Sh
P5J4GiLBqT456nq0HiUGEY63iHDO1Cs7GzoNOktesvOSXRhN2peCALwfgGLApcnz
cxXrWfZWnrr+iCp81YHJ5dlzQr+byBx/3AIwGcxWRnQ9G/mmcH6b+w7aNVTsuHpy
uUhhJrYeKrQ9ZklGhHw4ZgoH7VDB8Sn2Ebu45bJv+mqU+gzQ3mr5aw1nmOj+R0D4
zm8GtNkG3FnVv7vqj1M4wouOKtrTBXpsf7SRlFlzGiBGOyRYE96x0bWxqLpiql8x
k/WLBozKZfRYzMKBi1xcEeWmlYLTNN04qVmXltVGgM6YQj4TNiGmre6MGSgyejXy
EdRaIPrD9l1IfsKuq5UBYpkja/4YSxtJ4X+dK2LbIegmSXw7ZaHtAPmKIZBllgGM
+WOJ2dsz5a3F51Ue1WriO59W5zcQN/jFEVvzVh/LZyGNdbg1UXpiqxFmdRESRwM8
hcWtPDLkmM++8fRbV5+44YKvDgOXtXUy04tBAIwl8nCbAKuEwO5jnxSfoNCzcpOY
Ln28JA7vtu1R9wlI4YiZQjQ2gyKD40uAj0rwbWTWFh/EIlUK/1Tupxunxi+26yuW
8KdY/0pYKPuGQ7dt1+cHqp/6vjEnTyzrJ3DdlQDoKxuBWtxjPyg=
=8cXA
-----END PGP SIGNATURE-----

--dRgc669pgRVB2OqT--

