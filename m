Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE06DC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 13:33:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB0D0238E1
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 13:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jCMz/CYK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB0D0238E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSKR3-0005DO-R9
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 09:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kSKP2-0003Xd-SA
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 09:31:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50081)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kSKP0-0001er-0X
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 09:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602595900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lLCHTfvvEOkQB64GsJ80j3aa4m3yldhHEH9qq0gnFxE=;
 b=jCMz/CYKugyLYpQi/B9fsi8i6lYTxPxPyKd3hohwQDDxH3/dG3cmwcyjwMCExP+CaecRZs
 DCIQxRRoQdAc6xOBPV3YTLWrY3tptBIiRtT4Zrn7yZ7mNtS+XWfU+z6l2zCNBrEaWZQ92g
 L72g2Q1SK8l6Bui2HA1M+tyiPWYELUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-UWWirLt5PP-QF5Ni-DtV8A-1; Tue, 13 Oct 2020 09:31:38 -0400
X-MC-Unique: UWWirLt5PP-QF5Ni-DtV8A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A371110E219A;
 Tue, 13 Oct 2020 13:31:36 +0000 (UTC)
Received: from localhost (ovpn-114-235.ams2.redhat.com [10.36.114.235])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 402BF1002C0A;
 Tue, 13 Oct 2020 13:31:35 +0000 (UTC)
Date: Tue, 13 Oct 2020 14:31:35 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Joelle van Dyne <j@getutm.app>
Subject: Re: [PATCH 06/10] coroutine: add libucontext as external library
Message-ID: <20201013133135.GH164611@stefanha-x1.localdomain>
References: <20201012232939.48481-1-j@getutm.app>
 <20201012232939.48481-7-j@getutm.app>
MIME-Version: 1.0
In-Reply-To: <20201012232939.48481-7-j@getutm.app>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+QwZB9vYiNIzNXIj"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:04:27
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--+QwZB9vYiNIzNXIj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2020 at 04:29:35PM -0700, Joelle van Dyne wrote:
> From: osy <osy86@users.noreply.github.com>
>=20
> iOS does not support ucontext natively for aarch64 and the sigaltstack is
> also unsupported (even worse, it fails silently, see:
> https://openradar.appspot.com/13002712 )
>=20
> As a workaround we include a library implementation of ucontext and add i=
t
> as a build option.
>=20
> Signed-off-by: Joelle van Dyne <j@getutm.app>

Hi,
Thanks for sending posting this!

Please indicate what license libucontext is under, that it is compatible
with QEMU's overall GPL v2 license, and update QEMU license
documentation (LICENSE, etc), if necessary.

Please update .gitlab-ci.yml with build tests. Is there a way to test
building QEMU for iOS? If not, then it's difficult for the upstream QEMU
project to carry iOS-specific features since we cannot test them.

Thanks,
Stefan

--+QwZB9vYiNIzNXIj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+FrDYACgkQnKSrs4Gr
c8g1nwgAg6ouYmt0As3AGlDhS9KbnTBa3+OYlJn8mN8YayKnowVQARhQVekyR30X
veN5Mg7pF6go9q4PegAszlqK3IJHhrDFX75ZtrtQnPsLnaHsftJX6MVFKqw+YeAE
uTrm7BObwr9B3FUyQgCd0zoVgbVHcDHPBHQs8hBdZrt2TNr+oy9qTDo9u/48khaS
pk8J6RD2RhGhuWpKzRi8fiRafpB3JN5NXThJmVO2Hn1ZiWLw/suBhbhGMezk39dz
Wyy1Nqt6fPKjCYs6dDmfqshmpFR049kMOmx/79Wi4dfCx3tnzdy3HHdLQ1QvW8ig
fCLEdob1ll/+Y0RZhtWf3nsDVTPNZA==
=N36k
-----END PGP SIGNATURE-----

--+QwZB9vYiNIzNXIj--


