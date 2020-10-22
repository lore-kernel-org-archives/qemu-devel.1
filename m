Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE969C388F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 14:25:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39FE224171
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 14:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhWgvaWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39FE224171
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVbWa-0003MF-5f
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 10:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVbSa-0006bx-A8
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 10:20:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45688)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVbSY-0002Sk-Fn
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 10:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603376453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0QHTPmJaHE8r51xZoDyA5TWUv2MD+ia7Omz9fARq5PM=;
 b=BhWgvaWaDPWpvDfvz3ROf63mg9XDRy9Ou3/BFlff4b980v34pW8hvktBFtdQybtgKDlMMk
 cHrM+O8mGIo7fvr48RgXGm21MOdin8NhaRGgZLDI4AQX0HZCOMgu/D7pQnSf49zXq5qy0E
 9X7K8gXVTmsv4MsDdqJDmN3swhYCWfg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-9kjOXMZpOEG1JY9hYYUTDg-1; Thu, 22 Oct 2020 10:20:49 -0400
X-MC-Unique: 9kjOXMZpOEG1JY9hYYUTDg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA70A188C12A;
 Thu, 22 Oct 2020 14:20:48 +0000 (UTC)
Received: from localhost (ovpn-114-229.ams2.redhat.com [10.36.114.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DB615B4A1;
 Thu, 22 Oct 2020 14:20:45 +0000 (UTC)
Date: Thu, 22 Oct 2020 15:20:44 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 09/16] util/vfio-helpers: Convert vfio_dump_mapping to
 trace events
Message-ID: <20201022142044.GI761187@stefanha-x1.localdomain>
References: <20201020172428.2220726-1-philmd@redhat.com>
 <20201020172428.2220726-10-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201020172428.2220726-10-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="X+nYw8KZ/oNxZ8JS"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:09:01
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--X+nYw8KZ/oNxZ8JS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2020 at 07:24:21PM +0200, Philippe Mathieu-Daud=E9 wrote:
> The QEMU_VFIO_DEBUG definition is only modifiable at build-time.
> Trace events can be enabled at run-time. As we prefer the latter,
> convert qemu_vfio_dump_mappings() to use trace events instead
> of fprintf().
>=20
> Reviewed-by: Fam Zheng <fam@euphon.net>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  util/vfio-helpers.c | 19 ++++---------------
>  util/trace-events   |  1 +
>  2 files changed, 5 insertions(+), 15 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--X+nYw8KZ/oNxZ8JS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+RlTwACgkQnKSrs4Gr
c8i5mQf/fSrbLRiaIeU8LS94iCG8jjjkg+76joBj0+6UYUAtYx38kQiaH+oDyNU4
dR2rPr1Hlm0pLbcse/UVZSRRt7YCdJq8bUSoU5d5l8fOMr6bt4c6jmj394QIwN5d
yH3Q5XpLxemU3hC4lX62bTuEw3gA477hByQxbZJReSPGrgKJAvgZNuNyQh1eRgqS
86VbDbxqG9oy73n45pxt7rlzcDPhIv505ZmK4OSbJ9cAC8tNP4tO728C3PkHDTke
W4U/Lm2VwqopGq589B/TafgK2zmbgTjR8JtnzKKl8ZEfnfRg5ZnHkUINP38uH8T5
iFHJ0hRETVuEjo39QAVTUyukOJxULA==
=1fZr
-----END PGP SIGNATURE-----

--X+nYw8KZ/oNxZ8JS--


