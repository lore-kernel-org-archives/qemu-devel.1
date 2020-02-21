Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707F0C35641
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 08:55:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AAD82067D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 08:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FjhGC8El"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AAD82067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j545O-0006QO-E0
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 03:55:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j544o-0005yw-8H
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 03:54:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j544m-0006JZ-VR
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 03:54:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40014
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j544m-0006Ed-QI
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 03:54:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582275263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kxyLLjFtUjI/rO5u8tWbs67oT7Sd7qRcCjf1QBMhMoA=;
 b=FjhGC8Elu4dxP8Pa93tNegypDmbv/bh1CLe4NiHeHoo0LxIYXMgei6Wtlx5ALnf75qui+H
 9KtcjHeTI2hiAJ1jA8WeG9IUxkpQ1QX9x1JEdswjm1NLuU44CqghGqg1+0sQvJ0PWqo8Oq
 PFEJhG1zuVgXL/wIxPID0bOynIiYXWE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-Tr3sssKXNgKgffdKvD8vyA-1; Fri, 21 Feb 2020 03:54:19 -0500
X-MC-Unique: Tr3sssKXNgKgffdKvD8vyA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8515184B13D;
 Fri, 21 Feb 2020 08:54:18 +0000 (UTC)
Received: from localhost (ovpn-117-223.ams2.redhat.com [10.36.117.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AAB2F90775;
 Fri, 21 Feb 2020 08:54:15 +0000 (UTC)
Date: Fri, 21 Feb 2020 08:54:14 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: Re: [Virtio-fs] [PATCH] virtiofsd: Remove fuse.h and struct
 fuse_module
Message-ID: <20200221085414.GA1343391@stefanha-x1.localdomain>
References: <20200221065515.4476-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
In-Reply-To: <20200221065515.4476-1-yangx.jy@cn.fujitsu.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2020 at 02:55:15PM +0800, Xiao Yang wrote:
> All code in fuse.h and struct fuse_module are not used by virtiofsd
> so removing them is safe.
>=20
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  tools/virtiofsd/fuse.h   | 1229 --------------------------------------
>  tools/virtiofsd/fuse_i.h |   16 -
>  2 files changed, 1245 deletions(-)
>  delete mode 100644 tools/virtiofsd/fuse.h

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5PmrYACgkQnKSrs4Gr
c8hjUggAkDZGxDRsI4z+OF1ZBao/rNDi8RxJE7Kh4+S/4yL0I4ZzhK/0c3L87dOY
ywQ8hnA9ryuzt0Rhh0MaxOUm6seiV8WgBSy6ZwEjqKSP/cSgLqZzi0CiORs4UdGh
7e4pqb8gyPWzLC1Kem7X2/b/xeYw3bb0AjCNqTgyuMAScamY0BOsaNMVA0zahnq3
LJ0171CBZ0yTVmZOn8QnffqZQJQzOMxNFyLtd9ZvA6udj0xJfGvfr3sEENFmrpNB
d7HlEomOz4Rqey+JMCAQUvo5WNSveXiR70LhyqI4oyJpf/SJW07z4R8wqcqAgIQD
xwfVhncf6QTLAAvqEbkdeXSdjbC6MQ==
=WXyA
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--


