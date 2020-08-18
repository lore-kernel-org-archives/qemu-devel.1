Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF940C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:55:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D402080C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+q7xn/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D402080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k83xl-0006v9-Vg
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 11:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k83H5-0000QE-5q
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 11:11:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24612
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k83H3-0007p5-1S
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 11:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597763499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kj6Z/PkkEyQpk5LI/omHySnDgut8jk5Mqa3b6SF5xF4=;
 b=O+q7xn/AgIzZk+GXKWfVXKEnXXsH6IWiZgIVekqf8obBy6vM6IjfHT1/tkUvhJnOiCh7z4
 d2iwHXq+9VVGImqpfLcpUkC2ef0WknLM9Bi/HX4SiwDuzq29u4NT8C9QruNAMJAX2sCzH9
 1Zdr37Ijs2zV/KoRQFeTffIBFnPjAdk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-4ItaKiH7OzepzNxSBw0pRw-1; Tue, 18 Aug 2020 11:11:37 -0400
X-MC-Unique: 4ItaKiH7OzepzNxSBw0pRw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B598640C0;
 Tue, 18 Aug 2020 15:11:36 +0000 (UTC)
Received: from localhost (ovpn-114-160.ams2.redhat.com [10.36.114.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D62B5D6BD;
 Tue, 18 Aug 2020 15:11:35 +0000 (UTC)
Date: Tue, 18 Aug 2020 16:11:34 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH 2/6] vhost-user-server: drop unused #include <eventfd.h>
Message-ID: <20200818151134.GB311676@stefanha-x1.localdomain>
References: <20200614183907.514282-3-coiby.xu@gmail.com>
 <20200619120046.2422205-1-stefanha@redhat.com>
 <20200619120046.2422205-2-stefanha@redhat.com>
 <20200817124927.72rtan4menitqdop@Rk>
MIME-Version: 1.0
In-Reply-To: <20200817124927.72rtan4menitqdop@Rk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 08:01:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2020 at 08:49:27PM +0800, Coiby Xu wrote:
> On Fri, Jun 19, 2020 at 01:00:42PM +0100, Stefan Hajnoczi wrote:
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > util/vhost-user-server.c | 1 -
> > 1 file changed, 1 deletion(-)
> >=20
> > diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
> > index e94a8d8a83..49ada8bc78 100644
> > --- a/util/vhost-user-server.c
> > +++ b/util/vhost-user-server.c
> > @@ -7,7 +7,6 @@
> >  * later.  See the COPYING file in the top-level directory.
> >  */
> > #include "qemu/osdep.h"
> > -#include <sys/eventfd.h>
> > #include "qemu/main-loop.h"
> > #include "vhost-user-server.h"
> >=20
> > --
> > 2.26.2
> >=20
>=20
> All the patches have been applied to v10. I'm curious how do you find
> this issue. Is there a tool to detect this issue or simply you are so
> familiar with the QEMU code that you can spot it very easily?

No, I didn't use a tool.

When looking at the code I wondered if the #include was really
necessary. So I deleted the #include and recompiled to check that the
build still works.

Stefan

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8776YACgkQnKSrs4Gr
c8iX3ggAqZ2Z3Qf7dJIX7AMZ+qOFXvYzyKQPI1RS8otlMckErfqwJKIVe4pnVLzj
Ej+feogUqYhWaHkcr+2QbiPhjSHbcJHoC06Ekbrn6GUYHdYFzhCtVBAT/eCbf3c/
i++Ra++NOGCPGnXZSUvOm/3Zu5fj45O+JFFmiDi47TafsE99Q/8iKJfdn5gUFOP9
ho/G5KGRq+6ELPBcWkGeQgQ7cBzGvk1zRlaX5mpOdHmnWW8so/r5P/8ash5Fbq3q
acEqZpevn3EvkR03XQzaO66AcYBkkBZZ+z864MNgZvuetoZnE55/EWgP8omOeG30
6BAaY2bPO6mrrTqoSvQ+zd8Gf21fuA==
=9V1/
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--


