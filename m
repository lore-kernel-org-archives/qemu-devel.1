Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14D7C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 13:05:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22FAF20709
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 13:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMLr1dah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22FAF20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNbnA-0006KV-Ah
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 09:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kNbmQ-0005ps-6a
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 09:04:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25979)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kNbmN-0002QW-FB
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 09:04:21 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601471058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OtVhM9VMsYQmSY2UcEeouxpl5CwwQxK/R9nEdXNeJ9Q=;
 b=NMLr1dahf6DzhlZEDeMXiKnPArqXcyUHYbPZUD6e5T1D7WrdBjYuJabnZ9NbVzs8ca5nWx
 QId8Ag+MR1tzTy/XyfaovavZdnZCoZ4GrkhyqOmU4gVgY0gnqhChpUPDUYozGxGkIexsDm
 U6potUFuQF79TlIJR0AiMjiuFu6waxc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-VTifYOvlPQqtIxfgnFPQNw-1; Wed, 30 Sep 2020 09:04:16 -0400
X-MC-Unique: VTifYOvlPQqtIxfgnFPQNw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09F961084C8F;
 Wed, 30 Sep 2020 13:04:15 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-128.ams2.redhat.com [10.36.113.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7A54614F5;
 Wed, 30 Sep 2020 13:04:13 +0000 (UTC)
Date: Wed, 30 Sep 2020 15:04:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 1/4] keyval: Parse help options
Message-ID: <20200930130412.GB9292@linux.fritz.box>
References: <20200929172649.158086-1-kwolf@redhat.com>
 <20200929172649.158086-2-kwolf@redhat.com>
 <b28cad72-d344-78fa-fc07-b4a6a63fbc50@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b28cad72-d344-78fa-fc07-b4a6a63fbc50@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 29.09.2020 um 19:46 hat Eric Blake geschrieben:
> On 9/29/20 12:26 PM, Kevin Wolf wrote:
> > This adds a new parameter 'help' to keyval_parse() that enables parsing
> > of help options. If NULL is passed, the function behaves the same as
> > before. But if a bool pointer is given, it contains the information
> > whether an option "help" without value was given (which would otherwise
> > either result in an error or be interpreted as the value for an implied
> > key).
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
>=20
> > +++ b/util/keyval.c
>=20
> Might be nice to see this before the testsuite changes by tweaking the
> git orderfile.

What does your git orderfile look like? I don't know how to exclude
tests/ from file type patterns like *.c.

Kevin

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl90gkwACgkQfwmycsiP
L9bezRAAimzD6njO2o0MIdz6ZQYpEpyEiayR/FL3ImAE5dN1isOIl/e/lbbWmRJ/
IcP4kWzz9PblznpfYW+QxAkYj28kYmPFsPbsmuhyHfmXpnyDS1kqw/zsp7UJzHbI
MXuKqNCMaHdXmu9XDrxNy13hgUzaR5RqG/YFCeZ7JUJk6IMeKtQCzO2pyCiXDhwp
pVBdcD7qjwcCP7v2hMy5pksiuNM3Yib1g2oXiGp5J1/XnBWryS6qK0DGCnDvNOIj
levNxrRdn8nM+WZdkNWzCcz1qioHB0Qkbav/1Z03/oQzNPoacmHYRIXS6Pcjie4v
F5x6U3JsISxnZd3OWRnMKmazHJRu6G6/8LK+t1HgB5upQ4qz/Oe3CgRqyOO4NOVF
jt4mWi7kegrBz0pCQQ86B49IFmV7MbPqN29NJPYBTew8h6Pyf8HJsx5Rp2Vaqjg5
cbhx0o8oWFtZlpCxTgEfRHtha6f9Li66ltJdIg2zsC+Gtc4j5qXMcnFZlvjU76Pe
Z0QdI5N44eok4mniCAN6pHcfzBLDedVv+yv0PMMFgBfyj7qR4t7x4iWuB6XKkd79
8mOgPBYV+njXphh6X/zQ1qWr9HQ1bsgJ0+lllW7g6sAMmKJcantfykWXbjAKAYvp
7HljRFcRTkoPLt3RXOm1IgAtKXjarEz45OvsaN+xS/6sR6pkqvM=
=PpSU
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--


