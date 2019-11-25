Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831C2C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 18:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FAB420740
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 18:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8n/eZ8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FAB420740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZIoJ-0001iB-HX
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 13:10:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35076)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iZImv-0001Gz-5o
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 13:08:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iZImr-0006hj-O9
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 13:08:39 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41878
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iZImq-0006gp-3q
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 13:08:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574705314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xuKpJ2jVj2H2zzc5JXv/MrD4di1Z7HZ9MUT2nkBHQD4=;
 b=D8n/eZ8SRPxifg9XROHkeTc1P9K9dRdYYYW4hz6ros0hl86ZtR67jty1r3b0KlRx3n1QR9
 CJPo0+4Sh6jpCK/12gAdPc4NQvjAztCq7ZPNIbTNjfiar7LncEnDiDZtQD7oAqZTJo7HHG
 Gx8UCLuhUCXq+Tm+dbx5ZvW2qytqHsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-d0RBRMuMNR29Z0ka1fAzkg-1; Mon, 25 Nov 2019 13:08:32 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 037FC8E5DC2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 18:08:31 +0000 (UTC)
Received: from localhost.localdomain (ovpn-120-170.rdu2.redhat.com
 [10.10.120.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 433AA5D9CA;
 Mon, 25 Nov 2019 18:08:20 +0000 (UTC)
Date: Mon, 25 Nov 2019 13:08:18 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: Avocado notes from KVM forum 2019
Message-ID: <20191125180818.GB8589@localhost.localdomain>
References: <9b3b2ff0-a3bb-c7ba-d7ce-d178e8fbd5d8@redhat.com>
 <20191125135802.GH4438@habkost.net>
MIME-Version: 1.0
In-Reply-To: <20191125135802.GH4438@habkost.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: d0RBRMuMNR29Z0ka1fAzkg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: avocado-devel@redhat.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 25, 2019 at 10:58:02AM -0300, Eduardo Habkost wrote:
> Thank you, Philippe, those are great ideas.  I have copied them
> to the Avocado+QEMU Trello board so we don't forget about them:
> https://trello.com/b/6Qi1pxVn/avocado-qemu
>=20
> Additional comments below:
>=20
> On Mon, Nov 25, 2019 at 01:35:13PM +0100, Philippe Mathieu-Daud=E9 wrote:
> > Hi Cleber,
> >=20
> > Here are my notes from talking about Avocado with various people during=
 the
> > KVM forum in Lyon last month.
> >=20
> > All comments are QEMU oriented.
> >=20
> >=20
> > 1) Working offline
> >=20
> > Various people complained Avocado requires online access, and they woul=
d
> > like to use it offline.
> >=20
> >   Maintainer workflow example is:
> >=20
> >   - run avocado
> >   - hack QEMU, build
> >   - git pull
> >   - build
> >   - hack QEMU
> >   (go offline)
> >   - hack QEMU
> >   - build
> >   - run avocado <- FAILS
> >=20
>=20
> Ouch.  This shouldn't happen even with no explicit --offline
> option.  Failure to download artifacts shouldn't make tests
> report failure.
>=20
>

Agreed.  There are a number of work items already to cover this.  One
is a more generic test metadata collection system:

   https://trello.com/c/lumR8u8Y/1526-rfc-nrunner-extended-metadata

We already have code that can find the required assets, and with that,
we can let the job (not the test) attempt to fulfill those
requirements, skipping the tests if they can not be fulfilled.

Until this is available, we can wrap the "fetch_asset()" calls and
cancel the test if it fails.

> > Failure is because mainstream added new tests, which got pulled in, and=
 the
> > user only notice when running avocado again, but offline.
> > Test example is boot_linux_console.py, which added various tests from o=
ther
> > subsystems, so the maintainer has to disable the new tests manually to =
be
> > able to run his previous tests.
> >=20
> > Expected solution: skip tests when artifact is not available, eventuall=
y
> > when the --offline option is used
> >=20
> >=20
> > 2) Add artifacts manually to the cache
> >=20
> > Not all artifacts can be easily downloadable, some are public but requi=
re
> > the user to accept an End User License Agreement.
> > Users would like to share their tests with the documentation about wher=
e/how
> > to download the requisite files (accepting the EULA) to run the tests.
> >=20
> >=20
> > 2b) Add reference to artifact to the cache
> >=20
> > Group of users might share group of files (like NFS storage) and would =
like
> > to use directly their remote read-only files, instead of copying it to =
their
> > home directory.
>=20
> This sounds nice and useful, but I don't know how to make the
> interface for this usable.
>=20
>

I guess this would require an Avocado installation-wide configuration
entry for the available cache directories.  IMO given that
configuration is applied, the tests should transparently find assets
in the configured locations.

> >=20
> >=20
> > 3) Provide qemu/avocado-qemu Python packages
> >=20
> > The mainstream project uses Avocado to test QEMU. Others projects use Q=
EMU
> > to test their code, and would like to automatize that using Avocado. Th=
ey
> > usually not rebuild QEMU but use a stable binary from distributions. Th=
e
> > python classes are not available, so they have to clone QEMU to use Avo=
cado
> > (I guess they only need 5 python files).
> > When running on Continuous Integration, this is overkill, because when =
you
> > clone QEMU you also clone various other submodules.
>=20
> I only have one concern, here: I don't think we have the
> bandwidth to start maintaining a stable external Python API.
> Users of those packages will need to be aware that future
> versions of the modules might have incompatible APIs.
>

My understanding is that we would publish those files as a Python
module with versions matching QEMU.  No stability would be promised.
Users can always require a specific version of the Python module that
matches the QEMU version they expect/want to use.

> >=20
> >=20
> > 4) Warn the user when Avocado is too old for the tests
> >=20
> > Some users tried Avocado following the examples on the mailing list and=
 the
> > one in some commit's descriptions where we simply show "avocado run ...=
".
>=20
> Oops.
>
> > They installed the distribution Avocado package and tried and it fails =
for
> > few of them with no obvious reason (the .log file is hard to read when =
you
> > are not custom to). IIUC their distribution provides a older Avocado (6=
9?)
> > while we use recent features (72).
> >=20
> > We never noticed it because we use 'make check-venv' and do not test th=
e
> > distrib Avocado. While we can not test all distribs, we could add a ver=
sion
> > test if the Avocado version is too old, display a friendly message to t=
he
> > console (not the logfile).
>=20
> Sounds like a good idea.
>

A simpler (complementary?) solution, or maybe just a good practice, is
to try to use in the examples:

  "./tests/venv/bin/avocado run ..."

Do you think this would be enough?  It would of course not cover the
examples in previous commit messages.

Thanks!
- Cleber.

> >=20
> >=20
> > That it for my notes.
> >=20
> > Eduardo/Wainer, are there other topics I forgot?
>=20
> I don't remember anything specific right now.  Thanks again!
>=20
> --=20
> Eduardo


