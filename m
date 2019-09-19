Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595ABC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:21:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30BF32196F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BF32196F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4oB-0004l1-77
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 18:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iB4nE-0003vG-Hu
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iB4nB-0008Eo-LW
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:20:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56646)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iB4nB-0008EZ-GM
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:20:49 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 81EBC10C093C;
 Thu, 19 Sep 2019 22:20:48 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-8.rdu2.redhat.com [10.10.123.8])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A749110001BC;
 Thu, 19 Sep 2019 22:20:42 +0000 (UTC)
Date: Thu, 19 Sep 2019 18:20:40 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Thomas Huth <huth@tuxfamily.org>
Subject: Re: [PATCH] Acceptance test machine_m68k_nextcube.py: relax the
 error code pattern
Message-ID: <20190919222040.GA26567@localhost.localdomain>
References: <20190919161400.26399-1-crosa@redhat.com>
 <8a087ca1-cdae-20ee-d939-a47be4f25235@redhat.com>
 <20190919212635.03b79d37@thl530.multi.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190919212635.03b79d37@thl530.multi.box>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Thu, 19 Sep 2019 22:20:48 +0000 (UTC)
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
Cc: Willian Rampazzo <wrampazz@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 19, 2019 at 09:26:35PM +0200, Thomas Huth wrote:
> Am Thu, 19 Sep 2019 18:19:40 +0200
> schrieb Philippe Mathieu-Daud=E9 <philmd@redhat.com>:
>=20
> > Cc'ing Thomas
> >=20
> > On 9/19/19 6:14 PM, Cleber Rosa wrote:
> > > Instead of looking for a specific error, let's relax the pattern
> > > because different errors have been seen (I'm consistenly getting 52=
)
> > > and the real goal of this test is to validate the framebuffer
> > > operation, and not to reproduce one specific error. =20
> >=20
> > This might be because I wrote this test before Thomas added the seria=
l
> > controller (commit b17bed5b1727e3aa9e37fc8e8c3222130ceab22f).
>=20
> That's strange, the travis job worked fine for me ... but sure, let's
> drop the error number, we don't need it here.=20
>=20
> > > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > > ---
> > >  tests/acceptance/machine_m68k_nextcube.py | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/tests/acceptance/machine_m68k_nextcube.py
> > > b/tests/acceptance/machine_m68k_nextcube.py index
> > > e09cab9f20..fcd2c58ee7 100644 ---
> > > a/tests/acceptance/machine_m68k_nextcube.py +++
> > > b/tests/acceptance/machine_m68k_nextcube.py @@ -116,6 +116,6 @@
> > > class NextCubeMachine(Test): if len(line):
> > >                  console_logger.debug(line)
> > >          self.assertIn('Testing the FPU, SCC', text)
> > > -        self.assertIn('System test failed. Error code 51', text)
> > > +        self.assertIn('System test failed. Error code', text)
> > >          self.assertIn('Boot command', text) =20
> > >          self.assertIn('Next>', text) =20
> > >  =20
> >=20
> > Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>=20
> Reviewed-by: Thomas Huth <huth@tuxfamily.org>

Thanks for the prompt review, queueing on my python-next branch.

- Cleber.

