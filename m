Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2BEC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 14:28:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7206020835
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 14:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7206020835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42244 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH81R-0004Q7-PH
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 10:28:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phrdina@redhat.com>) id 1hH80Q-0003tc-Q5
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:27:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phrdina@redhat.com>) id 1hH80P-0005of-DL
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:27:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <phrdina@redhat.com>) id 1hH80P-0005oE-47
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 10:27:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 19D6B305390F;
	Thu, 18 Apr 2019 14:27:12 +0000 (UTC)
Received: from antique-laptop (unknown [10.43.2.63])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CD2795D9D6;
	Thu, 18 Apr 2019 14:27:06 +0000 (UTC)
Date: Thu, 18 Apr 2019 16:27:04 +0200
From: Pavel Hrdina <phrdina@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190418142704.GU18986@antique-laptop>
References: <1555416373-28690-1-git-send-email-puwen@hygon.cn>
	<20190416141700.GR18986@antique-laptop>
	<e7abd74f-61bb-fc34-0b3a-08c635d9f78c@hygon.cn>
	<20190417192610.GC19065@antique-laptop>
	<20190418084825.GC13773@redhat.com>
	<20190418095935.GS18986@antique-laptop>
	<20190418140520.GG25134@habkost.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KAk/33nSS6LK84p9"
Content-Disposition: inline
In-Reply-To: <20190418140520.GG25134@habkost.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 18 Apr 2019 14:27:12 +0000 (UTC)
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
Cc: mst@redhat.com, Pu Wen <puwen@hygon.cn>, qemu-devel@nongnu.org,
	pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418142704.7YqFoaWEHrq1vuagGuovBaE_DzI4B3LcajctwijmEbo@z>


--KAk/33nSS6LK84p9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2019 at 11:05:20AM -0300, Eduardo Habkost wrote:
> On Thu, Apr 18, 2019 at 11:59:35AM +0200, Pavel Hrdina wrote:
> > On Thu, Apr 18, 2019 at 09:48:25AM +0100, Daniel P. Berrang=C3=A9 wrote:
> > > On Wed, Apr 17, 2019 at 09:26:10PM +0200, Pavel Hrdina wrote:
> > > > On Wed, Apr 17, 2019 at 10:53:04PM +0800, Pu Wen wrote:
> > > > > On 2019/4/16 22:17, Pavel Hrdina wrote:
> > > > > > On Tue, Apr 16, 2019 at 08:06:13PM +0800, Pu Wen wrote:
> > > > > > > Add a new base CPU model called 'Dhyana' to model processors =
=66rom Hygon
> > > > > > > Dhyana(family 18h), which derived from AMD EPYC(family 17h).
> > > > > > >=20
> > > > > > > The following features bits have been removed compare to AMD =
EPYC:
> > > > > > > aes, pclmulqdq, sha_ni
> > > > > > >=20
> > > > > > > The Hygon Dhyana support to KVM in Linux is already accepted =
upstream[1].
> > > > > > > So add Hygon Dhyana support to Qemu is necessary to create Hy=
gon's own
> > > > > > > CPU model.
> > > > > >=20
> > > > > > I have once question that we will have to solve for EPYC CPUs a=
s well.
> > > > > > The name should not be based on the Product name or Model name =
as that
> > > > > > usually doesn't change with introduction of new microarchitectu=
re.
> > > > > >=20
> > > > > > With EPYC we made a mistake to name the CPU like that, luckily =
with
> > > > > > Intel we already use the microarchitecture name, so the EPYC CP=
U should
> > > > > > have been named ZEN-Server and for Ryzen CPUs there should be Z=
EN-Client
> > > > > > if there is any difference or otherwise we can simply use ZEN.
> > > > > >=20
> > > > > > The issue here is what happens once the ZEN2 microarchitecture =
is out
> > > > > > wihch introduces new features and we will have to come up with =
a CPU
> > > > > > name.
> > > > > >=20
> > > > > > Obviously we cannot change/remove the EPYC models so the questi=
on is
> > > > > > what is the difference between the AMD EPYC CPU and this new Dh=
yana CPU
> > > > > > if they are both based on the ZEN microarchitecture?
> > > > >=20
> > > > > Right now there's no much difference between Dhyana and EPYC from=
 the
> > > > > software's view. Dhyana removed the instructions aes, pclmulqdq, =
sha_ni
> > > > > compared to EPYC, but will have it's own implementation such as f=
or aes in
> > > > > future CPU models. Hygon also will implement something different =
=66rom AMD in
> > > > > the future.
> > > > >=20
> > > > > > In addition is there any way how we can introduce ZEN-Server &
> > > > > > ZEN-Client or simply ZEN, if there is no difference, as an alia=
s or a
> > > > > > new model next to the EPYC?
> > > > >=20
> > > > > Also as Eduardo mentioned that there's no CPU model alias or inhe=
ritance
> > > > > system in x86, so I think it's worthwhile to keep a separate CPU =
model for
> > > > > Hygon.
> > > >=20
> > > > So what happens once Zen2 is out and there are new Dhyana CPUs base=
d on
> > > > the Zen2 microarchitecture with some new features, what CPU models =
we
> > > > will introduce, EPYC-G2 and Dhyana-G2, but that will not correspond=
 to
> > > > the CPU model anymore.
> > > >=20
> > > > My idea was that we should probably introduce CPU model Zen-Server =
which
> > > > could cover both EPYC and Dhyana as they are both based on the Zen
> > > > microarchitecture.  The fact that Dhyana doesn't support all the
> > > > features is not an issue as QEMU will not use them if they are not
> > > > available on the host.
>=20
> It is an issue.  The fact that features are missing has huge
> importance for most virtualization management software that
> supports live migration.
>=20
> Not having the "enforce" flag enabled by default was a mistake,
> but it's hard to fix because we don't want to break backwards
> compatibility.
>=20
> > >=20
> > > I don't think this is a good idea. AFAICT, Dhyana and EPYC should not=
 be
> > > thought of as the same microarchitecture. Dhyana is a fork of the Zen
> > > microarchitecture as illustrated by the dropping of a number of CPU
> > > features. The Dhyana SEV patches show that it has had other significa=
nt
> > > changes, which are likely to require extra work in QEMU to support to=
o.
> >=20
> > Fair enough, still the point stands that we should use the name of the
> > microarchitecture.
>=20
> Note that using "microarchitecture[-variant]" is likely to be
> necessary if there's variation inside the same microarchitecture.
> We absolutely need to use different names for different sets of
> CPU features if we want to support them out of the box.
>=20
> Note that we can't (and don't need to) enumerate all possible
> combinations of features that exist in the world.  I let CPU
> vendors who submit patches decide which combinations of features
> are important to be supported out of the box.
>=20
> Dhyana adds to the complexity, because of the new CPU vendor ID.
> Different vendor IDs require different CPU models because the CPU
> model contains family/model/stepping/model_id values that make
> sense only in conjunction with the vendor ID.  Should we call it
> Zen-Dhyana?  Dhyana_G1?  I think I'll just let the Hygon
> developers decide.

Just for the reference, this discussion happened last year and AMD
developer Brijesh agreed [1] that the microarchitecture name would be
better, one of the reasons I've objected again.

Pavel

[1] <https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg03902.html>

--KAk/33nSS6LK84p9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEcbzs91ho/coWWY7aUi1kczAH4YwFAly4iTgACgkQUi1kczAH
4Yx0YA//dvSo2BEpmDnvJg4jjlvxQ1UQ1ltTvvydPPWePNauqi+ez30CQ8nd5fqM
v4EHRA7V+sWd/nyksec0gBgR9ylqHFCCOStZSLlgSFY24j2k/yHrXaD/qpBIe/d6
DTsCQsfDR4E2VWub47A87XWHihcmOZZbiDVNNgvggTdLm0MrZ9KVrrxi+GKMxipE
RDrM9Ywmhlzq6zMcabkULOwWbzi+5me8GZMSZLS5dGxRb6xZBfprevvd8+3ETGmP
Ur0vsGXABQNWw4daRrx27ROHZzWfjfArGOt6pnBgu/Xm+nr130Xg5z12JUEzuWRH
Xek8lYXiHG9/ObWjQXCPt75XJuCNn1xugvI/NFRJKVEfUQSoEpWNNZl3qKjnssAC
29JDu4hFaCOwB3zlhUs559do5ZQivBTeKbEqDWuTUlST4A1Irl9ptIy5WwkQLfs0
hop+JQMcxE8Rw94TN41DuGxEX3fJ369PiFEpFJuQYWKdmX50VYHuhDsRjLKF73Da
rXHEi49jev25Z7o0s5K3gDRuMBcMCJCfmGP0uDnHaEWw0J9G1Lq229NgsoXh2b+H
wPl2E6wpot6oZBOmFBUCImaurRLoDBT5i4enYvEa2y7NwN6589ovTlXwSWjxMV3i
w4E2bx+lq7OZvFXiACfDwgTw3WIZY2K0+hsJ8u20JiLbsoIcA4w=
=/jQA
-----END PGP SIGNATURE-----

--KAk/33nSS6LK84p9--

