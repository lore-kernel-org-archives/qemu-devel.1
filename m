Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E385AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:20:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE235207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXdZV3pD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE235207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeKKJ-0002Bo-T4
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 11:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jeKHm-00083Z-5O
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:17:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22958
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jeKHj-0000sM-Vh
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590679050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y0jm0K0F8sSwtWejfl4hbQDGAI3u1gvDdlODusRovPE=;
 b=BXdZV3pDuCA2e2sRFy7EnWNk94kLqVVLxTZgQKWMn4RfHODjDgU9b5Kz9PieKhMceASRP9
 S4NmEYNHnuORavUSlAs9zgDqGs2/pz0bmavK5d/bjhSHFu+WaKd1GRe43epWxG9FaNjoG3
 pfz+7LoonvKILNomnfvD+BkhqD3lBJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-oy2Xq6b0MQe-DfCfbDhsFw-1; Thu, 28 May 2020 11:17:11 -0400
X-MC-Unique: oy2Xq6b0MQe-DfCfbDhsFw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE7FE107ACCA;
 Thu, 28 May 2020 15:17:09 +0000 (UTC)
Received: from localhost (ovpn-114-90.ams2.redhat.com [10.36.114.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB9F25F7EA;
 Thu, 28 May 2020 15:17:08 +0000 (UTC)
Date: Thu, 28 May 2020 16:17:07 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v3] block: Factor out bdrv_run_co()
Message-ID: <20200528151707.GH158218@stefanha-x1.localdomain>
References: <20200520144901.16589-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200520144901.16589-1-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EemXnrF2ob+xzFeB"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 03:11:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org, philmd@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--EemXnrF2ob+xzFeB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2020 at 05:49:01PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> We have a few bdrv_*() functions that can either spawn a new coroutine
> and wait for it with BDRV_POLL_WHILE() or use a fastpath if they are
> alreeady running in a coroutine. All of them duplicate basically the
> same code.
>=20
> Factor the common code into a new function bdrv_run_co().
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>    [Factor out bdrv_run_co_entry too]
> ---
>=20
> v3: keep created coroutine in BdrvRunCo struct for debugging [Kevin]
>=20
>  block/io.c | 193 ++++++++++++++++++++---------------------------------
>  1 file changed, 72 insertions(+), 121 deletions(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--EemXnrF2ob+xzFeB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7P1fMACgkQnKSrs4Gr
c8jN5ggAp1cvSjZ4n3dNNGroHhkQEFVwmwsGqRkvnxCa82I7RlsNeweNrs+QkktV
McooEIilhd4gc04XFD+Mz6klubsaoLm9/7E4nZdsQ58aVduAk4NpGCy2CE8+O+VR
XDBIuOijB4U9RlKU01WUV2Ak/ecwVwt2vMiRSrPoW3kZumRisjrtroO91h9oe881
S+2frPwZiOBCsoQITuGVapQQMpLzhuey/iPRX2EEptXWCkbBq+zBa8l0OoJ/d2TM
7Nw98chE8TK6hw+j2KECc1zt6vFsrprWhOJkvzUt9fBhzdccg4We0T2vc0mrzBww
cfNDhnRID4a1nlHGR8rSJM9JQd4G4Q==
=0Rdf
-----END PGP SIGNATURE-----

--EemXnrF2ob+xzFeB--


