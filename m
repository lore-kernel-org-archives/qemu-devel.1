Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95B0C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B43D2207DD
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jN+POmww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43D2207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWcNC-0007WH-R8
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 04:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jWcMI-0006Ne-2A
 for qemu-devel@nongnu.org; Thu, 07 May 2020 04:58:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52451
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jWcMH-0004XX-AE
 for qemu-devel@nongnu.org; Thu, 07 May 2020 04:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588841900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UAco0Iw5JjD9AUIv/q3cRkchU4jFbo7zekt1cuVXzaU=;
 b=jN+POmwwrvNsmS663b3hXdqzFCBll3Y3/W3UldjBV3HbAC1U3lANvDuQmmzM4tYTfQ4MZH
 DPZPU5udkF8zCG/fxs9f9vpLdtPfI/nCbx091nLAa1wRMdwpq4F9XijTLOHsQ3MjeXjykx
 0PHZq8dvfJ+9Tw8ylOWGFgb1OI0ro98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-tncdmQpfOZ6jN0-2V1BC8A-1; Thu, 07 May 2020 04:58:18 -0400
X-MC-Unique: tncdmQpfOZ6jN0-2V1BC8A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41E8580183C;
 Thu,  7 May 2020 08:58:17 +0000 (UTC)
Received: from localhost (ovpn-114-212.ams2.redhat.com [10.36.114.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC1C05C1D4;
 Thu,  7 May 2020 08:58:16 +0000 (UTC)
Date: Thu, 7 May 2020 09:58:15 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 1/6] qemu/osdep: Document qemu_memalign() and friends
Message-ID: <20200507085815.GD34079@stefanha-x1.localdomain>
References: <20200504094641.4963-1-philmd@redhat.com>
 <20200504094641.4963-2-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200504094641.4963-2-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pZs/OQEoSSbxGlYw"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 02:00:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, Keith Busch <keith.busch@intel.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--pZs/OQEoSSbxGlYw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2020 at 11:46:36AM +0200, Philippe Mathieu-Daud=E9 wrote:
> Document allocator functions that require a specific
> de-allocator call.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  include/block/block.h          | 4 ++++
>  include/qemu/osdep.h           | 3 +++
>  include/sysemu/block-backend.h | 2 ++
>  3 files changed, 9 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--pZs/OQEoSSbxGlYw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6zzacACgkQnKSrs4Gr
c8hhoAgAj4VBugJTHSVK2ULsjOxBK0qBXBT4ddsHrNrWfkmBcBKaMN0rxrLUiJBs
MyIs7cLNE1ZBMUm+z4x4+4OlqLdSxdOv3S+G4eiW0Ifd/U8McvrxL8tShc47Tzxb
nyBoHQiui/nowrN8F5OSEZNz0y0HqRtpIKXtveWfLlNoHqrj4wQtj/SidZPoZT6e
wE1r8YlS9aANI0qa1hsm/2LJhwKMD7DvIKaOu+Jz4mX/hqKhmmqVjllEpzN4FYGi
fdAx94ldV6I0QJgYhQJ+14KxfxLLgjniIADhsoyFcOykYi9KzV/CF3VBALCDo4PP
lmmq10/5ikPxkspxX8RjYhsTnVBAkQ==
=0+/q
-----END PGP SIGNATURE-----

--pZs/OQEoSSbxGlYw--


