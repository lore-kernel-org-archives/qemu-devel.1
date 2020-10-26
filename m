Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB42C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:56:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A96B422400
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2xjMRz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96B422400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX4qs-0003uy-Rf
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 11:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kX4p0-0002H6-OP
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:54:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31541)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kX4oy-0004R0-It
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603727646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PBwOXaeNHjnf/JWe1UpoDBIpPHqC7x3swBjInLyiQuo=;
 b=a2xjMRz4/bS6oWskH48h525b/X3lTZZH5naor6nq0wqMtQsMGkRdqB2M5AVEXinaga3W2K
 4RAIBjcNy8GYPZZxXRpQYB4LI+fT46H9+INqZbaduHVV1J/D3nxw4rCt67N0HnQhhiu/Vd
 EU3GIeTOIoS45X/60MAKoWtnDFl3f5U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-SLcB0-vtOXSuY7dKG62_Qw-1; Mon, 26 Oct 2020 11:54:03 -0400
X-MC-Unique: SLcB0-vtOXSuY7dKG62_Qw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF3AF809DD3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 15:54:02 +0000 (UTC)
Received: from localhost (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 69BC210013C4;
 Mon, 26 Oct 2020 15:54:02 +0000 (UTC)
Date: Mon, 26 Oct 2020 15:53:58 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH v4 3/5] tools/virtiofsd: xattr name mappings: Map server
 xattr names
Message-ID: <20201026155358.GE52035@stefanha-x1.localdomain>
References: <20201023165812.36028-1-dgilbert@redhat.com>
 <20201023165812.36028-4-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201023165812.36028-4-dgilbert@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OZkY3AIuv2LYvjdk"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
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
Cc: dinechin@redhat.com, virtio-fs@redhat.com, qemu-devel@nongnu.org,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--OZkY3AIuv2LYvjdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2020 at 05:58:10PM +0100, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Map xattr names coming from the server, i.e. the host filesystem;
> currently this is only from listxattr.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 90 ++++++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--OZkY3AIuv2LYvjdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+W8RYACgkQnKSrs4Gr
c8hMJwf/Sn0wMUCvqqgiy4EUkBNuDyRs+bXMyL2GACXnXK6Msk1xDqvLKDQyAOjn
4uKawLy55UkoX1HQ6qoDtgOc7h4kNxirMnEH3G6weWO6FbZS0N5skDqI/0/F+Uwh
CWdCdTTKmnma3r2/UA67mm+yIqkd9308RqgIoJ6VTtwJD1ZHPfPh2UzcR6rXBCy/
+KkLaldP5kqhCBOEuZzaeLPFAeWTSDZbm2Xzbj2A8WwaYiY+HN3c3FnD+BSmyiKj
xvGlvxXTQm4Q7sslnasvfW/iRNVVP070D5HvG97LkRi8mOF9Oy+F/0KmekIzOEtd
PhlAVHdPAXtB7U6Bm11Qg/dZaK9Hvg==
=U14g
-----END PGP SIGNATURE-----

--OZkY3AIuv2LYvjdk--


