Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC046C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 16:32:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC74216C4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 16:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC74216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40162 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOPUD-0001FQ-Ov
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 12:32:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hOPT4-0000pP-WA
	for qemu-devel@nongnu.org; Wed, 08 May 2019 12:30:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hOPT4-0005RD-5z
	for qemu-devel@nongnu.org; Wed, 08 May 2019 12:30:54 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hOPT4-0005Qo-2K
	for qemu-devel@nongnu.org; Wed, 08 May 2019 12:30:54 -0400
Received: by mail-qt1-f194.google.com with SMTP id j53so4818496qta.9
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 09:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=2Q/CeXMvUJ6CclTyHUpqF5xbhnGveWrAGWvfGKmuFYA=;
	b=B1OfIZ4HSzqAEpbIfneAGBhdn5l97Tz5EkvI4XjWRq7iHLlGCpQyvyUYVSuK0UGLzA
	s+K8xsMS0JD0p/qfif+cDrv4J/PEULS3LjxNSgQ3DFv74DZXubNhjTYYkSQ8LRJkpXoT
	rjfK3EK5uUXkJNQQvwVzQz7dJLK8ICWiWS2WxAyLkHjSRSY98OxOfjlvNyQ2Yslu1DS5
	QVaPCk4Ph+5dV9fCgGOPMHh6hm5lMWZHq26Wyp09qQXQRLtlmTp70JjoCBaqQQFQ7iVv
	WJvuyu1k3o65ug6dF4h3QabUSP1NThHqWyimrN7Jt23ed0eLFiTP0mI5lH90nqPIYhWu
	QtDA==
X-Gm-Message-State: APjAAAWjaZiIehcqqKNqCGkBFVP6CRE9ejyTLHk66/rE6FvDBCs/42zj
	MO+IVcEUz0m8ew7P6A+L/ubo3g==
X-Google-Smtp-Source: APXvYqzZVq0DzKCf+tSALfp4O+O13sfBt6GxrFaCMMribQ4YVVJAobUe3NyqGOIp72BM2t/IcilUZA==
X-Received: by 2002:ac8:4a82:: with SMTP id l2mr18153561qtq.132.1557333052649; 
	Wed, 08 May 2019 09:30:52 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71])
	by smtp.gmail.com with ESMTPSA id d1sm7221700qkj.7.2019.05.08.09.30.50
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 08 May 2019 09:30:51 -0700 (PDT)
Date: Wed, 8 May 2019 12:30:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190508123042-mutt-send-email-mst@kernel.org>
References: <20190402161900.7374-1-armbru@redhat.com>
	<87h8a55h2k.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h8a55h2k.fsf@dusky.pond.sub.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.194
Subject: Re: [Qemu-devel] [PATCH 0/3] acpi: More trace points
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
Cc: imammedo@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

tagged, thanks!

On Wed, May 08, 2019 at 01:19:47PM +0200, Markus Armbruster wrote:
> Ping?
> 
> Markus Armbruster <armbru@redhat.com> writes:
> 
> > I wrote these patches to help me debug an unplug failure.  I expect
> > them to be helpful for others, too.
> >
> > Markus Armbruster (3):
> >   acpi/piix4: Convert debug printf()s to trace events
> >   acpi/pcihp: Convert debug printf()s to trace events
> >   acpi/pcihp: Add a few more trace points related to unplug
> >
> >  hw/acpi/pcihp.c      | 32 +++++++++++++++-----------------
> >  hw/acpi/piix4.c      | 14 +++-----------
> >  hw/acpi/trace-events | 16 ++++++++++++++++
> >  3 files changed, 34 insertions(+), 28 deletions(-)

