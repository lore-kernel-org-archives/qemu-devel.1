Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CE6C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:41:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37BBF207FC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37BBF207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAtsW-0000Qg-Ac
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 06:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54448)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iAtos-0004nl-DL
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:37:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iAtor-0007F6-CK
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:37:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38788)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iAtor-0007Ev-6V
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:37:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 73F8B100EFBA;
 Thu, 19 Sep 2019 10:37:48 +0000 (UTC)
Received: from localhost (unknown [10.36.118.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BBF525D6B0;
 Thu, 19 Sep 2019 10:37:42 +0000 (UTC)
Date: Thu, 19 Sep 2019 11:37:41 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190919103741.GO3606@stefanha-x1.localdomain>
References: <20190918231846.22538-1-alxndr@bu.edu>
 <20190918231846.22538-14-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="f0PSjARDFl/vfYT5"
Content-Disposition: inline
In-Reply-To: <20190918231846.22538-14-alxndr@bu.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Thu, 19 Sep 2019 10:37:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 13/22] libqtest: make qtest_bufwrite
 send "atomic"
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "bsd@redhat.com" <bsd@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--f0PSjARDFl/vfYT5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 11:19:40PM +0000, Oleinik, Alexander wrote:
> When using qtest "in-process" communication, qtest_sendf directly calls
> a function in the server (qtest.c). Combining the contents of the
> subsequent socket_sends into the qtest_sendf, makes it so the server can
> immediately handle the command, without building a local buffer and
> waiting for a newline.
>=20
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  tests/libqtest.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 19feea9e17..d770462869 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -1086,9 +1086,7 @@ void qtest_bufwrite(QTestState *s, uint64_t addr, c=
onst void *data, size_t size)
>      gchar *bdata;
> =20
>      bdata =3D g_base64_encode(data, size);
> -    qtest_sendf(s, "b64write 0x%" PRIx64 " 0x%zx ", addr, size);
> -    socket_send(s->fd, bdata, strlen(bdata));
> -    socket_send(s->fd, "\n", 1);
> +    qtest_sendf(s, "b64write 0x%" PRIx64 " 0x%zx %s\n", addr, size, bdat=
a);
>      qtest_rsp(s, 0);
>      g_free(bdata);
>  }
> --=20
> 2.23.0

Cc John Snow, who added the b64write command.

The downside to doing this is that sprintf-formatting needs to be
performed on the entire base64 buffer.  This slows things down slightly
and a larger temporary buffer needs to be allocated, but I'm not sure it
matters.

--f0PSjARDFl/vfYT5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2DWnUACgkQnKSrs4Gr
c8i9qwf/WLzFN5PYw3GjtAEzHsqFxYXzdc4ZHb4phouJmFsEkdpO8Rk+i3WV4Waz
5z1FA4Dc2c4iPpxgMlx1b9JaX7DfejNdmjUR8gYLyHNXdxtUkgUl+aQFSK5ncC2z
jZXhgsdhDA88y0HQJr/Bu1o41UocjDpARVe7dEHt6WZQt5NmUR24YDG/747ERfQs
wChib+CQIO4gLD576Ts/Y7D3sbCpkC1ji85txnvMD5JpNQEb8tNo05dV32rZwhs1
48YtXAPOFFhvfGbATSDUEgst6S0h8gj300fcNb6pIM3m+HOajWHm+wFiREWnTstv
IVn/0FrMEs21DjTcgD6kcjQtyuKaxg==
=Nlpt
-----END PGP SIGNATURE-----

--f0PSjARDFl/vfYT5--

