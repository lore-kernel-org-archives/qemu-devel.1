Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E852C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:56:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DDF522400
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7DNazjh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DDF522400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX4rh-00056M-6m
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 11:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kX4q3-0003ct-5b
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:55:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30451)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kX4q0-0004bZ-Ql
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603727710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tXykLQ8EHZbjbviqGSgKAp6aqjycmtpxyw4+UfdyiH4=;
 b=I7DNazjhFKjmrjqLN/zuUXH6ki8SmS5ov6jV2B1pWVEb7B5o+lkGcNzMknSwBp8kje+HQe
 qF4XGL9TYZQzJgEXqm3Brcu4bO4WeeEQly5l4fi0u+WvZK9iFGe8ikrL9shO+IYN3nUrgJ
 ThA06nRIkvAebbIHNWapVZDoBqhN0MU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-6DRSZgb7MvGDRsdQ17VCag-1; Mon, 26 Oct 2020 11:55:08 -0400
X-MC-Unique: 6DRSZgb7MvGDRsdQ17VCag-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66D601087D9A
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 15:55:07 +0000 (UTC)
Received: from localhost (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 230A95D9E4;
 Mon, 26 Oct 2020 15:55:00 +0000 (UTC)
Date: Mon, 26 Oct 2020 15:55:00 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH v4 5/5] tools/virtiofsd: xattr name mappings: Simple 'map'
Message-ID: <20201026155500.GG52035@stefanha-x1.localdomain>
References: <20201023165812.36028-1-dgilbert@redhat.com>
 <20201023165812.36028-6-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201023165812.36028-6-dgilbert@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="S5HS5MvDw4DmbRmb"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: dinechin@redhat.com, virtio-fs@redhat.com, qemu-devel@nongnu.org,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--S5HS5MvDw4DmbRmb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2020 at 05:58:12PM +0100, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> The mapping rule system implemented in the last few patches is
> extremely flexible, but not easy to use.  Add a simple
> 'map' type as a sprinkling of sugar to make it easy.
>=20
> e.g.
>=20
>   -o xattrmap=3D":map::user.virtiofs.:"
>=20
> would be sufficient to prefix all xattr's
> or
>=20
>   -o xattrmap=3D":map:trusted.:user.virtiofs.:"
>=20
> would just prefix 'trusted.' xattr's and leave
> everything else alone.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  docs/tools/virtiofsd.rst         |  19 ++++++
>  tools/virtiofsd/passthrough_ll.c | 112 ++++++++++++++++++++++++++++++-
>  2 files changed, 130 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--S5HS5MvDw4DmbRmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+W8VMACgkQnKSrs4Gr
c8gMrgf/U9bEIcTXJKwnINyZQtQyBUXrrtVMMYXln8oRZ4667nGP6xf7Ei4HEqjb
4uAx3Gfwq/HeKgq9G8nZk340kKYOpTntA3PIemcv2yJ7neVElt8/f5XuGyY+ztfx
WheSPs4RO9mBMzp1VFcgTqbb4OnnJD1jFRCZqSabAx5ljyv/5vQooYOMd/o5GUbJ
vtf5ac4WIC1KpbdaEd4qcCZiLcO/a+0UQJThd9zBumxkdpl6AQOAMpoE/ZTkpOzk
z4pUCe7Tlp6kUQta4EdpQnlistHrm1u2uDVSRdyALa+zSHpCwVqTHV8hUWotGacj
OjhRacNKKmZrvk8n63Pc6CGBC6D74w==
=ny2B
-----END PGP SIGNATURE-----

--S5HS5MvDw4DmbRmb--


