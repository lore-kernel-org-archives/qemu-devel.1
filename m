Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F7BC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:03:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A417E2082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DAbJ7NZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A417E2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iydGO-0001XK-S1
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 10:03:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48433)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iydDX-00066i-QD
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:00:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iydDV-0000m7-H9
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:00:51 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49361
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iydDV-0000i4-Ad
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:00:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580742046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SQ5LcPlJASuvzWxcMtRugqXwVw5LilPo8GHM6EnXkC8=;
 b=DAbJ7NZag0KcArbU5FbJorXnblNkhZGHI9Fuok/piGLfw12WoAHi9td8vkPKxbduig2/Js
 o9+KktT3oDMQk03Z2/SvEGVxGHggqWBh5Zm0PZ1rYA4jPBjNl7o/HxXW+eGcQ4DwfpguLR
 4z7Axc6jrRNjZUdjP06raomQT3zRxgQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-JTYvNnyuOgyf2QlAM9LHGA-1; Mon, 03 Feb 2020 10:00:41 -0500
X-MC-Unique: JTYvNnyuOgyf2QlAM9LHGA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFF641034B23;
 Mon,  3 Feb 2020 15:00:39 +0000 (UTC)
Received: from dhcp-17-70.bos.redhat.com (dhcp-17-70.bos.redhat.com
 [10.18.17.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4692C8642F;
 Mon,  3 Feb 2020 15:00:21 +0000 (UTC)
Date: Mon, 3 Feb 2020 10:00:19 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC] QEMU Gating CI
Message-ID: <20200203150019.GA28910@dhcp-17-70.bos.redhat.com>
References: <20191202140552.GA5353@localhost.localdomain>
 <CAFEAcA--Rag8JzvPP+Pvkebv1ifeZkpcx7zSXdDBkpZWmpZwxQ@mail.gmail.com>
 <20200203032700.GA12127@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200203032700.GA12127@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
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
Cc: Jeff Nelson <jen@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Ademar Reis <areis@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 02, 2020 at 10:27:12PM -0500, Cleber Rosa wrote:
>    >>> The set of machine I currently test on are:
>    >>>
>    >>>  * an S390x box (this is provided to the project by IBM's Communit=
y
>    >>>    Cloud so can be used for the new CI setup)
>    >>>  * aarch32 (as a chroot on an aarch64 system)
>    >>>  * aarch64
>    >>>  * ppc64 (on the GCC compile farm)
>=20
> I've built an updated gitlab-runner version for s390x, aarch64 and
> ppc64[2].  I've now tested its behavior with the shell executor
> (instead of docker) on aarch64 and ppc64.  I did not get a chance yet
> to test this new version and executor with s390x, but I'm planning
> to do it soon.
>

Just a quick update on s390x.  I've run a job and had no issues:

  https://gitlab.com/cleber.gnu/qemuci/-/jobs/424084346

- Cleber.

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl44NX4ACgkQZX6NM6Xy
CfOz7A//UhEBKXbA0es6ntFIspR3CW6r/3qOVgY1xoafmevitJNzOHI7MeeUvKX+
ajS4zltcOs1G3EN/Ym2rTuJTc7RPOHyMZcLGu9TFLLjAkJzS7VJyx9J0cf8BX3qZ
qKAcucelTPI0DzFx7G+5/G6f9UYXtyWM7sljXJUhQJJaQPhiOBKpA7UxjArYNXk9
KIjLJFQV7+AkZw8wzlBCUbWzKo18jsfxLRUKa17PhJo8quMIF5VSqiTir2yJQwvk
ujHlV/duAILuIfEiGxEtUKFr3FBOPms9ZzLJ1O5Dg9ZJIZZWEpeCtyFxmu7IrkBB
nk86Y98h8sN+bGUUa9KoVKIVWsTkgVhEsRfO+Q8oQzjjhUFFaLkwXDcc/9wti+LB
r6Fm5/rQjv1ONcCseuzXAlFBkBYQsV1YXTTKoosSIHVChCmzJY07ABbM0HQTz2c6
TbFnX604apbzsEDK0KSqpe4VSJwrQu56JHg2rqAeH3NS+MyBdPDMl8vCCqxefPaQ
vDVBbiKqy49NxzeHAbhZowjamLf3baVbk7MehD8i4Yug697UcfNx+YeSG0VUK9x+
uANxokFHwjrIUpArlxfQIdPFDUpjwSSSwGyFVrmfz0rAHTr9n7i9zUWCRGXpvSli
GpFDPdvkVRM6HNt69Py89aGETl0OGx5FXM0SD4cAqBRG7Ka4XrY=
=3zgd
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--


