Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD150C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 23:08:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59DB023899
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 23:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+Obrrzy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59DB023899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLaMD-0000GU-Hw
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 19:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLaLL-0007UE-1Z
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 19:08:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23678)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLaLI-0007WS-Ue
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 19:08:02 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600988880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QhlLbfMjslM8cri13LJFfzfY0lIpnr1Oq3JgeCtQfFg=;
 b=f+ObrrzyPxmwJixH1xxTo+Wh4NfelvC2ILkx9UM6CR9Ww3f51F5EL4YyURlZNEpWDEi6du
 wgiwtynF1DMxI339/Pdy4kVlKdbkwIXarjep7EWmmcGmd+FVMgzdJrCKYnRdqNCdIF8jpw
 sDl+OWYwIdH9TfbMFKQJQZkzAlBtNCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-rEfSwKAqMmC8ruvALu2_4g-1; Thu, 24 Sep 2020 19:07:57 -0400
X-MC-Unique: rEfSwKAqMmC8ruvALu2_4g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FBAE107465C;
 Thu, 24 Sep 2020 23:07:56 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 00C4819C66;
 Thu, 24 Sep 2020 23:07:55 +0000 (UTC)
Date: Thu, 24 Sep 2020 19:07:54 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 02/16] qapi/expr.py: Check for dict instead of OrderedDict
Message-ID: <20200924230754.GC347918@localhost.localdomain>
References: <20200922211313.4082880-1-jsnow@redhat.com>
 <20200922211313.4082880-3-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922211313.4082880-3-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
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

--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:12:59PM -0400, John Snow wrote:
> OrderedDict is a subtype of dict, so we can check for a more general form=
.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9tJsoACgkQZX6NM6Xy
CfM18g/+O0sIF7dKy9ipwFjBoP6PtAJjhqKiSV5DY0VSyVowG+OTtt0pNGn11BMG
QSWgmBuWR6S/0bXdN0LtfDQhku4f6lweb3k6K5jCikg2pDuufmRUBQBnyVio+JG6
lr5KVGJBOQde51P9yrr2nEai/9uKUFfqU0saqinhfGDqpGtkgBoUfe1nyk2J1EGh
1XzK7GtSUBVxSU0y2ofBzvrDIVyfDUV7uvjhxIFnwNzfjGe6ZuIVdqr8A7dMGxvt
rOwD/S5brUJMk1o8fjBFposaBuO26Z05zGtpK21TvkzjTTj6VbtfltTrI9FUZuvM
JWVFEUuxZIg2WB6dqsf0T2YQFo8qOq1xLZQoQ/WeqGXHCCnx1/Vloi/KZDyxNE8a
WW5ZjKHXfBjUv6X1agrkXyWXrDBncG+IPfrfcrWvC4Evq51w9jpGbeu2crDi/Zls
ZQGs2utXJ0PViUNlz6XMzBFIg9J8JLR+rgpatvO1H3zZ8qqvth0y9P/FvYvzLyOO
rKW3kvpPYUxfuvU6DM5BN/FuUUR6dsfTXrgTf19EVdzY+/G/fDAaXHtwI0ToY3ad
IKB+m27UmrS9Ixc4bDGrmTYlPt/OUs3RypayYSn7zlYEVPRVFZm9zi5Wf82nUdGx
HvZvquSnEk5WPODrmvLeSvU29ikUtRW21MnSPn3NSPjmEBqC8Uk=
=rR/O
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--


