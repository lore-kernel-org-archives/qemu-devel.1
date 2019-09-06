Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8430C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 10:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E65620693
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 10:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E65620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6BPs-0005pp-LL
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 06:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i6BOz-0004wg-L2
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:23:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i6BOy-0004Ao-Hg
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:23:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1329)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i6BOy-00048T-BH
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 06:23:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F2DBD8372F2;
 Fri,  6 Sep 2019 10:23:34 +0000 (UTC)
Received: from localhost (ovpn-117-208.ams2.redhat.com [10.36.117.208])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B26235D6A9;
 Fri,  6 Sep 2019 10:23:29 +0000 (UTC)
Date: Fri, 6 Sep 2019 11:23:28 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190906102328.GE5900@stefanha-x1.localdomain>
References: <20190905152136.30637-1-stefanha@redhat.com>
 <20190905152136.30637-3-stefanha@redhat.com>
 <20190905172732.GQ2700@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="k3qmt+ucFURmlhDS"
Content-Disposition: inline
In-Reply-To: <20190905172732.GQ2700@work-vm>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Fri, 06 Sep 2019 10:23:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC 2/3] virtiofsd: add DBus server to handle log
 level changes
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
Cc: virtio-fs@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Eryu Guan <eguan@linux.alibaba.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--k3qmt+ucFURmlhDS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 06:27:32PM +0100, Dr. David Alan Gilbert wrote:
> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > Introduce a DBus server thread that runs alongside the other virtiofsd
> > threads.  It processes changes to the /org/qemu/virtiofsd object which
> > can be accessed at the org.qemu.virtiofsd location on the bus.
> >=20
> > This code does not use locking because we are the only writer to the
> > int current_log_level variable.  More advanced management commands would
> > require locking to prevent race conditions with the other threads.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> OK, that is less complex than I'd feared.
> I guess there's something probably nice to do with name/integer mapping
> for warning levels that we could use from one of the libraries.

I used a free-form string because it's what systemd's LogLevel property
also does.  But I can investigate the cleanest approach for limiting it
to a set of string constants.

Stefan

--k3qmt+ucFURmlhDS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1yM6AACgkQnKSrs4Gr
c8ibkQf/dj60BBfKOmis/SmblMlFBwmZEnKcUwgfEso5mZwoRf+ONf+2pC3Gn3GQ
gPB45AL1qvAiSxRlZ4K4AKB+tUkPShjAEwGNMM1kp1HHO1fL3gL9wGwxejjkPXVI
44xHJqq5F9Hst2YRwGwU3UwoE3AoTphy/FvGjfU2yNCJOu7L3ftUnpIvl/xjmSgi
pUZN1j9Z6zWHm8gAaIgX4UGsDRD4vbTPeAsA9D+D7LdJN64WknmcmjU/wENjaWSn
4R1yJe2p5avYtiXEfQsF/mFMW+oF/bZLorbta7lcmK2vfeqz84APfeJORLtbal8l
AXTthC8gchi8FsxxClxOC6Gjr8HjSA==
=LCwc
-----END PGP SIGNATURE-----

--k3qmt+ucFURmlhDS--

