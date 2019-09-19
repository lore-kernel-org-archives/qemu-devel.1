Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F06AC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 18:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6C7020640
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 18:55:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C7020640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB1au-0004oJ-SJ
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 14:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iB1Zg-00040N-7f
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 14:54:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iB1Zc-0006qn-S7
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 14:54:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53418)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iB1Zc-0006qX-JF
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 14:54:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 76D9B8A1C97;
 Thu, 19 Sep 2019 18:54:35 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-8.rdu2.redhat.com [10.10.123.8])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 63B8F19C7F;
 Thu, 19 Sep 2019 18:54:31 +0000 (UTC)
Date: Thu, 19 Sep 2019 14:54:29 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: Problems with MIPS Malta SSH tests in make check-acceptance
Message-ID: <20190919185429.GA11935@localhost.localdomain>
References: <20190918071654.GK2440@umbus.fritz.box>
 <20190919011452.GA23168@localhost.localdomain>
 <20190919165632.GA5821@localhost.localdomain>
 <8bc26c85-253e-ff20-c3e0-1ecdb56d60c0@redhat.com>
 <20190919171444.GA6495@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190919171444.GA6495@localhost.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Thu, 19 Sep 2019 18:54:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 19, 2019 at 01:14:50PM -0400, Cleber Rosa wrote:
> On Thu, Sep 19, 2019 at 07:00:49PM +0200, Philippe Mathieu-Daud=E9 wrot=
e:
> > On 9/19/19 6:56 PM, Cleber Rosa wrote:
> > > On Wed, Sep 18, 2019 at 09:14:58PM -0400, Cleber Rosa wrote:
> > >> On Wed, Sep 18, 2019 at 05:16:54PM +1000, David Gibson wrote:
> > >>> Hi,
> > >>>
> > >>> I'm finding make check-acceptance is currently useless for me as =
a
> > >>> pre-pull test, because a bunch of the tests are not at all reliab=
le.
> > >>> There are a bunch which I'm still investigating, but for now I'm
> > >>> looking at the MIPS Malta SSH tests.
> > >>>
> > >>> There seem to be at least two problems here.  First, the test inc=
ludes
> > >>> a download of a pretty big guest disk image.  This can easily exh=
aust
> > >>> the 2m30 timeout on its own.
> > >>>
> > >>
> > >> You're correct that successes and failures on those tests depend
> > >> largely on bandwith.  On a shared environment I used for tests
> > >> the download of those images take roughly 400 seconds, resulting
> > >> in failures.  On my own machine, around 60, and the tests pass.
> > >>
> > >> There's a conceptual and conflicting problem in that the environme=
nt
> > >> for tests to run should be prepared beforehand.  The conflicting
> > >> solutions can be:
> > >>
> > >>  * extensive bootstrapping of the test execution environment, such
> > >>    as the installation of guests from ISOs or installation trees, =
or
> > >>    the download of "default" images wether the tests will use it o=
r
> > >>    not (this is what Avocado-VT does/requires)
> > >>
> > >>  * keeping test assets in the tree (Avocado allows this if you hav=
e
> > >>    a your_test.py.data/ directory), but it's not practical for lar=
ge
> > >>    files or files that can't or shouldn't be redistributed
> > >>
> > >>> Even without the timeout, it makes the test really slow, even on
> > >>> repeated runs.  Is there some way we can make the image download =
part
> > >>> of "building" the tests rather than actually running the testsuit=
e, so
> > >>> that a) the test themselves go faster and b) we don't include the
> > >>> download in the test timeout - obviously the download speed is hu=
gely
> > >>> dependent on factors that aren't really related to what we're tes=
ting
> > >>> here.
> > >>>
> > >>
> > >> On Avocado version 72.0 we attempted to minimize the isse by
> > >> implementing a "vmimage" command.  So, if you expect to use Fedora=
 30
> > >> aarch64 images, you could run before your tests:
> > >>
> > >>  $ avocado vmimage get --distro fedora --distro-version 30 --arch =
aarch64
> > >>
> > >> And to list the images on your cache:
> > >>
> > >>  $ avocado vmimage list
> > >>
> > >> Unfortunately, this test doesn't use the vmimage API.  Actually th=
at
> > >> is fine because not all test assets map nicely to the vmimage goal=
,
> > >> and should keep using the more generic (and lower level) fetch_ass=
et().
> > >>
> > >> We're now working on various "asset fetcher" improvements that sho=
uld
> > >> allow us to check/cache all assets before a test is executed.  Als=
o,
> > >> we're adding a mode in which the "fetch_asset()" API will default =
to
> > >> cancel (aka SKIP) a test if the asset could not be downloaded.
> > >>
> > >> If you're interested in the card we're using to track that new fea=
ture:
> > >>
> > >>   https://trello.com/c/T3SC1sZs/1521-implement-fetch-assets-comman=
d-line-parameter
> > >>
> > >> Another possibility that we've prototyped, and we'll be working on
> > >> further, is to make a specific part of the "test" code execution
> > >> (really a pre-test phase) to be executed without a timeout and eve=
n be
> > >> tried a number of times before bailing out and skipping the test.
> > >>
> > >>> In the meantime, I tried hacking it by just increasing the timeou=
t to
> > >>> 10m.  That got several of the tests working for me, but one still
> > >>> failed.  Specifically 'LinuxSSH.test_mips_malta32eb_kernel3_2_0' =
still
> > >>> timed out for me, but now after booting the guest, rather than du=
ring
> > >>> the image download.  Looking at the avocado log file I'm seeing a
> > >>> bunch of soft lockup messages from the guest console, AFAICT.  So=
 it
> > >>> looks like we have a real bug here, which I suspect has been
> > >>> overlooked precisely because the download problems mean this test
> > >>> isn't reliable.
> > >>>
> > >>
> > >> I've schedulled a 100 executions of `make check-acceptance` builds=
, with
> > >> the linux_ssh_mips_malta.py tests having a 1500 seconds timeout.  =
The
> > >> very first execution already brought interesting results:
> > >>
> > >>  ...
> > >>  (15/39) /home/cleber/src/qemu/tests/acceptance/linux_ssh_mips_mal=
ta.py:LinuxSSH.test_mips_malta32eb_kernel3_2_0: PASS (198.38 s)
> > >>  (16/39) /home/cleber/src/qemu/tests/acceptance/linux_ssh_mips_mal=
ta.py:LinuxSSH.test_mips_malta64el_kernel3_2_0: FAIL: Failure message fou=
nd in console: Oops (22.83 s)
> > >>
> > >> I'll let you know about my full results.  This should also serve a=
s a
> > >> starting point to a discussion about the reliability of other test=
s,
> > >> as you mentioned before.
> > >=20
> > > Out of the 100 executions on a ppc64le host, the results that conta=
in
> > > failures and errors:
> > >=20
> > > 15-/home/cleber/src/qemu/tests/acceptance/linux_ssh_mips_malta.py:L=
inuxSSH.test_mips_malta32eb_kernel3_2_0
> > >   - PASS: 92
> > >   - INTERRUPTED: 4
> > >   - FAIL: 4
> > > 16-/home/cleber/src/qemu/tests/acceptance/linux_ssh_mips_malta.py:L=
inuxSSH.test_mips_malta64el_kernel3_2_0
> > >   - PASS: 95
> > >   - FAIL: 5
> > >=20
> > > FAIL means that self.fail() was called, which means 'Oops' was foun=
d
> > > in the console.  INTERRUPTED here means that the test timeout kicke=
d
> > > in, and I can back David's statements about soft lockups.
> > >=20
> > > Let me know if anyone wants access to the full logs/results.
> >=20
> > Can you check if the FAIL case are this bug please?
> >=20
> > https://bugs.launchpad.net/qemu/+bug/1833661
> >
>=20
> Yes, the errors do match.  I posted an updated there:
>=20
>   https://bugs.launchpad.net/qemu/+bug/1833661/comments/3
>

What if we tag tests like this as "knownbug" (or a better name),
disabling execution by default?

- Cleber.

> Cheers,
> - Cleber.
>=20
> > Thanks,
> >=20
> > Phil.
> >=20

