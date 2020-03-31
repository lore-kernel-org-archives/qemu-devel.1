Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC31C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 19:54:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A17B2080C
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 19:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPHriLZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A17B2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJMyL-0002k9-LL
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 15:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49385)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jJMx8-0001qw-6o
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 15:53:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jJMx5-0002MF-H1
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 15:53:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55331
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jJMx5-0002Kv-8M
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 15:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585684414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A8RLnm05BD16LAcVFXf/3t6xDIQAvMVhL0LeemNs5ek=;
 b=iPHriLZ4LeaLbnLkMfXm+0jkRgtVVQsl5Ud18R+yjN68feRBKskRfU6vsCjgX/0f4KqChj
 +qFilL2RMJvwBpUbJgJOkc6Ylx1zU00bnWKeRJPH+a9/GKVQ3pvWcX+HP/ON1HePLvNqQm
 ezeBnrE80evnf88d0fwjvoNZ8lavpxE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-doqS1DTcMiqTUmshwHszWg-1; Tue, 31 Mar 2020 15:53:32 -0400
X-MC-Unique: doqS1DTcMiqTUmshwHszWg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4CEE800D5C;
 Tue, 31 Mar 2020 19:53:30 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8484D767E;
 Tue, 31 Mar 2020 19:53:22 +0000 (UTC)
Date: Tue, 31 Mar 2020 21:53:20 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 5/6] acpi: serial: don't use _STA method
Message-ID: <20200331215320.620c52bf@redhat.com>
In-Reply-To: <20200331152342.vdfhosgpi6popy2x@sirius.home.kraxel.org>
References: <20200327121111.1530-1-kraxel@redhat.com>
 <20200327121111.1530-6-kraxel@redhat.com>
 <20200327153340.519fac3f@redhat.com>
 <20200331152342.vdfhosgpi6popy2x@sirius.home.kraxel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 31 Mar 2020 17:23:42 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> > > -static Aml *build_com_device_aml(uint8_t uid)
> > > +static void build_com_device_aml(Aml *scope, uint8_t uid)
> > >  {
> > >      Aml *dev;
> > >      Aml *crs;
> > > -    Aml *method;
> > > -    Aml *if_ctx;
> > > -    Aml *else_ctx;
> > > -    Aml *zero = aml_int(0);
> > > -    Aml *is_present = aml_local(0);
> > > -    const char *enabled_field = "CAEN";
> > >      uint8_t irq = 4;
> > >      uint16_t io_port = 0x03F8;
> > >  
> > >      assert(uid == 1 || uid == 2);
> > >      if (uid == 2) {
> > > -        enabled_field = "CBEN";
> > >          irq = 3;
> > >          io_port = 0x02F8;
> > >      }
> > > +    if (!memory_region_present(get_system_io(), io_port)) {  
> >                                   ^^^^^^
> > even though acpi_setup() is a part of board code, usually it's not recommended to 
> > use get_system_foo() outside of machine_init()
> > 
> > how about fishing out present serial ports from isa device in a helper
> > like acpi_get_misc_info(), and then generalize AML like
> >    build_com_device_aml(Aml *scope, uint8_t uid, io_port, irq)  
> 
> Hmm, I'm wondering whenever it would be useful to have ...
> 
>    ISADeviceClass->build_aml(Aml *scope, ISADevice *dev);

in relation to iqr, you said earlier that device doesn't know to which irq it's mapped.
that might be a problem in this case, likewise for (MM)IO

> ... then just walk all isa devices and call the handler
> (if present).  Maybe the same for sysbus.

There was already such idea (Paolo or Michael), i.e. to move AML code
generation related to specific devices inside of device model (not
only ISA or sysbus), so one would just have to enumerate present
devices in generic way and ask them to provide AML descriptors and be
done with building DSDT.

Not sure if it's doable in generic way though, especially when it comes to
orchestrating _CRS between various devices.
(while linux might still boot with resource conflicts, Windows 
BSODs occasionally instead). Maybe there are other complications
I don't recall.

So it might take awhile to come up with approach which would work nice.

Simplest way to get job done in case of microvm is to make board
fill in assigned resources in some helper data structure and pass that
to acpi code. (another approach - arm/virt uses static 'registry' to distribute
address space/irq and then acpi code just fetches values from there if
device is present + a bunch of shared PCI code to make up dynamic PCI
description)

> cheers,
>   Gerd
> 


