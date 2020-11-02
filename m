Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6E6C388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:39:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC2FD22275
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RV30NQGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2FD22275
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZcre-0007Aj-2x
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 11:39:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kZcqj-0006IX-1O
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:38:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31677)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kZcqh-0001fH-E8
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:38:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604335106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HvRmTAmRBKOl/GkU0GI4vxD/wAYz2wz/v7JhVaVHHi8=;
 b=RV30NQGrcgLZ58FCVwBHOD9R8ShinLXVqD2U3c6q3puJIbzn6OI7uo8YCaHJX1SQYd7DDH
 GLXl+OwSVjerKNT9hmTbL8Wfx2CVeM45gTa7d4SMmfjaPAW+ba0gEopzs2rWwkFV/bql7p
 YpDebT1meyS3Be05TnpI+c5mFpjpeVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-IQdfjXPtMJuisQIq8ZHDZg-1; Mon, 02 Nov 2020 11:38:24 -0500
X-MC-Unique: IQdfjXPtMJuisQIq8ZHDZg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA0B280364B
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2020 16:38:23 +0000 (UTC)
Received: from localhost (ovpn-114-65.ams2.redhat.com [10.36.114.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 454D568433;
 Mon,  2 Nov 2020 16:38:20 +0000 (UTC)
Date: Mon, 2 Nov 2020 16:38:18 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: Add QAPI schema modules to their
 subsystems
Message-ID: <20201102163818.GA212231@stefanha-x1.localdomain>
References: <20201102081550.171061-1-armbru@redhat.com>
 <20201102081550.171061-2-armbru@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201102081550.171061-2-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2020 at 09:15:49AM +0100, Markus Armbruster wrote:
> Add the relevant QAPI schema modules to section Audio, QMP, Tracing,
> Cryptography.
>=20
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+gNfoACgkQnKSrs4Gr
c8jsOQgArqg89TC1/4A4+KcY4aeRIYuH4Cl6b4taJlcpCMGXZT0qEqXbIBk63AmC
3eGkqTHeOUyi4S1Dx6Cc5vMimIIwqZDM+gjsg7nBEfbZeIMCgS1yPd1JpfIsFNnp
36EK2wcl+WOkC+fqX82Xp/ay2cTO/+ImbdGHfultsF/nAefouamG0dw66Jq33kAK
AfTf/FLCymuhhk02v+j3Nz9SLzC5QvmMPZiae5F1PzmewWbiFxG2i2A2wTC+EIqv
XgDpjT8BuGjBbu50AMEzHGSyFlD9mXQ7lsp9VDBP1OGlg+J9Qe5VOQbcxNYBpI9k
PbM/mo7TgAObLjSU4tZ8AhoDZaJLRg==
=kMY5
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--


