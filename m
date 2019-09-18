Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAB1C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 08:23:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0094620640
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 08:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0094620640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAVFA-0005mw-5Y
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 04:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iAVEA-00051N-Iw
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iAVE9-000747-33
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:22:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53860)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iAVE8-00073i-RQ
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:22:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D70628A1C87;
 Wed, 18 Sep 2019 08:22:15 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-230.ams2.redhat.com
 [10.36.116.230])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A67095C1B2;
 Wed, 18 Sep 2019 08:22:14 +0000 (UTC)
Date: Wed, 18 Sep 2019 10:22:13 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190918082213.GC5207@localhost.localdomain>
References: <cover.1568735079.git.pkrempa@redhat.com>
 <249a9ca557108397b313625593bc83f161f32a16.1568735079.git.pkrempa@redhat.com>
 <8eae6ac1-bbc1-63ba-14b2-779ed3f42a29@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <8eae6ac1-bbc1-63ba-14b2-779ed3f42a29@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Wed, 18 Sep 2019 08:22:15 +0000 (UTC)
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Krempa <pkrempa@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 17.09.2019 um 18:33 hat Eric Blake geschrieben:
> On 9/17/19 10:49 AM, Peter Krempa wrote:
> > savevm was buggy as it considered all monitor owned block device nodes
> > for snapshot. With introduction of -blockdev the common usage made all
> > nodes including protocol nodes monitor owned and thus considered for
> > snapshot. This was fixed but clients need to be able to detect whether
> > this fix is present.
> >=20
> > Since savevm does not have an QMP alternative add the feature for the
> > 'human-monitor-command' backdoor which is used to call this command in
> > modern use.
> >=20
> > Signed-off-by: Peter Krempa <pkrempa@redhat.com>
> > ---
> >  qapi/misc.json | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/qapi/misc.json b/qapi/misc.json
> > index 6bd11f50e6..e2b33c3f8a 100644
> > --- a/qapi/misc.json
> > +++ b/qapi/misc.json
> > @@ -1020,6 +1020,11 @@
> >  #
> >  # @cpu-index: The CPU to use for commands that require an implicit CPU
> >  #
> > +# Features:
> > +# @savevm-blockdev-monitor-nodes: If present, the savevm monitor comma=
nd
> > +#                                 correctly handles monitor owned bloc=
k nodes
> > +#                                 when taking a snapshot.
>=20
> Is it worth adding a '(since 4.2)' on when features are added?

I would also rather describe the change in behaviour ("only includes
monitor owned block nodes if they have no parents") than saying that the
behaviour is now correct.

(Not the least because we know that the current way still isn't quite
correct, just hopefully correct enough: Block job BlockBackends are
currently snapshotted, which is unintended and will be changed in the
future. However, in practice people probably won't use block jobs on
non-root nodes and internal snapshots together.)

> > +#
> >  # Returns: the output of the command as a string
> >  #
> >  # Since: 0.14.0
> > @@ -1047,7 +1052,8 @@
> >  ##
> >  { 'command': 'human-monitor-command',
> >    'data': {'command-line': 'str', '*cpu-index': 'int'},
> > -  'returns': 'str' }
> > +  'returns': 'str',
> > +  'features' : [ { 'name': 'savevm-blockdev-monitor-nodes' } ] }
>=20
> We could, of course, actually implement a QMP 'savevm' and use _that_ as
> the introspection.  But that's a bigger can of worms, so this is
> reasonable enough for the 4.2 timeframe.

I think a QMP savevm would sidestep the whole issue by taking an
explicit list of nodes to snapshot, and an explicit option to tell which
node to store the vmstate on.

Kevin

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdgek1AAoJEH8JsnLIjy/WcjoP/jD1CT9GXDhDnRjziQfTveUK
cINnUxrn1NHYC+cR65FmRRr3KcCVN8i3/2Pf5p4AG5ewDn2y93yeH5zXTyIKTdhB
jV+xJUVyEsBsdC6kavRvZCSgUeRWcGJApMvQgyeuI2VXVTVOo/Z4FmXswiuAWVfZ
QQaK+3mjM1txoRM+1CRq8YdIcWhW18NsMVH+YY/NviZoN4TtiTF682aF28Jz1EWs
cGvZCZaE5jvBcDjVWXOEG4CXHJf+J+VIVIs6iMko5A4Wfv2Zw39MffThks0bJGZh
mZTTaJgG1ZUMKoJaDGPYysgrzNQTmoD7ckz/JCGWWjyyA/crMtX1hPiZsi+TK1oQ
UdFWcUAV8mk8e+/9ZY1c6omb3mXccJdXquDtKXu9mEYbjN6nE9aRfUubWcyo0kf3
e9dax7wss/RRUFQB+7LjXNe0/7pF6A68x41IllvervbyW403TDsvnLVRbPEtYjjL
AK+5STZtEuacSkGi+waj0qPC2rHkcGouBYtuNL4Z80jLS+cDdp3a02GnvdI04VU0
YUH2CYtc6VzW8NzMnJySjrR/SUSqc4/zwmWihK52Dc/rBOYrisv0sFHUfJPaZz1A
BU9ydZBGuyli98wcCs/uRQRpZrG2fZcJWPLyqVXys0irGAEnZza2bAssAlLkGpc7
V4vJbQdU8QQVHC6Y/Aa3
=mbVe
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--

