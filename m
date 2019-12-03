Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC754C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:31:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 968B62068E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FzhaxEIE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 968B62068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic6P2-0003kJ-C0
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 06:31:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ic6AS-0004Wr-Nk
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:16:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ic6AL-0007OM-Nh
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:16:29 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49174
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ic6AD-0007KR-Ua
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575371775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x2WmBldCSz6JHf4w4eDrluW8rDcJfFZrOP93pZJjae4=;
 b=FzhaxEIEgPs4Pt3VafYZJ6HoxZtxHuHOsPUSM49dvlAkEkpYwyPgJCtnWRH6ZD+nqB/XVI
 Wu0qOyOD2Y/hSFbGsdxz+oxA4N0qaUReYDBnlb5UfuhMJcw6ciZp+QTaSS/KcRkAiiW5qH
 0bJbH1NOjqn9CeAf2EwOW1UHEb5M02k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-zvi-Ksl8PZWHOyQb7cR0cw-1; Tue, 03 Dec 2019 06:16:12 -0500
X-MC-Unique: zvi-Ksl8PZWHOyQb7cR0cw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1F9A1005502;
 Tue,  3 Dec 2019 11:16:10 +0000 (UTC)
Received: from localhost (ovpn-116-133.ams2.redhat.com [10.36.116.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C90565D6A7;
 Tue,  3 Dec 2019 11:16:04 +0000 (UTC)
Date: Tue, 3 Dec 2019 11:16:00 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 05/15] stubs: add stubs for io_uring interface
Message-ID: <20191203111600.GA167235@stefanha-x1.localdomain>
References: <20191025160444.31632-1-stefanha@redhat.com>
 <20191025160444.31632-6-stefanha@redhat.com>
 <20191111111347.GC7297@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20191111111347.GC7297@linux.fritz.box>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>, oleksandr@redhat.com, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--/04w6evG8XlLl3ft
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

Okay, I'll clarify in the commit description.

I didn't find a program that actually requires these stubs today, but in
theory they are required when:
1. A program links against util-obj-y but not block-obj-y (e.g.
   vhost-user-gpu)
AND
2. It uses util/async.o, which depends on luring_*() APIs

You can test this by adding a call to qemu_bh_new() into
vhost-user-gpu's main.c:

  ld: libqemuutil.a(async.o): in function `aio_ctx_finalize':
  qemu/util/async.c:281: undefined reference to `luring_detach_aio_context'
  ld: /home/stefanha/qemu/util/async.c:282: undefined reference to `luring_=
cleanup'
  ld: libqemuutil.a(async.o): in function `aio_setup_linux_io_uring':
  qemu/util/async.c:358: undefined reference to `luring_init'
  ld: /home/stefanha/qemu/util/async.c:363: undefined reference to `luring_=
attach_aio_context'

The program may have no intention of using io_uring, just the QEMU main
loop and BH, so there is an argument for avoiding linking block-obj-y*.
That's the purpose of the stubs and why abort() is okay.

* It's possible to argue against this and personally I'm not that
convinced by stubs for this scenario.  But io_uring.o should be
consistent with how things work today with linux-aio.o.  If you feel
strongly against having stubs then the linux-aio.o stubs should also be
removed (see commit c2b38b277a788).

Stefan

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3mQ/AACgkQnKSrs4Gr
c8hz7gf/QJBstQJNJLsoEpOJlqeHREoduGEjfiCAiBwTYMUggKAqEiSflL9l9Wxf
PS7S2vdaf7dONuu3vdULJsQGBDL7f0ko1bXQisbimDcTiluaxntwLxqTCcSQ920p
GVg7C1C9tZzK8WD768e8SxVIpkGRznfhLJvBasUFyzVw36jehn6JBHZntZC4l8Ek
B69UY0K5jEUxjgLmM0iChgMD4ZIezQge1ctlZaVQ7PjO6sCgQ5cxjgU/iZInYy6c
khtC7xKKMJ73TEGWLcHmKXNmGAhYRZj+wcB6JrKa1YpTq/N7U+VeFv1mDsDzmLR3
Jic3M3dsRf9+d/aOxgHJ9sZS6wef3w==
=QEb7
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--


