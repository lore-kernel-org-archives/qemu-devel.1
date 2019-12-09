Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4CAC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 21:05:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC5D205C9
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 21:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC5D205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieQDM-00074T-4q
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 16:05:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ieQCZ-0006WR-QQ
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 16:04:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ieQCY-0005t8-IZ
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 16:04:19 -0500
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:38974)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ieQCY-0005pE-BD
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 16:04:18 -0500
Received: from player759.ha.ovh.net (unknown [10.109.146.53])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id EABEE114F50
 for <qemu-devel@nongnu.org>; Mon,  9 Dec 2019 22:04:15 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player759.ha.ovh.net (Postfix) with ESMTPSA id 7BC77D1DB54F;
 Mon,  9 Dec 2019 21:04:06 +0000 (UTC)
Date: Mon, 9 Dec 2019 22:04:04 +0100
From: Greg Kurz <groug@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [for-5.0 PATCH] ppc: Make PPCVirtualHypervisor an incomplete type
Message-ID: <20191209220404.4b1539c8@bahia.w3ibm.bluemix.net>
In-Reply-To: <CAFEAcA-WFd9XVXS5bt4sWOw9BzuS=ODTDneTUJzQ4z8Mks4X3A@mail.gmail.com>
References: <157589808041.21182.18121655959115011353.stgit@bahia.lan>
 <bf095dc0-321e-0d19-9d18-309317654050@redhat.com>
 <20191209172716.175a86b5@bahia.w3ibm.bluemix.net>
 <CAFEAcA-WFd9XVXS5bt4sWOw9BzuS=ODTDneTUJzQ4z8Mks4X3A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 13172747439285246225
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeltddgudeghecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejheelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.109.80
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
Cc: "Daniel P
 . Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Dec 2019 16:42:39 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Mon, 9 Dec 2019 at 16:28, Greg Kurz <groug@kaod.org> wrote:
> >
> > On Mon, 9 Dec 2019 15:02:38 +0100
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> >
> > > On 12/9/19 2:28 PM, Greg Kurz wrote:
> > > > PPCVirtualHypervisor is an interface instance. It should never be
> > > > dereferenced. Drop the dummy type definition for extra safety, which
> > > > is the common practice with QOM interfaces.
> > >
> > > This "common practice" is also referenced in commit 00ed3da9b5:
> > >
> > >      xics: Minor fixes for XICSFabric interface
> > >
> > >      Interface instances should never be directly dereferenced.  So, =
the
> > > common
> > >      practice is to make them incomplete types to make sure no-one do=
es
> > > that.
> > >      XICSFrabric, however, had a dummy type which is less safe.
> > >
> > >      We were also using OBJECT_CHECK() where we should have been using
> > >      INTERFACE_CHECK().
> > >
> > > This indeed follow the changes from commit aa1b35b975d8:
> > >
> > >      qom: make interface types abstract
> > >
> > >      Interfaces don't have instance, let's make the interface type re=
ally
> > >      abstract to avoid confusion.
> > >
> > > Now I can't find guidelines for this. If you don't know about it and =
use
> > > 'git-grep', it is very confusing to see we use structures we never de=
fine.
> > >
> >
> > I agree that this deliberate usage of incomplete types isn't common.
> >
> > > Can we document this use please?
> > >
> >
> > Probably we could amend the related section in the object.h header file.
> > Something like:
> >
> > --- a/include/qom/object.h
> > +++ b/include/qom/object.h
> > @@ -200,8 +200,11 @@ typedef struct InterfaceInfo InterfaceInfo;
> >   *
> >   * Interfaces allow a limited form of multiple inheritance.  Instances=
 are
> >   * similar to normal types except for the fact that are only defined by
> > - * their classes and never carry any state.  You can dynamically cast =
an object
> > - * to one of its #Interface types and vice versa.
> > + * their classes and never carry any state.  As a consequence, a point=
er to
> > + * an interface instance should always be of incomplete type in order =
to be
> > + * sure it cannot be dereferenced.
>=20
> It might be helpful to add here the concrete details of how to do that,
> so people don't have to look up what an incomplete type is:
>=20
> "That is, you should define the 'typedef struct SomethingIf SomethingIf'
> so that you can pass around 'SomethingIf *si' arguments, but not define
> a 'struct SomethingIf { ... }'. The only things you can validly do with
> a 'SomethingIf *' are to pass it as an argument to a method on its corres=
ponding
> SomethingIfClass, or to dynamically cast the interface pointer to a point=
er
> to the concrete object which is implementing the interface."
>=20
> ?
>=20
> > + * You can dynamically cast an object to one of its #Interface types a=
nd vice
> > + * versa.
>=20
> ...though that last part is then kind of awkwardly similar to this senten=
ce.
> There's probably better wording possible than what I suggest above.
>=20

What about ?

  * Interfaces allow a limited form of multiple inheritance.  Instances are
  * similar to normal types except for the fact that are only defined by
- * their classes and never carry any state.  You can dynamically cast an o=
bject
- * to one of its #Interface types and vice versa.
+ * their classes and never carry any state.  As a consequence, a pointer to
+ * an interface instance should always be of incomplete type in order to be
+ * sure it cannot be dereferenced.  That is, you should define the
+ * 'typedef struct SomethingIf SomethingIf' so that you can pass around
+ * 'SomethingIf *si' arguments, but not define a 'struct SomethingIf { ...=
 }'.
+ * The only things you can validly do with a 'SomethingIf *' are to pass i=
t as
+ * an argument to a method on its corresponding SomethingIfClass, or to
+ * dynamically cast it to an object that implements the interface.

> thanks
> -- PMM


