Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58593C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 15:47:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25135214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 15:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZxOvTXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25135214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifQgF-0000om-3k
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 10:47:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1ifQf2-0008Cv-Ce
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 10:45:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1ifQez-0005WJ-9I
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 10:45:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59211
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1ifQey-0005Sl-SV
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 10:45:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576165547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/rUgL3iHnqn3P1U+4hW1FK2OU40S0h7QAnmCGHNL86c=;
 b=hZxOvTXzFx/NQTmqTVg69MBUNfbouyfBIo3sTEBsNPg7DJwAJAvJXtyUE3lx99biMsGf/p
 PIOAhJTkKh8i82ChqxuMWNb1Fh+edw63aAIknXGNezDp2ozct3PHIyslI6uQtyCL4+ZBVX
 1Ze8ox6MNFsGPU7AF8pDG14jOVBBR68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-UJyjVgslOsa29JXGqNeKfQ-1; Thu, 12 Dec 2019 10:45:44 -0500
X-MC-Unique: UJyjVgslOsa29JXGqNeKfQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3D26477
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 15:45:42 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D1D249A84;
 Thu, 12 Dec 2019 15:45:39 +0000 (UTC)
References: <1576161021-5359-1-git-send-email-pbonzini@redhat.com>
 <1576161021-5359-2-git-send-email-pbonzini@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/5] i386: conditionally compile more files
In-reply-to: <1576161021-5359-2-git-send-email-pbonzini@redhat.com>
Date: Thu, 12 Dec 2019 16:45:36 +0100
Message-ID: <871rt9cztr.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Paolo Bonzini <pbonzini@redhat.com> writes:

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/i386/Makefile.objs     | 6 +++---
>  hw/i386/kvm/Makefile.objs | 6 +++++-
>  2 files changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl3yYKAACgkQ9GknjS8M
AjUiHQ//RnEiB2Tc8iwsrtPBlvijnJX8a7kUlw+MMLk9HJpB/PggNQW8lhenkzUa
43U9iMqg55adrusXoO3atwKALVLrGySLkumwpKbbqFnb4ajB4bpk8ANZbMJVI9D+
IrgEKDpSbWSotAoHzQsBDjAmQjcTz+7AixvkGWYz/9wgqZiTc3+Kl0BCZGYUyf1O
1V+IVS/Gwg95LlT3Qh0CqM48ZkmOcGuQTsEo+SUR3Y4RGV8VOaYPA1mCZnm2c05f
V8XWii7hQjiqZQX5WC5xm6eCrzeWIYvxfnk7gnuwZyQpu6Zw7axqntKUtDE3twCs
1KutLkEm9XUVyBuZ0Um5sqyF8JDRm/boD1IAoirNa5re4tcEVMx+UBJXxifUDNrf
pGlR+fNiyDysJRCTbJ0otNYC1s3K+xauIi5BFZjzagPYRWT6W1n544QtgM6E0N+5
u1EBQhkORcltef/kN3Z9KBBgsYZiPftUCuj9xbdszH0hoZ8YfNbQLOG8iJVY48NU
qWmjI8MiYv0p0lW3mZyS0I/uIWGIiDZr+nBcvXijlpTWGws2p0TJWY0B9PDF8TWl
RfA1vgUGmmZJjQnOpr3qwyBE9kJyAhroPICyBHfQs2TE+G2OS+1rs36ZtAuSLF1x
xgY8jcXDJWeOwY6WzyoCsJ/3m26qra6f8INVYHtws+KZCZ/vLRQ=
=HAKU
-----END PGP SIGNATURE-----
--=-=-=--


