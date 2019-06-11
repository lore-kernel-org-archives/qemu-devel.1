Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3736FC4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 09:35:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A69208E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 09:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A69208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54097 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hadBD-0006xx-DC
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 05:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43012)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hadA0-0006IJ-Gr
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 05:33:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1had9z-0008HE-Em
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 05:33:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60600)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1had9r-0007rl-T2; Tue, 11 Jun 2019 05:33:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2972B552FC;
 Tue, 11 Jun 2019 09:32:59 +0000 (UTC)
Received: from localhost (unknown [10.36.118.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EBE3668D2F;
 Tue, 11 Jun 2019 09:32:51 +0000 (UTC)
Date: Tue, 11 Jun 2019 10:32:50 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fam Zheng <fam@euphon.net>
Message-ID: <20190611093250.GO14257@stefanha-x1.localdomain>
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
 <20190610134905.22294-3-mehta.aaru20@gmail.com>
 <20190611073653.bfp22e6s4jed2qdx@debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BuBclajtnfx5hylj"
Content-Disposition: inline
In-Reply-To: <20190611073653.bfp22e6s4jed2qdx@debian>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 11 Jun 2019 09:33:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 02/12] qapi/block-core: add option for
 io_uring
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
Cc: Kevin Wolf <kwolf@redhat.com>, Sergio Lopez <slp@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--BuBclajtnfx5hylj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2019 at 03:36:53PM +0800, Fam Zheng wrote:
> On Mon, 06/10 19:18, Aarushi Mehta wrote:
> > Option only enumerates for hosts that support it.
> >=20
> > Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  qapi/block-core.json | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 1defcde048..db7eedd058 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -2792,11 +2792,13 @@
> >  #
> >  # @threads:     Use qemu's thread pool
> >  # @native:      Use native AIO backend (only Linux and Windows)
> > +# @io_uring:    Use linux io_uring (since 4.1)
> >  #
> >  # Since: 2.9
> >  ##
> >  { 'enum': 'BlockdevAioOptions',
> > -  'data': [ 'threads', 'native' ] }
> > +  'data': [ 'threads', 'native',
> > +            { 'name': 'io_uring', 'if': 'defined(CONFIG_LINUX_IO_URING=
)' } ] }
>=20
> Question: 'native' has a dependency on libaio but it doesn't have the
> condition.  Is the inconsistency intended?

'native' could be conditional too but I guess it's a historical thing.
Either QAPI 'if' didn't exit when BlockdevAioOptions was defined or we
simply forgot to use it :).

It doesn't need to be changed in this patch series.

Stefan

--BuBclajtnfx5hylj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlz/dUIACgkQnKSrs4Gr
c8jwXQf/dFKFhVqVXRQf4oIZaOdf9AJjxyIo7YKvLbhMovbKJrh/7zeTFHx+3rht
rBIXyH27NetPv3E4wBi5MYkIyKD1uFEJm7yUYuNaGwdHYQTz3fP+PUigb8Xg8hEQ
Vk16DQr+aqfc/uYI5RgFm4+5Bcl6IGU8LpAnk5SW2Khlhz8/mVb0KrBLv0xTiouV
wZHcfYsGb/sreAQL6ruIrb3FNUYfACCqBFSrnDBAiyr7GP5PY8m19M4M6Ysgd/Qb
Q6ZqK7UDhe0vI1ztuPhb/QtTUEYiHCegkC9Cwg+LPIuK0+OxWhuJ14u+yTflo1h6
yiNZiFIIfKCleXeE2zfZZjEQYH3KWg==
=9AjT
-----END PGP SIGNATURE-----

--BuBclajtnfx5hylj--

