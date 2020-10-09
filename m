Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FA4C43467
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:18:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FA0722276
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUEIUb3T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA0722276
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQpTy-0002xo-6P
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 06:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQpSA-0001k0-Ku
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:16:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45310)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQpS8-0001Xw-8W
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602238603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NYNNa2H91mDKPuEbpcbkGtfNNiLSLcWAwbqWjJV++zk=;
 b=IUEIUb3T6/DiGyRFkdMkDDLKDZIzJeN7QOqlM2NCJTBUp0TFQTMxwmZdck/LkoAkR6IALs
 QylvxOxHzqPVVM1eV9h9jIvc/StvNI9NgC1QWTT/0laczKxIzvtOUsjy1xOwpjLBVTS4Si
 radwHg8R4mNe1v9TQKvMAKDjs60DgSQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-q2MGqymBOiSfyyk5h0f4Jg-1; Fri, 09 Oct 2020 06:16:41 -0400
X-MC-Unique: q2MGqymBOiSfyyk5h0f4Jg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8067C427C6;
 Fri,  9 Oct 2020 10:16:40 +0000 (UTC)
Received: from localhost (ovpn-115-23.ams2.redhat.com [10.36.115.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A6ED3A5;
 Fri,  9 Oct 2020 10:16:39 +0000 (UTC)
Date: Fri, 9 Oct 2020 11:16:38 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] block/export: add vhost-user-blk multi-queue support
Message-ID: <20201009101638.GB168921@stefanha-x1.localdomain>
References: <20201001144604.559733-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201001144604.559733-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2020 at 03:46:02PM +0100, Stefan Hajnoczi wrote:
> The vhost-user-blk server currently only supports 1 virtqueue. Add a
> 'num-queues' option for multi-queue. Both --device
> vhost-user-blk-pci,num-queues=3D and --export vhost-user-blk,num-queues=
=3D need to
> be set in order for multi-queue to work (otherwise it will fall back to 1
> virtqueue).
>=20
> Based-on: 20200924151549.913737-1-stefanha@redhat.com ("[PATCH v2 00/13] =
block/export: convert vhost-user-blk-server to block exports API")
>=20
> Stefan Hajnoczi (2):
>   block/export: add vhost-user-blk multi-queue support
>   tests/qtest: add multi-queue test case to vhost-user-blk-test
>=20
>  qapi/block-export.json               |  6 ++-
>  block/export/vhost-user-blk-server.c | 24 ++++++---
>  tests/qtest/vhost-user-blk-test.c    | 81 ++++++++++++++++++++++++++--
>  3 files changed, 99 insertions(+), 12 deletions(-)
>=20
> --=20
> 2.26.2
>=20

Thanks, applied to my block tree with tab damage fixed:
https://github.com/stefanha/qemu/commits/block

Stefan

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+AOIYACgkQnKSrs4Gr
c8gcTwf+JmXgtsWPzBib8/s5Fc85V1rYFBS1nKR+NHudS+8CttAobhMGq9jOqTIm
hv1jsgK3N+kSn2riGzoT9Ulbo33tAKTbZgQggi5s8x3w9TgTP+hv/S/hy7IOQ6JH
nHdVPK/1G2WULoSYyOLSNbWjpl5XkHwXcTOC+3sLDO8CFEPCgdwfqlkAHX+GjV2Z
iv4HvSFjLWVKBBmuQx73MdiMeX4iz6vgzJh7eqZ9E2OVXxNquO73i/ayd/190/v7
mHy3FDalUnlUzSWFPhNK1W5AhBL2xsFJNUOtI+2ajjQYy/R4zMW2/c6zkceXGvm6
C+QavuVc8/gXQ+NOBpIOTV2LRvjsMw==
=BH68
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--


