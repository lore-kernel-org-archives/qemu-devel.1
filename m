Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7931EC4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 12:33:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 526AD218AF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 12:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 526AD218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7Iqv-0002Kl-9h
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 08:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49743)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i7IpZ-0001oo-0I
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 08:31:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i7IpX-0005x7-BD
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 08:31:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33490)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i7IpX-0005wd-5R
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 08:31:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AF612316D797;
 Mon,  9 Sep 2019 12:31:37 +0000 (UTC)
Received: from localhost (ovpn-117-125.ams2.redhat.com [10.36.117.125])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1263E6012A;
 Mon,  9 Sep 2019 12:31:36 +0000 (UTC)
Date: Mon, 9 Sep 2019 14:31:35 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190909123135.GD13708@stefanha-x1.localdomain>
References: <20190906110649.9561-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RhUH2Ysw6aD5utA4"
Content-Disposition: inline
In-Reply-To: <20190906110649.9561-1-thuth@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Mon, 09 Sep 2019 12:31:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [qemu-web RFC PATCH] Update to Jekyll 4.0
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 06, 2019 at 01:06:49PM +0200, Thomas Huth wrote:
> - Update versions in Gemfile
> - "has_key?" has to be renamed to "key?" in category_archive_plugin.rb
> - Add .jekyll-cache to .gitignore file
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .gitignore                          |  1 +
>  Gemfile                             | 15 +++------------
>  _plugins/category_archive_plugin.rb |  2 +-
>  3 files changed, 5 insertions(+), 13 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--RhUH2Ysw6aD5utA4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl12RicACgkQnKSrs4Gr
c8g2HQf/YmMsXuEzVD1bj+SBjaemjO3gngLSiV8qhTb/esOFYj8HSUlCc7ulCiFr
Kx/k4zBuYSjQ4WSKKv7lwwgCjJDZSK7QT13eBPkZQk6b/9MLS52zW3yFBAL8jzGy
CFqalegHvwwKJ2zEyDwo+h3dDI/lR+MlQxM3UTVLENttnRycpKiKY3fp+AiPjzAt
HK1NBlN1v0IZEuSWn4WgMd/7Zk9uoq3X392C6vgWkO0OJK9OKqQrtYTEOBsi0ctv
v07jhmW3qF2KLJOyVvyVELFSDl2BdcX7KpdNGTNB9ThkoqRQZTHSmBazjtOoyyug
cuPrKsnbVSE2BOYOELpAde52D3Rtog==
=2qCZ
-----END PGP SIGNATURE-----

--RhUH2Ysw6aD5utA4--

