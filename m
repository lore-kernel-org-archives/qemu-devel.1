Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C2DC433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 15:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E7F2137B
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 15:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E7F2137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCPGm-0007Du-6q
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 11:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kCPGG-0006ng-6V
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 11:28:52 -0400
Received: from relay64.bu.edu ([128.197.228.104]:48975)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kCPGE-0005sV-1P
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 11:28:51 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 07UFRf55010151
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 30 Aug 2020 11:27:45 -0400
Date: Sun, 30 Aug 2020 11:27:41 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH] xhci: check return value from usb_packet_map
Message-ID: <20200830152737.l3f42t2fvvrmdiwo@mozz.bu.edu>
References: <20200827115933.1851563-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827115933.1851563-1-ppandit@redhat.com>
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/30 11:28:47
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 Ruhr-University <bugs-syssec@rub.de>, Gerd Hoffmann <kraxel@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I think there is already a fix queued for this one:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg734424.html

On 200827 1729, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> While setting up a packet in xhci_setup_packet() routine,
> usb_packet_map() may return an error. Check this return value
> before further processing the packet, to avoid use-after-free
> issue.
> 
>  -> https://ruhr-uni-bochum.sciebo.de/s/NNWP2GfwzYKeKwE?path=%2Fxhci_uaf_2
>   #0  __interceptor_free (/lib64/libasan.so.6+0xb0307)
>   #1  qemu_vfree ../util/oslib-posix.c:247
>   #2  address_space_unmap ../exec.c:3635
>   #3  dma_memory_unmap ../include/sysemu/dma.h:145
>   #4  usb_packet_unmap ../hw/usb/libhw.c:65
>   #5  usb_packet_map ../hw/usb/libhw.c:54
>   #6  xhci_setup_packet ../hw/usb/hcd-xhci.c:1618
>   #7  xhci_fire_ctl_transfer ../hw/usb/hcd-xhci.c:1722
>   #8  xhci_kick_epctx ../hw/usb/hcd-xhci.c:1991
>   #9  xhci_kick_ep ../hw/usb/hcd-xhci.c:1861
>   #10 xhci_doorbell_write ../hw/usb/hcd-xhci.c:3162
>   ...
> 
> Reported-by: Ruhr-University <bugs-syssec@rub.de>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/usb/hcd-xhci.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index 67a18fe2b6..848e7e935f 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -1615,7 +1615,14 @@ static int xhci_setup_packet(XHCITransfer *xfer)
>      xhci_xfer_create_sgl(xfer, dir == USB_TOKEN_IN); /* Also sets int_req */
>      usb_packet_setup(&xfer->packet, dir, ep, xfer->streamid,
>                       xfer->trbs[0].addr, false, xfer->int_req);
> -    usb_packet_map(&xfer->packet, &xfer->sgl);
> +    if (usb_packet_map(&xfer->packet, &xfer->sgl) < 0) {
> +        DPRINTF("xhci: setup packet failed: pid: 0x%x addr %d ep %d\n",
> +                xfer->packet.pid, ep->dev->addr, ep->nr);
> +        usb_packet_cleanup(&xfer->packet);
> +        qemu_sglist_destroy(&xfer->sgl);
> +        return -1;
> +    }
> +
>      DPRINTF("xhci: setup packet pid 0x%x addr %d ep %d\n",
>              xfer->packet.pid, ep->dev->addr, ep->nr);
>      return 0;
> -- 
> 2.26.2
> 
> 

