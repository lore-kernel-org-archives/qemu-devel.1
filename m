Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5795C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:14:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51FD120791
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VL1ge0t6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FD120791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLcJg-00065L-BM
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 21:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLc85-0006Mq-F5
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 21:02:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39027)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLc83-0004AP-Lh
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 21:02:29 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600995746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=efpcnv3iaE4cDrmILcGzUzV//P5sRDTscCSxW2Tndfo=;
 b=VL1ge0t6aNk6bKh+1KAAy4lWhYpkGPv07KUTMq6o5oRe+n9y7QPv64BlaF3Nxs4BeUiOKe
 bimIdoiTua89IwChm/1ug1HRnc3cRFICNqYb+oJ6NEBOFuUfCwOPM/C0s79URMxmGGe1YI
 YEb4ZX9ZFOpRGwSpCckzR5pJRgFNlD8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-ehKWiv1vPSKp-AkB2Axy-A-1; Thu, 24 Sep 2020 21:02:24 -0400
X-MC-Unique: ehKWiv1vPSKp-AkB2Axy-A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 669FC8030A5;
 Fri, 25 Sep 2020 01:02:23 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BB6F75C1D7;
 Fri, 25 Sep 2020 01:02:22 +0000 (UTC)
Date: Thu, 24 Sep 2020 21:02:20 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 13/16] qapi/expr.py: Modify check_keys to accept any
 Iterable
Message-ID: <20200925010220.GF368253@localhost.localdomain>
References: <20200922211313.4082880-1-jsnow@redhat.com>
 <20200922211313.4082880-14-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922211313.4082880-14-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="QNDPHrPUIc00TOLW"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--QNDPHrPUIc00TOLW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:13:10PM -0400, John Snow wrote:
> This is a very minor adjustment.
>=20
> a + b is list-specific behavior, but we can accept a wider variety of
> types in a more pythonic fashion if we avoid that behavior.
>=20
> Typing it this way allows callers to use things like dict.keys() and
> other iterables that are not their own discrete lists.
>=20
> Including it just as a statement of practice if nothing else: It's nice
> to use the least-specific type possible as function input and use the
> most-specific type for returns.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--QNDPHrPUIc00TOLW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9tQZwACgkQZX6NM6Xy
CfMAtw/+JNcnNp0ba6AR7gd5fH6lPq6g9Ew1B/ofbAjgI7p0WxKxQHTK8wa+c0l1
29hXUwKKjSW/vYVQyDrtk7QSz0IBbe7iJ9Th9Xh8NvvLEy6ath+dJrla6LljGkVB
Hr0Ir/zDLvtm5uqINAueoR8JIcLYEXxXgQ3D+bLZp++0MpPVHSFFqWKmt1Jn1NSk
F6uu6i9Hl6C3i4GHHim1Fa4TwSIfnymJycPLrkEDheO+T1UZGsqjHL/SzD3ipTEJ
5g3y/2wSgOPapu2TBY7jpdrYTsyQRb3/EhTJCF9bPcrmlYQQTPvpdv71g11jW0YK
88o9W7C1EUCh35YZBCiEhLtl2QkK5Ak+xprRdNJfcD9RGndZmOckFGayIIXhT4Ba
Nqqxc0Rr1wzLlyEqX2mT2mlDLalpT7SfwqW50zMWUOQ0dAlGrJXVpoU2cUkcinrG
RNVNf65HarePbUTU7S/vxo+LzSJiKEunDWLiACTKOklEOCvAeug22twS2E/HqF+r
rAss+Z01KLlOEZ/8/wuJ5DG6sKhdmt5s6x/KdBWWPiAn+LJqRcY04t/puEqiWUal
5R/rXvOsHBJ2RHYCvp0qtQ3XiK2FgySYjSr8To4uehAUzLEb4Rs6jpFI3U7R8xRm
ZDg3qaZcy5VEwTwKiW/S6CHuqKRXSYDQUjeQ8hFRD0nb5bqQPBU=
=GC7t
-----END PGP SIGNATURE-----

--QNDPHrPUIc00TOLW--


