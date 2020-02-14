Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F19C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 09:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CC41222C2
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 09:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NrZtdMgK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC41222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Wz9-0007MJ-Cm
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 04:10:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45519)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1j2WyY-0006Zj-Od
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 04:09:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1j2WyX-0000DR-8g
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 04:09:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45202
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1j2WyW-0000CW-SW
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 04:09:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581671367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/hItWXPT3PepiXMrjkcf4av5prSvhyvWvmBQ163UULQ=;
 b=NrZtdMgKfoEePBmWK09veMrwmZWhrx5MKMzvOiQoqTxFQIU8kR2HVRUJoJ61XUojsHvlSG
 FW8lGifA/Unz+1JtnShABB9LKY20Z84SXjEL/WKH8z4gjkphkCg99kLMTkVCl0adxpCams
 B3SGlWC9vecoEtuiWwVK1CZKCna477w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-DI99oka5NYuksLkdlb5IIA-1; Fri, 14 Feb 2020 04:09:24 -0500
X-MC-Unique: DI99oka5NYuksLkdlb5IIA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFCBA107ACCD;
 Fri, 14 Feb 2020 09:09:22 +0000 (UTC)
Received: from lpt (unknown [10.43.2.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2161E1001B2B;
 Fri, 14 Feb 2020 09:09:18 +0000 (UTC)
Date: Fri, 14 Feb 2020 10:09:16 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
Subject: Re: [PATCH] Report stringified errno in VFIO related errors
Message-ID: <20200214090916.GV11103@lpt>
References: <2dc5a0962a38b912e4fa4900f9813b7ea1a9273c.1581670009.git.mprivozn@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2dc5a0962a38b912e4fa4900f9813b7ea1a9273c.1581670009.git.mprivozn@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CSNFvL6ilyiKL/Hs"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-trivial@nongnu.org, alex.williamson@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--CSNFvL6ilyiKL/Hs
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2020 at 09:47:39AM +0100, Michal Privoznik wrote:
>In a few places we report errno formatted as a negative integer.
>This is not as user friendly as it can be. Use strerror() and/or
>error_setg_errno() instead.
>
>Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
>---
> hw/vfio/common.c    | 2 +-
> util/vfio-helpers.c | 6 +++---
> 2 files changed, 4 insertions(+), 4 deletions(-)
>

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--CSNFvL6ilyiKL/Hs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl5GY7gACgkQ+YPwO/Ma
t50ZhAf+J7BeNYYuIJOLKE0T52Uo7bpFuAUKGMyHLUZAIKxTQIsDJBbPJHl0RCVG
9VISk6xHmwSNzh4YKibcZsxs5UoJ1rlZsfjgCR9vA8XC80vZyZOcaMxTlQ/omNJd
FnffTWCMbDtj1erYOMIvyvcvXGAsfvV0p1Lx2Oy63bz3hilt6WMz35ZfXEMbHY14
eQtDt1kwtXJzusBqTd5XBOfCOeb2s7+xB8GVrrr/1HCIuPnHmEFRZckq5JVQ+tFK
4XiEbjGe2lOtlac33WY0yGNvpMgOr2K2LIe695vFFjNKpW/w22bmFhu6ESquIWy0
po9EBoz99NbAFy9FFkLj+ILpFAl8zg==
=4LG7
-----END PGP SIGNATURE-----

--CSNFvL6ilyiKL/Hs--


