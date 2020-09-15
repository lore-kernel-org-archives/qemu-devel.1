Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAEBC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:12:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B57A21D43
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MAePisz7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B57A21D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI8sl-0006N2-6U
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 07:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kI8dg-0006yz-Sr
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:56:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50720)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kI8de-0005ng-Oj
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600167401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C9au2cekNGjgwRZ3P3YwVnFavuDcY0zRnTWes/aGzmw=;
 b=MAePisz7Q/9Q17H+iZodX9Ce0OCQmPtNyWi37gwT9XvXFO36zn2tG0Df8yf+0bZ01LpJLZ
 /8HXZl5zEHzVskvjECuNDXY1K8IXElt238oUNd3gReVuAZqCTbMfyO36WtP5yB2XO1CpRk
 zO6JiO/NGuyqSDQqW/Y2TaDXmCGonMU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-vfJ9HVjpOe6FGmNeHxwfuQ-1; Tue, 15 Sep 2020 06:56:36 -0400
X-MC-Unique: vfJ9HVjpOe6FGmNeHxwfuQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB7BCAD687;
 Tue, 15 Sep 2020 10:56:35 +0000 (UTC)
Received: from localhost (ovpn-115-47.ams2.redhat.com [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A4F97EB8B;
 Tue, 15 Sep 2020 10:56:35 +0000 (UTC)
Date: Tue, 15 Sep 2020 11:56:34 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/3] configure: add missing CONFIG_FOO variables
Message-ID: <20200915105634.GA696537@stefanha-x1.localdomain>
References: <20200914095231.621068-1-stefanha@redhat.com>
 <8cda7b10-1eba-ccfe-1cae-c023fba87553@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8cda7b10-1eba-ccfe-1cae-c023fba87553@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:23:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
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
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2020 at 12:50:23PM +0200, Paolo Bonzini wrote:
> On 14/09/20 11:52, Stefan Hajnoczi wrote:
> > The meson.build feature summary checks the presence of CONFIG_FOO varia=
bles.
> > Several of these variables are never emitted by ./configure so the feat=
ure
> > summary always shows these features as disabled.
> >=20
> > Stefan Hajnoczi (3):
> >   configure: add missing CONFIG_TCMALLOC
> >   configure: add missing CONFIG_JEMALLOC
> >   configure: rename QEMU_GA_MSI_ENABLED to CONFIG_QGA_MSI
> >=20
> >  configure   | 10 +++++++++-
> >  Makefile    |  2 +-
> >  meson.build |  2 +-
> >  3 files changed, 11 insertions(+), 3 deletions(-)
> >=20
>=20
> Thanks!
>=20
> For 1 and 2 I think it's simpler to move the whole test to Meson.  I
> already have a patch for that, though I was going to send it next week.

Great, it's nice to do feature checks in meson instead of ./configure.

Stefan

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9gneIACgkQnKSrs4Gr
c8iTegf9FSq0e/ZpR/H7PeN+TeAamEbxhF/gmZyaKl7c7amdi4EItv1O/RFBwQp7
QYincAGVQAXUqMxo0vfv3g/Kiin4FT9Lg5YBiH0fuwUrWIwU4za7595yBl5HbgSl
PPoyMswNJiwop9qEWAlphT00kEm9Snztns/txmSXlgPAMixeiSOCUjfCjuBTMm38
7x+L2TMl97j/rYNH98YcngTzWuBD5tIhFqjlXWjvAeDSpMIZi0fbmTf9EGsUIOQ/
zAIQoQmT15gaFwL6KPtOEBENtkJfz/NiBOIR0segE7dRwOHa+pN/CiI8HP2UtTJv
RXf1ebGFZTl4Zn8XsJWTEQvNYvEoXQ==
=aLtd
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--


