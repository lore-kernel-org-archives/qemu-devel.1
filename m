Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73462C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 11:24:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AABE206BF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 11:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AABE206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35403 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQs0y-0005Mq-CG
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 07:24:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1hQs09-000545-2M
	for qemu-devel@nongnu.org; Wed, 15 May 2019 07:23:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1hQs08-0002nt-0F
	for qemu-devel@nongnu.org; Wed, 15 May 2019 07:23:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pkrempa@redhat.com>)
	id 1hQs00-0002Yt-52; Wed, 15 May 2019 07:23:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0B8AAF2BC7;
	Wed, 15 May 2019 11:23:00 +0000 (UTC)
Received: from andariel.pipo.sk (ovpn-204-180.brq.redhat.com [10.40.204.180])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DE9C5D71E;
	Wed, 15 May 2019 11:22:54 +0000 (UTC)
Date: Wed, 15 May 2019 13:22:50 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190515112250.GE2240@andariel.pipo.sk>
References: <20190408143543.3982-1-kwolf@redhat.com>
	<20190408143543.3982-2-kwolf@redhat.com>
	<87d0ljjd3f.fsf@dusky.pond.sub.org>
	<20190515105846.GB7508@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dFWYt1i2NyOo1oI9"
Content-Disposition: inline
In-Reply-To: <20190515105846.GB7508@localhost.localdomain>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Wed, 15 May 2019 11:23:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/4] qapi: Support features for structs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--dFWYt1i2NyOo1oI9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2019 at 12:58:46 +0200, Kevin Wolf wrote:
> Am 18.04.2019 um 22:03 hat Markus Armbruster geschrieben:
> > Kevin Wolf <kwolf@redhat.com> writes:
> >=20
> > > Sometimes, the behaviour of QEMU changes compatibly, but without a
> > > change in the QMP syntax (usually by allowing values or operations th=
at
> > > previously resulted in an error). QMP clients may still need to know
> > > whether the extension is available.
> > >
> > > This allows to add a list of features to struct definitions that will=
 be
> > > made visible to QMP clients through schema introspection.
> >=20
> > Only a first step, but that's okay.  I think we want to be able to tack
> > features to all user-defined types, commands, and events.  Ideally even
> > to members of enum and object types.
> >=20
> > Use case: feature 'deprecated'.  We talked about ways to communicate
> > deprecation to management applications.  Introspection was proposed.
> > Feature 'deprecated' delivers it.
>=20
> How does introspection solve the problem? It requires the client to
> actively look for a deprecation instead of notifying it that it is using
> something deprecated.

Well, we can actively poll ..

> Do you expect libvirt to check a full list of all QMP commands, types,
> etc. it ever uses against the schema after starting a VM or something
> like that?

=2E. similarly to how we asked to be put on the reviewer list for the
deprecated.

We an use our test data which we gather from qemu periodically which
include the QMP schema to extract the list of deprecated features and
store them in git. If we bump the test data and a new deprecated entry
appears the developers will need to asses whether it's used or not and
take the appropriate action.

The appropriate action may also include deriving a capability
information from it and use it to alter libvirt's behaviour which would
then be queried at startup of the VM, but mostly we want to use the new
approach which will replace given deprecated feature as soon as it's
available.


--dFWYt1i2NyOo1oI9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlzb9ocACgkQHGwCByjY
1Gr6tQ//fajh6g8VZPufmSey7y2BZNwFnDpHtA4mV4GxaZUpsE8DJZxFKLKIp3/V
kok6uL0nkWfBrbCG+zuynv17TvlJhir8jzhZeDG0GlMVSsrNwGdkrb3jqSjOUkby
tmBZt90cN7x/TGM0ZA4USq4msFdzqGPh9tfmUkNrsv2FqPrHNeS2nKJWFVLUBed7
z8WJNuLnR05Kpqb0jF30qgHaCL42aO+urzJ45+btMcC31K35Rr9sgRurDj9KL5zn
8pDmwh8eEHSYru1xpHMZbsi0RFc8bMw2q7J7xnVkfSsFmVLSr9TPxfbya2bIwCE2
l2bpUoIujxO0MZxV0EqYjbTpKfkZDLOAgx8qiaWPyUpFaw4GBuUuDy+tGJuptFOS
gJx525MSgi7FnHpWZAAiLtSv/+bDMZ2o5gKDkbo/sQdVHvTl5Ot6Uy/gQJvbl7ob
UTw7/OBNNYkShGWXWxcMPu4ueqBF1pq2t9LXVRhV1BA8reMAUibMGQ5wP47oWJ1F
3PPDDhjGu81/pz0wIEQi3x4G4buc6CoyADvzmWD5Sh/AFdDgUowDVx40p15hnGEC
86dFYrLsCO8+qjQ/vlB+kc2Fz+/ywIVUe5ItH8L176feWWwnbN1zO9A3210zBwpI
D4GPSVlh62GSCS2gOYL4fvjmAsxQTzbjBlRvGL1VAo94w0fXPMw=
=TpaJ
-----END PGP SIGNATURE-----

--dFWYt1i2NyOo1oI9--

