Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBFEC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 21:25:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E252189D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 21:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E252189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i35RL-0001fp-6L
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 17:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1i35Qg-0001B1-3g
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 17:24:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1i35Qb-0001eT-VQ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 17:24:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40904)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1i35Qb-0001df-Np
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 17:24:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3C97110C6963;
 Wed, 28 Aug 2019 21:24:28 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-242.rdu2.redhat.com
 [10.10.123.242])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 13225600F8;
 Wed, 28 Aug 2019 21:24:26 +0000 (UTC)
Date: Wed, 28 Aug 2019 17:24:25 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Message-ID: <20190828212425.GB11512@localhost.localdomain>
References: <1564760158-27536-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <CAL1e-=hWc6G7Ob+LU7EWoY3LVBvABY2ky=RT28dSzqM=9O=OEA@mail.gmail.com>
 <20190821210030.GH7077@habkost.net>
 <CAL1e-=iZziwdyjJeaE-ZC2Rbjdmr_enYGBdK5zs4Lh0kN1DQOg@mail.gmail.com>
 <CAL1e-=gf-DOrdfN__Bxbx+B5NKu71ZTCypGEekoFc05WDaQjbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL1e-=gf-DOrdfN__Bxbx+B5NKu71ZTCypGEekoFc05WDaQjbw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Wed, 28 Aug 2019 21:24:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] tests/acceptance: Update MIPS Malta
 ssh test
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, cohuck@redhat.com, f4bug@amsat.org,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 22, 2019 at 07:59:07PM +0200, Aleksandar Markovic wrote:
> 22.08.2019. 05.15, "Aleksandar Markovic" <aleksandar.m.mail@gmail.com> =
=D1=98=D0=B5
> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> >
> > 21.08.2019. 23.00, "Eduardo Habkost" <ehabkost@redhat.com> =D1=98=D0=B5=
 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> > >
> > > On Wed, Aug 21, 2019 at 10:27:11PM +0200, Aleksandar Markovic wrote=
:
> > > > 02.08.2019. 17.37, "Aleksandar Markovic" <
> aleksandar.markovic@rt-rk.com> =D1=98=D0=B5
> > > > =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> > > > >
> > > > > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> > > > >
> > > > > This little series improves linux_ssh_mips_malta.py, both in th=
e
> sense
> > > > > of code organization and in the sense of quantity of executed t=
ests.
> > > > >
> > > >
> > > > Hello, all.
> > > >
> > > > I am going to send a new version in few days, and I have a questi=
on
> for
> > > > test team:
> > > >
> > > > Currently, the outcome of the script execition is either PASS:1
> FAIL:0 or
> > > > PASS:0 FAIL:1. But the test actually consists of several subtests=
. Is
> there
> > > > any way that this single Python script considers these subtests a=
s
> separate
> > > > tests (test cases), reporting something like PASS:12 FAIL:7? If y=
es,
> what
> > > > would be the best way to achieve that?
> > >
> > > If you are talking about each test_*() method, they are already
> > > treated like separate tests.  If you mean treating each
> > > ssh_command_output_contains() call as a separate test, this might
> > > be difficult.
> > >
> >
> > Yes, I meant the latter one, individual code segments involving an
> invocation of ssh_command_output_contains() instance being treated as
> separate tests.
> >
>=20
> Hello, Cleber,
>=20
> I am willing to rewamp python file structure if needed.
>=20
> The only thing I feel a little unconfortable is if I need to reboot the
> virtual machine for each case of ssh_command_output_contains().
>

Hi Aleksandar,

The short answer is that Avocado provides no way to report "subtest"
statuses (as a formal concept), neither does the current
"avocado_qemu" infrastructure allow for management of VMs across
tests.  The later is an Avocado-VT feature, and it to be honest it
brings a good deal of problems in itself, which we decided to avoid
here.

About the lack of subtests, we (the autotest project, then the Avocado
project) found that this concept, to be well applied, need more than
we could deal with initially.  For instance, Avocado has the concept
of "pre_test" and "post_test" hooks, with that, should those be
applied to subtests as well?  Also, there's support for capturing
system information (a feature called sysinfo) before and after the
tests... again, should it be applied to subtests?  Avocado also stores
a well defined results directory, and we'd have to deal with something
like that for subtests.  With regards to the variants feature, should
they also be applied to subtests?  The list of questions goes on and
on.

The fact that one test should not be able (as much as possible) to
influence another test also comes into play in our initial decision
to avoid subtests.

IMO, the best way to handle this is to either keep a separate logger
with the test progress:

  https://avocado-framework.readthedocs.io/en/71.0/WritingTests.html#adva=
nced-logging-capabilities

With a change similar to:

---
diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/=
linux_ssh_mips_malta.py
index 509ff929cf..0683586c35 100644
--- a/tests/acceptance/linux_ssh_mips_malta.py
+++ b/tests/acceptance/linux_ssh_mips_malta.py
@@ -17,6 +17,7 @@ from avocado_qemu import Test
 from avocado.utils import process
 from avocado.utils import archive
=20
+progress_log =3D logging.getLogger("progress")
=20
 class LinuxSSH(Test):
=20
@@ -149,6 +150,7 @@ class LinuxSSH(Test):
         stdout, _ =3D self.ssh_command(cmd)
         for line in stdout:
             if exp in line:
+                progress_log.info('Check successful for "%s"', cmd)
                 break
         else:
             self.fail('"%s" output does not contain "%s"' % (cmd, exp))
---

You could run tests with:

  $ ./tests/venv/bin/avocado --show=3Dconsole,progress run --store-loggin=
g-stream progress -- tests/acceptance/linux_ssh_mips_malta.py

And at the same time:

  $ tail -f ~/avocado/job-results/latest/progress.INFO=20
  17:20:44 INFO | Check successful for "uname -a"
  17:20:44 INFO | Check successful for "cat /proc/cpuinfo"
  ...

I hope this helps somehow.

Best regards,
- Cleber.

> Grateful in advance,
> Aleksandar
>=20
> > > Cleber, is there something already available in the Avocado API
> > > that would help us report more fine-grained results inside each
> > > test case?
> > >
> >
> > Thanks, that would be a better way of expressing my question.
> >
> > >
> > > >
> > > > Thanks in advance,
> > > > Aleksandar
> > > >
> > > > > Aleksandar Markovic (2):
> > > > >   tests/acceptance: Refactor and improve reporting in
> > > > >     linux_ssh_mips_malta.py
> > > > >   tests/acceptance: Add new test cases in linux_ssh_mips_malta.=
py
> > > > >
> > > > >  tests/acceptance/linux_ssh_mips_malta.py | 81
> > > > ++++++++++++++++++++++++++------
> > > > >  1 file changed, 66 insertions(+), 15 deletions(-)
> > > > >
> > > > > --
> > > > > 2.7.4
> > > > >
> > > > >
> > >
> > > --
> > > Eduardo

