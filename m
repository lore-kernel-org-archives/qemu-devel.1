Received: from eggs.gnu.org ([2001:4830:134:3::10]:48061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fDoJe-0002r6-FG
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:44:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fDoJZ-000730-HI
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:44:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46696 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1fDoJZ-00072l-CJ
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:44:45 -0400
Date: Wed, 2 May 2018 11:44:34 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180502114434.2ad9cc16.cohuck@redhat.com>
In-Reply-To: <20180502081632.GH3308@redhat.com>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<d50e3a40-d7f3-4c9b-e930-4c2f4d6c8a53@redhat.com>
	<CAFEAcA8wJuJ9464LadgjJOo-7ttdGYcfDQWALbkxBRJCr_knkg@mail.gmail.com>
	<87d0ye8qho.fsf@dusky.pond.sub.org>
	<20180502081632.GH3308@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, 2 May 2018 09:16:32 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Wed, May 02, 2018 at 09:29:39AM +0200, Markus Armbruster wrote:

> > How can I provide both the old command line in all its quirky glory and
> > a QAPIfied command line?  Unless we can, the deprecation policy doesn't
> > help one bit, it still wants us to replicate every mess we ever made in
> > the old command line.  Would that be a smart choice? =20
>=20
> I venture to suggest that the deprecation policy leaves us enough
> ambiguity that we could issue a deprecation warning saying something
> suitably vague like "various quirks of the cli may change in incompatible
> ways in future", and then just do a big-bang conversion to QAPI'ified
> version. If there are known quirks that we intend to break we could
> call them out, but if we accidentally change a few quirks without
> realizing it, so be it.
>=20
> IOW, the big-bang conversion to QAPIified CLI is possible with our
> deprecation policy, without having the maintain the existing code
> in parallel with bug-for-bug compat. The main constraint is that
> we would need to have a reasonable idea about when the QAPIified
> CLI is likely to be ready to merge, so we have ability to warn
> developers of forthcoming changes.

I agree, that should be workable with our current deprecation policy.

[If it is at all feasible, we should also warn explicitly if a
known-quirky option is used, but the general warning should be enough,
especially if we feature it prominently in QEMU release notes as well.]
