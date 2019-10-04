Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416BFC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:14:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 154D720867
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 09:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154D720867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGJfS-00031y-7C
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 05:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iGJeW-0002JM-Td
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iGJeV-0007KS-Tz
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 05:13:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33644)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1iGJeS-0007Hs-Od; Fri, 04 Oct 2019 05:13:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B9BF21057875;
 Fri,  4 Oct 2019 09:13:27 +0000 (UTC)
Received: from localhost (unknown [10.36.118.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC0C45C222;
 Fri,  4 Oct 2019 09:13:26 +0000 (UTC)
Date: Fri, 4 Oct 2019 10:13:25 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH 0/2] block: Skip COR for inactive nodes
Message-ID: <20191004091325.GF505@stefanha-x1.localdomain>
References: <20191001174827.11081-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vKFfOv5t3oGVpiF+"
Content-Disposition: inline
In-Reply-To: <20191001174827.11081-1-mreitz@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Fri, 04 Oct 2019 09:13:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--vKFfOv5t3oGVpiF+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2019 at 07:48:25PM +0200, Max Reitz wrote:
> Hi,
>=20
> While working on $IMGOPTS support for Python iotests, I noticed a minor
> bug.  Let=E2=80=99s fix it, as you do with bugs.
>=20
>=20
> Max Reitz (2):
>   block: Skip COR for inactive nodes
>   iotests/262: Switch source/dest VM launch order
>=20
>  block/io.c                 | 41 +++++++++++++++++++++++++-------------
>  tests/qemu-iotests/262     | 12 +++++------
>  tests/qemu-iotests/262.out |  6 +++---
>  3 files changed, 36 insertions(+), 23 deletions(-)
>=20
> --=20
> 2.21.0
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--vKFfOv5t3oGVpiF+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2XDTUACgkQnKSrs4Gr
c8jNSAf/Q7wA+XZcvWHuGj1BbvKOZ3y0iCZ8YmCfSTH2FeoA8n2o1tipCwPb0xli
vecwO2Q1VSw2QFJssLW7/sODzXmtv7EkPPOSuE7E4/K9en9yH3tlH9JIfbJcC354
2ufd44P23FWZYnCr2ZfPC4LjRG0cieuF7XqQIPQVrTA7L4asS3S07Nf917uC0hRa
hE+h+OSpxBZ3ca9E3xQlRF+sPSI7PwcWr8L/J2HQYaO+Bxm3Pf8Q6azWF9D27yfB
kaUG9bk5zMNEJf0uX/jPvpalYHa96/5NAjIKjt9HEqNvOndekDbe28ejyxHDVOt9
9cMlmPeWSdtBdJ7syMhbzXdM3jjpzg==
=+FwL
-----END PGP SIGNATURE-----

--vKFfOv5t3oGVpiF+--

