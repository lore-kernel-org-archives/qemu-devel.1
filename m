Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABF0C76199
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 21:49:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81E6E2084E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 21:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdYwB35g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E6E2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3Rmp-00082E-M7
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 16:49:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1j3RkT-0004xW-MN
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:46:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1j3RkS-0000oa-R7
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:46:45 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60711
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1j3RkS-0000nl-B4
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:46:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581889604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yKtvU1H67Zknv2WeCNHn33+6TrBEQtkG0I2JXFjt1g0=;
 b=PdYwB35g4S80dCCr33Dww08KI+f2b5BgpQcHOfd7mWmvV4KbTDl1Dd9AzxdZ5I0E8yx16Y
 o/Cd1zr2B3vJTZq7CPaoFwtOYemUzZ6whc9WsQ0Hf+XNv8gFEX+UpjRaGyQ005ywne5ma0
 eszQF3qdsDsGZyO04kHr7ebZudDPozw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-6J-3k4UyN1m2mKtqVvq3LQ-1; Sun, 16 Feb 2020 16:46:41 -0500
X-MC-Unique: 6J-3k4UyN1m2mKtqVvq3LQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95742100550E;
 Sun, 16 Feb 2020 21:46:40 +0000 (UTC)
Received: from lpt (ovpn-200-18.brq.redhat.com [10.40.200.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 54E395DA75;
 Sun, 16 Feb 2020 21:46:37 +0000 (UTC)
Date: Sun, 16 Feb 2020 22:46:35 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 5/7] commit: Fix is_read for block_job_error_action()
Message-ID: <20200216214635.GI745061@lpt>
References: <20200214200812.28180-1-kwolf@redhat.com>
 <20200214200812.28180-6-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200214200812.28180-6-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rCb8EA+9TsBVtA92"
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
Cc: pkrempa@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, nsoffer@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--rCb8EA+9TsBVtA92
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2020 at 09:08:10PM +0100, Kevin Wolf wrote:
>block_job_error_action() needs to know if reading from the top node or
>writing to the base node failed so that it can set the right 'operation'
>in the BLOCK_JOB_ERROR QMP event.
>
>Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>---
> block/commit.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
>

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--rCb8EA+9TsBVtA92
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl5JuDsACgkQ+YPwO/Ma
t52mwQf9Eb0ry6Jlv/7948piwR4H1eZBNo6OK5zrNJquwlBioLd5WpEjtV4twxbs
Tq2i1IcgHOxES3JtD7ilKHzRVlBlgbJZZga3EInq+qQDqR0I3z6dsFQoq86o3Kc+
4tkYnc8PtAUZTM1l/IyJ7GevJKrmERDPosTw1mAVZscFi9kGr6N8X1zr1Xh6MscN
XwuohiegumrF13uISNxY8Qmx6kLb94u4GkgfkErRix0QTD8jFQvFd/Foes9Kky+T
c3DtER92KDTzCSd3BIugSbq0TpbXBIGOkztPDmGRlk4/rBmfTGTbmSl5ulSkNsfu
UxmWsKkkpJhVCNA4RqmmnsPFgA+7ng==
=5dm6
-----END PGP SIGNATURE-----

--rCb8EA+9TsBVtA92--


