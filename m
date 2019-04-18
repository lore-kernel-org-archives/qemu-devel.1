Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F32C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 16:30:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBDA821872
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 16:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UQuK3DBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBDA821872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44093 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH9vo-0006G3-3R
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 12:30:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56075)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<BATV+2af28a5d36b01af4518d+5716+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1hH9t2-000410-6y
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 12:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<BATV+2af28a5d36b01af4518d+5716+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1hH9kV-0005m0-0u
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 12:18:56 -0400
Received: from bombadil.infradead.org ([2607:7c80:54:e::133]:50434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from
	<BATV+2af28a5d36b01af4518d+5716+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1hH9kT-0005fJ-T3
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 12:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oSiywyWZOOkDew8YDIRL2lgfYPRWYKSt6r/K8nAvB38=;
	b=UQuK3DBWUvS3ekW0bjE1qVo6+
	MJzsQy6sTGxK00p7qVJ4VFtC1fWyQ7xuIglmmJFdYRHtDzE+aNGMdNRLf3HLnPAOBrQLtgfLLqXkV
	roN4AQhtKnlTNAuwf8sTOFq6GZl/ptQS0UKstolaRecDOv644T1QMJ8t9ODMIMUpcOjuj03JuDO2M
	1AG97LDrgEDRf5sUoXXV25MqNc5qhJpMQ2DK1Hb9Na19ziCgs8b4jrtYlU/QZ65chrvNKLIkN25d5
	G1A3jBOm1AnpyhDDKhTNYMIfJFehyF56uHA5kl+sfAvNUyUKy4MQiZcM5LNHgtyUhIbKJDR3z9iiu
	BnpM8rboA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
	Hat Linux)) id 1hH9kA-0006UQ-C7; Thu, 18 Apr 2019 16:18:34 +0000
Date: Thu, 18 Apr 2019 09:18:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Message-ID: <20190418161833.GA22970@infradead.org>
References: <20190410040826.24371-1-pagupta@redhat.com>
	<20190410040826.24371-2-pagupta@redhat.com>
	<CAPcyv4i1FjBzfcWtzeCvj-giHa9xaX0dMQ==q4LZC_L8VEqkHg@mail.gmail.com>
	<20190412083230.GA29850@quack2.suse.cz>
	<x494l73z7th.fsf@segfault.boston.devel.redhat.com>
	<CAPcyv4jrNHqW3FuGkeo==ZoJr7LKahCv4_esnokfy7enek8=2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <CAPcyv4jrNHqW3FuGkeo==ZoJr7LKahCv4_esnokfy7enek8=2Q@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:7c80:54:e::133
Subject: Re: [Qemu-devel] [PATCH v5 1/6] libnvdimm: nd_region flush callback
 support
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
Cc: Pankaj Gupta <pagupta@redhat.com>, cohuck@redhat.com,
	Jan Kara <jack@suse.cz>, KVM list <kvm@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, david <david@fromorbit.com>,
	Qemu Developers <qemu-devel@nongnu.org>,
	virtualization@lists.linux-foundation.org,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Ross Zwisler <zwisler@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	linux-nvdimm <linux-nvdimm@lists.01.org>,
	Vishal L Verma <vishal.l.verma@intel.com>,
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>, Jeff Moyer <jmoyer@redhat.com>,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	Len Brown <lenb@kernel.org>, kilobyte@angband.pl,
	Rik van Riel <riel@surriel.com>, yuval shaia <yuval.shaia@oracle.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
	Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-xfs <linux-xfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418161834.Z717LG4AjeLYPUmTXOMnaU6aIWM1lInHWclC0uZmfN4@z>

On Thu, Apr 18, 2019 at 09:05:05AM -0700, Dan Williams wrote:
> > > I'd either add a comment about avoiding retpoline overhead here or just
> > > make ->flush == NULL mean generic_nvdimm_flush(). Just so that people don't
> > > get confused by the code.
> >
> > Isn't this premature optimization?  I really don't like adding things
> > like this without some numbers to show it's worth it.
> 
> I don't think it's premature given this optimization technique is
> already being deployed elsewhere, see:
> 
> https://lwn.net/Articles/774347/

For one this one was backed by numbers, and second after feedback
from Linux we switched to the NULL pointer check instead.

