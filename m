Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A4CC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 19:29:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F8502168B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 19:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8502168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5EUM-0008I0-6E
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 15:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1i5ETE-0007pL-4Y
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 15:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1i5ETB-00041s-N8
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 15:28:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40754)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1i5ETB-000419-Hk
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 15:28:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4CEB518AF895;
 Tue,  3 Sep 2019 19:28:00 +0000 (UTC)
Received: from localhost (ovpn-116-55.gru2.redhat.com [10.97.116.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D9C315C21A;
 Tue,  3 Sep 2019 19:27:59 +0000 (UTC)
Date: Tue, 3 Sep 2019 16:27:58 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190903192758.GA19758@habkost.net>
References: <20190828184026.5840-1-ehabkost@redhat.com>
 <CAFEAcA-AvFS2cbDH-t5SxgY9hA=LGL81_8dn-vh193vtV9W1Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFEAcA-AvFS2cbDH-t5SxgY9hA=LGL81_8dn-vh193vtV9W1Lg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Tue, 03 Sep 2019 19:28:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL v6 00/12] Machine + x86 queue, 2019-08-28
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 03, 2019 at 04:03:54PM +0100, Peter Maydell wrote:
> On Wed, 28 Aug 2019 at 19:40, Eduardo Habkost <ehabkost@redhat.com> wro=
te:
> >
> > Sorry for taking so long after 4.1.0 to send this.  I had to sort
> > out some conflicts with recent header cleanups.
> >
> > The following changes since commit 23919ddfd56135cad3cb468a8f54d5a595=
f024f4:
> >
> >   Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-2019082=
7' into staging (2019-08-27 15:52:36 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
> >
> > for you to fetch changes up to f4abcc0a75f1310dbe66b852ed97ec7caf2708=
d5:
> >
> >   i386/vmmouse: Properly reset state (2019-08-27 16:50:14 -0300)
> >
> > ----------------------------------------------------------------
> > Machine + x86 queue, 2019-08-28
> >
> > Bug fixes:
> > * Fix die-id validation regression (Eduardo Habkost)
> > * vmmouse: Properly reset state (Jan Kiszka)
> > * hostmem-file: fix pmem file size check (Stefan Hajnoczi)
> >
> > Cleanups:
> > * NUMA code cleanups (Tao Xu)
> > * Remove stale externs from includes (Alex Benn=E9e)
> >
> > Features:
> > * qapi: report the default CPU type for each machine (Daniel P. Berra=
ng=E9)
> >
> > ----------------------------------------------------------------
>=20
> Hi. This generates extra warnings during 'make check'
> that all look like:
>=20
> qemu-system-ppc64: warning: Default splitting of RAM between nodes is
> deprecated, Use '-numa node,memdev' to explictly define RAM allocation
> per node
>=20
> Can you suppress them, please (or fix them if they are
> legitimate)?

I'm removing the patch that causes the spurious warnings, and
I'll send a new pull request soon.

--=20
Eduardo

