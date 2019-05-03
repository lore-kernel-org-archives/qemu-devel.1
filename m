Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD89C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 20:01:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B8D6206BB
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 20:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8D6206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46689 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMeNC-0008DP-LZ
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 16:01:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hMeMM-0007pd-5a
	for qemu-devel@nongnu.org; Fri, 03 May 2019 16:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hMeMK-0004w9-8L
	for qemu-devel@nongnu.org; Fri, 03 May 2019 16:00:42 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hMeMK-0004q1-3u
	for qemu-devel@nongnu.org; Fri, 03 May 2019 16:00:40 -0400
Received: by mail-qt1-f195.google.com with SMTP id i31so8108214qti.13
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 13:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=J1bFCEA+pHnGdbLQKLgqPtItZghCCMlIVv4I8tpxZy4=;
	b=CvrmkNlAmW6QwdXXqpUnSIL10Q5ySCQfrVidkR7F1GQXirbaSerXLjEYaqUWVbC1M/
	UurGxRYyZXjmB0/zQx/iwdHm2vKRxmP1zAgIX19+YOTveozG8ZoVNI5qxXh0Z+YwbzXR
	+dkG/Ya64GKo/qsNkYdG4lQ69meIna3yOhQjr16G46hqEwRt7SmHz/6zG+mrbnLh7MrN
	vjT1am4vwfDXxtx3uXD4H4bo9+PVzDDYm/YNRGgUFLchES9VPksX8fG3K7htYzF3T/yo
	+s5hk8VYk0s4oTVevTU9OnxoLfSgv6uXNu3wBnuk/T0k0faNoahIZbtJQIjGkMXhG8eC
	fibw==
X-Gm-Message-State: APjAAAWa1bvRqMrkA3H3QZQCsVVHAL/Pht87j1kuYDGTWxyucb9KmBZn
	swzrv1iRTtOXugKcKCgdQsDYtw==
X-Google-Smtp-Source: APXvYqxyEPbUTcO69W7p6PpBq34o3hNRhBFPp0IE6poEnT6IYoAehMZn87E6jg5bWpGhztJxhU4HGQ==
X-Received: by 2002:a0c:98b3:: with SMTP id f48mr9723721qvd.202.1556913636321; 
	Fri, 03 May 2019 13:00:36 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	z85sm1999359qka.18.2019.05.03.13.00.34
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 03 May 2019 13:00:35 -0700 (PDT)
Date: Fri, 3 May 2019 16:00:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190503155951-mutt-send-email-mst@kernel.org>
References: <20181220054037.24320-1-peterx@redhat.com>
	<20181220054037.24320-2-peterx@redhat.com>
	<20190426132744.2b594bf5@x1.home> <20190426150236.1af2ff08@x1.home>
	<94415012.15677076.1556342950794.JavaMail.zimbra@redhat.com>
	<daded638-42f1-9bc3-8c36-66b0fbba9438@redhat.com>
	<20190429082106.4fd59e77@x1.home>
	<20190429145556.GA28722@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190429145556.GA28722@habkost.net>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.195
Subject: Re: [Qemu-devel] [PATCH v2 1/3] q35: set split kernel irqchip as
 default
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503200033.c_9TwEdpanXhZ4OaSDDmyH23kAPSjvQPUhE_BjxIyWY@z>

On Mon, Apr 29, 2019 at 11:55:56AM -0300, Eduardo Habkost wrote:
> irqchip=split and irqchip=kernel aren't guest ABI compatible, are
> they?

Can you remind me why they aren't?

> -- 
> Eduardo

