Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77495C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:09:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 519EF2065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 09:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 519EF2065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jglsc-0004Sd-K2
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 05:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jgls2-0003uh-0B
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:09:06 -0400
Received: from 2.mo179.mail-out.ovh.net ([178.33.250.45]:34077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jgls0-0005nR-W0
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 05:09:05 -0400
Received: from player711.ha.ovh.net (unknown [10.110.103.121])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 3876C16D247
 for <qemu-devel@nongnu.org>; Thu,  4 Jun 2020 11:08:53 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player711.ha.ovh.net (Postfix) with ESMTPSA id 7121712DFA0B3;
 Thu,  4 Jun 2020 09:08:31 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R0053139fd52-1911-4642-b917-db792ecb09ea,0E78B47C015AB62E5F4E4B3B4EB6DB016BBCF3B5)
 smtp.auth=groug@kaod.org
Date: Thu, 4 Jun 2020 11:08:21 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC v2 00/18] Refactor configuration of guest memory protection
Message-ID: <20200604105228.2cb311d3@kaod.org>
In-Reply-To: <20200604064414.GI228651@umbus.fritz.box>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <87tuzr5ts5.fsf@morokweng.localdomain>
 <20200604064414.GI228651@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/T8M54mOA9k=ZBfZa=7RzYIy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 13412845592681355750
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudeguddguddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtsehgtderreertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeggfekuddvuddtgfekkeejleegjeffheduuefhledtteeftdfhffdtgfegiefhvdenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeduuddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=178.33.250.45; envelope-from=groug@kaod.org;
 helo=2.mo179.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 05:08:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com, frankja@linux.ibm.com,
 kvm@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, dgilbert@redhat.com,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 mdroth@linux.vnet.ibm.com, Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/T8M54mOA9k=ZBfZa=7RzYIy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Jun 2020 16:44:14 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Jun 04, 2020 at 01:39:22AM -0300, Thiago Jung Bauermann wrote:
> >=20
> > Hello David,
> >=20
> > David Gibson <david@gibson.dropbear.id.au> writes:
> >=20
> > > A number of hardware platforms are implementing mechanisms whereby the
> > > hypervisor does not have unfettered access to guest memory, in order
> > > to mitigate the security impact of a compromised hypervisor.
> > >
> > > AMD's SEV implements this with in-cpu memory encryption, and Intel has
> > > its own memory encryption mechanism.  POWER has an upcoming mechanism
> > > to accomplish this in a different way, using a new memory protection
> > > level plus a small trusted ultravisor.  s390 also has a protected
> > > execution environment.
> > >
> > > The current code (committed or draft) for these features has each
> > > platform's version configured entirely differently.  That doesn't seem
> > > ideal for users, or particularly for management layers.
> > >
> > > AMD SEV introduces a notionally generic machine option
> > > "machine-encryption", but it doesn't actually cover any cases other
> > > than SEV.
> > >
> > > This series is a proposal to at least partially unify configuration
> > > for these mechanisms, by renaming and generalizing AMD's
> > > "memory-encryption" property.  It is replaced by a
> > > "guest-memory-protection" property pointing to a platform specific
> > > object which configures and manages the specific details.
> > >
> > > For now this series covers just AMD SEV and POWER PEF.  I'm hoping it
> >=20
> > Thank you very much for this series! Using a machine property is a nice
> > way of configuring this.
> >=20
> > >From an end-user perspective, `-M pseries,guest-memory-protection` in
> > the command line already expresses everything that QEMU needs to know,
> > so having to add `-object pef-guest,id=3Dpef0` seems a bit redundant. Is
> > it possible to make QEMU create the pef-guest object behind the scenes
> > when the guest-memory-protection property is specified?
> >=20
> > Regardless, I was able to successfuly launch POWER PEF guests using
> > these patches:
> >=20
> > Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> >=20
> > > can be extended to cover the Intel and s390 mechanisms as well,
> > > though.
> > >
> > > Note: I'm using the term "guest memory protection" throughout to refer
> > > to mechanisms like this.  I don't particular like the term, it's both
> > > long and not really precise.  If someone can think of a succinct way
> > > of saying "a means of protecting guest memory from a possibly
> > > compromised hypervisor", I'd be grateful for the suggestion.
> >=20
> > Is "opaque guest memory" any better? It's slightly shorter, and slightly
> > more precise about what the main characteristic this guest property con=
veys.
>=20
> That's not a bad one, but for now I'm going with "host trust
> limitation", since this might end up covering things other than just
> memory protection.
>=20

Any idea what these other things might be ? It seems a bit hard to
decide of a proper name without a broader picture at this point.

--Sig_/T8M54mOA9k=ZBfZa=7RzYIy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl7YugUACgkQcdTV5YIv
c9YaHRAAsCGaQhAxkJQswzk2fB4NUMaNIjaDUka+MU/TxbgZuYyMNrvklAyPjG/a
Rzr281IzBU907eLOuP3KM0jf3enSdU3DpfD1fll2Dzw9eSgNphvMrCf4xkD4wcad
rSkID8GRegn4KbK7GL4xCFdvPE1egiAwVRjPMkJi9yVDdPgRkhufIlswWoN5Mhx/
ydKcdmjbP9fbKu5d9y6aa0D9Uw/lt1PpIbU8yHJnOuRz9HBROCx5CJ8mD9IgSgd8
IWums28UJKvVwq+zJojQButne51nVkHjn9yY2VxW3WAj7JpjHBdm4o3VdbeNFUTm
MXaYmCBMcuwTxMrqxXvR32byRhRCHw/2q6PkEAUkxa0SHBIsqjhmU+mUU0hgqrYt
lPynCReqrJ2M0JabdYfrpXQvCTp6L7LmHBmzR/4wfMvF1PI1oKe4cp7uvDDpfXql
NHfckWS5V+QQYq87YmriFP56aVxRNx6lmSGk3mXS6ohn01GJ9z2O3/LQY5pIFCxb
fnTh58xb4y05+/+cQa85CWEa+HuGNxXA7p0DecHE5gEeG8imrNH7vu4SzSwcD5qO
WmgGCNF1qftUZDOzWUQuj1mjwaaW0mnIYseqb41mFxpg6vvKeebmhbgObUx2N1by
AkEqzB8IaCxO7/b7yYPyhv1R1aWIxEmBTQhJvr53nzWmAWSgupQ=
=zeHm
-----END PGP SIGNATURE-----

--Sig_/T8M54mOA9k=ZBfZa=7RzYIy--

