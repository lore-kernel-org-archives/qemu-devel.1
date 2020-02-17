Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EF8C7619F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:59:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FC5C206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CNtkT6e7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC5C206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3dC1-0008E0-D8
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 04:59:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j3dAa-00073m-BW
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:58:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j3dAZ-0004uM-6O
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:58:28 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23257
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j3dAZ-0004tE-2J
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:58:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581933506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZogEG8toiqfCP5fg/6/af4SkarvfUvlDyQlXBDg/0M8=;
 b=CNtkT6e7yCpN/iCochZ9ursa2ANKuaGGqxAsZHd8JaOuu6uNb8ce3Bg4G2pLmoPFxfZsCb
 1w4aANaQtRCVvQVoB5dZKbM1VzDJACiu63dvMmknF7HxnaeDA/itOoNxdvoawAzGe0aIgD
 kam8Y+7AEaQBYhe/5CAXbYQdTRoGk74=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-xqbwdpvANT6Bk7svwFR_tQ-1; Mon, 17 Feb 2020 04:58:24 -0500
X-MC-Unique: xqbwdpvANT6Bk7svwFR_tQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 463BD800EBB;
 Mon, 17 Feb 2020 09:58:23 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-208.ams2.redhat.com [10.36.117.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53EAA16D20;
 Mon, 17 Feb 2020 09:58:19 +0000 (UTC)
Date: Mon, 17 Feb 2020 10:58:17 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
Subject: Re: [PATCH 1/7] qapi: Document meaning of 'ignore' BlockdevOnError
 for jobs
Message-ID: <20200217095817.GB6309@linux.fritz.box>
References: <20200214200812.28180-1-kwolf@redhat.com>
 <20200214200812.28180-2-kwolf@redhat.com>
 <20200216214430.GE745061@lpt>
MIME-Version: 1.0
In-Reply-To: <20200216214430.GE745061@lpt>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: pkrempa@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, nsoffer@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 16.02.2020 um 22:44 hat J=E1n Tomko geschrieben:
> On Fri, Feb 14, 2020 at 09:08:06PM +0100, Kevin Wolf wrote:
> > It is not obvious what 'ignore' actually means for block jobs: It could
> > be continuing the job and returning success in the end despite the erro=
r
> > (no block job does this). It could also mean continuing and returning
> > failure in the end (this is what stream does). And it can mean retrying
> > the failed request later (this is what backup, commit and mirror do).
> >=20
> > This (somewhat inconsistent) behaviour was introduced and described for
> > stream and mirror in commit ae586d6158. backup and commit were
>=20
> fatal: ambiguous argument 'ae586d6158': unknown revision or path not in t=
he working tree.

Oops, thanks for catching this. Not sure how this happened, but
32c81a4a6ec is the correct commit.

Kevin

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJeSmO5AAoJEH8JsnLIjy/WdVUP/3amYCow0jrlSXkPe/l3JGOm
T2u3aNXwbrCr/jZUlWyPdJtwhMPMFoEqNl319tC/npqKLp8p+hgVkf/mn48RqyQv
Rsqi3kzwglf+94jbYL76Wf7BTG9jDjQTMKE7d+Mvtjb2TEoMPuj1TwJqaAy4DEaY
5VNFmjY/b5eBuE3Sj40wU36kjBinLUjmkZJMMvcc0iosKh3umoweH/wFvlPg7Xty
hwpz2vcGTnOvWteW1w1lFW8gWUj4ykN5OG000o5Phs9vzKTdJmpyl16SZteJ0Yqa
MuhoG5JdiJdxsvYr4ziRQ5bJcEIx5WHha/dOXg9kWWGymT0+rB05jgyGxCAPWvh0
QFitGfK4zPnNg+zz3gkg7gYtJkfqjdzKEA7f7GzvbhZrulmc1ukFMmB/kpTff6Yv
6xMRIl0RCb79hDP0hjVVwoLjH8iIeJ+Pv3GA77VYBQglpWlhz//ZD4MFlIRuuKPR
i3FZRxBJuKyWKj644TxzXFqyquZSdmV2Q7GQSkTQVTwF/gL+UedqIymVulLYNoj+
UJ5UBBmjw39mlmXtIaX4MkAYy7DsYNyByUfrxYR18ojMlQju5M0hbUqg87Xm9+ms
YymFXpZSq0nL8XPCbYRYJsOWIk+g8T0wA8WotaSrfC7d9ThQGlkjP7SW8mCdsl4F
Jmy2n7cs5KsjoUzyrG4o
=Ue1s
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--


