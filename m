Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AD0C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 14:56:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D89320781
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 14:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/l46ybJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D89320781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFJ46-0001Oz-46
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 10:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jFJ3G-0000nM-VZ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jFJ3E-0002aE-MW
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:55:10 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:41709)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jFJ3E-0002Xs-IN
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584716107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gmy8Jyk7jCQ5s4ZmTl4sevzlWrK45wSmOumju3DXl0M=;
 b=I/l46ybJxC/Alh4g3bwaJ4nj3U/Rbouiuz0PtCRMoDYQWqsKL+JkVRpnjQcYv6+rgduica
 TUv2a6h170L2Zjzgm8sfVULINw3gWja5GIhaMa6+CgCw4ZRpKvX4wPwySbmsL2AzSYXvTs
 UjGOqbHIXPRznbh1Bs3/qbx+xhoZH/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-cGjff7zWMXypVYnqntgBVw-1; Fri, 20 Mar 2020 10:55:05 -0400
X-MC-Unique: cGjff7zWMXypVYnqntgBVw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43E03800D4E;
 Fri, 20 Mar 2020 14:55:04 +0000 (UTC)
Received: from localhost (unknown [10.40.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEFC99B91E;
 Fri, 20 Mar 2020 14:54:35 +0000 (UTC)
Date: Fri, 20 Mar 2020 15:54:33 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 03/13] microvm: add isa-acpi device
Message-ID: <20200320155433.68461e7b@redhat.com>
In-Reply-To: <20200320082258.fm4prxr6fac336ua@sirius.home.kraxel.org>
References: <20200319080117.7725-1-kraxel@redhat.com>
 <20200319080117.7725-4-kraxel@redhat.com>
 <20200319144218.5d2f8fd3@redhat.com>
 <20200320082258.fm4prxr6fac336ua@sirius.home.kraxel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Mar 2020 09:22:58 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Thu, Mar 19, 2020 at 02:42:18PM +0100, Igor Mammedov wrote:
> > On Thu, 19 Mar 2020 09:01:07 +0100
> > Gerd Hoffmann <kraxel@redhat.com> wrote:
> >  =20
> > > Minimal ACPI device for PCI-less machines like microvm. =20
> > it seems that x86 kernel is able to boot on hw-reduced acpi systems
> > (but I haven't really tested any distro kernel, not sure how usable NEM=
U is)
> >=20
> > Maybe reusing hw/acpi/generic_event_device.c (which was borrowed
> > for NEMU effort) would be better since guest won't have to initialize
> > not necessary interfaces and QEMU could implement simpler hw impl
> > compared to full ACPI with GPEs, SCIs & co. =20
>=20
> I see the generic event device has support for powerdown request events,
> good.  But I'm wondering how entering S5 state (aka poweroff) would
> work then?


Relevant parts from spec:
ACPI6.1:
16.1.7 Transitioning from the Working to the Soft Off State
...
4.
or writes the HW-reduced ACPI Sleep Type value for S5 and the SLP_EN bit to=
 the
Sleep Control Register.

4.8.3.7 Sleep Control and Status Registers

in kernel handled by acpi_hw_extended_sleep()


From QEMU:

build_fadt_rev5()
  build_fadt()
    ...
    /* SLEEP_CONTROL_REG */
    build_append_gas(tbl, AML_AS_SYSTEM_MEMORY, 0 , 0, 0, 0);
    /* SLEEP_STATUS_REG */
    build_append_gas(tbl, AML_AS_SYSTEM_MEMORY, 0 , 0, 0, 0);
    ...
    this is what board should implement (we cloud add an optional MMIO regi=
ster to
    GED to hanlde shutdown on QEMU side)
    (ARM doesn't use it as it's using arch specific, PSCI method to shutdow=
n machine),
    I'd add relevant fields to AcpiFadtData, fill it in build_fadt_rev5() a=
nd use them in build_fadt()


virt_powerdown_req()
  acpi_send_event(s->acpi_dev, ACPI_POWER_DOWN_STATUS)

triggers in guest AML generated by:

acpi_dsdt_add_power_button()

build_ged_aml()
  ...ACPI_POWER_BUTTON_DEVICE... -> tells OSPM to do 16.1.7 using 4.8.3.7




>=20
> cheers,
>   Gerd
>=20
>=20


