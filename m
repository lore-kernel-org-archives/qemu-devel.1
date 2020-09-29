Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A227C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 04:18:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1AB6208FE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 04:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vubq3Kn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1AB6208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN76O-0007bI-3w
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 00:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kN75S-00070B-59
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 00:17:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kN75Q-000827-3g
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 00:17:57 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601353075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qUCVyEj9616TrSsRAkmsCedp725vlnspnjwjW3DhTIw=;
 b=Vubq3Kn+eyNUmPStvV+JDY9Uc8jji7bcxGeDx6WL1Tzjsg7kHF7pyNZPbwFvacUn2lnQO+
 brxs0TpRKpyGFRyIX4h2R0bI6Z0pprzZMf0yCjTX1ZIC/bSBv/zlNIe3nTKuQWcUdP0vht
 eHTRSttVu+0ap9nXlZcWPbQ3WCgizu8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-MtHdT0YzMsuzgbutBMewMw-1; Tue, 29 Sep 2020 00:17:51 -0400
X-MC-Unique: MtHdT0YzMsuzgbutBMewMw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B523D1005E61
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 04:17:50 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3005C60C84;
 Tue, 29 Sep 2020 04:17:50 +0000 (UTC)
Date: Tue, 29 Sep 2020 00:17:48 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 23/47] qapi: establish mypy type-checking baseline
Message-ID: <20200929041748.GK700868@localhost.localdomain>
References: <20200925002900.465855-1-jsnow@redhat.com>
 <20200925002900.465855-24-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200925002900.465855-24-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2feizKym29CxAecD"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--2feizKym29CxAecD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 08:28:36PM -0400, John Snow wrote:
> Fix two very minor issues, and then establish a mypy type-checking
> baseline.
>=20
> Like pylint, this should be run from the folder above:
>=20
>  > mypy --config-file=3Dqapi/mypy.ini qapi/
>=20
> This is designed and tested for mypy 0.770 or greater.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> Tested-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--2feizKym29CxAecD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9ytWwACgkQZX6NM6Xy
CfPSnxAArFxccIzx/N2F2Ee0GCYqCZIIjQsdr3z3CzMX0Dn2Rs4nfV+c+eAuXKKu
ueVtqHxJ2Yyq0ztw1YQgRQBBcvfnbzOaLSctaIWFqHIWGgk2BYjybp85WTLMIGZV
VC7f/33seRa940yWqnKzTwTTPNcSwtViAK+ztldWUSJe3gQGlFYfuZ6/vQPFcmaC
XcMiP7R6xJeMJaIbaZ9JlVLnjx0Elief/4IxsbMCo+q4yjppt+0VajTJ+SNqlapr
NJ4YfNUAoDEYN/1CiaslxNSHAwErpylre7/DLEuzMxl4HGEb0do1s/US5OlURT/C
6/FVVAgrzLsm3YmjAgngtiv2SZWasJsoAZhUnAGyfN6+w8t3WjJ7RoE7zkL0LjAo
nJLMhMIPucxBMrziFyYh4H26WV24anbae8jxA4vRsRYLRJVWCE/U2rOH477HEPhk
k8fzRFALrtNthr+1YXO6viBX5svwB/1bIY3k45HKO90xRvGQrV+9TEwpG1R5yKAe
ogdL6G3evCqZZOlRadcLiEcD1CHYxcMQ+KSzuhyGpJTJgeIYRrFVC81HNZYMDEda
iGRt2jtTVcQx8wj0/W6x81h3mfFWzH63HXAYjX6MIAFn4//BqLrvwVg9XPTz0i3i
FwHgm8gzWp4A2nYJ2azKpPar+RJncwTOj1mGMgxNuuda1sW4XII=
=RgL8
-----END PGP SIGNATURE-----

--2feizKym29CxAecD--


