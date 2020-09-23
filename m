Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87604C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 12:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB05921D92
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 12:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6ezb8AQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB05921D92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL3mB-0003h2-HJ
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 08:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL3kQ-00021e-BR
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 08:19:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49044
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL3kN-0003Z9-Me
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 08:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600863582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UFhKQualgs3uW/2Yf1CioHfFaWLHg/ex2JAqXJuzsT4=;
 b=S6ezb8AQ1ssQhDjwbOBFHV3jkPUnW9BjbcZKsGldOHy0bqPZx2mJIYsDYLCyjMVTzF7TzZ
 frsrMOJKALIOAlVTTwe74545woTHw5b4k3QIgXxyBuUtZZljuUYx1obVHRKabiSZvRwmjG
 EAsk+ccjdu4FfBJBgOAJVWDNxm3G88Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-HUVBOIhbPR6a2mJvUv6r7g-1; Wed, 23 Sep 2020 08:19:38 -0400
X-MC-Unique: HUVBOIhbPR6a2mJvUv6r7g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A3A11009443;
 Wed, 23 Sep 2020 12:19:37 +0000 (UTC)
Received: from localhost (ovpn-113-77.ams2.redhat.com [10.36.113.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E769219C4F;
 Wed, 23 Sep 2020 12:19:36 +0000 (UTC)
Date: Wed, 23 Sep 2020 13:19:35 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Anthony PERARD <anthony.perard@citrix.com>
Subject: Re: [PATCH] Add execute bit back to scripts/tracetool.py
Message-ID: <20200923121935.GA51019@stefanha-x1.localdomain>
References: <20200923103620.1980151-1-anthony.perard@citrix.com>
MIME-Version: 1.0
In-Reply-To: <20200923103620.1980151-1-anthony.perard@citrix.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 03:55:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2020 at 11:36:20AM +0100, Anthony PERARD wrote:
> Commit a81df1b68b65 ("libqemuutil, qapi, trace: convert to meson")
> removed it without explanation and it is useful to be able to run a
> script without having to figure out which interpreter to use.
>=20
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> ---
>  scripts/tracetool.py | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  mode change 100644 =3D> 100755 scripts/tracetool.py

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9rPVcACgkQnKSrs4Gr
c8jE/wf/eieF5VLgUX8Z5dGcmthBxTXVFXWx5VpjVqjxlpN/z3QuN7noA0pdNp3O
ZdQAPkWJPA7zFnksrp6MpIAha5olK4gR7xK9EW9Di3spArmzflao9ArrR/aLfCFU
QeONKm79S0xZIM+IDO5mLM5L4P2erpEbm+JyGwSKbQHbUgsVlvpnzvW07+PFILwv
1HwDiSRSoq1z6sVA20CkrrKeGwaJ3L+7pNqXC7fVJquEB8C+NJ4PrD4e/giejgWm
wZYsXaWOY0QvNzQP1z9myOIX9Pm26wqQXbhvtvZZ0/8FYuoxThbbgzZL0sJxKk7U
3QxP1sH4Z5VGW3BvUEA1AY4DMwwWKw==
=jiOD
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--


