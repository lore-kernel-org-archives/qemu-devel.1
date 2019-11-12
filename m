Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98875C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:38:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6397320674
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1hHc96U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6397320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUTZB-0006c0-Ey
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 05:38:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iUTYU-00069p-FS
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:37:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iUTYR-0004eY-GV
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:37:48 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44403
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iUTYR-0004eT-Cv
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573555066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IbYQ1tHLkpZLPHUamEEDVMq02s1fWeANMDA8YtCwhdI=;
 b=A1hHc96UHxHQayz41oBxZcaZpnTTSnK8WSyvM2CiyB35bBBM8gydwkYShnHcjMxnfAsfHt
 0IfpLJyMkV5vSTANj1gj2ZuHoBgHtX8nBCoi2x4onikwUH48Vx3DreAlPIRZbTgUDr4VfH
 wcV4Er+8C6Kc8SE29M5yt7FkqxT7fZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-lAz1cAo1OTubClrN9zd4Ng-1; Tue, 12 Nov 2019 05:37:43 -0500
X-MC-Unique: lAz1cAo1OTubClrN9zd4Ng-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2287107ACC5
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 10:37:42 +0000 (UTC)
Received: from localhost (ovpn-116-203.ams2.redhat.com [10.36.116.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3004A1B5AE;
 Tue, 12 Nov 2019 10:37:41 +0000 (UTC)
Date: Tue, 12 Nov 2019 10:37:41 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kashyap Chamarthy <kchamart@redhat.com>
Subject: Re: [PATCH qemu-web] Add a blog post on "Micro-Optimizing KVM
 VM-Exits"
Message-ID: <20191112103741.GG463128@stefanha-x1.localdomain>
References: <20191108092247.16207-1-kchamart@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191108092247.16207-1-kchamart@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+1TulI7fc0PCHNy3"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: aarcange@redhat.com, pbonzini@redhat.com, vkuznets@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--+1TulI7fc0PCHNy3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 08, 2019 at 10:22:47AM +0100, Kashyap Chamarthy wrote:
> +The proposal: "KVM Monolithic"
> +------------------------------
> +
> +Based on his investigation, Andrea proposed a patch series, ["KVM
> +monolithc"](https://lwn.net/Articles/800870/), to get rid of the KVM

s/monolithc/monolithic/

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+1TulI7fc0PCHNy3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3Ki3QACgkQnKSrs4Gr
c8izbAgAx8XbW0LECOqh5mF0FILwn4RaYiOe1zUhQEVCyenXTIsB+ZFbXjPN8Tvo
dZG5gkeZCyDMgBgN1ksAwX41RO7rkn2d64mMuYTwKuQUrGMdjItdTSny+D9nOCAu
k7he7JhUin8Dxi72t/db5yko+ADA/1JbLZrxxbcOkygaS3+TgcCmfp9i6vl+LAAs
jqtyJPwWA6VzPwv1kSvQHNYC931c+WPhJMmVQBNc5LrbvbWbDilrrCi/VMTjw+xu
UKOQKTtdy6umnQJaoBoFgwYhCkCH58fvPOradF7HXPPinZhX6NDEr3NTmcj8VBij
hfYP6OU1IvYJ8VKfTNwwQ9o22GNUMA==
=thf/
-----END PGP SIGNATURE-----

--+1TulI7fc0PCHNy3--


