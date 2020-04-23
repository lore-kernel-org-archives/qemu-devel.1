Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD03C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 06:20:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2575920724
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 06:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qEL7jXjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2575920724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRVDM-00083B-9C
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 02:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58912)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <BATV+4e4c82ab207447f3219b+6087+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1jRVCE-0007XI-7R
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 02:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from
 <BATV+4e4c82ab207447f3219b+6087+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1jRVCD-00063d-3u
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 02:18:50 -0400
Received: from bombadil.infradead.org ([2607:7c80:54:e::133]:34952)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+4e4c82ab207447f3219b+6087+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1jRVCC-00057V-BD
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 02:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=rq+QTShohzY4Rd55RAkLg7KPowx3+3Zby0B4moCrCAY=; b=qEL7jXjdh2GSG0KAjb7y96qB1K
 wOBucwe//4VQGGg/7GXhV+gQ6CMAXoGlzwYLQ62tBi3VaGqsCf0uO3KP8q2HpxcJutrlexg0JBK4B
 sWtpnDwYuhphJSvyXGABzlVszINTd0bDteg8nSbUPAMnmlEjIYcRoqu9VN7ct/xM5vSDXaTsSkgMP
 cmg9nPEYHl9tuQuRSoyX6004eLFn+GnUuBIZanO/vhOzVCxE8K5jZkh/qgGUziwuYilR0/AALIqE7
 xlwzMQ78eqpC/siuM6wPXjkqZGqyh4YR6dDmEda21cwqxKHByclDa9fPB/sFU8QW60Z9EgDkHzOjU
 b12plF5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jRV9z-00067g-MX; Thu, 23 Apr 2020 06:16:31 +0000
Date: Wed, 22 Apr 2020 23:16:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH 0/1] KVM support for VMD devices
Message-ID: <20200423061631.GA12688@infradead.org>
References: <20200422171444.10992-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422171444.10992-1-jonathan.derrick@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2607:7c80:54:e::133;
 envelope-from=BATV+4e4c82ab207447f3219b+6087+infradead.org+hch@bombadil.srs.infradead.org;
 helo=bombadil.infradead.org
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:7c80:54:e::133
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci@vger.kernel.org,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
 Bjorn Helgaas <helgaas@kernel.org>,
 Andrzej Jakowski <andrzej.jakowski@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 22, 2020 at 01:14:44PM -0400, Jon Derrick wrote:
> The two patches (Linux & QEMU) add support for passthrough VMD devices
> in QEMU/KVM. VMD device 28C0 already supports passthrough natively by
> providing the Host Physical Address in a shadow register to the guest
> for correct bridge programming.
> 
> The QEMU patch emulates the 28C0 mode by creating a shadow register and
> advertising its support by using QEMU's subsystem vendor/id.
> The Linux patch matches the QEMU subsystem vendor/id to use the shadow
> register.

Please pick a different PCI ID for Qemu vs real hardware so that we
can properly quirk them if they end up behaving differently due to
hardware or software bugs.

