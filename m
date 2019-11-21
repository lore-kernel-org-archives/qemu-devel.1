Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E497C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 10:16:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16B1F206CB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 10:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HFIn9iHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B1F206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXjVc-0006Mg-1E
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 05:16:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iXjSr-00046I-9M
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 05:13:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iXjSp-0006Ha-VG
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 05:13:29 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:39695 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1iXjSo-00067J-T5
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 05:13:27 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47Jb3q4765z9sPf; Thu, 21 Nov 2019 21:13:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574331191;
 bh=Q8NXMCM0eG9ScEw3HYVhi6Bl4mOirlad7XuQ0pliSPs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HFIn9iHmyO+4dVo2szkBSfHPENlnbmnRhVvDS4mFeKvVGtUpauUT0a+oaS8IuMXIX
 9JpQBQcT6e1geKYeBTK0FrEP+IagD5dae3dKAeCNW+uOrgBIN1xR/E3jwvSoKWiTr6
 fV1DPQTeHc5g87ZqVvJyE58jx3e+XKQzyGIH85CU=
Date: Thu, 21 Nov 2019 20:48:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH] pseries: disable migration-test if /dev/kvm cannot be used
Message-ID: <20191121094833.GT5582@umbus.fritz.box>
References: <20191120170955.242900-1-lvivier@redhat.com>
 <87zhgpn1dt.fsf@trasno.org>
 <e96b3dd9-05d3-d260-852a-13423ed9b8cc@redhat.com>
 <87v9rdmy1o.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0q0JoaF5XvbG/IKT"
Content-Disposition: inline
In-Reply-To: <87v9rdmy1o.fsf@trasno.org>
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Cole Robinson <crobinso@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--0q0JoaF5XvbG/IKT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2019 at 09:30:27AM +0100, Juan Quintela wrote:
> Laurent Vivier <lvivier@redhat.com> wrote:
> > On 21/11/2019 08:18, Juan Quintela wrote:
> >> Laurent Vivier <lvivier@redhat.com> wrote:
> >>> On ppc64, migration-test only works with kvm_hv, and we already
> >>> have a check to verify the module is loaded.
> >>>
> >>> kvm_hv module can be loaded in memory and /sys/module/kvm_hv exists,
> >>> but on some systems (like build systems) /dev/kvm can be missing
> >>> (by administrators choice).
> >>>
> >>> And as kvm_hv exists test-migration is started but QEMU falls back to
> >>> TCG because it cannot be used:
> >>>
> >>>     Could not access KVM kernel module: No such file or directory
> >>>     failed to initialize KVM: No such file or directory
> >>>     Back to tcg accelerator
> >>>
> >>> And as the test is done with TCG, it fails.
> >>>
> >>> As for s390x, we must check for the existence and the access rights
> >>> of /dev/kvm.
> >>>
> >>> Reported-by: Cole Robinson <crobinso@redhat.com>
> >>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> >>=20
> >> Reviewed-by: Juan Quintela <quintela@redhat.com>
> >>=20
> >> Oh, why it is so difficult!!!
> >>=20
> >> Thanks, Juan.
> >>=20
> >
> > David,
> >
> > could you add this one too to your ppc-for-4.2 queue?
>=20
> I was about to ask if you preffered it to go through the migration tree.
>=20
> David?

Migration tree is good for me.

>=20
> Later, Juan.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0q0JoaF5XvbG/IKT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3WXW8ACgkQbDjKyiDZ
s5KkehAAjeezk7k9Jz8nHAT6KeGKfSvS7ZEXJo0VmKua1m6BWfzLwnjEwhePF2Pu
TUekvFJeR5rfxoADNC38c+AAHRNxYo68UTEjX9Fkre/2cJ6q1tuui06yy+k82+/6
wdbz8tnx7qPMDYF8b9MXXi0VUkJTY2UxSYU25564t9hwWI7kuQLOZPbGIsZ2kLx2
2ffl7GLoGaVOhMxAR0mkOgVTJF1GQJvkajIl0Xw6j4iJ9+/OCYejw9/mCVsr/Bm+
35m3ugK/hjiBaUny7m3IcgpB8sa5XULWbhKaQ8IRuqr4vERyavQscgq4iEGcvmia
SI/Jnce+Q6s4FnW9724wxADTSSML5WBauGrubzBhersOvVeNxN8clDdCR/bk/gSl
pmzjsE50rkb/qFiV7LQfZ6eOPkgiDEN944FmwP9ocoXRdImK54K7Xm7YstEgJB+D
tilqMijb13vJixhAZG9qI28LKF8O+uHtZJxojXfui0y+6T+ZEI/0C/+1TKlnLI9v
lAVgsg79B1TyBvWbicH548Mj8cqBsK/R3pkYG5dqidnvV8yxp7L+RlEHdqidqQTw
YXAXiJMf+rQw9XaSFPadoGZF3Ghxl8cvcVa4hRdxhohM5HvP1gzhYuKllu8kBIuw
7N0bG3VxFEH1+tv1DN3DI4e9V9ssFaIjAgyq0/EtWJh7Iv7sdCk=
=pN4Z
-----END PGP SIGNATURE-----

--0q0JoaF5XvbG/IKT--

