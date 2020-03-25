Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABDCC1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 09:17:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98AB9206F6
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 09:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIJ/16Na"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98AB9206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH2AX-0000cV-KK
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 05:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51537)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jH29c-0000BZ-ML
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:16:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jH29Z-000178-Jr
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:16:51 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:49037)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jH29Z-000163-92
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585127808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4tEh041oXzSa/ftW4a3NWQV4FCp2HQL6fMW+P63qO+c=;
 b=dIJ/16Nago0LQ5dI5fVZDQI9r8SEfy1J3J1xGs9p9TyvRePx/36wlXimxLkTLnHNRfG98b
 H97j5V6jM5hPet7MzBimB9EK1eNLbEX4DsGLm05wpioAKwCf8F1sV9CMarGRHp8wwz/sVk
 oY1iix92PHO2sEeSCkYfbeRm7cQmWZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-8GQRQVzPM2e6dDmrmVEDDA-1; Wed, 25 Mar 2020 05:16:45 -0400
X-MC-Unique: 8GQRQVzPM2e6dDmrmVEDDA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC1F9A1360;
 Wed, 25 Mar 2020 09:16:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 49E665C1B0;
 Wed, 25 Mar 2020 09:16:38 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 23E7517535; Wed, 25 Mar 2020 10:16:36 +0100 (CET)
Date: Wed, 25 Mar 2020 10:16:36 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 00/13] microvm: add acpi support
Message-ID: <20200325091636.rqqv3ewxue6wm5qe@sirius.home.kraxel.org>
References: <20200319080117.7725-1-kraxel@redhat.com>
 <20200323065050-mutt-send-email-mst@kernel.org>
 <20200323120948.f6egd7rhfso6276p@sirius.home.kraxel.org>
 <20200323131658.30152128@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200323131658.30152128@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

> > mounted.  Decided to use the "i8042: PNP: No PS/2 controller found."
> > line instead for a simple test (just check the kernel log timestamps,
> > three runs each).  The ACPI initialization is already done at that
> > point, so it should be useful nevertheless.  Here we go:
> >=20
> > Without acpi:
> >   0.277710
> >   0.278852
> >   0.279520
> >=20
> > With acpi:
> >   0.283917
> >   0.284262
> >   0.284836
> I wonder what would be difference with hw-reduced acpi

The kernel does a bunch of reads+writes at boot (roughly 20-30),
mostly timer ports, so probably while initializing the pm_timer
clocksource.  Then it stops talking to the acpi hardware,
preferring kvmclock clocksouce I guess.

So I expect hw-reduced acpi wouldn't make much of a difference.
Actually trying that isn't that high on my priority list.

There is bigger fish to fry, untangling the hw/i386/acpi-build.c
monster for starters, so building with ACPI=3Dy + PCI=3Dn works ...

cheers,
  Gerd


