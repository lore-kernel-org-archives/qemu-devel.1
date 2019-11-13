Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50691C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 11:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1796B222C9
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 11:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aFeg1Bjq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1796B222C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUr48-0001tM-8i
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 06:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iUr33-0000xj-3L
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 06:42:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iUr32-00016N-0H
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 06:42:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35749
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iUr31-000164-St
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 06:42:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573645375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n5TLFGXJehTFWZi7glcawbPCbF72AnDjPDJ2VujtrUE=;
 b=aFeg1BjqA7lFMkR95P5e/FS6azyGhNZ+Op8yg9FAqiitRDuENdZN0TV9rRgceTELA7RwKZ
 cx/CgVkfv0XiywH58t12ZOsJ1i+dEb//Hb0Upf6+4TzPKzmGVZTkW8rQVn1J3iHm+CBS0q
 5sJ3Nk3Fs/hkEqQ8rnwfd99wkDaPii0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-i3z_vbdxOCmb0jz_oUg7YQ-1; Wed, 13 Nov 2019 06:42:52 -0500
X-MC-Unique: i3z_vbdxOCmb0jz_oUg7YQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06E85800C77;
 Wed, 13 Nov 2019 11:42:51 +0000 (UTC)
Received: from localhost (ovpn-117-166.ams2.redhat.com [10.36.117.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A2CA12EB1;
 Wed, 13 Nov 2019 11:42:44 +0000 (UTC)
Date: Wed, 13 Nov 2019 11:42:43 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 05/15] stubs: add stubs for io_uring interface
Message-ID: <20191113114243.GC538417@stefanha-x1.localdomain>
References: <20191025160444.31632-1-stefanha@redhat.com>
 <20191025160444.31632-6-stefanha@redhat.com>
 <20191111111347.GC7297@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20191111111347.GC7297@linux.fritz.box>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7gGkHNMELEOhSGF6"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, oleksandr@redhat.com, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--7gGkHNMELEOhSGF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2019 at 12:13:47PM +0100, Kevin Wolf wrote:
> Am 25.10.2019 um 18:04 hat Stefan Hajnoczi geschrieben:
> > From: Aarushi Mehta <mehta.aaru20@gmail.com>
> >=20
> > Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> This commit message needs to answer at least where these stubs are
> actually used. Aren't all callers protected with #ifdef
> CONFIG_LINUX_IO_URING? (And if they aren't, why is abort() okay?)

Okay, will look into this.

Stefan

--7gGkHNMELEOhSGF6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3L7DMACgkQnKSrs4Gr
c8j+KQf+LPQHFzkemqc5hDRAyNNwo9xNVZMVRaDgAj/fLNvqI9sVJgaH8PDKJ6Yn
Xgr2scz7eJtvc5lJ7SokTmlVIWPakvTz95G/ZR9wFDDdoX0MV35IMi0WZh23EbdE
0+fR3uOh32cfNrOk6rbTYL1p9KUegie7nVXrzRUk4PwdJ+HJhmCKcZ+s+UtAOQ7w
6yaXiFNY8hqPZ+ZxQNPCxdDr7wyQMjIp9AO7Sn5RI6ZHbMf23vW5Q89a9jqN2RYe
Kt9/Z3mSlwBRQWerN+o0F65OWzFMh8wwAN6inqnvWmIds7917BwGLeKOQCB/KL8E
b1PKV8jHcyAdyIXQ4Us0Wg4/gICIfg==
=MWaE
-----END PGP SIGNATURE-----

--7gGkHNMELEOhSGF6--


