Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57253C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 19:09:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DB962175B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 19:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB962175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59076 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUFYv-0006wT-H0
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 15:09:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hUFYD-0006fJ-Lv
	for qemu-devel@nongnu.org; Fri, 24 May 2019 15:08:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hUFYC-0003TJ-SW
	for qemu-devel@nongnu.org; Fri, 24 May 2019 15:08:21 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hUFYC-0003KI-Om
	for qemu-devel@nongnu.org; Fri, 24 May 2019 15:08:20 -0400
Received: by mail-vs1-f66.google.com with SMTP id m1so6556993vsr.6
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 12:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=NUhb2EkK+XCkSl0raA19LtUXR6jPN5Z4Yd110KHR+NE=;
	b=Wc4ve2H2TclT7/1KDSPIwJigMGvyBJ3PS8YSVO4i6/BRq2bqc7Jvaet8ggPVusUf37
	xDxsPDU6VDszbAOdn9sR33WLn+AkZRKZvR1SP4vrkPxalYAOg2FcVoWQJm0Y0mb/au84
	obVWAUFPMqRyEUR7gLPqyRi8Bx+ocvo5J2bHSjkbfgLtm1HBwTqworLlrQwROslw9vct
	iJCyrn9ex8QvG44IgeYhb4xzAnzJ73WtAlTwaVfLa8oq/DZOqJEPSU0/FiVVeIXEc1gR
	MbOD4G3FGjioObuYsUhb5Gvrj/OFILzAeZNYChMyJYE4oCZ1gzEoWy9pqoSxR3tnZ71v
	3wRw==
X-Gm-Message-State: APjAAAUDsS3pP2Sc3wjT+uPMKoIa33UdBrsZZdOG2FsK0/HAKK9GU0Yx
	o37nRE6+6gP2VAQ8JdvP9bFmbQ==
X-Google-Smtp-Source: APXvYqy4CB4gt70gFqOFdlOf7ERIcUVK+dYpsCtg23upj9kb4Uhdn3lyRpxgibRVJRgAhoUIdpSj4g==
X-Received: by 2002:a67:ec15:: with SMTP id d21mr47532553vso.186.1558724883058;
	Fri, 24 May 2019 12:08:03 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71])
	by smtp.gmail.com with ESMTPSA id o5sm1611455vki.37.2019.05.24.12.08.01
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 24 May 2019 12:08:02 -0700 (PDT)
Date: Fri, 24 May 2019 15:08:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190524150731-mutt-send-email-mst@kernel.org>
References: <20190524183638.20745-1-stefanha@redhat.com>
	<24b93cc5-edb1-a197-14be-e63ac356325d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24b93cc5-edb1-a197-14be-e63ac356325d@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.217.66
Subject: Re: [Qemu-devel] [RFC v3 0/3] scsi: restart dma after vm change
 state handlers
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 24, 2019 at 08:47:18PM +0200, Paolo Bonzini wrote:
> On 24/05/19 20:36, Stefan Hajnoczi wrote:
> > v3:
> >  * Fix s/k->vmstate_change/vdc->vmstate_change/
> >  * Still RFC, waiting for customer to confirm this fixes the issue
> > v2:
> >  * Do it properly with a clean API instead of deferring to a BH!
> >    Thanks for encouraging me to do this, Kevin.
> > 
> > These patches solve a deadlock when the 'cont' command is used and there are
> > failed requests on a virtio-scsi device with iothreads.  The deadlock itself is
> > actually not the thing we need to fix because we should never reach that case
> > anyway.  Instead we need to make sure DMA restart is only performed after the
> > virtio-scsi iothread is re-initialized.
> 
> custom_dma_restart is a bit ugly...  Do you think it would make sense to
> order the VMStateChange handlers using some kind of enum (with the order
> unspecified within the category)?
> 
> We could start with
> 
> 	VMSTATECHANGE_PRIO_UNKNOWN  = 0  (if needed?)

Yes I think it's a good idea to explicitly say I don't care
about the order like this.

> 	VMSTATECHANGE_PRIO_IOTHREAD = 100
>         VMSTATECHANGE_PRIO_DEVICE   = 200
> 
> where higher priorities run first on stop and last on resume.
> 
> Paolo

