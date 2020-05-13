Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CABDC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 15:38:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68432205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 15:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ue95rS0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68432205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYtSb-0004vN-BD
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 11:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jYtRy-0004M6-7Q
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:37:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45688
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jYtRw-0003gy-Pp
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589384255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u54vhko4ropn4BzRKdydUEAIzcpDoaucLbLzYZ/ab4E=;
 b=Ue95rS0tEM76wvXQYEWoQg7TZl5lgmepEZEoIGDOW5t3QaefJFtueAiOGoGyz1EgJnRHoA
 ygu7hRqgos2Ua/wPrxKk8vVcG7xKcOyDm8kMaHxKhuJScsm6LlmaQqV1Xf0+2cVXsj6ksF
 atwIKO/6eeTgrDubCTZEg9DHWI4ACF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-pGuygLHDNda2OmSGqmKZlw-1; Wed, 13 May 2020 11:37:33 -0400
X-MC-Unique: pGuygLHDNda2OmSGqmKZlw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 663B58015CF;
 Wed, 13 May 2020 15:37:32 +0000 (UTC)
Received: from localhost (unknown [10.40.208.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AEA305C1BB;
 Wed, 13 May 2020 15:37:28 +0000 (UTC)
Date: Wed, 13 May 2020 17:37:25 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Roman Kagan <rvkagan@yandex-team.ru>
Subject: Re: [PATCH v4 5/6] i386: Hyper-V VMBus ACPI DSDT entry
Message-ID: <20200513173725.277b0e16@redhat.com>
In-Reply-To: <20200511201106.GB1307176@rvkaganb.lan>
References: <20200424123444.3481728-1-arilou@gmail.com>
 <20200424123444.3481728-6-arilou@gmail.com>
 <20200505150637.7131e79b@redhat.com>
 <20200505153838.GC2862@jondnuc>
 <30fea22b-ef36-04d9-17ef-d13e3f93a3c5@maciej.szmigiero.name>
 <20200507031425.GG2862@jondnuc>
 <20200511201106.GB1307176@rvkaganb.lan>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 01:56:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, eyakovlev@virtuozzo.com,
 Jon Doron <arilou@gmail.com>, qemu-devel@nongnu.org, liran.alon@oracle.com,
 Roman Kagan <rkagan@virtuozzo.com>, pbonzini@redhat.com, vkuznets@redhat.com,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 11 May 2020 23:11:23 +0300
Roman Kagan <rvkagan@yandex-team.ru> wrote:

> On Thu, May 07, 2020 at 06:14:25AM +0300, Jon Doron wrote:
> > Igor it seems like the IRQ being used is 5 and not 7 & 13 like in the
> > current patch. =20
>=20
> HyperV using irq 5 doesn't mean QEMU has to too.  Especially so as no
> guest was noticed to use the irqs in ACPI.  I'd rather try and test if
> the guest requires any those at all.
>=20
> > Seems like it needs to reside in the _CRS like you said. =20
>=20
> They already are there.
>=20
> > Seems like it has all those _STA/_DIS/_PS0 just like the way it's curre=
ntly
> > in the patch (unless I'm missing something). =20
>=20
> Right, but, as you can see, they are pretty dumb, so the question is
> whether they are necessary or the guests can do without (Linux
> apparently can).

Agreed with all of above,
Instead of blind copying dubious AML, we should try to figure out what's
really necessary of it and throw away the rest.

>=20
> Thanks,
> Roman.
>=20
> > Notice _PS3 is not a Method.
> >=20
> > So just to summarize the changes i need to do:
> > 1. Change from 2 IRQs to single one (and use 5 as the default)
> > 2. IRQs needs to be under _CRS.
> > 3. You mentioned you want under a different location than the ISA bug w=
here
> > would you want it to be?
> >=20
> > Please let me know if there is anything else.
> >=20
> > Thanks,
> > -- Jon.
> >=20
> > On 06/05/2020, Maciej S. Szmigiero wrote: =20
> > > On 05.05.2020 17:38, Jon Doron wrote: =20
> > > > On 05/05/2020, Igor Mammedov wrote:
> > > >=20
> > > > I dont know what were the original intentions of the original patch=
 authors (at this point I simply rebased it, and to be honest I did not nee=
d this patch to get where I was going to, but it was part of the original p=
atchset).
> > > >=20
> > > > But I'm willing to do any changes so we can keep going forward with=
 this.
> > > >  =20
> > > > > On Fri, 24 Apr 2020 15:34:43 +0300
> > > > > Jon Doron <arilou@gmail.com> wrote:
> > > > >  =20
> > > > > > Guest OS uses ACPI to discover VMBus presence.=C3=82=C2=A0 Add =
a corresponding
> > > > > > entry to DSDT in case VMBus has been enabled.
> > > > > >=20
> > > > > > Experimentally Windows guests were found to require this entry =
to
> > > > > > include two IRQ resources. They seem to never be used but they =
still
> > > > > > have to be there.
> > > > > >=20
> > > > > > Make IRQ numbers user-configurable via corresponding properties=
; use 7
> > > > > > and 13 by default. =20
> > > > > well, it seems that at least linux guest driver uses one IRQ,
> > > > > abeit not from ACPI descriptior
> > > > >=20
> > > > > perhaps it's what hyperv host puts into _CRS.
> > > > > Could you dump ACPI tables and check how hyperv describes vmbus i=
n acpi?
> > > > >=20
> > > > >  =20
> > > >=20
> > > > I can no longer get to the HyperV computer I had (in the office so =
hopefully if someone else has access to HyperV machine and willing to reply=
 here with the dumped ACPI tables that would be great).
> > > >  =20
> > >=20
> > > Here is a VMBus ACPI device description from Hyper-V in Windows Serve=
r 2019:
> > >=20
> > > Device (\_SB.VMOD.VMBS)
> > > {
> > >    Name (STA, 0x0F)
> > >    Name (_ADR, Zero)  // _ADR: Address
> > >    Name (_DDN, "VMBUS")  // _DDN: DOS Device Name
> > >    Name (_HID, "VMBus")  // _HID: Hardware ID
> > >    Name (_UID, Zero)  // _UID: Unique ID
> > >    Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
> > >    {
> > > =09STA &=3D 0x0D
> > >    }
> > >=20
> > >    Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
> > >    {
> > > =09STA |=3D 0x0F
> > >    }
> > >=20
> > >    Method (_STA, 0, NotSerialized)  // _STA: Status
> > >    {
> > > =09Return (STA) /* \_SB_.VMOD.VMBS.STA_ */
> > >    }
> > >=20
> > >    Name (_PS3, Zero)  // _PS3: Power State 3
> > >    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Setting=
s
> > >    {
> > > =09IRQ (Edge, ActiveHigh, Exclusive, )
> > > =09    {5}
> > >    })
> > > }
> > >=20
> > > It seems to use just IRQ 5.
> > >=20
> > > Maciej =20
> >  =20
>=20


