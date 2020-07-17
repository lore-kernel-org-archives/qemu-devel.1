Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B15C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 17:12:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D630A20717
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 17:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jAagfx82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D630A20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwTu8-0001zP-5P
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 13:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jwTtI-0001Xu-JO
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 13:11:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44395
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jwTtF-00049K-K2
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 13:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595005875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2AMU7kXgsmroj3OkjSJnDrsJrfXNO1FrxQl3btc5KCM=;
 b=jAagfx82P3owOd89JQKld/RIlk858i0U0To/QOggSodua/1eBw3sEwYhtjkokhSIO3pdb0
 hRrdYRCJWcKEpS2ECS27AzroT43tBBDKo0JEi9XNnlWXg1OsAkoqSvzuLmmpDj6M58uDbb
 W+YP5yLqK0ixrpdrtyjeOQ0lPX9N/vE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-XkE7hKg1OgSv7w8CgJlhmg-1; Fri, 17 Jul 2020 13:11:03 -0400
X-MC-Unique: XkE7hKg1OgSv7w8CgJlhmg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B04D08014D7;
 Fri, 17 Jul 2020 17:11:01 +0000 (UTC)
Received: from localhost (ovpn-114-107.ams2.redhat.com [10.36.114.107])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 81E8375559;
 Fri, 17 Jul 2020 17:10:55 +0000 (UTC)
Date: Fri, 17 Jul 2020 18:10:54 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Nikos Dragazis <ndragazis@arrikto.com>
Subject: Re: Inter-VM device emulation (call on Mon 20th July 2020)
Message-ID: <20200717171054.GA136776@stefanha-x1.localdomain>
References: <86d42090-f042-06a1-efba-d46d449df280@arrikto.com>
 <20200715112342.GD18817@stefanha-x1.localdomain>
 <deb5788e-c828-6996-025d-333cf2bca7ab@siemens.com>
 <20200715153855.GA47883@stefanha-x1.localdomain>
 <87y2nkwwvy.fsf@linaro.org>
 <b3efd773-c07e-8095-c1ca-5ffb894ac2ac@arrikto.com>
MIME-Version: 1.0
In-Reply-To: <b3efd773-c07e-8095-c1ca-5ffb894ac2ac@arrikto.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: "John G. Johnson" <john.g.johnson@oracle.com>,
 Andra-Irina Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 qemu-devel@nongnu.org, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Alexander Graf <graf@amazon.com>, Thanos Makatos <thanos.makatos@nutanix.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2020 at 11:58:40AM +0300, Nikos Dragazis wrote:
> On 15/7/20 7:44 =CE=BC.=CE=BC., Alex Benn=C3=A9e wrote:
>=20
> > Stefan Hajnoczi <stefanha@redhat.com> writes:
> >=20
> > > On Wed, Jul 15, 2020 at 01:28:07PM +0200, Jan Kiszka wrote:
> > > > On 15.07.20 13:23, Stefan Hajnoczi wrote:
> > > > > Let's have a call to figure out:
> > > > >=20
> > > > > 1. What is unique about these approaches and how do they overlap?
> > > > > 2. Can we focus development and code review efforts to get someth=
ing
> > > > >     merged sooner?
> > > > >=20
> > > > > Jan and Nikos: do you have time to join on Monday, 20th of July a=
t 15:00
> > > > > UTC?
> > > > > https://www.timeanddate.com/worldclock/fixedtime.html?iso=3D20200=
720T1500
> > > > >=20
> > > > Not at that slot, but one hour earlier or later would work for me (=
so far).
> > > Nikos: Please let us know which of Jan's timeslots works best for you=
.
> > I'm in - the earlier slot would be preferential for me to avoid clashin=
g with
> > family time.
> >=20
>=20
> I'm OK with all timeslots.

Great, let's do 16:00 UTC.

I have a meeting at 14:00 UTC so I can't make the earlier slot and it
sounds like Andra-Irina and Alexander Graf do too. Sorry, Alex (Benn=C3=A9e=
),
not optimal but it's hard to find a slot that is perfect for everyone.

Stefan

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8R254ACgkQnKSrs4Gr
c8grAAgAi2wVUmRLdx6YA+VLULX0iVZjWcEwN4qqjvrwXwEHSz5q3MRzkbZCcRI4
xvlY9ZHk279PCt2CBx8317aupxADZFUAv3N4zz+9XZnOi1A8JfOTjq40D8/9ECZG
5so8TZrZxjLo5+zXbRlwXPYTMYTbAgLy3EH/Qbj5v1oTavSVO8WcOtsGdWQo+oQm
Re/KMrIrR+vjPjO9gBuQm9+qtfEIX4W5UfLw0fPVbQeExq2sBG5JkcUA6FGoni9w
PT6hvOS50YwEbFuEgAY7zkQ0eEziBotU/5V+p6cOoBJq/JKOLXA6b9AxhnLkD+Ee
gakArk5I1uxEpq/6laYT+DqMTB102A==
=HI4C
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--


