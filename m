Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABF8C49ED9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:06:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A521D2089F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A521D2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7hjA-0002qN-Gu
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 11:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i7hgG-000899-Tp
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:03:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i7hgF-0006oK-LV
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:03:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34750)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i7hgF-0006nn-DY
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:03:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 06EA43066779;
 Tue, 10 Sep 2019 15:03:42 +0000 (UTC)
Received: from localhost (unknown [10.36.118.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A29EA5D6B2;
 Tue, 10 Sep 2019 15:03:28 +0000 (UTC)
Date: Tue, 10 Sep 2019 17:03:19 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Message-ID: <20190910150319.GB31674@stefanha-x1.localdomain>
References: <20190902121233.13382-1-johannes@sipsolutions.net>
 <20190902121233.13382-2-johannes@sipsolutions.net>
 <fe517ef6c6a8e2df9675388be9454b5863c7fc55.camel@sipsolutions.net>
 <20190909160039.GC20875@stefanha-x1.localdomain>
 <d095bafedcd4bcc5d76279785e5bd523aef62b58.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline
In-Reply-To: <d095bafedcd4bcc5d76279785e5bd523aef62b58.camel@sipsolutions.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 10 Sep 2019 15:03:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC] docs: vhost-user: add in-band kick/call
 messages
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 09, 2019 at 07:34:24PM +0200, Johannes Berg wrote:
> On Mon, 2019-09-09 at 18:00 +0200, Stefan Hajnoczi wrote:
>=20
> > Is this really necessary? =20
>=20
> Yes* :)
>=20
> > Can the simulation interpose between the
> > call/kick eventfds in order to control when events happen?
> >=20
> >   CPU --cpu_kickfd--> Simulation --vhost_kickfd--> vhost-user device
> >=20
> > and:
> >=20
> >   vhost-user device --vhost_callfd--> Simulation -->cpu_callfd-> CPU
> >=20
> > The simluation controls when the CPU's kick is seen by the device and
> > also when the call is seen by the CPU.
>=20
> The point isn't to let the simulation know about anything that happens.
> The CPU and the device are *part* of the simulation.

I was thinking more of letting the simulation decide when to signal the
second eventfd in each pair, but now I understand you are trying to make
everything synchronous and ioeventfd is async by definition.

>=20
> > I don't understand why new vhost-user protocol messages are required.
>=20
> I guess I haven't really explained it well then :-)
>=20
> So let's say, WLOG, I have a simulated network and a bunch of Linux
> machines that are running on simulation time. Today I can do that only
> with user-mode Linux, but we'll see.
>=20
> Now in order to run everything on simulation time, *everything* that
> happens in the simulation needs to request a simulation calendar entry,
> and gets told when that entry is scheduled.
>=20
> So think, for example, you have
>=20
> CPU ---[kick]---> device
>=20
> Now, this is essentially triggering an interrupt in the device. However,
> the simulation code has to ensure that the simulated device's interrupt
> handling only happens at a scheduler entry. Fundamentally, the
> simulation serializes all processing, contrary to what you want in a
> real system.
>=20
> Now, this means that the CPU (that's part of the simulation) has to
> *wait* for the device to add an entry to the simulation calendar in
> response to the kick... That means that it really has to look like
>=20
> CPU               device                   calendar
>      ---[kick]-->
>                          ---[add entry]-->
>                          <---[return]-----

What are the semantics of returning from the calendar?  Does it mean
"it's now your turn to run?", "your entry has been added and you'll be
notified later when it's time to run?", or something else?

>      <-[return]--

What are the semantics of returning to the CPU?  Does it mean the
submitted I/O request is now complete?

>=20
> so that the CPU won't get to idle or some other processing where it asks
> the simulation calendar for its own next entry...
>
> Yes, like I said before, I realize that all of this is completely
> opposed to what you want in a real system, but then in a real system you
> also have real timeouts, and don't just skip time forward when the
> simulation calendar says so ...

Sorry for these questions.  If this becomes tedious for you I will look
into the paper you linked.

Stefan

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl13uzcACgkQnKSrs4Gr
c8gOOggAmWZE/4gOYcbcJMX17ggAA7yD9qsrtEclb7+qK9797fBU325N55Wu1SXV
FWuQb/2G12UICgO+9c4HYPgnmATPnsDSNXDcjy5ki53O9IOq4VOpafh2uho07y1s
jXqCMKdP/rjkXQbMVnJW/wBxo9AUL1gRrIiYtWjfZgS/INUT0+2+YhBOf82/xPzm
AhSedvM3yPShsppvgTBUOntJ4P3wdKS4EVxHOGA6tpM1uBaviZS7p3WwbCmY57eT
gMJLaQd+koVPMtTh++zhJa7beA19LGZat4OfBysud/KxS+J0YnBB/xIF7B4FsmhO
ZvvOuxcatlBQpGMLq5/swU/ongXvAw==
=Evyw
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--

