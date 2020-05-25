Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08304C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:13:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3A49206B6
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 08:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1lp+DFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A49206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd8Ep-0005um-0A
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 04:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jd8E9-0005Jl-Mp
 for qemu-devel@nongnu.org; Mon, 25 May 2020 04:12:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22459
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jd8E7-0000XZ-Rg
 for qemu-devel@nongnu.org; Mon, 25 May 2020 04:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590394370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a/yqDAZDTtbJUfD7fgRgPNytPrfV/mDIVeXwhB0slAE=;
 b=J1lp+DFFiO9sFTz6J2isbugVGoIDspAv7v2/FsfUa3PR+UxbLclZ1DAXNlNEx0n2H/Ee/I
 vDpSJlfWKKadCIN04giAVVOA3/Q0bUl5O0UjzIGStpUc0tWbeMqpAtV2e9SKQBo9rMuMht
 d3ObS/JRn1tqVlh+PXmSbBfwMbubG58=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-JT-yT6UDPQGyjqHQityWHA-1; Mon, 25 May 2020 04:12:48 -0400
X-MC-Unique: JT-yT6UDPQGyjqHQityWHA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D39E1855A01;
 Mon, 25 May 2020 08:12:47 +0000 (UTC)
Received: from localhost (ovpn-112-233.rdu2.redhat.com [10.10.112.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F27A79C22;
 Mon, 25 May 2020 08:12:42 +0000 (UTC)
Date: Mon, 25 May 2020 10:12:41 +0200
From: Sergio Lopez <slp@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 3/7] block/nvme: don't access CQE after moving cq.head
Message-ID: <20200525081241.cbsgtyi6pf7dkyyf@dritchie>
References: <20200519171138.201667-1-stefanha@redhat.com>
 <20200519171138.201667-4-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200519171138.201667-4-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6vuejpxec6v6tliy"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=slp@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:54:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--6vuejpxec6v6tliy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2020 at 06:11:34PM +0100, Stefan Hajnoczi wrote:
> Do not access a CQE after incrementing q->cq.head and releasing q->lock.
> It is unlikely that this causes problems in practice but it's a latent
> bug.
>=20
> The reason why it should be safe at the moment is that completion
> processing is not re-entrant and the CQ doorbell isn't written until the
> end of nvme_process_completion().
>=20
> Make this change now because QEMU expects completion processing to be
> re-entrant and later patches will do that.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/nvme.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>

--6vuejpxec6v6tliy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl7LffgACgkQ9GknjS8M
AjUayg/+N55PRalxTmZznvUaQcwekZgdNEGKY1nm8deogZfKNxVGl/GSfwAy9p/4
3luMvYcvUZp2eE7ANeXnhjGS3zm9SyKELZPhcTi220vH10ROdjjS9ZI/lqRBuW5h
TS+xwYmwK0ylkeCfWTiCUsp/CsPCU4yRhvikN48z3IHQRtgnK5WfpneXxOoRODAx
1HfsTqqiaNbJJSu1j0lzzUco2tQL22J6OyTzvLwv3VjQ70xiIrJbHFNjmBPSBiCB
aKxEtwVJQGmrKqHrkkG4TnOSe25SlOZaWP8SidTJk9lgGUBJnMhplX1q/11IJSbc
l9WNubRZFXwHFmj2AUQ9Xa6bK8p52ofAFOEu5drHm0umPYgFMVBlS/L9vKw0Skvt
uCBm5Jvqh30T6jUntETgjRTR5WaKmsbIJiikQDUOk0vonfA6RluqcyIWNUjXsMmR
kxb6wPKnwHNwjzCz2LZCJ2hkfv7KkB1jz53eAMBrg2w3n2f0fHeE62FUU51Ss3Bj
zP6l2Ten0xg10UoPGIPkV/5HwrcFvcr9EIVlHhu5qJcId0nBnvfONT4rUBLyfPaI
Qn74766YCvHrVR8kcMBaYnMXPJ4aBy5YRQCrFXTZx4F4khhJzWB2Z2EmFQmPBBxl
YVpnA+qdIQy4Va6lMuo+wG0XHWK6eSM18/sVSdApVlI/O4uUKUo=
=JWPW
-----END PGP SIGNATURE-----

--6vuejpxec6v6tliy--


