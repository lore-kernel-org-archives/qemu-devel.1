Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5E2C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46A2D2073B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HutlO0y5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A2D2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIxi9-0002h2-ES
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 12:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kbusch@kernel.org>) id 1jIxhD-0000rc-Bl
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kbusch@kernel.org>) id 1jIxhC-0000Ax-C9
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:55:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51698)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kbusch@kernel.org>)
 id 1jIxhA-00009B-5z; Mon, 30 Mar 2020 12:55:28 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F036C2073B;
 Mon, 30 Mar 2020 16:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585587325;
 bh=udl1qLljsSDOr5Hbvoeaeun9iY6pf9r8iv5Z/Wr7tCk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HutlO0y5g7ZTMn/qwESzAbN2kAMGZFyxj1O23aK4iUdvIwF2H7xvSiV7PjGFUx2CM
 k0kwL3BtjZPWr6e2DY8RvWq5gCtLC+agX+QQbTpRGJFkJRnwHJSZBJJaHX4VOrFIGr
 GtflLve1TNK3h1W1LlcMXNgDln4D/yq5lRHKOu/o=
Date: Tue, 31 Mar 2020 01:55:18 +0900
From: Keith Busch <kbusch@kernel.org>
To: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Subject: Re: [PATCH RESEND v4] nvme: introduce PMR support from NVMe 1.4 spec
Message-ID: <20200330165518.GA8234@redsun51.ssa.fujisawa.hgst.com>
References: <20200330164656.9348-1-andrzej.jakowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330164656.9348-1-andrzej.jakowski@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 198.145.29.99
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
Cc: kwolf@redhat.com, haozhong.zhang@intel.com, qemu-block@nongnu.org,
 stefanha@gmail.com, dgilbert@redhat.com, qemu-devel@nongnu.org,
 yi.z.zhang@linux.intel.com, junyan.he@intel.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 30, 2020 at 09:46:56AM -0700, Andrzej Jakowski wrote:
> This patch introduces support for PMR that has been defined as part of NVMe 1.4
> spec. User can now specify a pmrdev option that should point to HostMemoryBackend.
> pmrdev memory region will subsequently be exposed as PCI BAR 2 in emulated NVMe
> device. Guest OS can perform mmio read and writes to the PMR region that will stay
> persistent across system reboot.

Looks pretty good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

For a possible future extention, it could be interesting to select the
BAR for PMR dynamically, so that you could have CMB and PMR enabled on
the same device.

