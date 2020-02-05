Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6D8C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 22:29:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB848214AF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 22:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXVuI2rj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB848214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izTBA-0000qk-48
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 17:29:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1izTAH-0008TP-9N
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:28:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1izTAG-0005BK-3j
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:28:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38045
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1izTAF-00057R-W4
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580941735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z8Xz9/SQWB2raEfBa1w6njTpy2U9uq1y8sCEFkYcQPo=;
 b=IXVuI2rj7Gr4hnedUjZmnRTZqdSMsJs29ZGTAT/wEzKL8SlRV19AclPVgwu6b9fB5wNmc+
 JaSPQEs001xZn/6VhsDjM5wBFAhITrtDsFDpfvJiH9+Lpe7uI7OKgOl5cFXV1aYtP0ZArv
 RIYNyND4OQjLY+Edxrk/9Y/2ov6B90c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-Eo3JlTD1O_KMxXErhoO8ZA-1; Wed, 05 Feb 2020 17:28:52 -0500
X-MC-Unique: Eo3JlTD1O_KMxXErhoO8ZA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2A17107B287;
 Wed,  5 Feb 2020 22:28:51 +0000 (UTC)
Received: from lpt (ovpn-200-44.brq.redhat.com [10.40.200.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 365588DC09;
 Wed,  5 Feb 2020 22:28:47 +0000 (UTC)
Date: Wed, 5 Feb 2020 23:28:44 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 2/2] qemu-nbd: Removed deprecated --partition option
Message-ID: <20200205222844.GD31521@lpt>
References: <20200123164650.1741798-1-eblake@redhat.com>
 <20200123164650.1741798-3-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200123164650.1741798-3-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5gxpn/Q6ypwruk0T"
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
Cc: "reviewer:Incompatible changes" <libvir-list@redhat.com>,
 peter.maydell@linaro.org, qemu-devel@nongnu.org,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2020 at 10:46:50AM -0600, Eric Blake wrote:
>The option was deprecated in 4.0.0 (commit 0ae2d546); it's now been
>long enough with no complaints to follow through with that process.
>
>Signed-off-by: Eric Blake <eblake@redhat.com>
>---
> docs/interop/qemu-nbd.rst |  15 ++---
> qemu-deprecated.texi      |  49 ++++++--------
> qemu-nbd.c                | 133 +-------------------------------------
> 3 files changed, 24 insertions(+), 173 deletions(-)
>

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--5gxpn/Q6ypwruk0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl47QZsACgkQ+YPwO/Ma
t531dAf9GtmVVTV9Dr5snryrIbySXvAM4q/Ju3co54GKeWrE386yiwnckcRx7LcA
zssXZXWAmsUj6niDGBGkYCU8gmagsyaShQZVm/B1sV+YnUbrwTUmHy7G/X/sDSf/
uKEAuee/zFS+rDpvuJXQFpqXtJVoFhSrEv3o5FPZZWw46kzV8+MyNC0d+U9/+zvv
l2a8AzORjkzYusXqbFU18BpEJNg52dHy4nU9bQzsEaLK8IY/uRQZl9DPrNZT1KXv
mvPNV9d6l3jyYEgAM2f0+IfDC1H5O2xaiIFKzPFwjJP4pChM/tIxqP5CsW6SBbe8
3cCmOMt1YD1Y6hGUAwCwQlutJ6mGAw==
=JT0w
-----END PGP SIGNATURE-----

--5gxpn/Q6ypwruk0T--


