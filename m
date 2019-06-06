Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE247C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:31:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6AA920872
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6AA920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36632 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYxAP-0003Pn-Pe
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 14:31:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1hYx9k-000365-Oi
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 14:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1hYx9X-00068Q-R5
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 14:30:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>)
	id 1hYx9P-0005V2-8c; Thu, 06 Jun 2019 14:30:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 034AC81DE3;
	Thu,  6 Jun 2019 18:29:34 +0000 (UTC)
Received: from dhcp-17-47.bos.redhat.com (dhcp-17-47.bos.redhat.com
	[10.18.17.47])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C9FEF7DFF6;
	Thu,  6 Jun 2019 18:29:27 +0000 (UTC)
Date: Thu, 6 Jun 2019 14:29:26 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190606182926.GA4501@dhcp-17-47.bos.redhat.com>
References: <20190520220635.10961-1-f4bug@amsat.org>
	<20190520220635.10961-3-f4bug@amsat.org>
	<20190605160659.GB7080@localhost.localdomain>
	<20190605204323.GF22416@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190605204323.GF22416@habkost.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Thu, 06 Jun 2019 18:29:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] BootLinuxConsoleTest: Test the
 SmartFusion2 board
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	Alistair Francis <alistair@alistair23.me>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 05, 2019 at 05:43:23PM -0300, Eduardo Habkost wrote:
> On Wed, Jun 05, 2019 at 12:06:59PM -0400, Cleber Rosa wrote:
> > On Tue, May 21, 2019 at 12:06:35AM +0200, Philippe Mathieu-Daud=E9 wr=
ote:
> > > Similar to the x86_64/pc test, it boots a Linux kernel on an
> > > Emcraft board and verify the serial is working.
> > >=20
> > > If ARM is a target being built, "make check-acceptance" will
> > > automatically include this test by the use of the "arch:arm" tags.
> > >=20
> > > Alternatively, this test can be run using:
> > >=20
> > >   $ avocado run -t arch:arm tests/acceptance
> > >   $ avocado run -t machine:emcraft-sf2 tests/acceptance
> > >
> >=20
> > The pattern accepted as a tag currently doesn't include a dash, see:
> >=20
> >    https://avocado-framework.readthedocs.io/en/68.0/ReferenceGuide.ht=
ml#docstring-directives-rules
> >=20
>=20
> Why isn't this causing test jobs to fail?

Because docstring directives are searched for "gracefully", that is,
if it doesn't match the pattern, it's not considered a docstring
directive.

Also, there's nothing in the jobs that require or check for that
specific machine tag.  The "check-acceptance" rule uses the built
targets, and adds "arch:<$TARGET>" tags to the command line.

Now, if one run this (as exemplified in the commit message):

  $ avocado run -t machine:emcraft-sf2 tests/acceptance

The *tag* failure/limitation would have been noticed.  BTW, it should
be easy to expand the docstring directive pattern and fix this
limitation on newer Avocado versions.

You can also see the parsed key/val tags with:

  $ avocado list -V tests/acceptance

Although only on new Avocado versions (>69.0), you can also see the
parsed key:val tags.

>=20
> This patch is already queued on python-next, should I remove it?
>

Or ammended it?  It's a minor issue IMO (s/-/_/).

>=20
> > My suggestion is to replace the dash for an underline.  This was done
> > on the s390 test:
> >=20
> >    :avocado: tags=3Dmachine:s390_ccw_virtio
>=20
> I would love if we stopped using the docstring to store
> machine-readable data and used Python class attributes or
> methods, like most Python APIs do.  e.g.:
>=20
>   class MyTest(avocado.Test):
>       tags =3D {'machine':'s390-ccw-virtio'}
>=20
>       def test_my_feature(self):
>           ...
>
>=20
> I understand the Avocado runner currently tries to not run any
> test code at the "list" step.  But can we have a mode where it
> will actually load the Python module and look at the class
> objects directly, instead of trying to parse the Python code
> without evaluating it?
>=20
> > [...]
>=20
> --=20
> Eduardo

I get your point, and I'd love to have no "no learning wheels" mode
too.  But given that the "safe loader" was a very basic architecture
design, and we probably wouldn't be dropping it, this means twice the
code to maintain.

I'd be interested in collecting more use cases (besides this s/-/_/)
to better justify such an effort.

Regards,
- Cleber.

