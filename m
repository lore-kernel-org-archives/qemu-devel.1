Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1ECCC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 13:20:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5FF6218D2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 13:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5FF6218D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41613 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJHp0-0003ci-QN
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 09:20:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hJHnF-0002FV-ET
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:18:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hJHhG-0007aA-2c
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:12:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>)
	id 1hJHhE-0007Z5-4p; Wed, 24 Apr 2019 09:12:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0EDA730A9DD0;
	Wed, 24 Apr 2019 13:12:19 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E950600C4;
	Wed, 24 Apr 2019 13:12:12 +0000 (UTC)
Date: Wed, 24 Apr 2019 14:12:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190424131210.GK31388@redhat.com>
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-3-thuth@redhat.com>
	<20190424112537.GF31388@redhat.com>
	<c2202c0c-e504-7678-d1f3-6afc67bd2164@redhat.com>
	<20190424125046.GJ31388@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190424125046.GJ31388@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Wed, 24 Apr 2019 13:12:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/6] tests/qemu-iotests/group: Introduce a
 new "ci" group for CI pipelines
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424131210.z7tIXc1QKxz-wQ1NkYsi7HqRVw0npQZ1_8abGYmZZoY@z>

On Wed, Apr 24, 2019 at 01:50:46PM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Apr 24, 2019 at 02:37:02PM +0200, Thomas Huth wrote:
> > On 24/04/2019 13.25, Daniel P. Berrang=C3=A9 wrote:
> > > On Wed, Apr 24, 2019 at 12:37:43PM +0200, Thomas Huth wrote:
> > >> Tests in this group are supposed to run in every possible QEMU con=
figuration.
> > >> That means they should run with every QEMU binary (also non-x86), =
without
> > >> dependencies on an optional features, they must work at least with=
 the qcow2
> > >> image format and be able to run on all kind of host filesystems an=
d users
> > >> (i.e. also as "nobody" or "root").
> > >>
> > >> The initial list has been created as a subset of the "quick" group=
, where
> > >> I've disabled all tests that are failing with qemu-system-aarch64 =
or
> > >> qemu-system-tricore or in one of our CI pipelines.
> > >>
> > >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> > >> ---
> > >>  tests/qemu-iotests/group | 194 ++++++++++++++++++++--------------=
-----
> > >>  1 file changed, 102 insertions(+), 92 deletions(-)
> > >>
> > >> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
> > >> index bae7718380..2ed42dcc14 100644
> > >> --- a/tests/qemu-iotests/group
> > >> +++ b/tests/qemu-iotests/group
> > >> @@ -4,63 +4,73 @@
> > >>  # - do not start group names with a digit
> > >>  #
> > >> =20
> > >> +#
> > >> +# Some notes about the groups:
> > >> +# - Tests in the "quick" group should finish within some few seco=
nds
> > >> +# - Tests in the "ci" group are suitable for running in CI system=
s. That
> > >> +#   means they should run with every QEMU binary (also non-x86), =
with
> > >> +#   every QEMU configuration (i.e. no dependency on an optional f=
eature),
> > >> +#   at least with the qcow2 image format and all kind of host fil=
esystems
> > >> +#   and users (i.e. also as "nobody" or "root").
> > >=20
> > > No dependancy on optional features feels a bit restrictive from my =
POV.
> > >=20
> > > We have quite alot of testing coverage of stuff that depends on the
> > > crypto libraries that is important for us to run in "CI". This incl=
udes
> > > LUKS block drivers, qcow2 with LUKS,  NBD with TLS. Personally I ex=
pect
> > > all of those to be tested by CI systems.
> > >=20
> > > IOW for a "CI" group, the bar should be higher than "no optional fe=
atures"
> >=20
> > Ok, I think I just did not write it properly. What I meant was: the t=
est
> > should not *fail* because of a missing feature (what some tests are
> > unfortunately doing). It's fine if the test detects the missing featu=
re
> > and then marks the test as *skip*.
>=20
> Ok, this brings back the topic I don't think we ever resolved around ho=
w
> to best "detect" features in the iotests. eg if we want to know whether
> we can use TLS features, how do we decide this ?
>=20
> One option is to do a dummy launch of QEMU using TLS & check if it fail=
s,
> but that's kind of fragile for CI. A genuine bug in QEMU might cause th=
is
> dummy launch to fail, and thus mistakenly skip all the tests instead of
> failing.
>=20
> We can't look at config-host.{h,mak} either as iotests are supposed to =
be
> runnable outside of a build tree.
>=20
> We could look at whether gnutls is linked to QEMU but again that is goi=
ng
> to be fragile if a bug in configure causes us to mistakenly stop enabli=
ng
> gnutls.
>=20
> For developers, dynamically probing features & skipping is reasonable.
>=20
> For automated CI, I think we should set clear desired featureset upfron=
t
> based on what we know we are supposde to have available and not silentl=
y
> skip tests

I guess I should say "perfect is the enemy of good". What you propose
with "make check" is clearly better than what we have today which is
nothing by default.  So my point about defined featureset for running
under CI shouldn't be a blocker of the "make check" improvement.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

