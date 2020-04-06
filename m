Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C4EC2BA18
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 06:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7639820672
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 06:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bLORG9/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7639820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLLin-0004KS-Ic
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 02:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jLLhk-0003Ue-Mr
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 02:57:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jLLhj-0000Q1-6t
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 02:57:56 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38723 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jLLhi-0000Mn-C7; Mon, 06 Apr 2020 02:57:55 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48whF95HFsz9sRf; Mon,  6 Apr 2020 16:57:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1586156269;
 bh=SeReKDq3PkE2Rfj3RFIwi+8lDiPM/sCz4p6FOI4wZK0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bLORG9/0B/r+vMpjWG/x3Ztg3X+m+TO43dVhWMh8j95DdCFPmSyGC/bgPHm43T2zE
 tVviF+OpqAOHWs4vj+oGXLxqGbea1X0uOljmHmloImOC0bFzanyCEOTPllFWcO82Gk
 rcOlQGV4XjHhKYhxxOJ1HIAvPlonwR0787IIMnoQ=
Date: Mon, 6 Apr 2020 16:45:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 3/5] nmi: add MCE class for implementing machine check
 injection commands
Message-ID: <20200406064559.GB2945@umbus.fritz.box>
References: <20200325144147.221875-1-npiggin@gmail.com>
 <20200325144147.221875-4-npiggin@gmail.com>
 <20200331002203.GB47772@umbus.fritz.box>
 <1585900632.k0ft0cc80l.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
In-Reply-To: <1585900632.k0ft0cc80l.astroid@bobo.none>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 03, 2020 at 06:04:47PM +1000, Nicholas Piggin wrote:
> David Gibson's on March 31, 2020 10:22 am:
> > On Thu, Mar 26, 2020 at 12:41:45AM +1000, Nicholas Piggin wrote:
> >> Like commit 9cb805fd26 ("cpus: Define callback for QEMU "nmi" command")
> >> this implements a machine check injection command framework and defines
> >> a monitor command for ppc.
> >>=20
> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >=20
> > So, AFAICT, both x86 and ppc have something called an MCE, and while
> > I'm guessing they're somewhat related, they don't work quite the same
> > way - different information provided to the handler and so forth.
> >=20
> > I think it's reasonable to overload the "mce" HMP command based on
> > target for the different types.  However, I think calling the
> > interface classes which are specific to the ppc type just "mce" could
> > be pretty confusing.
>=20
> Okay. So, convert i386 first?

Uh.. not necessarily.  But call your version PpcMce or something
instead.

> > In addition, I think this is adding an HMP command to inject the event
> > without any corresponding way of injecting via QMP.  I believe that's
> > frowned upon.
>=20
> I attempted that but didn't get too far. I guess it's more of a
> special test than a management function (nmi has valid uses in=20
> administering a machine), so maybe we can get an exemption. One issue
> is different QMP command for powerpc vs x86.
>=20
> I think error injection as a general concept might be valid there, but
> the better interface for that level would be higher up, e.g, not
> specifying register settings but rather "simulate uncorrected memory
> error on this byte".
>=20
> Do you think that is reasonable reason to avoid adding QMP for this
> nasty low level thing?

Hrm, I doubt it will convince the qemu community at large.  I think
the view is that QMP is the "real" management interface for qemu - HMP
is somewhere in between a shim for convenience and something needed
for backwards compat.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl6K0CQACgkQbDjKyiDZ
s5LwJhAA2QQuKSUk4VObkpZkb4Ui5Vt7Bbq018a79CiIVhqaMQTUzLMe7w8yolm0
ByQwszH/kLzlFpoP23+z7Ns45NnqpVAi4VQ4QO1bm15BpBFDgYobnBX54NGQxX0c
oD5u+ygGCw6Y+P0Ra11zF75gJ48ZaHSURITsTJQsH8CbxeEkNqKUKWaa/ldfloRP
eBGMVI3rbcpV05YoDmHQulvYroHS+8PV0WDdgq6ILV247MBLNk0v7i+Uvad0Ur2z
DEMgmp4MLa1rXYpIqbqQwP7M5IryQMsEbI/0aPzh5VVZCtcqK+2Ug4T4K6REmqNN
Hg7TKb5QzLl0YdTKuWvgkpY4nU4+VAtfHyhHJZjDljHMduX8CLT8g3BBf/lHoRHu
UkeSBKcnKpEHZHnyU6AOaPpkAa3MFr+4Hb5S3th10XTvrQX9iOOZATniHBJrpJv2
/k8VW0SEDT87B3LAKtvkfKPhL0Soo2uOwpNlg1oADVQxhj5f4Np+AQ6/gUx8plg8
hz6S6w1aQSGdLr48cQLwPgMwdV3VXTZqcxqVGaLZ+JszOu3eBoEr92mOtbVwnbPS
uF4BsS+bVe1OGjU4YJ0A65c4r8vrAN4ml9iJLfHudAlFlO3rb1S2dev7+1SyPNmx
Z6gJxxhzmB2NwfKKlVJUS9h2G82gw9P8U5JUSGugkhzAO62zz0c=
=MxZ9
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--

