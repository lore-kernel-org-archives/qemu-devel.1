Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811A9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:24:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 053CD20708
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAD1rFp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 053CD20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuw8G-0003hJ-SW
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 05:24:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iuw7Y-00036N-Md
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:23:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iuw7W-0003OQ-O8
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:23:23 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50835
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iuw7W-0003Nc-JS
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:23:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579861401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=14u5b1h+uqFIpe/+DiUKIQrNuO2yt2Y1/rH9pZADhs4=;
 b=UAD1rFp2SthNUjN6CmkVi+LM6o7qRwFzTXtwReEHb49JY77Rd23u3L+gYYvQbL7IsYlgYa
 x0EENLbF3sGi8FepOkx+5nGW6PjDtO39SeHQRveMcY4N1mRRSeCt6iDM96IR69eqHm8O+h
 XJpcps2VtSR7nkEcYZRojaaZIDJ9Fo0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-Qy4cuX_YMFaE68mybwEicw-1; Fri, 24 Jan 2020 05:23:19 -0500
X-MC-Unique: Qy4cuX_YMFaE68mybwEicw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F378107ACCA;
 Fri, 24 Jan 2020 10:23:18 +0000 (UTC)
Received: from localhost (ovpn-117-162.ams2.redhat.com [10.36.117.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6317845A0;
 Fri, 24 Jan 2020 10:23:17 +0000 (UTC)
Date: Fri, 24 Jan 2020 10:23:16 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: salvador@qindel.com
Subject: Re: [PATCH] qemu_set_log_filename: filename argument may be NULL
Message-ID: <20200124102316.GB736986@stefanha-x1.localdomain>
References: <20200123113225.GB691377@stefanha-x1.localdomain>
 <20200123193626.19956-1-salvador@qindel.com>
MIME-Version: 1.0
In-Reply-To: <20200123193626.19956-1-salvador@qindel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: qemu-trivial@nongnu.org, sfandino@yahoo.com,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, stefanha@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2020 at 08:36:26PM +0100, salvador@qindel.com wrote:
> From: Salvador Fandino <salvador@qindel.com>
>=20
> NULL is a valid log filename used to indicate we want to use stderr
> but qemu_set_log_filename (which is called by bsd-user/main.c) was not
> handling it correctly.
>=20
> That also made redundant a couple of NULL checks in calling code which
> have been removed.
>=20
> Signed-off-by: Salvador Fandino <salvador@qindel.com>
> ---
>  trace/control.c |  4 +---
>  util/log.c      | 28 ++++++++++++++++------------
>  vl.c            |  5 +----
>  3 files changed, 18 insertions(+), 19 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4qxZQACgkQnKSrs4Gr
c8hS5gf/b3nLNl3uIzDOvqiBwsckgkvOWheZPjk9qJhXGSDciadsDxAiejjNXrtk
H7umpUYKfT+CAPC250lIHVg3TqVVsArg/EJBpoWfiGa6x/ivJ9Wt3AJqN/2JKExU
kdK8i1bAHz7wvxpUS8+uE5IMwb4pfGfwYG6GCKhYHbSMEZaYJ47r0vtk2u9ksoLh
e9sTfTiXcfvkFHDvDe+TeWJowseK6FRZSOquSh4KUAN/z11qZmL80LTf+BJbaEAn
jLgrdaFFyw7ubllkvrNXd670rrk2F6TvYtZy0doVKSceKoDAPZ/bDNFuZPFAi0oj
N0ZfqDK0K/QoU8bjk9xR9S5fdIhFTw==
=H7i+
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--


