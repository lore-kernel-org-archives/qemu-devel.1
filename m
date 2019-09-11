Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D839ECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:36:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6F3C208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F3C208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7xAd-0006dF-3G
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 03:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i7x9v-0005yv-J4
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:35:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i7x9r-0001L6-Kt
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:35:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59998)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i7x9r-0001Kd-CB
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:35:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 19DE610C0939;
 Wed, 11 Sep 2019 07:35:18 +0000 (UTC)
Received: from localhost (ovpn-116-185.ams2.redhat.com [10.36.116.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A1F8601B6;
 Wed, 11 Sep 2019 07:35:10 +0000 (UTC)
Date: Wed, 11 Sep 2019 09:35:03 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Message-ID: <20190911073503.GB4181@stefanha-x1.localdomain>
References: <20190902121233.13382-1-johannes@sipsolutions.net>
 <20190902121233.13382-2-johannes@sipsolutions.net>
 <fe517ef6c6a8e2df9675388be9454b5863c7fc55.camel@sipsolutions.net>
 <20190909160039.GC20875@stefanha-x1.localdomain>
 <d095bafedcd4bcc5d76279785e5bd523aef62b58.camel@sipsolutions.net>
 <20190910150319.GB31674@stefanha-x1.localdomain>
 <e114b68dffecd9b4c4666327b15a28098c83f7ec.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline
In-Reply-To: <e114b68dffecd9b4c4666327b15a28098c83f7ec.camel@sipsolutions.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Wed, 11 Sep 2019 07:35:18 +0000 (UTC)
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


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2019 at 05:14:36PM +0200, Johannes Berg wrote:
> On Tue, 2019-09-10 at 17:03 +0200, Stefan Hajnoczi wrote:
> >=20
> > > Now, this means that the CPU (that's part of the simulation) has to
> > > *wait* for the device to add an entry to the simulation calendar in
> > > response to the kick... That means that it really has to look like
> > >=20
> > > CPU               device                   calendar
> > >      ---[kick]-->
> > >                          ---[add entry]-->
> > >                          <---[return]-----
> >=20
> > What are the semantics of returning from the calendar?  Does it mean
> > "it's now your turn to run?", "your entry has been added and you'll be
> > notified later when it's time to run?", or something else?
>=20
> The latter - the entry was added, and you'll be notified when it's time
> to run; but we need to have that state on the calendar so the CPU won't
> converse with the calendar before that state is committed.

Is the device only adding a calendar entry and not doing any actual
device emulation at this stage?

If yes, then this suggests the system could be structured more cleanly.
The vhost-user device process should focus on device emulation.  It
should not be aware of the calendar.  The vhost-user protocol also
shouldn't require modifications.

Instead, Linux arch/um code would add the entry to the calendar when the
CPU wants to kick a vhost-user device.  I assume the CPU is suspended
until arch/um code completes adding the entry to the calendar.

When the calendar decides to run the device entry it signals the
vhost-user kick eventfd.  The vhost-user device processes the virtqueue
as if it had been directly signalled by the CPU, totally unaware that
it's running within a simulation system.

The irq path is similar: the device signals the callfd and the calendar
adds an entry to notify UML that the request has completed.

Some pseudo-code:

arch/um/drivers/.../vhost-user.c:

  void um_vu_kick(struct um_vu_vq *vq)
  {
      if (simulation_mode) {
          calendar_add_entry({
              .type =3D CAL_ENTRY_TYPE_VHOST_USER_KICK,
              .device =3D vq->dev,
              .vq_idx =3D vq->idx,
          });
          return;
      }

      /* The normal code path: signal the kickfd */
      uint64_t val =3D 1;
      write(vq->kickfd, &val, sizeof(val));
  }

I'm suggesting this because it seems like a cleaner approach than
exposing the calendar concept to the vhost-user devices.  I'm not 100%
sure it offers the semantics you need to make everything deterministic
though.

A different topic: vhost-user does not have a 1:1 vq buffer:kick
relationship.  It's possible to add multiple buffers and kick only once.
It is also possible for the device to complete multiple buffers and only
call once.

This could pose a problem for simulation because it allows a degree of
non-determinism.  But as long as the both the CPU and the I/O completion
of the device happen on a strict schedule this isn't a problem.

Stefan

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl14o6cACgkQnKSrs4Gr
c8gu3Af/eN/zEjjXJKe+qgkRMZJRpXKJJBa0ey0VAO+xOsC6xqy0e7NXxxUZMIZY
IPYGdFs7FMIgfFMua2+k98TtqNfWMbcLa69t0bREYNltPDTeIl32pxklc93pQ1b4
+x4oR6hiIBBUJ391Xc8CIYHbqdVrT2JFLQOa+aZ/d1QAd5vXOgwcRuK+CFSIk2ZO
PCItMNYYc+zK3+QSewRdiIe7lEa2DpIdW765GgbPac29U1S3ru4iCzBp2vxcp1r4
XVcbN8R6kSyO4gI0PSOKvoPC/JASq4s4ZYJzgou9e7WPcRlzp9vyHU6zxRJOw+6O
Xljf/dhBMDyHErX8ikkjPojeHwTlSQ==
=hT0q
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--

