Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24A5C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 12:10:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DD8220788
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 12:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1rxfiGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD8220788
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGLuj-0000Q4-NK
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 08:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jGLu3-0008Mv-BH
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jGLu2-0006mc-BW
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:09:59 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:55683)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jGLu2-0006mS-5j
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584965397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/zjd3JETTCHtj2QJfM71AHKLOIO0dheMjXt/59EAgeo=;
 b=d1rxfiGyCWMwlZVw2cz5r/OuLLjxUuYbtIp8KcUqVJYVknclvGlTgDDoagUXdx9LE8cJbC
 o3Uf949bEqJc8xLYJmx00XhONJ0XuEFm5wOcVSg2gi9H2Bss7z09etXgsa5rt/pP2ABYLb
 vvjTBG1RsttzLQjGl9TzI6zo9NSA9BM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-kYBAfH6-MWKJV5gM1bElfA-1; Mon, 23 Mar 2020 08:09:55 -0400
X-MC-Unique: kYBAfH6-MWKJV5gM1bElfA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D604E800D6C;
 Mon, 23 Mar 2020 12:09:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 647755DA7C;
 Mon, 23 Mar 2020 12:09:49 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9E1349DB6; Mon, 23 Mar 2020 13:09:48 +0100 (CET)
Date: Mon, 23 Mar 2020 13:09:48 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 00/13] microvm: add acpi support
Message-ID: <20200323120948.f6egd7rhfso6276p@sirius.home.kraxel.org>
References: <20200319080117.7725-1-kraxel@redhat.com>
 <20200323065050-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200323065050-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 23, 2020 at 06:51:10AM -0400, Michael S. Tsirkin wrote:
> On Thu, Mar 19, 2020 at 09:01:04AM +0100, Gerd Hoffmann wrote:
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
> What is the cost though? How do boot times compare?

Well, acpi speeds up booting by one second because this delay ...

   [    0.275736] i8042: PNP: No PS/2 controller found.
   [    0.275736] i8042: Probing ports directly.
   [    1.315447] i8042: No controller found

... goes away, at least with standard distro kernels.  When building
your own you can probably compile out the driver somehow, even though
something seems to select SERIO_I8042 so trying to simply flip
CONFIG_SERIO_I8042 to 'n' in .config doesn't work.  And a runtime
switch seems to not be there either ...

So that ruined my plan to just time until the root filesystem is
mounted.  Decided to use the "i8042: PNP: No PS/2 controller found."
line instead for a simple test (just check the kernel log timestamps,
three runs each).  The ACPI initialization is already done at that
point, so it should be useful nevertheless.  Here we go:

Without acpi:
  0.277710
  0.278852
  0.279520

With acpi:
  0.283917
  0.284262
  0.284836

So the difference is less than 0.01 seconds on my box.

cheers,
  Gerd


