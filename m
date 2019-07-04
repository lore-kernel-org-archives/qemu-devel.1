Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAE6C0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 16:13:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86A892189E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 16:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A892189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj4Mo-00050h-LW
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 12:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43025)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hj4Av-0005RB-JD
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:01:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hj4As-0006Ry-ST
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:01:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48730)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1hj4Aq-0006Q6-50; Thu, 04 Jul 2019 12:01:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 019113083394;
 Thu,  4 Jul 2019 16:01:00 +0000 (UTC)
Received: from localhost (ovpn-117-206.ams2.redhat.com [10.36.117.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3FABB140FD;
 Thu,  4 Jul 2019 16:00:56 +0000 (UTC)
Date: Thu, 4 Jul 2019 17:00:55 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "palmer@sifive.com" <palmer@sifive.com>
Message-ID: <20190704160055.GH1609@stefanha-x1.localdomain>
References: <20190627152011.18686-1-palmer@sifive.com>
 <20190627152011.18686-34-palmer@sifive.com>
 <CAFEAcA8sscJQ2GCwL1gM+EcRtfHQb1v0BwORt6ncH54x51TCVg@mail.gmail.com>
 <5896113812cd914308e5b617377f8e8205224cfe.camel@wdc.com>
 <CAFEAcA_-h6b_f1fuWh7NkGo+FT0xSyCDXgd3b4pwEvNDN8HcJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="it/zdz3K1bH9Y8/E"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_-h6b_f1fuWh7NkGo+FT0xSyCDXgd3b4pwEvNDN8HcJw@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 04 Jul 2019 16:01:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 33/34] roms: Add OpenSBI version 0.3
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Jeff Cody <codyprime@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--it/zdz3K1bH9Y8/E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2019 at 07:01:12PM +0100, Peter Maydell wrote:
> On Mon, 1 Jul 2019 at 18:50, Alistair Francis <Alistair.Francis@wdc.com> =
wrote:
> >
> > On Mon, 2019-07-01 at 17:54 +0100, Peter Maydell wrote:
> > > On Thu, 27 Jun 2019 at 16:24, Palmer Dabbelt <palmer@sifive.com>
> > > wrote:
> > > > From: Alistair Francis <alistair.francis@wdc.com>
> > > Also, new git modules in .gitmodules should be qemu.org
> > > URLs, not random external ones. (ie, we should set up
> > > mirroring of any new external repo we start shipping
> > > code and binaries for). We can set this up and fix up the
> > > gitmodules file after the fact, but the ideal is to do
> > > it in advance rather than afterwards.
> >
> > Ok, who can setup a git mirror for the QEMU repo?
>=20
> That would be Jeff or Stefan (cc'd).

Please let me know when you're ready and I'll set up a git mirror.

Your commit can be merged as normal and then I'll send another one
updating it to a git.qemu.org mirror.

Stefan

--it/zdz3K1bH9Y8/E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0eIrcACgkQnKSrs4Gr
c8hqZgf9GKkYWjGGbfGiloh/iarDIuaYpCjk6P1prYqq7hc/FS4XrZoFo11v43Ec
RZZRqwYjtTBlKIim7c8+gIdXleKYWWhJd+cSjsFmrtNQ5JkRWNpuyLPuraDnyRCx
R/njf/EC33nVKUFH4pcYGQIjzxP4nX7lgnp1bgL6/QisZzY67Ad7trI+a787Fi+x
B2osuMa5bqv0PQhQDn4FLjFpCPfZ3sdzSyuSaztVS9wxPgBgkIUrDZ86xP6cJqmM
9ym3lJprAtfdb/eRq80/leiT8fZSOXTiY3qGvUIGM53HFHdSG3sn3vx0AFspqwki
nCUjJB6tssrK416AtjUIgh90aan6iw==
=ccdO
-----END PGP SIGNATURE-----

--it/zdz3K1bH9Y8/E--

