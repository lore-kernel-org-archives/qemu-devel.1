Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CC3C388F7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 05:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16EAA20872
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 05:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPy3QYfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16EAA20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbGVo-0002uS-0j
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 00:11:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kbGVF-0002UJ-52
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 00:11:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57310)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kbGVD-0002bB-LW
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 00:11:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604725862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sZR3fIdnHj0k4LIUzAOAhB1WRK3FkVi59znhSdBaBnI=;
 b=GPy3QYfz7m3/lrVn5AQX8+125QYWphw8rdN0JSaabmkuIhW7EqXbzMVi1ApodRyThRXQ1e
 S3niS3Cx1DXgRuBshHSjMLYShWvY6mEEdiHKbmuyqlQKR2dFRl+U17KNFFhXzwTSd3VwWB
 v7nzy6oNNkfeu6QwQfCcRYiBAj9LC6Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-QvHDrJGCM0SGmDPYrG6rMA-1; Sat, 07 Nov 2020 00:10:59 -0500
X-MC-Unique: QvHDrJGCM0SGmDPYrG6rMA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 221D41006C82
 for <qemu-devel@nongnu.org>; Sat,  7 Nov 2020 05:10:58 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-47.rdu2.redhat.com
 [10.10.112.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 726996EF7B;
 Sat,  7 Nov 2020 05:10:57 +0000 (UTC)
Date: Sat, 7 Nov 2020 00:10:55 -0500
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 08/11] qapi/introspect.py: replace 'extra' dict with
 'comment' argument
Message-ID: <20201107051055.GD2208@localhost.localdomain>
References: <20201026194251.11075-1-jsnow@redhat.com>
 <20201026194251.11075-9-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201026194251.11075-9-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cPi+lWm09sJ+d57q"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 07:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 03:42:48PM -0400, John Snow wrote:
> This is only used to pass in a dictionary with a comment already set, so
> skip the runaround and just accept the comment.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+mLF8ACgkQZX6NM6Xy
CfOhzA//ZkgTgJT/t0TyrDtb2yZHNIaPcuZJaKZPrn0eTkmNMvDTsqN0/R2l2iSw
Rg7nCGns4NZnRJ7EXxCrXe+O+mIqzQF4csLQBI0j5CUkirKll4YIJBfeuUDqTOv4
F9VxgLBojGRdWGcdrefWbU8OWDu9l23bnZY8dVrbrxrx/oe/WqCtxofdGC2i3g6O
Rr4vj1irpKOE+5kMzWsBvMS2Pa+tWAPcSd5A64u/QdKG1eBVSyCqWkoj/7ERGMCS
ALiQOz1R0v3qiQKaCm5U3LvYRK6qY/JE9BfA9lhvEKjmltyVThQ+oy/hlBTHSfwU
4/2PUsIVifvKkLWp9TQZkql6gvRoekOri14wmNgmzEtZ+YA26hFAV9F4PSc2xMaF
x+Q8FBVT8TSVM6UaTpia+1qRMkHSvOXKsDelRVYfN9gAQ9NUUGy3AnCjq1Gmp062
aRBtuw24u2u23oH1eX1Y+1mO8n8RLhRPLTVHPdcWyTbcpNI6d7cRw6xRxWYRsnhI
yvjzZZkXG7PHRQWUQXqxihos53U5nxnpr0O9cocfb+rJVZD6hSdknK+W+bvO+LNz
0o2yQNU/0xTKnZGbTjJR+yOF91A456+wvf21bQJwzvMTYFrpk3UqOw/8N+Thmiso
On+/wpYoOS2CXJuPrhal5v0kBD+z4emirQhGetgMeCbijxvvs7Q=
=6Rcw
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--


