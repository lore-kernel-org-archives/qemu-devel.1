Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615ABC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 12:19:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A53DB23787
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 12:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/sF4eXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53DB23787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLQDL-0001rG-Ia
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 08:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLQAp-0000ea-Rv
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 08:16:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26674)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLQAm-0002rU-2M
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 08:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600949787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c3yQOSy20D3+Vj0HNlPpWGrn7dwc5VLbZs/rDwDOoFw=;
 b=Q/sF4eXUfv4t7+ME/gk4ezoFo09eF5T+XGI6ykjhP4BILsEMZdxQSuKopIContpmqQu6JW
 tXmfbtrebkDCfyrMw8E96M5UoLeIuo10B0uviEaeVBkl16QKTD4tzpFaHqRf4fa0M1Sxs8
 CHLo1gEVNu3+cGJqvHUDQ/iKNbUijOo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-EgCiAlqPNa6GngnHhfeZTg-1; Thu, 24 Sep 2020 08:16:23 -0400
X-MC-Unique: EgCiAlqPNa6GngnHhfeZTg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 357FE871805;
 Thu, 24 Sep 2020 12:16:22 +0000 (UTC)
Received: from localhost (ovpn-114-5.ams2.redhat.com [10.36.114.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9FD478834;
 Thu, 24 Sep 2020 12:16:21 +0000 (UTC)
Date: Thu, 24 Sep 2020 13:16:20 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v8 0/7] coroutines: generate wrapper code
Message-ID: <20200924121620.GA62770@stefanha-x1.localdomain>
References: <20200915164411.20590-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200915164411.20590-1-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="C7Us/CiahOveQMyD"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: fam@euphon.net, kwolf@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--C7Us/CiahOveQMyD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2020 at 07:44:04PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Hi all!
>=20
> The aim of the series is to reduce code-duplication and writing
> parameters structure-packing by hand around coroutine function wrappers.
>=20
> Benefits:
>  - no code duplication
>  - less indirection
>=20
> v8:
> 04: - rebase on meson build
>         - script interface is changed to satisfy meson custom_target
>     - rename script s/coroutine-wrapper.py/block-coroutine-wrapper.py/
>     - add docs/devel/block-coroutine-wrapper.rst
>=20
> Vladimir Sementsov-Ogievskiy (7):
>   block: return error-code from bdrv_invalidate_cache
>   block/io: refactor coroutine wrappers
>   block: declare some coroutine functions in block/coroutines.h
>   scripts: add block-coroutine-wrapper.py
>   block: generate coroutine-wrapper code
>   block: drop bdrv_prwv
>   block/io: refactor save/load vmstate
>=20
>  docs/devel/block-coroutine-wrapper.rst |  54 ++++
>  block/block-gen.h                      |  49 ++++
>  block/coroutines.h                     |  65 +++++
>  include/block/block.h                  |  34 ++-
>  block.c                                |  97 ++-----
>  block/io.c                             | 336 ++++---------------------
>  tests/test-bdrv-drain.c                |   2 +-
>  block/meson.build                      |   8 +
>  scripts/block-coroutine-wrapper.py     | 187 ++++++++++++++
>  9 files changed, 451 insertions(+), 381 deletions(-)
>  create mode 100644 docs/devel/block-coroutine-wrapper.rst
>  create mode 100644 block/block-gen.h
>  create mode 100644 block/coroutines.h
>  create mode 100755 scripts/block-coroutine-wrapper.py

Please send a v9 and I'll merge it.

Stefan

--C7Us/CiahOveQMyD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9sjhQACgkQnKSrs4Gr
c8gELAgAhUc/q9Wv88oETDLTGF/DbMekDjK3sFX3IIztpCEEd0A7AOFCQ0uk0lJ9
GkMSaXz7LZkL24h28/uJINZCP4t9KJcy56jW7y8g9vQPAUe7WcfKEcs2dwpSonLA
OR9u2FoLJnzflqG93jFLwnMoBWO7GZ02JrmDuCrD+eZ3DG4hiRPe40LM9m4k5uD3
Cvx0+mj34GMa+PSZSRxrJMrhE6Y7knTY02aHjiVqkkptTxNyaYpk2g3y4ca4fhxi
/vdMko1MuBzESnI6XHx9sUNIxb+XntxSmhmI/MHF3SnCR3yHRfWIfXTKq0C76yUu
+AU0NPxBB/zX68+8efa4OMas9ihiuw==
=SBTE
-----END PGP SIGNATURE-----

--C7Us/CiahOveQMyD--


