Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F71C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:03:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 101E72076E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGersmMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101E72076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Pcn-0001bS-AN
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 11:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k8PaM-000745-9k
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 11:01:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k8PaK-0005er-Q3
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 11:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597849264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dwh04ABRBU6apcAdMPASJzFTwmm0SvDALtj05AdNmEQ=;
 b=UGersmMuFba31IutEHbOG45RNgJ0Q27lFuLhQjSqVGJK6EWlPrd73rVeKXYUzcVjO2K7Ad
 PMnV2u1H8chWOwVVwy/nQeQcl2PoqVCTsBviOvGMFyiEeolXaylIGWCkRzAPmmDOKvoQtl
 etaS05HzQYHZ6clBMA4d/rUc0Ab7x+4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-4CEgvJGeNdC0U7U2mxfIzg-1; Wed, 19 Aug 2020 10:59:43 -0400
X-MC-Unique: 4CEgvJGeNdC0U7U2mxfIzg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12018186A56F;
 Wed, 19 Aug 2020 14:59:42 +0000 (UTC)
Received: from localhost (ovpn-113-22.ams2.redhat.com [10.36.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A696C5C1D0;
 Wed, 19 Aug 2020 14:59:41 +0000 (UTC)
Date: Wed, 19 Aug 2020 15:59:40 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v3 09/12] iotests.py: add filter_img_check
Message-ID: <20200819145940.GM366841@stefanha-x1.localdomain>
References: <20200817091553.283155-1-vsementsov@virtuozzo.com>
 <20200817091553.283155-10-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200817091553.283155-10-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WuedheRyq6FDfQ9j"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 10:07:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org, armbru@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--WuedheRyq6FDfQ9j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2020 at 12:15:50PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Add analog of bash _filter_qemu_img_check to python framework.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/iotests.py | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--WuedheRyq6FDfQ9j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl89PlwACgkQnKSrs4Gr
c8gF4Af7BMqC3nGSjZedZTungh/AyJKUz/+1iA0EwXcrcbXEVCfwGpF3TwBE1ZCi
PvAK0ie1RVNjyGZr7injg/It4sTREL/WarScewYu8sgQ9zaoa3t3vIG13l8HE8N1
Dx598hZQbYIPAFWxajnhhYC7Ad0ldm2iHiyCSIOA+2djSyPveg6XvXHZx2xGEFeq
bkpLWFINzHQv4GTyFqVWaESYlIS1PwRJSv4gdi5cv7CYcuVpoh4ktUyTy1T2iU+B
5jjasG/7im+nUXMEVjHdrKrCy8gskoxpCMcDIuOsPBj6EeukABE7nfABwmIPKiAg
IYETFjUKVuXkseVT3PrXDW+IWbbN8w==
=ucYy
-----END PGP SIGNATURE-----

--WuedheRyq6FDfQ9j--


