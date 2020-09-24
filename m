Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9E0C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:16:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1092123600
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GRKXInpG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1092123600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLWjZ-0000t6-1T
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLWgp-000797-Tp
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:13:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36006)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLWgo-0004vy-83
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600974837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CNiUDrdB5D3qrcDyauFEItUNr3cwdP1UFje6GOHws1w=;
 b=GRKXInpG6PDOOLc5jOx+xq3NUKI0Flle4esRQyd6cuaWnGh/ainLiMDTCgwHY+ROI6h4OL
 mPc/zyAQWrzRo4GgpSU8DT9T7E7gy0mou/UaoPYdupM70xYKUuUvbba2yabm3jNB3ZQDyg
 ltOqsxcvEYs5xlu8EO3lj0CEZGsRAWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-VW_unlwcO1O_cso4dbNsbw-1; Thu, 24 Sep 2020 15:13:53 -0400
X-MC-Unique: VW_unlwcO1O_cso4dbNsbw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA49D9CC32;
 Thu, 24 Sep 2020 19:13:34 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA5C83782;
 Thu, 24 Sep 2020 19:13:33 +0000 (UTC)
Date: Thu, 24 Sep 2020 15:13:31 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 37/38] qapi/visit.py: remove unused parameters from
 gen_visit_object
Message-ID: <20200924191331.GB346482@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-38-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-38-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:01:00PM -0400, John Snow wrote:
> And this fixes the pylint report for this file, so make sure we check
> this in the future, too.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>

LGTM, and pylint is happy.

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9s79sACgkQZX6NM6Xy
CfN9xBAAwSA2xscK/mgvX17RMfy89ghwvMze5GoMB8DIv4tKoYrEn6RRomkCej1z
bqNQO8KUySmxfwdMUhvNBviLCwy61akfDoky3yqJcTl6WeXSUgxWMgeZHw/WGZeH
2iFKsxBlLIwZZMjB+UhKrUsrCwJnvBCrWA59q+Air/amNV8a0SBANBHEMeyG7t32
RtOHpLacfG//47XvUd9AfSDrfmBOLMvYNfMAAP8WS3USN29zsfls/E4oYl7G5wKz
Uo6lQ7e5Xrrny2brZrakcQCbyIsxSJMXPCh9Ocr5ScZntoV9L+GuqWCky1+J5PYb
wwmy3zX66TlVpD2d6V+bMI6eBQZ0ehV3bmcqkz4AF5toKSANWUn1vuksTCa8c1q9
yVHoauvPjAiBIIhsp/NXq5tmeUfSh05sokcCqIFAvryF1IDdf3jD0zVHoZGrGkJJ
PJWsuL4OIV1hH+bv/C5fodBj4EOpTCK7H5E63cpTy8AfYJ5nfJsRgySjugfLtMMB
LJt4RRvwfMYeuAm075sqEEoy2RlpcislA//dSD/qX74BCGxkLxdvjBPdLFUHN+5y
FnbrvCt/9x9p1flmK5+N9tR2rJ39nuPkbR30xVxx+a48uNhacni79pKWnk5W7xje
H7FPTmfSiBKW7ULCrGX4s96bMrapwHmxAFw+e5D3pfB1IexDy8w=
=OYLF
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--


