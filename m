Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1953CC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:02:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58268208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 16:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58268208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIatT-00066f-0a
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 12:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iIapW-0004q1-R5
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:58:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iIapU-0002cl-Ty
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:58:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25452)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iIapU-0002cB-JY
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 11:58:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CD4FA801661;
 Thu, 10 Oct 2019 15:58:15 +0000 (UTC)
Received: from Igors-MacBook-Pro (unknown [10.36.112.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0CFA65E7B2;
 Thu, 10 Oct 2019 15:57:58 +0000 (UTC)
Date: Thu, 10 Oct 2019 17:57:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 0/3] acpi: cphp: add CPHP_GET_CPU_ID_CMD command to cpu
 hotplug MMIO interface
Message-ID: <20191010175754.7c62cf8f@Igors-MacBook-Pro>
In-Reply-To: <20191010095459-mutt-send-email-mst@kernel.org>
References: <20191009132252.17860-1-imammedo@redhat.com>
 <20191010055356-mutt-send-email-mst@kernel.org>
 <20191010153815.4f7a3fc9@redhat.com>
 <20191010095459-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Thu, 10 Oct 2019 15:58:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?UTF-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 10 Oct 2019 09:59:42 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Oct 10, 2019 at 03:39:12PM +0200, Igor Mammedov wrote:
> > On Thu, 10 Oct 2019 05:56:55 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >=20
> > > On Wed, Oct 09, 2019 at 09:22:49AM -0400, Igor Mammedov wrote:
> > > > As an alternative to passing to firmware topology info via new fwcf=
g files
> > > > so it could recreate APIC IDs based on it and order CPUs are enumer=
ated,
> > > >=20
> > > > extend CPU hotplug interface to return APIC ID as response to the n=
ew command
> > > > CPHP_GET_CPU_ID_CMD. =20
> > >=20
> > > One big piece missing here is motivation:
> > I thought the only willing reader was Laszlo (who is aware of context)
> > so I skipped on details and confused others :/
> >=20
> > > Who's going to use this interface?
> > In current state it's for firmware, since ACPI tables can cheat
> > by having APIC IDs statically built in.
> >=20
> > If we were creating CPU objects in ACPI dynamically
> > we would be using this command as well.
>=20
> I'm not sure how it's even possible to create devices dynamically. Well
> I guess it's possible with LoadTable. Is this what you had in
> mind?

Yep. I even played this shiny toy and I can say it's very tempting one.
On the  other side, even problem of legacy OSes not working with it aside,
it's hard to debug and reproduce compared to static tables.
So from maintaining pov I dislike it enough to be against it.


> > It would save
> > us quite a bit space in ACPI blob but it would be a pain
> > to debug and diagnose problems in ACPI tables, so I'd rather
> > stay with static CPU descriptions in ACPI tables for the sake
> > of maintenance.
> > > So far CPU hotplug was used by the ACPI, so we didn't
> > > really commit to a fixed interface too strongly.
> > >=20
> > > Is this a replacement to Laszlo's fw cfg interface?
> > > If yes is the idea that OVMF going to depend on CPU hotplug directly =
then?
> > > It does not depend on it now, does it?
> > It doesn't, but then it doesn't support cpu hotplug,
> > OVMF(SMM) needs to cooperate with QEMU "and" ACPI tables to perform
> > the task and using the same interface/code path between all involved
> > parties makes the task easier with the least amount of duplicated
> > interfaces and more robust.
> >=20
> > Re-implementing alternative interface for firmware (fwcfg or what not)
> > would work as well, but it's only question of time when ACPI and
> > this new interface disagree on how world works and process falls
> > apart.
>=20
> Then we should consider switching acpi to use fw cfg.
> Or build another interface that can scale.

Could be an option, it would be a pain to write a driver in AML for fwcfg a=
ccess though
(I've looked at possibility to access fwcfg from AML about a year ago and g=
ave up.
I'm definitely not volunteering for the second attempt and can't even give =
an estimate
it it's viable approach).

But what scaling issue you are talking about, exactly?
With current CPU hotplug interface we can handle upto UNIT32_MAX cpus, and =
extend
interface without need to increase IO window we are using now.

Granted IO access it not fastest compared to fwcfg in DMA mode, but we alre=
ady
doing stop machine when switching to SMM which is orders of magnitude slowe=
r.
Consensus was to compromise on speed of CPU hotplug versus more complex and=
 more
problematic unicast SMM mode in OVMF (can't find a particular email but we =
have discussed
it with Laszlo already, when I considered ways to optimize hotplug speed)

> > > If answers to all of the above is yes, then I don't really like it: it
> > > is better to keep all paravirt stuff in one place, namely in fw cfg.
> > Lets discuss, what cpu hotplug fwcfg interface could look like in=20
> >  [PATCH 3/4] hw/i386: add facility to expose CPU topology over  fw-cfg
> > mail thread and clarify (dis)likes with concrete reasons.
> >=20
> > So far I managed to convince myself that we ought to reuse
> > and extend current CPU hotplug interface with firmware features,
> > to endup with consolidated cpu hotplug process without
> > introducing duplicate ABIs, but I could be wrong so
> > lets see if fwcfg will be the better approach.
> >=20
> > =20
> > > > CC: Laszlo Ersek <lersek@redhat.com>
> > > > CC: Eduardo Habkost <ehabkost@redhat.com>
> > > > CC: "Michael S. Tsirkin" <mst@redhat.com>
> > > > CC: Gerd Hoffmann <kraxel@redhat.com>
> > > > CC: Paolo Bonzini <pbonzini@redhat.com>
> > > > CC: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > > > CC: Richard Henderson <rth@twiddle.net>
> > > > =20
> > > > Igor Mammedov (3):
> > > >   acpi: cpuhp: fix 'Command data' description is spec
> > > >   acpi: cpuhp: add typical usecases into spec
> > > >   acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command
> > > >=20
> > > >  docs/specs/acpi_cpu_hotplug.txt | 37 +++++++++++++++++++++++++++++=
+---
> > > >  hw/acpi/cpu.c                   | 15 +++++++++++++
> > > >  hw/acpi/trace-events            |  1 +
> > > >  3 files changed, 50 insertions(+), 3 deletions(-)
> > > >=20
> > > > --=20
> > > > 2.18.1 =20
> > >=20
>=20


