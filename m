Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA6BC10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 10:00:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E8042183F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 10:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8042183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38766 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH3qR-0004FL-TT
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 06:00:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phrdina@redhat.com>) id 1hH3pY-0003qn-OE
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 05:59:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phrdina@redhat.com>) id 1hH3pX-0005uY-Gj
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 05:59:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <phrdina@redhat.com>) id 1hH3pX-0005uK-83
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 05:59:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3741308A102;
	Thu, 18 Apr 2019 09:59:41 +0000 (UTC)
Received: from antique-laptop (unknown [10.43.2.63])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F1EE21001DDE;
	Thu, 18 Apr 2019 09:59:37 +0000 (UTC)
Date: Thu, 18 Apr 2019 11:59:35 +0200
From: Pavel Hrdina <phrdina@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190418095935.GS18986@antique-laptop>
References: <1555416373-28690-1-git-send-email-puwen@hygon.cn>
	<20190416141700.GR18986@antique-laptop>
	<e7abd74f-61bb-fc34-0b3a-08c635d9f78c@hygon.cn>
	<20190417192610.GC19065@antique-laptop>
	<20190418084825.GC13773@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ixDgnS8AC6zwmyK0"
Content-Disposition: inline
In-Reply-To: <20190418084825.GC13773@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Thu, 18 Apr 2019 09:59:42 +0000 (UTC)
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
Cc: ehabkost@redhat.com, mst@redhat.com, Pu Wen <puwen@hygon.cn>,
	qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418095935.YYzUv1eczXg69Uw_16lZJvQLjnuZsj6E7IRJhKr0RBA@z>


--ixDgnS8AC6zwmyK0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2019 at 09:48:25AM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Apr 17, 2019 at 09:26:10PM +0200, Pavel Hrdina wrote:
> > On Wed, Apr 17, 2019 at 10:53:04PM +0800, Pu Wen wrote:
> > > On 2019/4/16 22:17, Pavel Hrdina wrote:
> > > > On Tue, Apr 16, 2019 at 08:06:13PM +0800, Pu Wen wrote:
> > > > > Add a new base CPU model called 'Dhyana' to model processors from=
 Hygon
> > > > > Dhyana(family 18h), which derived from AMD EPYC(family 17h).
> > > > >=20
> > > > > The following features bits have been removed compare to AMD EPYC:
> > > > > aes, pclmulqdq, sha_ni
> > > > >=20
> > > > > The Hygon Dhyana support to KVM in Linux is already accepted upst=
ream[1].
> > > > > So add Hygon Dhyana support to Qemu is necessary to create Hygon'=
s own
> > > > > CPU model.
> > > >=20
> > > > I have once question that we will have to solve for EPYC CPUs as we=
ll.
> > > > The name should not be based on the Product name or Model name as t=
hat
> > > > usually doesn't change with introduction of new microarchitecture.
> > > >=20
> > > > With EPYC we made a mistake to name the CPU like that, luckily with
> > > > Intel we already use the microarchitecture name, so the EPYC CPU sh=
ould
> > > > have been named ZEN-Server and for Ryzen CPUs there should be ZEN-C=
lient
> > > > if there is any difference or otherwise we can simply use ZEN.
> > > >=20
> > > > The issue here is what happens once the ZEN2 microarchitecture is o=
ut
> > > > wihch introduces new features and we will have to come up with a CPU
> > > > name.
> > > >=20
> > > > Obviously we cannot change/remove the EPYC models so the question is
> > > > what is the difference between the AMD EPYC CPU and this new Dhyana=
 CPU
> > > > if they are both based on the ZEN microarchitecture?
> > >=20
> > > Right now there's no much difference between Dhyana and EPYC from the
> > > software's view. Dhyana removed the instructions aes, pclmulqdq, sha_=
ni
> > > compared to EPYC, but will have it's own implementation such as for a=
es in
> > > future CPU models. Hygon also will implement something different from=
 AMD in
> > > the future.
> > >=20
> > > > In addition is there any way how we can introduce ZEN-Server &
> > > > ZEN-Client or simply ZEN, if there is no difference, as an alias or=
 a
> > > > new model next to the EPYC?
> > >=20
> > > Also as Eduardo mentioned that there's no CPU model alias or inherita=
nce
> > > system in x86, so I think it's worthwhile to keep a separate CPU mode=
l for
> > > Hygon.
> >=20
> > So what happens once Zen2 is out and there are new Dhyana CPUs based on
> > the Zen2 microarchitecture with some new features, what CPU models we
> > will introduce, EPYC-G2 and Dhyana-G2, but that will not correspond to
> > the CPU model anymore.
> >=20
> > My idea was that we should probably introduce CPU model Zen-Server which
> > could cover both EPYC and Dhyana as they are both based on the Zen
> > microarchitecture.  The fact that Dhyana doesn't support all the
> > features is not an issue as QEMU will not use them if they are not
> > available on the host.
>=20
> I don't think this is a good idea. AFAICT, Dhyana and EPYC should not be
> thought of as the same microarchitecture. Dhyana is a fork of the Zen
> microarchitecture as illustrated by the dropping of a number of CPU
> features. The Dhyana SEV patches show that it has had other significant
> changes, which are likely to require extra work in QEMU to support too.

Fair enough, still the point stands that we should use the name of the
microarchitecture.

Pavel

--ixDgnS8AC6zwmyK0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEcbzs91ho/coWWY7aUi1kczAH4YwFAly4SocACgkQUi1kczAH
4YzLeg//aknXHTND/2BS7LqqGzOk8Gu4eq9JwcWdnX3wcYg3fzmNzrdVQMd91DjH
UTxVojyklrjC1ln6ZtifW2th/WJk9QG5zpgkd7Efx4lLvdnKx+15GuL66H+yOrt6
wn3lIZjWZpXiR2I3IhU03U6Lo0CvtLfIjv5dhUgY03O6wq7nr+kV5YsEbnSf492u
trn19seduCOA3VIujH+NAZs8JXkpehxp9VqRmRjuWVG9CpyZ5aWx83e+cOTCekfb
Zko9zR4zhtzMp6wTopdcgpUm52fBAesuuzuVMG12KW8BnXySuRri2h8x5jLmX6Ro
4DNe7rw1ECv4NHFZEj+hpEf6XOfHOpvZ1+CcLo2YANUhUTGBUFP8oiLR10ab0mgn
1IfYJl3xYQO/qq6i3kk1DLkGbxEp8BDVTIpwvOH5Fo7pn527hEQFbHIIPemvpdWC
5SSxrIIpN6h6I4YJfflqpDnwjV+6BNEnAzSOsoTo8fZsHNccpEzFX37X1TD35tvm
P8RKb5Ano9CANcNvhPuVD75DHxQUYttb3hDcN4QJqDkeKJ23ikRAPA9COa0RykIs
hZBqBLkexHynU5Mb3hCrf+3/q4ckwjvp2Ta4QejevXptFapM4cOu2uZ1bMaMgcz+
rso1S9oBVGVl2zy/y063rRQ60V8ZMqP5WQR5GV7hcPQ2O2B21As=
=gozU
-----END PGP SIGNATURE-----

--ixDgnS8AC6zwmyK0--

