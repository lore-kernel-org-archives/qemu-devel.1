Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A07C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 10:35:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE35208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 10:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE35208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36678 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdXvh-0007Y5-2u
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 06:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56562)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hdXsa-0003f2-07
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 06:31:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hdXjV-0001kL-Bj
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 06:22:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34048)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1hdXjT-0001hn-T4; Wed, 19 Jun 2019 06:22:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1F59C30811C7;
 Wed, 19 Jun 2019 10:22:13 +0000 (UTC)
Received: from localhost (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A44895C220;
 Wed, 19 Jun 2019 10:22:05 +0000 (UTC)
Date: Wed, 19 Jun 2019 11:21:58 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190619102158.GB13569@stefanha-x1.localdomain>
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
 <20190610134905.22294-6-mehta.aaru20@gmail.com>
 <86a8e88792be3df0b16277ac762865abb411f490.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
In-Reply-To: <86a8e88792be3df0b16277ac762865abb411f490.camel@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 19 Jun 2019 10:22:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 05/12] stubs: add stubs for io_uring
 interface
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2019 at 03:33:01PM +0300, Maxim Levitsky wrote:
> On Mon, 2019-06-10 at 19:18 +0530, Aarushi Mehta wrote:
> > diff --git a/stubs/io_uring.c b/stubs/io_uring.c
> > new file mode 100644
> > index 0000000000..622d1e4648
> > --- /dev/null
> > +++ b/stubs/io_uring.c
> > @@ -0,0 +1,32 @@
> > +/*
> > + * Linux io_uring support.
> > + *
> > + * Copyright (C) 2009 IBM, Corp.
> > + * Copyright (C) 2009 Red Hat, Inc.
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +#include "qemu/osdep.h"
> > +#include "block/aio.h"
> > +#include "block/raw-aio.h"
> > +
> > +void luring_detach_aio_context(LuringState *s, AioContext *old_context)
> > +{
> > +    abort();
> > +}
> > +
> > +void luring_attach_aio_context(LuringState *s, AioContext *new_context)
> > +{
> > +    abort();
> > +}
> > +
> > +LuringState *luring_init(Error **errp)
> > +{
> > +    abort();
> > +}
> > +
> > +void luring_cleanup(LuringState *s)
> > +{
> > +    abort();
> > +}
>=20
> I do wonder if there is any value in these stubs (and linux aio stubs as =
well) since any attempt to use this
> will abort the test, even basic aio initialization.
>=20
> I am not yet familiar with qemu unit tests, so I won't yet put ack on thi=
s patch.

=46rom docs/devel/build-system.txt:

  The utility code that is used by all binaries is built into a
  static archive called libqemuutil.a, which is then linked to all the
  binaries. In order to provide hooks that are only needed by some of the
  binaries, code in libqemuutil.a may depend on other functions that are
  not fully implemented by all QEMU binaries.  Dummy stubs for all these
  functions are also provided by this library, and will only be linked
  into the binary if the real implementation is not present.  In a way,
  the stubs can be thought of as a portable implementation of the weak
  symbols concept.

Take util/async.c as an example.  It calls laio_init(), which lives in
block/.  But our binary using libqemuutil.a (which contains async.o)
never actually calls into it.  We need to a stub just to make the linker
happy but don't worry, it will never be called by the program.

Stefan

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0KDMYACgkQnKSrs4Gr
c8jaTAf/TlmmZn1TZvv7F7CXE1I1pkAaI1unqU97Ta71a7wnVjdL9cuoevRHW0tu
2FsBsiOe3pnzXIaF0qiWdi6mSEnnuwqNArO2EuuFh1HhJESGJksJ4tQEIN5F52/+
2LywmuGQWwu9s+gwNCpdGOi4DnPvisDCZwjO9Uo01DREkIJ/mi9gFMF+mcXqbRQH
ujtL1AbgzAOazCKKJf+cEhDfbqAz3WfBwFp/v3G1CZndIGcaNkImD2aIkNgjR55B
UodDdoLWZO6ChFvT4vgDe+HVZoV+EvjSGy6x6yMN3hH8juJ1DQsp/rom9D69yV7P
hsPfH4GBf3KndsL1KfM8SqG34A2HXQ==
=r6X2
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--

