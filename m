Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F006C04AB4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 17:01:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAAC220815
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 17:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAAC220815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32965 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRJlN-0002YJ-QZ
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 13:01:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hRJkW-00029n-5T
	for qemu-devel@nongnu.org; Thu, 16 May 2019 13:00:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hRJkU-00036k-AG
	for qemu-devel@nongnu.org; Thu, 16 May 2019 13:00:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>)
	id 1hRJkN-00030L-5p; Thu, 16 May 2019 13:00:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 277C130BDE5D;
	Thu, 16 May 2019 17:00:45 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E93315D9C4;
	Thu, 16 May 2019 17:00:38 +0000 (UTC)
Date: Thu, 16 May 2019 19:00:33 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Message-ID: <20190516190033.6c8d382f@redhat.com>
In-Reply-To: <CAP+75-XHpLkekrmSxK8FFGkpPJQH=V0+2d6RonQTyJNcSHGaEg@mail.gmail.com>
References: <20190419003053.8260-1-richardw.yang@linux.intel.com>
	<20190419003053.8260-7-richardw.yang@linux.intel.com>
	<20190514211015-mutt-send-email-mst@kernel.org>
	<d9d265e1-1052-9d8d-c749-5d1e5901f567@redhat.com>
	<20190516074110.GA11938@richard>
	<CAP+75-XHpLkekrmSxK8FFGkpPJQH=V0+2d6RonQTyJNcSHGaEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Thu, 16 May 2019 17:00:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 6/6] acpi: pci: use build_append_foo()
 API to construct MCFG
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
Cc: Yang Zhong <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
	"Michael
	S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
	Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 May 2019 13:01:31 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On Thu, May 16, 2019 at 9:41 AM Wei Yang <richardw.yang@linux.intel.com> =
wrote:
> >
> > On Wed, May 15, 2019 at 07:29:17AM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote: =20
> > >
> > >Thanks Michael for testing...
> > >
> > >Wei, can you add a MCFG test in tests/bios-tables-test.c?
> > > =20
> >
> > I took a look into the test, current q35 has already has a reference MC=
FG in
> > tests/data/acpi/q35/MCFG.
> >
> > And there would be a warning message when reserved[8] is missed.
> >
> >     /x86_64/acpi/q35/bridge: acpi-test: Warning! MCFG mismatch.
> >
> > Is this enough? Or what more information prefer to add? =20
>=20
> Well, the test has to fail for any mismatch (not a simple warning).
>=20
> A mismatch failure seems to be enough IMHO.
Warning is sufficient, we do not fail ACPI tests on mismatch.
It was a policy decision for APCI tests as far as I remember.
We might reconsider it in the future but it shouldn't affect this patch.


>=20
> > >>> -    AcpiMcfgAllocation allocation[0];
> > >>> -} QEMU_PACKED;
> > >>> -typedef struct AcpiTableMcfg AcpiTableMcfg;
> > >>> -
> > >>>  /*
> > >>>   * TCPA Description Table
> > >>>   *
> > >>> --
> > >>> 2.19.1 =20
> >
> > --
> > Wei Yang
> > Help you, Help me =20
>=20


