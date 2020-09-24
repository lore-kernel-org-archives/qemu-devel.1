Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC781C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 18:55:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC2F238A1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 18:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FlhwSwv3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC2F238A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLWOx-0001GJ-AA
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 14:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLWNF-0000FV-2V
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 14:53:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47312)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLWND-0002KK-40
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 14:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600973622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VLxHfUefncnoDZiRsebfjsMAdn9pAZvZc1wiKxq6Q3w=;
 b=FlhwSwv3CeSaPeUqTf5lVX+NKjrLus8nlLV4yvZYZgpeGHNnPLtVMFmhsWNBK6mJAijdgu
 jfioCkFD1l2YRrqlkdBAKFvF2y1iERfptiH0DdX+afAQvFd55ie4kE2I9RTDX7dFhGEbbP
 sdtMpTz83Vde1zVGfuaVLJfjF9ziOcA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-rGi4awjeNSynRp-RjvDNdg-1; Thu, 24 Sep 2020 14:53:39 -0400
X-MC-Unique: rGi4awjeNSynRp-RjvDNdg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77C601DDFA;
 Thu, 24 Sep 2020 18:53:38 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC3625D9F1;
 Thu, 24 Sep 2020 18:53:37 +0000 (UTC)
Date: Thu, 24 Sep 2020 14:53:36 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 35/38] qapi/types.py: remove one-letter variables
Message-ID: <20200924185336.GG191229@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-36-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-36-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UkokfXldvRlmz8/+"
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--UkokfXldvRlmz8/+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:00:58PM -0400, John Snow wrote:
> "John, if pylint told you to jump off a bridge, would you?"
> Hey, if it looked like fun, I might.
>

:D

> Now that this file is clean, enable pylint checks on this file.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--UkokfXldvRlmz8/+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9s6y8ACgkQZX6NM6Xy
CfM17hAAtIgM63U9khN1Ixz44V+RwX36Zsmnb+AjLJ0YGpm8uI91TnMhR1FY1KzJ
Uc6ST24tuECh0/aYFRoT03p7jHSjNJjWMg/oSAkU/vz0HG/CWMooscWbA4QbmAJ0
rJ0D5cfDeCfs/QsJAgf5ZgnUhbgeFqf643iGx1NqN8Y76zcJ25L2Irj1MIx4Yxl8
fY9mDB7GIE+zPJ8Fe5qkDIz3hqdZqet1Y5Vx5h4/hrBxvpzbQyd2xGutSwEOKP3V
YZfPt6JuOXHSR535mURftGIPFBdpdOCbmCH5f+oy6SYUiTKkIHlBeszxcvCA+FGB
cVlYDWfmRG44gshNelJCY6MNm4LfaoBAwPCbrk8YbnAS7T8iglWjKlwUmF40BXZW
khKSTlONLNrbchcvAqSVgohdCl1MxetBY0x10FEDVFNycATGj4KzG8imNxjdI8Hw
sr3xOLn2somv6mF6RlgRYtYKTi3uxPQME1Ui4T4Zpx8I19C/rcD4Y5ZwYcRu0mGh
CFFeHle4iCJfU6nQY7OYey9ltxouBfrPywLOEe8ehnjywKQFHD1q3ITBE+YiF0//
aHt5ijKtYtE/+QD1ZhKiI67Mr/n9yMXVXxjMA4Sc6QAgoPA4wFjHYhboDMqhzKGj
dEozx7oHaUNV/gva46tRdJMYjuPrW3frihxKKEku1NHsIbw9nQ0=
=2Z2n
-----END PGP SIGNATURE-----

--UkokfXldvRlmz8/+--


