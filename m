Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807D5C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 08:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 591D121906
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 08:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591D121906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAVPq-0003fS-Fz
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 04:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1iAVNt-0002h0-I5
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:32:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1iAVNs-0004Pq-CC
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:32:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9745)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1iAVNs-0004PH-4B
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:32:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 31EF58980F0;
 Wed, 18 Sep 2019 08:32:19 +0000 (UTC)
Received: from andariel.pipo.sk (ovpn-204-94.brq.redhat.com [10.40.204.94])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A37460872;
 Wed, 18 Sep 2019 08:32:17 +0000 (UTC)
Date: Wed, 18 Sep 2019 10:32:14 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190918083214.GJ1835@andariel.pipo.sk>
References: <cover.1568735079.git.pkrempa@redhat.com>
 <249a9ca557108397b313625593bc83f161f32a16.1568735079.git.pkrempa@redhat.com>
 <8eae6ac1-bbc1-63ba-14b2-779ed3f42a29@redhat.com>
 <20190918082213.GC5207@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="x0KprKst+ZOYEj2z"
Content-Disposition: inline
In-Reply-To: <20190918082213.GC5207@localhost.localdomain>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Wed, 18 Sep 2019 08:32:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] qapi: Allow introspecting fix for
 savevm's cooperation with blockdev
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--x0KprKst+ZOYEj2z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 10:22:13 +0200, Kevin Wolf wrote:
> Am 17.09.2019 um 18:33 hat Eric Blake geschrieben:
> > On 9/17/19 10:49 AM, Peter Krempa wrote:
> > > savevm was buggy as it considered all monitor owned block device nodes
> > > for snapshot. With introduction of -blockdev the common usage made all
> > > nodes including protocol nodes monitor owned and thus considered for
> > > snapshot. This was fixed but clients need to be able to detect whether
> > > this fix is present.
> > >=20
> > > Since savevm does not have an QMP alternative add the feature for the
> > > 'human-monitor-command' backdoor which is used to call this command in
> > > modern use.
> > >=20
> > > Signed-off-by: Peter Krempa <pkrempa@redhat.com>
> > > ---
> > >  qapi/misc.json | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/qapi/misc.json b/qapi/misc.json
> > > index 6bd11f50e6..e2b33c3f8a 100644
> > > --- a/qapi/misc.json
> > > +++ b/qapi/misc.json
> > > @@ -1020,6 +1020,11 @@
> > >  #
> > >  # @cpu-index: The CPU to use for commands that require an implicit C=
PU
> > >  #
> > > +# Features:
> > > +# @savevm-blockdev-monitor-nodes: If present, the savevm monitor com=
mand
> > > +#                                 correctly handles monitor owned bl=
ock nodes
> > > +#                                 when taking a snapshot.
> >=20
> > Is it worth adding a '(since 4.2)' on when features are added?
>=20
> I would also rather describe the change in behaviour ("only includes
> monitor owned block nodes if they have no parents") than saying that the
> behaviour is now correct.

That's a good idea. I'll post it in a v2 if required.

> (Not the least because we know that the current way still isn't quite
> correct, just hopefully correct enough: Block job BlockBackends are
> currently snapshotted, which is unintended and will be changed in the
> future. However, in practice people probably won't use block jobs on
> non-root nodes and internal snapshots together.)
>=20
> > > +#
> > >  # Returns: the output of the command as a string
> > >  #
> > >  # Since: 0.14.0
> > > @@ -1047,7 +1052,8 @@
> > >  ##
> > >  { 'command': 'human-monitor-command',
> > >    'data': {'command-line': 'str', '*cpu-index': 'int'},
> > > -  'returns': 'str' }
> > > +  'returns': 'str',
> > > +  'features' : [ { 'name': 'savevm-blockdev-monitor-nodes' } ] }
> >=20
> > We could, of course, actually implement a QMP 'savevm' and use _that_ as
> > the introspection.  But that's a bigger can of worms, so this is
> > reasonable enough for the 4.2 timeframe.
>=20
> I think a QMP savevm would sidestep the whole issue by taking an
> explicit list of nodes to snapshot, and an explicit option to tell which
> node to store the vmstate on.

A straight replacement for savevm would be quite pointless and also such
discussion took already place multiple times in the past. The result
always was that we need something better than just a qmp version of
savevm.

I'll be happy to implement the libvirt support for the "new" savevm if
it ever appears.

--x0KprKst+ZOYEj2z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAl2B64sACgkQHGwCByjY
1GrLUBAAgedhKOuYk+81I6HGdG6jT9CvGjsLUsfoYdo7IkZONs7cZlZeTMRAVV5Q
SgChffnxRZj4WVwP2yBJE1T0r7sX4caN+EDvP3Lw1sawQHtNMQPFLGT9DNwkkd2v
4HBgXNA4Jo+02eq0RIuXcuC3bP6J1dbelXr+NGzsCUTnonY0LIItcW0UjcDiUSJJ
WzN5D8dlk8V8/EmGcqJusGmXMdisjrE5RPwZdhnkUZgAL9y2Elhg2PyzfHtIF/uY
3kDKbIian+BxbD0fPCCsW5nAzB56SNAgdZAT86zbWw88ahIa4MYV2j6iHooWx7eE
neRkmIqmbMzzm9V0Q64FELvq2tW7KRXTDzXuoiSBw1hY8krayt2SSle4z0DSdv8o
mjBGvGr5eFIbeEG19/6KMBE+jPwNMETXdQLIV5JZtUw/Jk5UsATQD2mAS1LqichT
ELwNLh0edaWdh+ikZ7IeKVEA5sfkrKfbfyyb/3pYPi/Rq+88MXKsedny21n/l5cx
wkwbmreGDK9wB3wTnxd3gPVzJYzELfAQEFNYRmUXfzZWEwOiEW81P0V8fjHfI45a
hZhwmUmRsDGUDzpmydUOytqpubZEL7ll+3j5Y+4bRsa4JfJ5yxqr/p6dMMx0B+IF
b95kRflGZujiAUhJQ4YXj/HqsGXNtE5NrvmFlg9inl6FKdc1CO0=
=of4W
-----END PGP SIGNATURE-----

--x0KprKst+ZOYEj2z--

