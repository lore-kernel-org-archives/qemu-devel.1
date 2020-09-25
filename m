Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0706CC4346E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:17:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 857C3207C4
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QwOSVFsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857C3207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLcMy-0000b2-Ic
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 21:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLcEi-0007C1-Qw
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 21:09:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33357)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLcEf-0004pI-Pu
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 21:09:19 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600996157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wEMmMVk3Gjsn2Z4sSRwjP4ghgCa33Yk7RKvvnHhd7NQ=;
 b=QwOSVFsZSZ1xaNj4NhAHDIm2rtXXfTlqnPV0O+4B1PxoPM1+33YwDRwXG2VIj3a3/qBmZV
 GJVhhXK1mlIbGd+956QCgmf8WFLysV6k8y3KlC46GjoITrQ7letKdPXWDwyl5GWYth/gYe
 3U3RGFJ+ZjREWZ+njDXHjf60iViS1rk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-qwRVCBWgOP2QhP5KCpL5_Q-1; Thu, 24 Sep 2020 21:09:14 -0400
X-MC-Unique: qwRVCBWgOP2QhP5KCpL5_Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D090A8064D1;
 Fri, 25 Sep 2020 01:09:13 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 377F55C1C7;
 Fri, 25 Sep 2020 01:09:13 +0000 (UTC)
Date: Thu, 24 Sep 2020 21:09:11 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 15/16] qapi/expr.py: move related checks inside check_xxx
 functions
Message-ID: <20200925010911.GH368253@localhost.localdomain>
References: <20200922211313.4082880-1-jsnow@redhat.com>
 <20200922211313.4082880-16-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922211313.4082880-16-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SUk9VBj82R8Xhb8H"
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

--SUk9VBj82R8Xhb8H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:13:12PM -0400, John Snow wrote:
> There's not a big obvious difference between the types of checks that
> happen in the main function versus the kind that happen in the
> functions. Now they're in one place for each of the main types.
>=20
> As part of the move, spell out the required and optional keywords so
> they're obvious at a glance.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--SUk9VBj82R8Xhb8H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9tQzUACgkQZX6NM6Xy
CfNLyhAAtZcDHfbMBxZ49AtZu4iz5/6psRI3IC6hlLnmVfUZHrnEiO7jl+mh+ONr
WnfeD7N2K0xMD2EXblpZU5BGeO/N7P0trXDbkQLLzmQs1V6iBYAivBf10DUIfKjc
VHdFMUqG6cCppXLlws91wDpK3K2dO9xrdF+U6m+FY6ymSb5WR5a1WCM0BMdFovsI
6aWbm1iqUdfiwJlHYQlLjseyhADKIV/ERsk9QoJcnOtGpiA0WBYnIL+tWlpZbu4P
NPMTeg+fiOxvLZPs1IkycI46bEYNbr62Qp81UJqEoDMswT1mhW4nYCHm+u4HOtSh
Btc0qLFhn0YSTJDRt90PaThw07PxF72u915m02zQeWWcldvlf/FLzI9xFuSeW7/S
ww/NNvUFTwIiqE6qphcKPM0cWkC44B163Bzcguco4IlbqyXJrT4rMpFtPVal9Nih
3obCW4nrTol/L1eivxS6omS+zq/69RtVYXCe1sqS4H+Q5C+YbDcd4hyBZyNSuaF4
ZgZI1VQI4dWmrxo3aBM/v2+rgix8Cx8hIEYdlxS9yJhB3sqAIlVrmCWKy5Zlm58n
KNXXOg3kWQECYmmwspahB3OJP0CunWgzVAwE1KQbfSwy4LO8I8ukHg1wqlPe7HOE
xPeE9x6OyeF+/0e0dfH+7FhSu9W+HcHBG0Sy5OuVIUH7szxJTxY=
=VEuW
-----END PGP SIGNATURE-----

--SUk9VBj82R8Xhb8H--


