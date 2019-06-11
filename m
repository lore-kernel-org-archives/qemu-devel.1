Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85088C43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 10:04:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C7D12086A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 10:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7D12086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55130 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haddn-0002z6-37
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 06:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51556)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hadYX-0000cl-Ni
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 05:59:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hadYW-0001es-TT
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 05:59:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54878)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1hadYU-0001cJ-Qb; Tue, 11 Jun 2019 05:59:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CC2B646202;
 Tue, 11 Jun 2019 09:59:01 +0000 (UTC)
Received: from localhost (unknown [10.36.118.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E26485D704;
 Tue, 11 Jun 2019 09:58:58 +0000 (UTC)
Date: Tue, 11 Jun 2019 10:58:57 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190611095857.GT14257@stefanha-x1.localdomain>
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
 <20190610134905.22294-13-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6k8oSBQUGGHRSAt9"
Content-Disposition: inline
In-Reply-To: <20190610134905.22294-13-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 11 Jun 2019 09:59:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 12/12] qemu-iotests/087: checks for
 io_uring
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Julia Suvorova <jusual@mail.ru>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--6k8oSBQUGGHRSAt9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2019 at 07:19:05PM +0530, Aarushi Mehta wrote:
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> ---
>  tests/qemu-iotests/087     | 26 ++++++++++++++++++++++++++
>  tests/qemu-iotests/087.out | 10 ++++++++++
>  2 files changed, 36 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
> index d6c8613419..0cc7283ad8 100755
> --- a/tests/qemu-iotests/087
> +++ b/tests/qemu-iotests/087
> @@ -124,6 +124,32 @@ run_qemu_filter_aio <<EOF
>  { "execute": "quit" }
>  EOF
> =20
> +echo
> +echo =3D=3D=3D aio=3Dio_uring without O_DIRECT =3D=3D=3D
> +echo
> +
> +# Skip this test if io_uring is not enabled in this build

Is this comment a todo?  I see nothing that skips the test.

--6k8oSBQUGGHRSAt9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlz/e2EACgkQnKSrs4Gr
c8j7egf9FWHb52R/y/xkgrpsclXkrX4Faem0ZCSiMQkh+3ZxsOnGCvathtHMrJZO
TPFXSjirCWX3zjjY7QUivuixR7DhkDAaMX/8HZVdQHHjC5Qisucb8VEHbGgW+KQ6
GdDqzE0vZTibgchySIhjb5AFWgg/mTHzOYz04R7PTyoqTAIn76zCeGNHwEr6G9BR
l9NSAp+ETKpRgjJ3611ey9ITDTjvvaHeCBbZ4w8L/z8K4LxQI+uconFGLchvv+nZ
Cp/BDRsWvePKZiYPW3np9Cvz4nY7BlZRsIAeEHFYj9jHR5hes64u1p410b/F+F9r
67KCkJlTX4eZnU7l0/uZduKdsFPI3g==
=UunI
-----END PGP SIGNATURE-----

--6k8oSBQUGGHRSAt9--

