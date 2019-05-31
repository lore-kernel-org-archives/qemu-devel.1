Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A48C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 18:24:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0192E26971
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 18:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0192E26971
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47505 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWmCR-0001Fl-8H
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 14:24:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hWm80-0005zp-NF
	for qemu-devel@nongnu.org; Fri, 31 May 2019 14:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hWltf-0006a5-Vn
	for qemu-devel@nongnu.org; Fri, 31 May 2019 14:04:57 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hWltf-0006YO-Rf
	for qemu-devel@nongnu.org; Fri, 31 May 2019 14:04:55 -0400
Received: by mail-qt1-f194.google.com with SMTP id s57so1941278qte.8
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 11:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=L8WW6YdYzXgy/94Unx54MyCwrUsfdCp/O3Ms0KWgkXU=;
	b=k0zpowqEXThawuKTv4UpDjVsf7KxeXcIBWMzywF7/enGBRqvby8YJwQagSyHsayCnP
	I+09tt5CFIirTcHyfv1j25aekbqKw31OnA8WlFspnwnLHQycEl8rqI4Q/XkDdECVTcNs
	sP6pSD1Wedrfxu+lUWA4ToNTC9yWFIt8IumVumJpJpm8nmreTIKZU5h8ZVxq4espMNR4
	PEpl9NNjNfX8vxyTUwWId4gMPSLoE8ggwb14BWmev/oaqT17N3RaBbw7DBJQchy46osN
	OBjTGOSTlFnCVchkLUL/9QEI1xCobBoe9F2FYOeOPpAdwRnYaSTB2TAr0EkyEcn5juWO
	Z+GA==
X-Gm-Message-State: APjAAAUpkkudTAMu0NezIC1qUHVgtki8k+wtKDbkqa0spK5hGpsnP84A
	g7suwWfQaJ8x1I+u1bWZCUwBBQ==
X-Google-Smtp-Source: APXvYqw8WsejzsDfyb78c/LXuIp2viudtZ4aq8ovjiLBZplhIT/JOJyGRYOiTZ23ssib0Bv3IdsHYA==
X-Received: by 2002:ac8:303c:: with SMTP id f57mr10422275qte.294.1559325893234;
	Fri, 31 May 2019 11:04:53 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	d16sm4475035qtd.73.2019.05.31.11.04.50
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 31 May 2019 11:04:51 -0700 (PDT)
Date: Fri, 31 May 2019 14:04:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190531135059-mutt-send-email-mst@kernel.org>
References: <20190517125820.2885-1-jfreimann@redhat.com>
	<20190517125820.2885-4-jfreimann@redhat.com>
	<20190521094504.GB2915@work-vm>
	<20190530145645.tjwkgi4hae5yblsi@jenstp.localdomain>
	<20190530134631-mutt-send-email-mst@kernel.org>
	<20190530180022.GB2864@work-vm>
	<20190530140419-mutt-send-email-mst@kernel.org>
	<20190530182210.GA22103@habkost.net>
	<20190530190322-mutt-send-email-mst@kernel.org>
	<20190531170154.GB22103@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531170154.GB22103@habkost.net>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.194
Subject: Re: [Qemu-devel] [PATCH 3/4] net/virtio: add failover support
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
Cc: pkrempa@redhat.com, berrange@redhat.com, aadam@redhat.com,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	qemu-devel@nongnu.org, laine@redhat.com,
	Jens Freimann <jfreimann@redhat.com>, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 31, 2019 at 02:01:54PM -0300, Eduardo Habkost wrote:
> > Yes. It's just lots of extremely low level interfaces
> > and all rather pointless.
> > 
> > And down the road extensions like surprise removal support will make it
> > all cleaner and more transparent. Floating things up to libvirt means
> > all these low level details will require more and more hacks.
> 
> Why do you call it pointless?

We'd need APIs to manipulate device visibility to guest, hotplug
controller state and separately manipulate the resources allocated. This
is low level stuff that users really have no idea what to do about.
Exposing such a level of detail to management is imho pointless.
We are better off with a high level API, see below.

> If we want this to work before
> surprise removal is implemented, we need to provide an API that
> works for management software.
>  Don't we want to make this work
> without surprise removal too?

This patchset adds an optional, off by default support for
migrating guests with an assigned network device.
If enabled this requires guest to allow migration.

Of course this can be viewed as a security problem since it allows guest
to block migration. We can't detect a malicious guest reliably imho.
What we can do is report to management when guest allows migration.
Policy such what to do when this does not happen for a while and
what timeout to set would be up to management.

The API in question would be a high level one, something
along the lines of a single "guest allowed migration" event.


-- 
MST

