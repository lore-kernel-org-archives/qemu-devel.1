Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8ACC282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:38:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBDDE20835
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 19:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBDDE20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58603 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGqNv-0006hS-5R
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 15:38:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phrdina@redhat.com>) id 1hGqCQ-0006kz-3u
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phrdina@redhat.com>) id 1hGqCP-0005Bq-2J
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:26:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <phrdina@redhat.com>) id 1hGqCL-00050F-OD
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:26:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0956259464;
	Wed, 17 Apr 2019 19:26:17 +0000 (UTC)
Received: from antique-laptop (ovpn-204-70.brq.redhat.com [10.40.204.70])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8555060C61;
	Wed, 17 Apr 2019 19:26:13 +0000 (UTC)
Date: Wed, 17 Apr 2019 21:26:10 +0200
From: Pavel Hrdina <phrdina@redhat.com>
To: Pu Wen <puwen@hygon.cn>
Message-ID: <20190417192610.GC19065@antique-laptop>
References: <1555416373-28690-1-git-send-email-puwen@hygon.cn>
	<20190416141700.GR18986@antique-laptop>
	<e7abd74f-61bb-fc34-0b3a-08c635d9f78c@hygon.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Content-Disposition: inline
In-Reply-To: <e7abd74f-61bb-fc34-0b3a-08c635d9f78c@hygon.cn>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Wed, 17 Apr 2019 19:26:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] i386: Add new Hygon 'Dhyana' CPU model
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
Cc: pbonzini@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
	ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417192610.JxFH-FFuH2MJa2uSG9iUTPieOjsSRuAb1VR0Wp_OSNU@z>


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2019 at 10:53:04PM +0800, Pu Wen wrote:
> On 2019/4/16 22:17, Pavel Hrdina wrote:
> > On Tue, Apr 16, 2019 at 08:06:13PM +0800, Pu Wen wrote:
> > > Add a new base CPU model called 'Dhyana' to model processors from Hyg=
on
> > > Dhyana(family 18h), which derived from AMD EPYC(family 17h).
> > >=20
> > > The following features bits have been removed compare to AMD EPYC:
> > > aes, pclmulqdq, sha_ni
> > >=20
> > > The Hygon Dhyana support to KVM in Linux is already accepted upstream=
[1].
> > > So add Hygon Dhyana support to Qemu is necessary to create Hygon's own
> > > CPU model.
> >=20
> > I have once question that we will have to solve for EPYC CPUs as well.
> > The name should not be based on the Product name or Model name as that
> > usually doesn't change with introduction of new microarchitecture.
> >=20
> > With EPYC we made a mistake to name the CPU like that, luckily with
> > Intel we already use the microarchitecture name, so the EPYC CPU should
> > have been named ZEN-Server and for Ryzen CPUs there should be ZEN-Client
> > if there is any difference or otherwise we can simply use ZEN.
> >=20
> > The issue here is what happens once the ZEN2 microarchitecture is out
> > wihch introduces new features and we will have to come up with a CPU
> > name.
> >=20
> > Obviously we cannot change/remove the EPYC models so the question is
> > what is the difference between the AMD EPYC CPU and this new Dhyana CPU
> > if they are both based on the ZEN microarchitecture?
>=20
> Right now there's no much difference between Dhyana and EPYC from the
> software's view. Dhyana removed the instructions aes, pclmulqdq, sha_ni
> compared to EPYC, but will have it's own implementation such as for aes in
> future CPU models. Hygon also will implement something different from AMD=
 in
> the future.
>=20
> > In addition is there any way how we can introduce ZEN-Server &
> > ZEN-Client or simply ZEN, if there is no difference, as an alias or a
> > new model next to the EPYC?
>=20
> Also as Eduardo mentioned that there's no CPU model alias or inheritance
> system in x86, so I think it's worthwhile to keep a separate CPU model for
> Hygon.

So what happens once Zen2 is out and there are new Dhyana CPUs based on
the Zen2 microarchitecture with some new features, what CPU models we
will introduce, EPYC-G2 and Dhyana-G2, but that will not correspond to
the CPU model anymore.

My idea was that we should probably introduce CPU model Zen-Server which
could cover both EPYC and Dhyana as they are both based on the Zen
microarchitecture.  The fact that Dhyana doesn't support all the
features is not an issue as QEMU will not use them if they are not
available on the host.

Another possibility is to introduce Zen-Server (or AMD-Zen-Server) and
Hygon-Zen-Server with different set of features.

In the future when new microarchitecture is introduced we can simply use
the exact name of the microarchitecture and we don't have to follow the
road as we did with AMD Opteron CPUs where we have different suffixes.

The whole point is that we should name the CPUs the same way for all
vendors and stop introducing new CPU names that will create more
confusion.

Pavel

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEcbzs91ho/coWWY7aUi1kczAH4YwFAly3fdIACgkQUi1kczAH
4Yy9MQ/+ILxdTSmV5vWFEOOfb+c2oYJUO49z3ow34b6tMe1mYW3KvHzTKegWwGRo
BUDc3+lCDO07Lpt2Nac3+m9MnsR53LQjiMXrauKlsaw4OpqG+lRr+cSnNPVbi0Hh
K1aYrhGImc+oJb3MT2/dGscX/qbyHvvqk8KGo4cP/dmBzoYBDSYKQ0nfHYfxejA9
3sgViP5tS11oz8afTHNSexqOxyvdO832SZluRlJ8WwQICP3gjyqY4YxdWYWs8zkw
MPy7h35uSIML/mR22WKq0w1ubkIHquQBzG6u+P/PfhLyKjpUiNMnUfy9AN6kLuQ5
/wAUPPVO02SkykYqa32y/mzgqe8QzE4ozj8cOcrryEsslA8H1hirlQZkclZFBIRC
t1PdCeeGSfJRzs/jmqqriUhNoeFihrikVMTTh7blm6AbJYLdwQBJ87tWnDbiOM/S
ZDDtqNCVSUycaaOcgti7INpZkAGFiAx/okD6kkfgdPl8vZLAXpEcdLgOV06Jjco8
VzgHLqEMSunamag/2ieEDgdy7RdAwWuQ3RiVwrm7ciw4WOiafHgAMOI5pIOP6lM+
IN8bhRif362wkrgZMjr6aQqtxsb0NqHRucTFPNScLoKH5lSyQN+8ioh52ncWS4iX
I6tFkKeW/uBn7hbszZCFo3IDNRHBXMhZ2W0NWOhlI5MHpzr/l+Q=
=ZzwK
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--

