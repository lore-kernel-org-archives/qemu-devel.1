Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6C8C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 08:33:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 116C824684
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 08:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VwsZkxHo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 116C824684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwMJX-0003Sz-47
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 03:33:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50159)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iwMIw-0002oM-Eh
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 03:33:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iwMIv-0008Px-A4
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 03:33:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46251
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iwMIv-0008Ol-5r
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 03:33:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580200380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vUMDQmja9w6M4HDA4epiDSwEKKTKgGmTfLT3BRo5my4=;
 b=VwsZkxHoqV7wEScMZm7LBR6TkVMj/xaVB+EhE3LwrgjM5N4rK5IhK96/l5dY+FFRi9gzdq
 WResUc+PXleGbuMXcRHS+0gHOkYE/WfeFJvykhmsSC4sH6nU782j1oc3k0DL/PrwIXrEEW
 j+Z7iu1RXt7OCI/ddbjT5fEIq+V/XsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-x7YGt-jSN2Wev2mHGbfh4w-1; Tue, 28 Jan 2020 03:32:56 -0500
X-MC-Unique: x7YGt-jSN2Wev2mHGbfh4w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0E0A1800D41;
 Tue, 28 Jan 2020 08:32:54 +0000 (UTC)
Received: from localhost (unknown [10.33.36.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B2215DA8C;
 Tue, 28 Jan 2020 08:32:53 +0000 (UTC)
Date: Tue, 28 Jan 2020 09:32:53 +0100
From: Sergio Lopez <slp@redhat.com>
To: Kamil Rytarowski <n54@gmx.com>
Subject: Re: [PATCH 1/4] Add the NVMM vcpu API
Message-ID: <20200128083253.7osgcbwxkmkhgwds@dritchie>
References: <20200107125401.18126-1-n54@gmx.com>
 <20200107125401.18126-2-n54@gmx.com>
MIME-Version: 1.0
In-Reply-To: <20200107125401.18126-2-n54@gmx.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tvsmmas7lzcnnr23"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org,
 Maxime Villard <max@m00nbsd.net>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--tvsmmas7lzcnnr23
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2020 at 01:53:58PM +0100, Kamil Rytarowski wrote:
> From: Maxime Villard <max@m00nbsd.net>
>=20
> Adds support for the NetBSD Virtual Machine Monitor (NVMM) stubs and
> introduces the nvmm.h sysemu API for managing the vcpu scheduling and
> management.
>=20
> Signed-off-by: Maxime Villard <max@m00nbsd.net>
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> ---
>  accel/stubs/Makefile.objs |  1 +
>  accel/stubs/nvmm-stub.c   | 43 +++++++++++++++++++++++++++++++++++++++
>  include/sysemu/nvmm.h     | 35 +++++++++++++++++++++++++++++++
>  3 files changed, 79 insertions(+)
>  create mode 100644 accel/stubs/nvmm-stub.c
>  create mode 100644 include/sysemu/nvmm.h

Reviewed-by: Sergio Lopez <slp@redhat.com>

--tvsmmas7lzcnnr23
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl4v8bQACgkQ9GknjS8M
AjVCNg/+N6MHxW29IhKTAOVwuPhk+1kCcCuEwWn6UnlcjHxUFKi3q6epqcu4sNg0
+h/zzu9I1x2d7xuO3G1q6XId8i1SLrhyia9AyqNINkmJpr03y6E/99qL9R9pX1ZU
V3U73/FgIe44jidM8cMt5c9zSlpXM73UPLsWGAPGsX5PSaozHgJT3TbA5XwMbLqa
aUwjZr8oEw3sVjzh9FbpRHpr2XHCC/+ArwZjIpPezWDzqjxO/uux4K5KWIbc70ru
YVfZ25Cg7hWpVl3oUkDI/Ip2xFS7Tzpc3vVPfW9Izrto32T5rHUh+KQfbZ3okoOr
6CcDbxOdrpulCFRc1DUo5SGNlNXp4W4qmdDrOtEqRcZjvhp/UwNGAvmdGDk33G/R
tndA/moo+YeKxDvdMTvfjP7VoqUJw5hN3dnFa8RlCGgNFJHfZfb9CNpnVh3hpFqw
0CFuRhO0TPXFO1Ab3ZKreCXfjBK126QyEdvGts7EOEQUAuJ3nQqZgO1zsqegGm3v
qxcPWYvMQTPWXUlvS2osHoIEwe3xyB5sTM6I7p6V+LtdfiPac39c6FJ7XBZsGduQ
6fSQ3xaQX3jx6GH49ayP28kJIBsa77WBdyKIcMdIlVPChV7+iMvvFmo+EDuE24nS
Qr8XSUCYwmH8ThQc9RUgjXLVyO0fhMrp9I/YX7gSttllE9ZdkMo=
=myJ6
-----END PGP SIGNATURE-----

--tvsmmas7lzcnnr23--


