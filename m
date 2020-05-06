Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6DEC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 11:47:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E31206D5
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 11:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eG8/p+t0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E31206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWIWX-0007ti-5K
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 07:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jWIVm-0007GF-5F
 for qemu-devel@nongnu.org; Wed, 06 May 2020 07:46:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51056
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jWIVl-0003I7-4S
 for qemu-devel@nongnu.org; Wed, 06 May 2020 07:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588765607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rNwbRdcjy134DSQmFIXGl0rUXTqfFhwOaIAGdon8tXo=;
 b=eG8/p+t05/YCinMJ779tTkvZ+1Gh09ZV1lnqtAWnZAnL53j8l/ap2YcHOowt3JX4m2jhNJ
 QRLD8b7eywbLHXqL+rjG+SA794WT4kNfW7kt886VCZYo53kjhs2fiCWMjI7k0g81rBjuGu
 CskbEBH4FQ9DkqMFbQ8oo8wUY8LyL6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-5JlkDANXO2axYwiJbxQzyQ-1; Wed, 06 May 2020 07:46:45 -0400
X-MC-Unique: 5JlkDANXO2axYwiJbxQzyQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C54A6835B46;
 Wed,  6 May 2020 11:46:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 412305D9DA;
 Wed,  6 May 2020 11:46:36 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 370891747D; Wed,  6 May 2020 13:46:35 +0200 (CEST)
Date: Wed, 6 May 2020 13:46:35 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 00/13] microvm: add acpi support
Message-ID: <20200506114635.b5msujuhhbim2kdv@sirius.home.kraxel.org>
References: <20200505134305.22666-1-kraxel@redhat.com>
 <20200505100010-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200505100010-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 02:39:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 05, 2020 at 10:04:02AM -0400, Michael S. Tsirkin wrote:
> On Tue, May 05, 2020 at 03:42:52PM +0200, Gerd Hoffmann wrote:
> > I know that not supporting ACPI in microvm is intentional.  If you stil=
l
> > don't want ACPI this is perfectly fine, you can use the usual -no-acpi
> > switch to toggle ACPI support.
> >=20
> > These are the advantages you are going to loose then:
> >=20
> >   (1) virtio-mmio device discovery without command line hacks (tweaking
> >       the command line is a problem when not using direct kernel boot).
> >   (2) Better IO-APIC support, we can use IRQ lines 16-23.
> >   (3) ACPI power button (aka powerdown request) works.
> >   (4) machine poweroff (aka S5 state) works.
>=20
> Questions
>=20
> - what's the tradeoff in startup time?

In the noise.  0.28-0.29 seconds on my hardware to the "i8042: PNP: No
PS/2 controller found" message, no matter whenever acpi is on or off.
With "quiet" (acpi prints more and logging to the serial console is
slow).

At that point -no-acpi takes one second to figure the ps2 controller
really isn't there (as discussed before).

Another interesting difference is interrupt handling.

The -no-acpi version:

           CPU0      =20
  2:          0    XT-PIC      cascade
  4:        284   IO-APIC   4-edge      ttyS0
  8:          0   IO-APIC   8-edge      rtc0
 14:       5399   IO-APIC  14-edge      virtio1
 15:         58   IO-APIC  15-edge      virtio0
NMI:          0   Non-maskable interrupts
[ ... ]

The acpi version:

           CPU0      =20
  1:          0   IO-APIC   9-edge      ACPI:Ged
  2:        231   IO-APIC  23-fasteoi   virtio0
  3:       6291   IO-APIC  22-fasteoi   virtio1
  4:       1758   IO-APIC   4-edge      ttyS0
  5:          0   IO-APIC   8-edge      rtc0
NMI:          0   Non-maskable interrupts
[ ... ]

> - what should be the default?

IMO it makes sense to enable it by default.  You get working
power management.  You can boot stock cloud images (patched
seabios parses the dsdt to find virtio-mmio devices to boot
from virtio-mmio disks).

It's easier to leave behind legacy stuff:  The kernel trusts the
firmware and doesn't go into "trying harder to find ps2 kbd" mode.
Also what is this "cascade" thing in /proc/interrupts above? [1]

I expect dropping the rtc is easier with acpi too, the kernel probably
wouldn't try to find it then.  Right now seabios needs rtc cmos for
ram size probing, so I didn't test that yet.

On the other hand I don't really see any disadvantages.  The tables are
small ...

# find /sys/firmware/acpi/tables/ -type f | xargs ls -l
-r--------. 1 root root  70 May  6 06:48 /sys/firmware/acpi/tables/APIC
-r--------. 1 root root 472 May  6 06:48 /sys/firmware/acpi/tables/DSDT
-r--------. 1 root root 268 May  6 06:48 /sys/firmware/acpi/tables/FACP

... and simple (no methods) so you can hardly call that "bloat".

> Based on above I'd be inclined to say default should stay no acpi and
> users should enable acpi with an option.

I disagree, but I can live with off by default too.  We already have
acpi=3DOnOffAuto for X86MachineState, so it is just a matter of handling
microvm.acpi=3Dauto accordingly in x86_machine_is_acpi_enabled().

take care,
  Gerd

[1] Rhetorical question, I know what it is. [2]
[2] I don't want remember though.


