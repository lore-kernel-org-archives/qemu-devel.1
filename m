Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F0AC10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 14:00:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 696CA208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 14:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696CA208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIYzj-0000w2-KI
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 10:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iIYyv-0000Mx-6p
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iIYyu-0005CZ-0l
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:59:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46540)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iIYyt-0005CB-Nt
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:59:51 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D8B9146671
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 13:59:50 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id m19so5834483qtm.13
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 06:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=PmSBLJc/RPTgDhjFpdk7JsB5kksLvl51aABljQ1ogYo=;
 b=TDON6AbV6JcAx5YnlK1LbyaDbcLi0wrjodqRYIQrDqQvefD9AQlQgqWkDsySoWHDDc
 rTet16nWIH+qlNJMP4FPzbbWE8IpQ4hYowwnrzjrd6ClGwWQozjC7jIiyt+KGo1fjOGz
 0b0LY0uxemv/jbg1akWr+3Hn8XJwdS7dmQMuSav6DLvHsRyqBudEmcmWhrYmM+9+bMS5
 Y1DXBVahYzMxNwKLBIYs0YHh7Y7/Iz4Gif9DrQS79HBUMkMWKL5Q7AGPxUZnq+aPUsSz
 crM5Ga170ek7NUQyOUkX5w2gg6GO/y64k7XfRYWBbTMeK3GH3nYDscxk0TXZ+HM2OJ0U
 brnQ==
X-Gm-Message-State: APjAAAWV5X5zdvVmmRH7VF17jNzODyaMM8J9gquk9NAvu+fIdYkpgpNJ
 Mv3VHdsdEUIFICxssW0kCYdgI4qY2FwuJT5veln4cNNeJKfyV2pjZgbV8yB3NGW9ar8wBylsRqi
 Z1WdJjBsUv7KO8Q8=
X-Received: by 2002:a37:a6d0:: with SMTP id
 p199mr10047744qke.204.1570715990068; 
 Thu, 10 Oct 2019 06:59:50 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzsrpZea1l72o4c6NH0Aph6yMfr0QermgvQmllc08bU5kZ5qk2rtJLMz7Jjfr5FPdAk2H1/5w==
X-Received: by 2002:a37:a6d0:: with SMTP id
 p199mr10047722qke.204.1570715989729; 
 Thu, 10 Oct 2019 06:59:49 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 n125sm2723452qkn.129.2019.10.10.06.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2019 06:59:48 -0700 (PDT)
Date: Thu, 10 Oct 2019 09:59:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [RFC 0/3] acpi: cphp: add CPHP_GET_CPU_ID_CMD command to cpu
 hotplug MMIO interface
Message-ID: <20191010095459-mutt-send-email-mst@kernel.org>
References: <20191009132252.17860-1-imammedo@redhat.com>
 <20191010055356-mutt-send-email-mst@kernel.org>
 <20191010153815.4f7a3fc9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20191010153815.4f7a3fc9@redhat.com>
Content-Transfer-Encoding: quoted-printable
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
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 10, 2019 at 03:39:12PM +0200, Igor Mammedov wrote:
> On Thu, 10 Oct 2019 05:56:55 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>=20
> > On Wed, Oct 09, 2019 at 09:22:49AM -0400, Igor Mammedov wrote:
> > > As an alternative to passing to firmware topology info via new fwcf=
g files
> > > so it could recreate APIC IDs based on it and order CPUs are enumer=
ated,
> > >=20
> > > extend CPU hotplug interface to return APIC ID as response to the n=
ew command
> > > CPHP_GET_CPU_ID_CMD. =20
> >=20
> > One big piece missing here is motivation:
> I thought the only willing reader was Laszlo (who is aware of context)
> so I skipped on details and confused others :/
>=20
> > Who's going to use this interface?
> In current state it's for firmware, since ACPI tables can cheat
> by having APIC IDs statically built in.
>=20
> If we were creating CPU objects in ACPI dynamically
> we would be using this command as well.

I'm not sure how it's even possible to create devices dynamically. Well
I guess it's possible with LoadTable. Is this what you had in
mind?


> It would save
> us quite a bit space in ACPI blob but it would be a pain
> to debug and diagnose problems in ACPI tables, so I'd rather
> stay with static CPU descriptions in ACPI tables for the sake
> of maintenance.
> > So far CPU hotplug was used by the ACPI, so we didn't
> > really commit to a fixed interface too strongly.
> >=20
> > Is this a replacement to Laszlo's fw cfg interface?
> > If yes is the idea that OVMF going to depend on CPU hotplug directly =
then?
> > It does not depend on it now, does it?
> It doesn't, but then it doesn't support cpu hotplug,
> OVMF(SMM) needs to cooperate with QEMU "and" ACPI tables to perform
> the task and using the same interface/code path between all involved
> parties makes the task easier with the least amount of duplicated
> interfaces and more robust.
>=20
> Re-implementing alternative interface for firmware (fwcfg or what not)
> would work as well, but it's only question of time when ACPI and
> this new interface disagree on how world works and process falls
> apart.

Then we should consider switching acpi to use fw cfg.
Or build another interface that can scale.

> > If answers to all of the above is yes, then I don't really like it: i=
t
> > is better to keep all paravirt stuff in one place, namely in fw cfg.
> Lets discuss, what cpu hotplug fwcfg interface could look like in=20
>  [PATCH 3/4] hw/i386: add facility to expose CPU topology over  fw-cfg
> mail thread and clarify (dis)likes with concrete reasons.
>=20
> So far I managed to convince myself that we ought to reuse
> and extend current CPU hotplug interface with firmware features,
> to endup with consolidated cpu hotplug process without
> introducing duplicate ABIs, but I could be wrong so
> lets see if fwcfg will be the better approach.
>=20
> =20
> > > CC: Laszlo Ersek <lersek@redhat.com>
> > > CC: Eduardo Habkost <ehabkost@redhat.com>
> > > CC: "Michael S. Tsirkin" <mst@redhat.com>
> > > CC: Gerd Hoffmann <kraxel@redhat.com>
> > > CC: Paolo Bonzini <pbonzini@redhat.com>
> > > CC: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > > CC: Richard Henderson <rth@twiddle.net>
> > > =20
> > > Igor Mammedov (3):
> > >   acpi: cpuhp: fix 'Command data' description is spec
> > >   acpi: cpuhp: add typical usecases into spec
> > >   acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command
> > >=20
> > >  docs/specs/acpi_cpu_hotplug.txt | 37 +++++++++++++++++++++++++++++=
+---
> > >  hw/acpi/cpu.c                   | 15 +++++++++++++
> > >  hw/acpi/trace-events            |  1 +
> > >  3 files changed, 50 insertions(+), 3 deletions(-)
> > >=20
> > > --=20
> > > 2.18.1 =20
> >=20

