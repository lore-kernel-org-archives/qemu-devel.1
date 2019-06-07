Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42DCC468BC
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 12:28:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0528208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 12:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0528208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49982 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZDyi-0000cR-Tv
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 08:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46295)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hZDvz-0007Ec-Fj
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 08:25:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hZDvx-0004lT-3S
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 08:25:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53954)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1hZDvp-0004Oh-BZ; Fri, 07 Jun 2019 08:25:19 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7EFE83082DDD;
 Fri,  7 Jun 2019 12:25:13 +0000 (UTC)
Received: from localhost (ovpn-117-94.ams2.redhat.com [10.36.117.94])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 80CEF5F592;
 Fri,  7 Jun 2019 12:25:12 +0000 (UTC)
Date: Fri, 7 Jun 2019 14:25:11 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190607122511.GA5220@stefanha-x1.localdomain>
References: <20190603123823.32661-1-mehta.aaru20@gmail.com>
 <20190603123823.32661-3-mehta.aaru20@gmail.com>
 <871s08efp3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <871s08efp3.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 07 Jun 2019 12:25:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 2/9] qapi/block-core: add option for
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
 Julia Suvorova <jusual@mail.ru>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2019 at 07:58:32AM +0200, Markus Armbruster wrote:
> Aarushi Mehta <mehta.aaru20@gmail.com> writes:
>=20
> > Option only enumerates for hosts that support it.
>=20
> Blank line here, please.  Same in other patches.
>=20
> > Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> > ---
> >  qapi/block-core.json | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
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
> We prefer '-' over '_' in the QAPI schema: 'io-uring' instead of
> 'io_uring'.  Exceptions can be made when existing siblings use '_' (not
> the case here), or to match how the thing is commonly spelled outside
> QEMU.  Up to the subject matter experts; I just want to make sure it's
> not accidental.

#2

The Linux API is called "io_uring".  That's the commonly used name for
it, not io-uring, IOURing, etc.  The QMP schema has the ability to
represent the official spelling, so I think we should use it for this
enum value.

Stefan

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlz6V6cACgkQnKSrs4Gr
c8gINQf6Ap5QWiWuh85tgcWjUiwZOcF/lFqrfC2/eoUe147EMhhhPYZl4SgU2TtC
FIhmP7d5mV1IkzR4jhSOC2Ybl3tg3iKP8nhvD0PvpePsCBvok7iiZCu02fNzkMR1
BpRTGZzZFfvIeu6sqCrfRfE9KeR6fsQYtp7Z4O9LgnbvaG3k/AwaiIuMQI5YROl7
jlDitZy7MGfAgq8/o51YTlaY1IJCjoXd+hoXR7jYRO+4UinGEUr+/fZAdDVoC/C+
yAMd616JlQd621pkbimcb1aAM0uGO2HCsPnjmKP8xv9izqujh5OgN6ERr2S70aPP
OrxOuL195vwN5aScfkH4c+cZkbR1kw==
=6txy
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--

