Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBD9C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 04:14:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F785214D8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 04:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OOiErtBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F785214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN72K-0004rG-7H
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 00:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kN71i-0004QV-GX
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 00:14:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27719)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kN71h-0007U2-0n
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 00:14:06 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601352844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lB7YlX5nQouTVuZIHcg+IUWx5MX7JVkWZQWs4OVKF44=;
 b=OOiErtBD2XsIInP/dUhJaH6ZDFvUxsA5tqe/Cx5+q9CnZaHi9srx62ACHsPYuqfrib8HiL
 Lsfo9PhX0rTfM+BtmtypTc7ty65aX+1SRmvlIBvk59GUF/LqXi0CVOhxKLyP5oalwiTg4q
 nwbkkbLfPRepuFBPU9J70X6suw4FOC4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-NIXWc24aNEaHOiSKvKGD0w-1; Tue, 29 Sep 2020 00:14:01 -0400
X-MC-Unique: NIXWc24aNEaHOiSKvKGD0w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 746D3801AE1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 04:14:00 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B96BC7368F;
 Tue, 29 Sep 2020 04:13:59 +0000 (UTC)
Date: Tue, 29 Sep 2020 00:13:57 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 12/47] qapi: enforce import order/styling with isort
Message-ID: <20200929041357.GI700868@localhost.localdomain>
References: <20200925002900.465855-1-jsnow@redhat.com>
 <20200925002900.465855-13-jsnow@redhat.com>
 <87imc2w6uf.fsf@dusky.pond.sub.org>
 <8baab976-1dfd-a7b4-1a1e-47480cf0c4b6@redhat.com>
 <87tuvigkuf.fsf@dusky.pond.sub.org>
 <a2bd875a-b158-3c64-e6b6-7238e1e7c7d9@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a2bd875a-b158-3c64-e6b6-7238e1e7c7d9@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="svExV93C05KqedWb"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 23:30:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--svExV93C05KqedWb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2020 at 10:34:42AM -0400, John Snow wrote:
> On 9/28/20 8:13 AM, Markus Armbruster wrote:
> > PEP 8: "Surround top-level function and class definitions with two blan=
k
> > lines."
> >=20
> > [...]
> >=20
> >=20
>=20
> Yep, but flake8 does not complain about the first definitions that occur
> below imports. Why not? I don't know.
>=20
> Regardless, I can change it and fold the changes in; they won't affect mu=
ch
> here.
>=20

Well, on all of the cases here, it's not function or class definition
that follows, so that aspect of PEP 8 is not being violated.

- Cleber.

--svExV93C05KqedWb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9ytIMACgkQZX6NM6Xy
CfPRsQ/+M6m7bYCZZ5+3FaXzkoTmZ6oSIfo5YVBOGF9qe7XJLqV6HQ8Wo74NC/A8
YZMSLMGDaTsXxd+YL5EbsBx2rVemZnXUTuVyic5eOiPybET2CcPMXrc0nSe3vzdc
LE5tx1MD+QI9VU25jcXajAvd8dwpVrhZ0kx5m0rBF3zeChE/zD8gaCt8pjhskFWd
3mv8owYskSva0fqJ1CZwgu1EbbysT0B8JtIoWuceDMkKaFDNuVlOqUMHBl++wdPL
e+kx6JGiYTgodwSp5Ig+fAEya89ilwqoH4+GUB0T3JxuCOJaokROGRS1Ncs8azV9
dT38da4qZW5pK/2I6Rm/lfdW2vXwPMjShnKxrjq8ZspGNbIJDeLd6nwRFpNGMREy
Ojv6BN3G7b5Q/bFO/LOYNx0BFtXXhhmHiurVCawNlzrh2uEDQZpKgNpXObCKj04D
kvevocggoRA84/WPhDW1JZ9Hrvpb5jgfRc0GNW5K0PX8/XP80JtdILXGW1w+ptpE
g8ij+tVun/b7BeW5NCAwGojuJiVyTG6pBCOQk/qWKbbALo1VNTrVIimQ31f/DDRh
1z+DLsFXJnQyvldI3uLw86UYbwlC3a22OxqHSEXOo/n8XvkQcAnsvydzop/c/Who
mxstx+WcHDon5LyhFJtHvSnMHv1FMzAoP0qcvZmiH3gaBe3xjmg=
=+91L
-----END PGP SIGNATURE-----

--svExV93C05KqedWb--


