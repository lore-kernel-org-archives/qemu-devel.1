Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D75C433E5
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 01:39:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DD9A2075E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 01:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="dnox/6fk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD9A2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8w1p-0003tp-Ev
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 21:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8w0k-0002zl-Br; Thu, 20 Aug 2020 21:38:31 -0400
Received: from ozlabs.org ([203.11.71.1]:51945)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8w0h-0003CI-QE; Thu, 20 Aug 2020 21:38:30 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BXkgD6Fsbz9sTR; Fri, 21 Aug 2020 11:38:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597973896;
 bh=d6evanwXgBG4IPliJsRhqkIUyNzNEyBUO0d7EazVANI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dnox/6fkFo5XlX69C8HBD541rPCo7/e7tr+R3WgXlZoysJVj+Suxq9bzInIi0M8Ek
 nz8N23J2vbhGe1W3d2JbF4UHyytU/ooZbpgCDzPEczF51jy56tC77RANoKSMfwGUOd
 o6ml7Y+bOFRtlWezENMmb9+lHMQq475ultksP+1g=
Date: Fri, 21 Aug 2020 11:38:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 0/4] spapr/xive: Allocate vCPU IPIs from the vCPU
 contexts
Message-ID: <20200821013807.GV271315@yekko.fritz.box>
References: <20200820134547.2355743-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="G9m07da55tKJni3T"
Content-Disposition: inline
In-Reply-To: <20200820134547.2355743-1-clg@kaod.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 20:03:50
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>,
 Gustavo Romero <gromero@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--G9m07da55tKJni3T
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2020 at 03:45:43PM +0200, C=E9dric Le Goater wrote:
> Hello,
>=20
>=20
> When QEMU switches to the XIVE interrupt mode, it creates all the
> guest interrupts at the level of the KVM device. These interrupts are
> backed by real HW interrupts from the IPI interrupt pool of the XIVE
> controller.
>=20
> Currently, this is done from the QEMU main thread, which results in
> allocating all interrupts from the chip on which QEMU is running. IPIs
> are not distributed across the system and the load is not well
> balanced across the interrupt controllers.
>=20
> Change the vCPU IPI allocation to run from the vCPU context. The
> associated XIVE IPI interrupt will be allocated on the chip on which
> the vCPU is running and improve distribution of the IPIs in the system.
> When the vCPUs are pinned, this will make the IPI local to the chip of
> the vCPU. It will reduce rerouting between interrupt controllers and
> gives better performance.
>=20
>=20
> I did some basic migration testing with the 'dual' and 'xive' modes,
> also tried CPU hoplug. I haven't tried migration with older pseries
> machine.

LGTM, applied to ppc-for-5.2.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--G9m07da55tKJni3T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8/JX0ACgkQbDjKyiDZ
s5LXhxAAtzI5norZqEs9I5qk657PW3Rr3sCOLs//Nyl3LZYICqHy5DwhxZXteAKZ
hWav26NFXXN879C9+hjPP7RqsN4d9IzW/IXNuptLN1n+gSA1wkfFBtUU8KoIYh2y
tvQ6IlGRCyWmjRZ86mUOQDgti8TM14n3a4NeW7xhBPD1NCf8PY+fj2ZKQmlJ4nQ1
mMomIzbO7W6XNVfAGM1hZmaMQbCM46CHWdiqlW70R8bcnQhCfCk+g4cnWwzHo2lY
ui7zyD66jSdqjuSxSyFgh8zKV2N/APQwIgrsdqYcMK8//9VEe9IEaVgGhTZiZcX9
8ERZ6rrLG2kha/tk3pOLZmSFgam4BrZaWoCFA6qjeX+R5rheipyPoKSfZ6yG7Yll
DdGpignYvT4LGE5IXwmVQ6izhGgpZf+JRrRKSmq/NDxodnt7De8WyyfZI/hu5b/9
rwzzwOcRZoOkyd88JHJ9waNJZv4yCa9WY9mFusFcGbt0dUXTKeOq7tQCqEU8GfGo
bTrmYxufhzMML2ZCjDWY64ozdPQT2yrK0hVPRAm3sZ9tjhXNidCeb+v3HvJ0iSWF
Vv32Devl6N5O+ZstMZca9arNpvae1+i9943WlF6akaQXeHSaZZHPb0AuntrJAQkO
vdidDlTgMWeBgzhMkQt4ShYAufMOkiQDAsl3qCUKUt5LK6Wv3GU=
=6cBF
-----END PGP SIGNATURE-----

--G9m07da55tKJni3T--

