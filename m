Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF00C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:14:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B5E621D91
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vyk2dlo5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5E621D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLWhG-0007Sl-E0
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLWfg-0006D4-VU
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:12:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29896)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLWfe-0004oC-UN
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:12:48 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600974766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3KQjyDtr86N3Vu29eaf2j+Q2gjNsZEkZFwan1PkONWk=;
 b=Vyk2dlo5cEKd4K1wsI1lIC6u+y17hgB2Cd5uSWV/fQwtBHB5sK55rCYOK+iYhrcAE+Uv5Z
 aoWKIX6+FMLqoIWP3cZ6XhStWgSKKGWEGU6RoxQ7ZSHsPrSLVq9jJCjX0y1JLBiqTgv4ok
 MU//tEmh8xdWhHAbwxGHm+QTvBJAC+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-Um8MmS1dOD-YXQlb-c8H_Q-1; Thu, 24 Sep 2020 15:12:42 -0400
X-MC-Unique: Um8MmS1dOD-YXQlb-c8H_Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E26F4104D3E5;
 Thu, 24 Sep 2020 19:12:40 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69CC658826;
 Thu, 24 Sep 2020 19:12:35 +0000 (UTC)
Date: Thu, 24 Sep 2020 15:12:33 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 36/38] qapi/visit.py: assert tag_member contains a
 QAPISchemaEnumType
Message-ID: <20200924191233.GA346482@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-37-jsnow@redhat.com>
 <20200923191549.GY3312949@habkost.net>
 <c85b68d3-1ca1-9283-6911-664179b1c732@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c85b68d3-1ca1-9283-6911-664179b1c732@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
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
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2020 at 06:13:30PM -0400, John Snow wrote:
> On 9/23/20 3:15 PM, Eduardo Habkost wrote:
> > On Tue, Sep 22, 2020 at 05:00:59PM -0400, John Snow wrote:
> > > Signed-off-by: John Snow <jsnow@redhat.com>
> >=20
> > This for making mypy happy, correct?  An explanation in the commit
> > message would be nice.
> >=20
> > Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> >=20
>=20
> Yes, it's for mypy -- but it's a runtime visible change. Technically our
> type system isn't mature enough to express this constraint natively, so i=
t's
> being carried around as developer knowledge.
>=20
> This formalizes that knowledge, albeit in a very crude way.
>=20
> I've amended the commit msg.

OK, this answers my previous question about why it was handled as an
assert.

- Cleber.

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9s76EACgkQZX6NM6Xy
CfPatxAAyA62VTdb0dvqEmnV24zAoKxOq0ajB6oOnK2/A2sOcFZtR52pgzr4UZsm
430bMUBz5ZJtIBqbFKkFof8I352D3hCidQ9o0VGmJXEBO2fjpngvYB3QwmJzlFwU
kR5y290+ECVa7mL4fKYcCwzICtSE45IwgSbvMC36XNmRWM+PhXNmlN8zfE+gGuek
sFrf5RZUroy1HMfGlnbuoC3txVvGmo54GzTBgJ2/Gm2hoj2FLb3shxwbgiragmxI
NgwhQQY3IcQ7JF4p6IzPHvSFQ54XrLm6yAbjGNh6a+P1sYD9uRElw8roHwzYESZF
g1KEJfmFGNLYWYBWRUk6F1MOtelTru8lmix0B7XlBcl9ZdIMOoy6IzF6ikzZdYyS
m8BRWzU8D5eDYqQ/H105LJ7D4RD9li6Ke6d8hUMjyd9EznU51+HxsvRlOBuLQt5A
VowuFiMhfG+ej/WKoxWGhQhAgn0NyjFMyyYrmcfRrynQ3UlTYjXsD72yToMR1/fR
ByRyfIJ2g6MlalZ0xP+5BYNyXtYD6LCx9FxdAgJcjCJD7IW7kh7Fftb2/UnWKNy0
Ja6wuIKcK24nJrwJPO/JmxJJ6/Q10PQI15oUGzoDy2tCQihShkcGcLSQ1R285AIQ
BxLLqJLsOBWRp3o9AKFp93zveuTa2AODnw3bYpneSP5PNv2DwcE=
=zXt7
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--


