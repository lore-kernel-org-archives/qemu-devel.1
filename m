Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3489C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:34:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 634B2214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SfDnCMM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634B2214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL1AJ-0003vr-Dm
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 05:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL0rD-0005pH-2q
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:14:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55989)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL0rB-0002kS-0i
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600852472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wHsRYwC30JIrbWlzcK3Pgf3/G4Enl84VFctA9JFCc0g=;
 b=SfDnCMM5CLXk5g02sB3jwum3d8eUkxlMewY+NTn5gs5dko1pfRBEg/6nEcVp+3YnNoQDJS
 TdLagaeFOb9Vwep818IZ5RFlfDwE6kL7YxmMbDPIZTXLgTOoXghCbtN2dbC9itOAeYYy1r
 am4R863O++dieMvZbSL+4GxlGw11/JU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-_PqHLbaiMC6IfjTHJ7cS1A-1; Wed, 23 Sep 2020 05:14:28 -0400
X-MC-Unique: _PqHLbaiMC6IfjTHJ7cS1A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8E191891E83;
 Wed, 23 Sep 2020 09:14:23 +0000 (UTC)
Received: from localhost (ovpn-114-98.ams2.redhat.com [10.36.114.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BFE345577A;
 Wed, 23 Sep 2020 09:14:08 +0000 (UTC)
Date: Wed, 23 Sep 2020 10:14:07 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] qemu/atomic.h: prefix qemu_ to solve <stdatomic.h>
 collisions
Message-ID: <20200923091407.GC16268@stefanha-x1.localdomain>
References: <20200921162346.188997-1-stefanha@redhat.com>
 <c8892b73-6cee-9fd3-54b0-289149926041@redhat.com>
 <52b8a46e-ab9e-1645-163d-497122ece907@redhat.com>
 <8610ca0e-0b3f-6d95-43b9-e2e49571e311@redhat.com>
 <20200922081849.GD1989025@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922081849.GD1989025@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/Uq4LBwYP4y1W6pO"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 sheepdog@lists.wpkg.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 Jiri Slaby <jslaby@suse.cz>, Stefano Stabellini <sstabellini@kernel.org>,
 Alberto Garcia <berto@igalia.com>, kvm@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Paul Durrant <paul@xen.org>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Liu Yuan <namei.unix@gmail.com>,
 xen-devel@lists.xenproject.org, Sunil Muthuswamy <sunilmut@microsoft.com>,
 John Snow <jsnow@redhat.com>, Hailiang Zhang <zhang.zhanghailiang@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 09:18:49AM +0100, Daniel P. Berrang=E9 wrote:
> On Tue, Sep 22, 2020 at 08:56:06AM +0200, Paolo Bonzini wrote:
> > On 22/09/20 08:45, David Hildenbrand wrote:
> > >> It's certainly a good idea but it's quite verbose.
> > >>
> > >> What about using atomic__* as the prefix?  It is not very common in =
QEMU
> > >> but there are some cases (and I cannot think of anything better).
> > >
> > > aqomic_*, lol :)
> >=20
> > Actually qatomic_ would be a good one, wouldn't it?
>=20
> Yes, I think just adding a 'q' on the front of methods is more than
> sufficient (see also all the qcrypto_*, qio_* APIs I wrote). The
> only think a plain 'q' prefix is likely to clash with is the Qt
> library and that isn't something we're likely to link with (famous
> last words...).

This is why I didn't use "qatomic". "atomic" feels too common to prefix
with just a single letter.

But I grepped /usr/include and code searched GitHub. I can't find any
uses of "qatomic_" so it looks safe. FWIW Qt does have qatomic.h but
doesn't use the name for identifiers in the code.

Let's do it!

Stefan

--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9rEd8ACgkQnKSrs4Gr
c8hx6QgAmcq3iyL/5X+5ylXdiawWVoC4zV4zxgyO20rzguAaBuIPYnGrzO9/5k7b
rFywg6HbM8SPy+iaRqL1fbemPxvySlHdd3zOIrMQYrTk1HJoijxenSMZpnBWxIWx
sN3WONGXmgL54kx8RC6nTmmzXOtz9OLX4koU9c3YwNGWyQchI6+1yEuw0HjqMZmS
DfBOC/syGd7IbE9PoqGcLZMHujPpvCVK+y2CS3WLZZiZXDvqLwiyB8ZX1Bjp0qUG
MKOZYfE3t+SaqkHIF7lswCwQt+3gZf2zj2KUxOKFGcRgEOKekklzST8yHA1kYR4u
EfnQANnly2evsXyGBwQBzh15Isi/RA==
=jOfu
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--


