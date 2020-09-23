Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32300C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 20:19:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85E98206D9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 20:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FraXI14V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E98206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLBEr-0007U8-JB
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 16:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLBDT-0006FO-9M
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 16:18:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45894)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLBDR-0005VG-0d
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 16:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600892291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vGZOfNAXGITNurNrHqW2lvq+Fmzzdty2APLizUNbYBo=;
 b=FraXI14VYgKSONnJgDxFv9SmDMfHWCeDMTTMFqyJoBbvCLhuqdOcQUEArgFBWl7vXqnjKP
 vP+xEL66v8YVaxqpUS+X7plzUodiNptR2AtuCUXkBMX8FdcgoTbXMdaC7t1/gw94DevhRP
 6YuZBSPjSiuPqZFvWDfvbDV/G7sz9lA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-sPWBuTd4OgWQ26vcjWZC-w-1; Wed, 23 Sep 2020 16:18:07 -0400
X-MC-Unique: sPWBuTd4OgWQ26vcjWZC-w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5217681F030;
 Wed, 23 Sep 2020 20:18:06 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 671071002388;
 Wed, 23 Sep 2020 20:18:05 +0000 (UTC)
Date: Wed, 23 Sep 2020 16:18:03 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 17/38] qapi/events.py: add type hint annotations
Message-ID: <20200923201803.GQ191229@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-18-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-18-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="f4HxWLVbzokH9yio"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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

--f4HxWLVbzokH9yio
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:00:40PM -0400, John Snow wrote:
> Annotations do not change runtime behavior.
> This commit *only* adds annotations.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--f4HxWLVbzokH9yio
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9rrXkACgkQZX6NM6Xy
CfPKAw/+KjrS003Xo5RyHv6VBfFUcX6WcY54aoY3QXcsRyU4290aqZojTzHJzTnn
jeMc8R18ngsDhygnTZndoANDQVeaMomZA3OjiY3bVGo7Hy9rAER+ISBjF/4cvonB
gn0uPguB2wOYkJQ3eJMlLyg0ZNNYiOhseTB+i6hL2uV74GAYvlG+iyVKFwYVxCM3
Gd6mbxHOQzps/C0jSZDulm5fo2ICEwBpHD1I0RTYh4dseX/Y8gLSiJdzcS7roqoT
l2HTiIM0lb8FrhoerAesmKKS/j3DVs+2v0oiw+7eCqEO5RWq9x4dWTP1Q8dV4wjI
MyVuTj7zCKLB+1gtW225y23CY2Oq10koxgIDLG8/Ypnv9D5GNu2PlaQXyOZkTtBZ
sOVy5FTV8RFowuBK+nn6QfZBrhUtkHot1dKYzBOLz6P/WJUFw4+i/ssQsjsJqMu6
XJ8Uhe/ETK1yYYLCdDS+DR7xbl+YSFTCqE8ZwCfhXG1iFBXahHniVTgWgSyszvBd
i6XeKRU2vm6u5vBwNbmUAOYfQWvGzVQ/bwNpZSR9uwTi+Vjyimn/WxoepTtkvsuc
PZuRN9WmWbYG8Xn3aujwRnZbX8gW2nigvalYGyu7XlUoWKRUidf7gZVWiWKEhV2+
wR4xr+v1kacdFOxAj5zEvCPRcSemhxAIQdzExqw4v7HYLh2Q2Ok=
=z6Iy
-----END PGP SIGNATURE-----

--f4HxWLVbzokH9yio--


