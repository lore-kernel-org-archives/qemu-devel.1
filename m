Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39225C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 09:58:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01E2B20678
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 09:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AiPXPb63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E2B20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2XEk-00069y-UA
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 05:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2XED-0005jS-6D
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 05:57:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53583
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2XEB-0001IR-J5
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 05:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596448674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UY1gG0olnoH6WCTObK9dcQ4Tg6Muc4tazh44viu6xVQ=;
 b=AiPXPb636AXoB+HaEJYT2SQzYGmjADL7mb45Dpt6Nvurxow80qVOqOnR3YAlq3OzpXTQ3W
 52ugpNpYoK3bPhkZEI1/vyTkH05APAQVKv5jraMzt7D7sNBUnxN2BGHD89ngT1EUe+dr9n
 MayvxaAjmEjPr87oWD3oRav7xTLf0kU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-hA7Ku2V1MI6C702uAB7CrA-1; Mon, 03 Aug 2020 05:57:52 -0400
X-MC-Unique: hA7Ku2V1MI6C702uAB7CrA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA29C800685
 for <qemu-devel@nongnu.org>; Mon,  3 Aug 2020 09:57:50 +0000 (UTC)
Received: from localhost (ovpn-114-66.ams2.redhat.com [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE47810013C4;
 Mon,  3 Aug 2020 09:57:39 +0000 (UTC)
Date: Mon, 3 Aug 2020 10:57:38 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Virtio-fs] [PATCH] virtiofsd: Disable remote posix locks by
 default
Message-ID: <20200803095738.GE244853@stefanha-x1.localdomain>
References: <20200727161841.GA54539@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200727161841.GA54539@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ffoCPvUAPMgSXi6H"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:09:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: virtio-fs-list <virtio-fs@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ffoCPvUAPMgSXi6H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2020 at 12:18:41PM -0400, Vivek Goyal wrote:
> Right now we enable remote posix locks by default. That means when guest
> does a posix lock it sends request to server (virtiofsd). But currently
> we only support non-blocking posix lock and return -EOPNOTSUPP for
> blocking version.
>=20
> This means that existing applications which are doing blocking posix
> locks get -EOPNOTSUPP and fail. To avoid this, people have been
> running virtiosd with option "-o no_posix_lock". For new users it
> is still a surprise and trial and error takes them to this option.
>=20
> Given posix lock implementation is not complete in virtiofsd, disable
> it by default. This means that posix locks will work with-in applications
> in a guest but not across guests. Anyway we don't support sharing
> filesystem among different guests yet in virtiofs so this should
> not lead to any kind of surprise or regression and will make life
> little easier for virtiofs users.
>=20
> Reported-by: Aa Aa <jimbothom@yandex.com>
> Suggested-by: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ffoCPvUAPMgSXi6H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8n35IACgkQnKSrs4Gr
c8i7hQf9FLImnoPnUW5yy+IZ4gOCx8EGfMPCVrflDnB8wrWt5tJI5WfFUlnFbsCP
hLPTvasXJCGkX10pFSv2Lr+FyrJw14XL29yMY7ceQDsmbJSucAowm09D7YQPpppX
8nG4716DA1DKIuSdOY2OYSk6RcDL20JVrvH62lt4ENM/1koG0FRbsKuK5G+DwHRo
AJLZTxO+TXaUy3Tio0VWiKeXxLLYm59Uga4OCXzI8c2tPpweMj5Uj2mOVbISOJnE
4In8BOuH0vf2qg9VIZ2M8TB2a45PSF//viumYK7CMfw/rH9p+2dkl4BtndGyeDHE
f24Gjz4J95Y0cyywUYFom6m544ZYUQ==
=u7/G
-----END PGP SIGNATURE-----

--ffoCPvUAPMgSXi6H--


