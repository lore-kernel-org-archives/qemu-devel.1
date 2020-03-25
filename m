Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EB5C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 09:54:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 535E62078A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 09:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CihHoGa7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535E62078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH2k9-0007yq-I1
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 05:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jH2jU-0007Yt-En
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:53:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jH2jT-0003r3-Hh
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:53:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:20729)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jH2jT-0003qn-E7
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585130035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eW4UDQqZdo87zUtJOdi8Dq6aZ/5pQfzu42uk9552Q0I=;
 b=CihHoGa7i89pQnZP2bVY/M/CIzxKyQUnZ5hBhQTK0RmIXmN9IZk3YqJOofKpHvQ+Z4P4yM
 RpY1wY1G+IFzTI1VoWuE0KXCKlWV1EYYDOZ6NO1JJsuYGCbZjVf19o3zGpcZlFbe9AbFR4
 yBYMrmKVXeq/iCUI2wT1bPFlkL959OA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-SkvgQ9F-MlykeeTHpIW9dw-1; Wed, 25 Mar 2020 05:53:13 -0400
X-MC-Unique: SkvgQ9F-MlykeeTHpIW9dw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB918801E70;
 Wed, 25 Mar 2020 09:53:12 +0000 (UTC)
Received: from office.mammed.net (unknown [10.40.195.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0A8A7E311;
 Wed, 25 Mar 2020 09:53:03 +0000 (UTC)
Date: Wed, 25 Mar 2020 10:53:00 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 00/13] microvm: add acpi support
Message-ID: <20200325105300.74a35505@office.mammed.net>
In-Reply-To: <20200325091636.rqqv3ewxue6wm5qe@sirius.home.kraxel.org>
References: <20200319080117.7725-1-kraxel@redhat.com>
 <20200323065050-mutt-send-email-mst@kernel.org>
 <20200323120948.f6egd7rhfso6276p@sirius.home.kraxel.org>
 <20200323131658.30152128@redhat.com>
 <20200325091636.rqqv3ewxue6wm5qe@sirius.home.kraxel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 25 Mar 2020 10:16:36 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

> > > mounted.  Decided to use the "i8042: PNP: No PS/2 controller found."
> > > line instead for a simple test (just check the kernel log timestamps,
> > > three runs each).  The ACPI initialization is already done at that
> > > point, so it should be useful nevertheless.  Here we go:
> > > 
> > > Without acpi:
> > >   0.277710
> > >   0.278852
> > >   0.279520
> > > 
> > > With acpi:
> > >   0.283917
> > >   0.284262
> > >   0.284836  
> > I wonder what would be difference with hw-reduced acpi  
> 
> The kernel does a bunch of reads+writes at boot (roughly 20-30),
> mostly timer ports, so probably while initializing the pm_timer
> clocksource.  Then it stops talking to the acpi hardware,
> preferring kvmclock clocksouce I guess.
> 
> So I expect hw-reduced acpi wouldn't make much of a difference.
> Actually trying that isn't that high on my priority list.

there aren't pm timers on hw-reduced, that's the point of it
(a bunch of registers that where mandatory with full profile
are absent so OS doesn't have to initialize not needed stuff)

> There is bigger fish to fry, untangling the hw/i386/acpi-build.c
> monster for starters, so building with ACPI=y + PCI=n works ...
> 
> cheers,
>   Gerd
> 


