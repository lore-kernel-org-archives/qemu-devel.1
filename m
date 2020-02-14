Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B63C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 10:12:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6F4920873
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 10:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FCQGDfYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F4920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2XxK-000848-3e
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 05:12:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1j2Xq1-0005O0-2c
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 05:04:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1j2Xpz-0000Q7-Bp
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 05:04:44 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26563
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1j2Xpz-0000Or-6t
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 05:04:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581674682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BbbpFig12LBcDTZzX//QG1cZkkfpdQI/xFRCDW9GG8g=;
 b=FCQGDfYvO0dMjcsfE51F4vRJcUU8c15i9LVp/r1nhQLWae54rMRMouu70eNwRewrhobf49
 ytt/1+c2fjiLDPZrLAm4VedeSmucp1VRfZzQIKwe1hF0kcMC4KY3Q4YLSr91cX3ANXemL8
 Q67KeL4WbXJozpP9u0LWnDW43/84AI8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-T_V4piqMNqiRK30iUfD8Jg-1; Fri, 14 Feb 2020 05:04:39 -0500
X-MC-Unique: T_V4piqMNqiRK30iUfD8Jg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04B18107B267;
 Fri, 14 Feb 2020 10:04:39 +0000 (UTC)
Received: from lpt (unknown [10.43.2.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 50BBD1001DD8;
 Fri, 14 Feb 2020 10:04:35 +0000 (UTC)
Date: Fri, 14 Feb 2020 11:04:32 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
Subject: Re: [PATCH v2] Report stringified errno in VFIO related errors
Message-ID: <20200214100432.GX11103@lpt>
References: <4949c3ecf1a32189b8a4b5eb4b0fd04c1122501d.1581674006.git.mprivozn@redhat.com>
MIME-Version: 1.0
In-Reply-To: <4949c3ecf1a32189b8a4b5eb4b0fd04c1122501d.1581674006.git.mprivozn@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NJ5+aVN4Egd/eJfU"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: qemu-trivial@nongnu.org, alex.williamson@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--NJ5+aVN4Egd/eJfU
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2020 at 10:55:19AM +0100, Michal Privoznik wrote:
>In a few places we report errno formatted as a negative integer.
>This is not as user friendly as it can be. Use strerror() and/or
>error_setg_errno() instead.
>
>Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
>---
>
>v1 posted here:
>
>https://lists.nongnu.org/archive/html/qemu-devel/2020-02/msg03623.html
>
>diff to v1:
> - Change error reporting in vfio_dma_unmap() too as I missed it in v1.
>
> hw/vfio/common.c    | 4 ++--
> util/vfio-helpers.c | 6 +++---
> 2 files changed, 5 insertions(+), 5 deletions(-)
>

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--NJ5+aVN4Egd/eJfU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl5GcKwACgkQ+YPwO/Ma
t50WewgAhwOCz3sgS2qSWfEL2hw0MGPl/+f8ouWZdEOyRlIFC81A1/aRauA3/9+j
I9w26e5HHu5XlNzgSKYe1+5IcgQ/fhDMqn5l9kiBrQztp/iAMaTK0fpAiZuvLyrP
x36FJ2bgRcRfWmqFi4fcnlLUpg9Jd0IKqyxyPE0ItusvKTTTdtA+eru9UClE9mvd
mfaSvT5QuTFVH51uJU4vHKrDzLC9Qu/GLCtGBofeUFmey7Mc1vBqGalqWjycSaiy
BLFZkwcv89GhI4/YRDE4eKf4G72hG+RqfS+uNYRNOI9aEXq2mCgHgRQEHELVeboS
uTmSONKVUrLPqcZe+hic8PWvwWUL8g==
=BrS4
-----END PGP SIGNATURE-----

--NJ5+aVN4Egd/eJfU--


