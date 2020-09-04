Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261B3C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:11:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E76DF2073B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76DF2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEDMk-0006PM-4y
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 11:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kEDM4-0005ph-1v
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:10:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59258
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kEDM0-0001Oh-4e
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:10:19 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-GcqnC4MhOmaCnirajaerkg-1; Fri, 04 Sep 2020 11:10:12 -0400
X-MC-Unique: GcqnC4MhOmaCnirajaerkg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78EB781C478;
 Fri,  4 Sep 2020 15:10:11 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-166.rdu2.redhat.com
 [10.10.120.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E94281195;
 Fri,  4 Sep 2020 15:10:02 +0000 (UTC)
Date: Fri, 4 Sep 2020 11:10:00 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 2/2] GitLab Gating CI: initial set of jobs,
 documentation and scripts
Message-ID: <20200904151000.GC232153@localhost.localdomain>
References: <20200709024657.2500558-1-crosa@redhat.com>
 <20200709024657.2500558-3-crosa@redhat.com>
 <20200709103029.GK3753300@redhat.com>
 <20200904001139.GE55646@localhost.localdomain>
 <20200904081816.GB721059@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200904081816.GB721059@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=crosa@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 01:57:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04, 2020 at 09:18:16AM +0100, Daniel P. Berrang=E9 wrote:
> On Thu, Sep 03, 2020 at 08:11:39PM -0400, Cleber Rosa wrote:
> > On Thu, Jul 09, 2020 at 11:30:29AM +0100, Daniel P. Berrang=E9 wrote:
> > > On Wed, Jul 08, 2020 at 10:46:57PM -0400, Cleber Rosa wrote:
> > > > This is a mapping of Peter's "remake-merge-builds" and
> > > > "pull-buildtest" scripts, gone through some updates, adding some bu=
ild
> > > > option and removing others.
> > > >=20
> > > > The jobs currently cover the machines that the QEMU project owns, a=
nd that
> > > > are setup and ready to run jobs:
> > > >=20
> > > >  - Ubuntu 18.04 on S390x
> > > >  - Ubuntu 20.04 on aarch64
> > > >=20
> > > > During the development of this set of jobs, the GitLab CI was teste=
d
> > > > with many other architectures, including ppc64, s390x and aarch64,
> > > > along with the other OSs (not included here):
> > > >=20
> > > >  - Fedora 30
> > > >  - FreeBSD 12.1
> > > >=20
> > > > More information can be found in the documentation itself.
> > > >=20
> > > > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > > > ---
> > > >  .gitlab-ci.d/gating.yml                | 146 +++++++++++++++++
> > >=20
> > > AFAIK, the jobs in this file just augment what is already defined
> > > in the main .gitlab-ci.yml. Also since we're providing setup info
> > > for other people to configure custom runners, these jobs are usable
> > > for non-gating CI scenarios too.
> > >
> >=20
> > If you mean that they introduced new jobs, you're right.
> >=20
> > > IOW, the jobs in this file happen to be usable for gating, but they
> > > are not the only gating jobs, and can be used for non-gating reasons.
> > >
> >=20
> > Right, I do not doubt these jobs may be useful to other people and on
> > scenarios other than "before merging a patch series".
> >=20
> > > This is a complicated way of saying that gating.yml is not a desirabl=
e
> > > filename, so I'd suggest splitting it in two and having these files
> > > named based on what their contents is, rather than their use case:
> > >=20
> > >    .gitlab-ci.d/runners-s390x.yml
> > >    .gitlab-ci.d/runners-aarch64.yml
> > >=20
> > > The existing jobs in .gitlab-ci.yml could possibly be moved into
> > > a .gitlab-ci.d/runners-shared.yml file for consistency.
> > >
> >=20
> > Do you imply that every gitlab CI job should be a gating job?  And
> > that the same jobs should be used when other people with their own
> > forks?  I find this problematic because:
> >=20
> > * It would trigger pipelines with jobs that, unless every user has the
> >   same runners configured, would have unfulfilled jobs that don't have
> >   a matching hardware.
>=20
> Jobs that require a custom runner should not be set to run by default,
> but individual contributors must absolutely be able to opt-in to running
> those jobs simply by registering a runner on their account.
>

Agreed, and that's why they have been put into this diffent "gating"
class here.

> > * It dilutes the idea that those jobs are inherently different with
> >   regards to the management of their infrastructure.
>=20
> I don't really know what yiu mean here, but "Inherantly different"
> does not sound like a desirable property.
>

Organizations and individuals will have responsibility over the
infrastructure they choose to add, which is "inherently different"
from the gitlab shared machines.  Not sure there's a way around it.

> > * It destroys the notion of layered testing, for whatever people find
> >   that worth it, where a faster turnaround could/would be possible
> >   with fewer jobs for every push, and many more jobs before a merge.
>=20
> The key goal of CI is to reduce the burden on maintainers. The biggest
> cost is if we merge code and failure is noticed after merge. IT is
> still a large cost, however, if Peter only finds a CI failure when he
> attempts the pre-merge test. He has to throw out the pull request
> putting more work on the subsystem maintainer. The subsystem maintainer
> may have to throw it back to the original author.
>=20
> The ideal scenario that we need to strive towards is that the original
> author has tested their code with 100% coverage of all the CI jobs QMEU
> has defined.
>

I agree... but it's also unrealistic at this point, right?  For
instance, do we have s390x boxes to run all of those?  Avocado has
been using Travis CI for s390x/ppc64/aarch64, and those are quite
unreliable even with a load many orders of magnitude smaller then the
QEMU project.  So, resources are needed to have this flat, 100%
coverage, "ideal scenario" you describe.

> Any time there is a job that is not run by authors, but only by the
> maintainers, we are putting increased burden on the maintainers, so
> must be minimize that.
>

I agree.  But if resources are limited, then should the testing scope
be decresead so that it's equalized?

> IOW, layered testing is not desirable as goal. Rather layered testing
> is just a default setup, but we'd encourage contributors to run the
> full set of CI jobs, especially if they are frequent contributors.
> The more they run themselves, the less burden on subsystem maintainers
> and Peter, and thus the better we all scale.
>

We agree on goals, we don't agree on the strategy though.

> > Finally, I find the split by runner architecture you suggested
> > problematic because different organizations may have jobs for the same
> > architecture.  I believe that files for different organizations may be
> > a better organization instead.  Entries in the MAINTAINERS are one
> > example where the grouping by architecture may not be optimal.
>=20
> I don't think we should be structuring jobs around organizations. We
> should be defining a set of desired jobs we wish to be able to run.
> Any organization can bring a runner that is capable of running the
> jobs and donate it to the QEMU project for our formal CI runner
> The organization is not defining the job though - QEMU is  defining
> the jobs we expect to have used for testing.
>

This was disscussed previously[1].

> This is key because any contributor needs to be able to spin up an
> identical envrionment to replicate any build failures. We don't want
> runners for merge testing that are built as a blackbox by someone.
> That is the single biggest painpoint with Peter's current merge
> jobs - we can't easily replicate Peter's merge env even if we had
> the matching hardware available.
>

With the right automation, such as the playbooks introduced here, any
person with the same hardware should have an environment to replicate
a job and debug and issue.

[1] - https://lists.gnu.org/archive/html/qemu-devel/2019-12/msg00231.html

Best regards,
- Cleber.

> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9SWMUACgkQZX6NM6Xy
CfNIEw//d52NKTDmoUH4nyHpCebPdmS/te8NfokTht1HPfU5oHjeU5W03EAeww21
i0AYvI7Br5efkxGUyIPhZT52vdDXKgw1hvKfOrYZ1VFtuuKtgaCrvanLqHb5Tmxt
PMiX/abgrOVwuJO86GyoOoyuVvpJKj4n28IbLJXixxY+rJYlxXBX0kfUo1b59oOD
uHKaEwy6EsHDlHTI5EMsSElRdn4IIi+eKJi97JLsG0fwqOE5C5ekDM7FCQ5qtOIg
GFONoVM5t1hUe15OSqwYmusdCbtabjLiIZ8mioT5f4UCLihka9kQz6dFY+RJ3JeP
tOinqBn0YUtaXakR9ODHQlJ94D37GaCXBe/fr4U09+QfnHuzSLniXLfAz8hDLkBV
1CWeEYCBd5050SaGgcXTiP5Q04WwyRHv2MlRxmV7IyzlMkvWBD64/o9gWGWUPgAu
OcvXfb0snzhMg6YX/8nFx9X9BFq2tq2MmhC9nkUx9ujuVg5gkqxdaSRo/dk8oMMx
6524GDNAObDxMjyT4OuvvtnfLB3wJB3UTS2MvMDjMNaTszLq8T3wtdkDltUjITs5
NWUw7hgAOWdERNe6rBDokFe4Zg+dPGFsYHJDX6G/xkF+lLxQTs0OemRfqtfLqP9y
9XB8y3u3V4YRmtynsmahJJwYwLuh1o0qxG1ltE8B1vx07EN2GQE=
=yAHT
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--


