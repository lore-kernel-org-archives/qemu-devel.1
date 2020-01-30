Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10376C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:46:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D19F8206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="REN6LAhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19F8206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixB5C-0004kF-VD
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 09:46:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ixB3H-0002m3-C9
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:44:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ixB3G-0004tF-DO
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:44:15 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44543
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ixB3G-0004qk-4e
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:44:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580395453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cvfs3X8OwcUTApJRIPg6yTXpurjde92mDinZ1AxhEws=;
 b=REN6LAhPgsdUvJ+nmCXAoR4hBtPTSvfSKxGZRc69eQ6RHPNywroPxumbyI/b2c6XaiY9fI
 9EMtMzFWwAILpEHKVeo7x5im8mDsTJoGNua2KepFiz4m4VtuBRk+l+Y7ECaisCfQy9kVCq
 MbbQ2zUgppXNDAiOvfGS/BbcNvhjV70=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-4lBEkybEN0mmzzlVOA7lTQ-1; Thu, 30 Jan 2020 09:44:09 -0500
X-MC-Unique: 4lBEkybEN0mmzzlVOA7lTQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 223831005510;
 Thu, 30 Jan 2020 14:44:08 +0000 (UTC)
Received: from localhost (unknown [10.36.118.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C69A48;
 Thu, 30 Jan 2020 14:44:04 +0000 (UTC)
Date: Thu, 30 Jan 2020 14:44:04 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Bulekov, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v8 00/21] Add virtual device fuzzing support
Message-ID: <20200130144404.GE180311@stefanha-x1.localdomain>
References: <20200129053357.27454-1-alxndr@bu.edu>
MIME-Version: 1.0
In-Reply-To: <20200129053357.27454-1-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HnQK338I3UIa/qiP"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "darren.kenny@oracle.com" <darren.kenny@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--HnQK338I3UIa/qiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2020 at 05:34:11AM +0000, Bulekov, Alexander wrote:
> This series adds a framework for coverage-guided fuzzing of
> virtual-devices. Fuzzing targets are based on qtest and can make use of
> the libqos abstractions.
>=20
> V8:
>  * Small fixes to the virtio-net.
>  * Keep rcu_atfork when not using qtest.

I'm happy with this series.  No doubt there will be changes but I think
it's time to get this merged so others can more easily participate in
the device fuzzing effort.

Stefan

--HnQK338I3UIa/qiP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4y67MACgkQnKSrs4Gr
c8jJUggAtEzSSWi57jpwxAhsOUNV6pIl0pZXPpB6OP6/5GoRbC+lUP9cb4TnZcyu
BUVgMD9xVSKl8WoVeXrFXfIxt7ORgbhmJTOpVNxnEQjhZ+5GrPJcI0dKanqmOWP3
YoTv3rMD0mxofJO3dbZg2U1v9LGVAVi6i5vvMd94muNKspcT9vQoMIDRwuHce2SI
kgTgYCAmEF7dFnEaOb30nr995ZQVCUPpBj4yqrWgIkJXR1UTtEw/0YnaNKeR0I+e
sB2dEorAc6H3slnysEI1J21X6/S3DV+sTH9iqTlC+Q4y4XwTI6sltPiQOHZJ2hcB
WmfsyhkPVnjT0wDGU2lYveC+E+sNBw==
=YOxk
-----END PGP SIGNATURE-----

--HnQK338I3UIa/qiP--


