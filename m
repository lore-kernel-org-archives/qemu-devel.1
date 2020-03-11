Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66F8C4CEC3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 16:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25AE120737
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 16:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLKfPn7R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25AE120737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC4eC-0006XB-S1
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 12:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jC4d7-0003PR-QS
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 12:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jC4cz-0008Vp-5a
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 12:54:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27639
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jC4cz-0008VZ-2M
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 12:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583945680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oFr7djhE0/iS+iKhyNjI1DmbIejtjZhC0ylagqvEGVs=;
 b=gLKfPn7RfYuCBykt1hjagQfaewZ6nUVx5x/OkJW+kbXl2ndAjwVnhsvh6qHVu1pQTXAkeu
 uFioYbOd6CpiJ3qGliTb2SfQl9EkJnJXmvkfzNi+LCfndP0pENQG1Ps+27jH8M9IxdNxR9
 +ZP6dU5/6a0/En7sP+lK6KNr0xYbsPw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-Ku63rgnuPleH95IZ0EhkSw-1; Wed, 11 Mar 2020 12:54:33 -0400
X-MC-Unique: Ku63rgnuPleH95IZ0EhkSw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FB7618FF660;
 Wed, 11 Mar 2020 16:54:32 +0000 (UTC)
Received: from localhost (unknown [10.36.118.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDD131001DDE;
 Wed, 11 Mar 2020 16:54:31 +0000 (UTC)
Date: Wed, 11 Mar 2020 16:54:30 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PULL 0/9] Block patches
Message-ID: <20200311165430.GA281087@stefanha-x1.localdomain>
References: <20200311124045.277969-1-stefanha@redhat.com>
 <158393463555.5248.10581197100321444095@39012742ff91>
MIME-Version: 1.0
In-Reply-To: <158393463555.5248.10581197100321444095@39012742ff91>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: fam@euphon.net, peter.maydell@linaro.org, qemu-block@nongnu.org,
 mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2020 at 06:50:37AM -0700, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200311124045.277969-1-stefanha@re=
dhat.com/
...
> dbus-daemon[12353]: Could not get password database information for UID o=
f current process: User "???" unknown or no memory to allocate password ent=
ry
>=20
> **
> ERROR:/tmp/qemu-test/src/tests/qtest/dbus-vmstate-test.c:114:get_connecti=
on: assertion failed (err =3D=3D NULL): The connection is closed (g-io-erro=
r-quark, 18)
> cleaning up pid 12353
> ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/qtest/dbus-vmstate-test.=
c:114:get_connection: assertion failed (err =3D=3D NULL): The connection is=
 closed (g-io-error-quark, 18)
> make: *** [/tmp/qemu-test/src/tests/Makefile.include:632: check-qtest-x86=
_64] Error 1
> make: *** Waiting for unfinished jobs....
> Traceback (most recent call last):
>   File "./tests/docker/docker.py", line 664, in <module>

Known patchew issue.  Unrelated to this pull request.

Stefan

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5pF8YACgkQnKSrs4Gr
c8gYRAgApdJ/rcsK94p3kRkfIgX7U58T8NYoW5pj3Fuq7Mrr7ux1OTOoYFe0GLPB
11b7eh7aOa0VijNBymGLCd+c9TXK5G+Dm6CDphDiRfaUk/Uu5DMMnJ5sCfuY3DOy
RmAO5/eahDt+TWkv2W9yb3dDvPIcWWcSe5PFR0r0R/QVEtx31UOH5rIgFg6FoRrc
Dm21PJkfa1QT05I/QOURUk8FGUTKZJTSZBeEbX+B9CF9cWrQcuG5PPA7IOhshrbV
hfWGV+eqLLr9u2dTy+DVwbjjn6m4wEqxpojY0p43b6maQJrI/AEfiBaj/sTY+7/e
UvMbxCowAI9nPALbg8yfoKNcuReyBw==
=D7j9
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--


