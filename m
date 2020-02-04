Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF1BC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:33:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 363AF2087E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSWcwzrU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363AF2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz18P-0001km-CB
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 11:33:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kbusch@kernel.org>) id 1iz17T-00010j-Gg
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:32:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kbusch@kernel.org>) id 1iz17S-00034y-DU
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:32:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:56352)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kbusch@kernel.org>)
 id 1iz17P-0002Rr-GP; Tue, 04 Feb 2020 11:32:07 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 619502082E;
 Tue,  4 Feb 2020 16:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1580833925;
 bh=VGpliKchjwjo/WMoBAoq+ZpfBQeqPHkgFGk3mhPlDIw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KSWcwzrUqvVXWOvYldwltMhxiqSMl9J/r3a1sAvfhpQXksjilNCVMFMGU+V37/727
 aCHhDuoTim+07FQmB3NSpF/qvRJgCwj0l/CWZNZrbg5LPIi8i8CVA40Omk2ImQWiSn
 a561SFCaDe/YAgYQZ2BeZ2u0Y6BV0/U7zcqgEqRA=
Date: Wed, 5 Feb 2020 01:31:58 +0900
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v5 22/26] nvme: support multiple namespaces
Message-ID: <20200204163158.GA6823@redsun51.ssa.fujisawa.hgst.com>
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095230eucas1p27456c6c0ab3b688d2f891d0dff098821@eucas1p2.samsung.com>
 <20200204095208.269131-23-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204095208.269131-23-k.jensen@samsung.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 04, 2020 at 10:52:04AM +0100, Klaus Jensen wrote:
> This adds support for multiple namespaces by introducing a new 'nvme-ns'
> device model. The nvme device creates a bus named from the device name
> ('id'). The nvme-ns devices then connect to this and registers
> themselves with the nvme device.
> 
> This changes how an nvme device is created. Example with two namespaces:
> 
>   -drive file=nvme0n1.img,if=none,id=disk1
>   -drive file=nvme0n2.img,if=none,id=disk2
>   -device nvme,serial=deadbeef,id=nvme0
>   -device nvme-ns,drive=disk1,bus=nvme0,nsid=1
>   -device nvme-ns,drive=disk2,bus=nvme0,nsid=2
> 
> The drive property is kept on the nvme device to keep the change
> backward compatible, but the property is now optional. Specifying a
> drive for the nvme device will always create the namespace with nsid 1.
> 
> Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>

I like this feature a lot, thanks for doing it.

Reviewed-by: Keith Busch <kbusch@kernel.org>

> @@ -1256,18 +1272,24 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, NvmeCmd *cmd, uint8_t rae,
>      uint64_t units_read = 0, units_written = 0, read_commands = 0,
>          write_commands = 0;
>      NvmeSmartLog smart;
> -    BlockAcctStats *s;
>  
>      if (nsid && nsid != 0xffffffff) {
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }

This is totally optional, but worth mentioning: this patch makes it
possible to remove this check and allow per-namespace smart logs. The
ID_CTRL.LPA would need to updated to reflect that if you wanted to
go that route.

