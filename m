Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A432C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 21:41:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6C9C2082E
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 21:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C9C2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDEX4-0002VD-4t
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 17:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <samuel.thibault@gnu.org>) id 1jDEWW-00026m-QG
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 17:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <samuel.thibault@gnu.org>) id 1jDEWV-0001CM-T9
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 17:40:48 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:36616)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <samuel.thibault@gnu.org>)
 id 1jDEWV-0001CC-Mx
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 17:40:47 -0400
Received: from localhost (localhost [127.0.0.1])
 by hera.aquilenet.fr (Postfix) with ESMTP id AA284DB2A;
 Sat, 14 Mar 2020 22:40:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HeTt-tQE21bJ; Sat, 14 Mar 2020 22:40:44 +0100 (CET)
Received: from function (unknown [IPv6:2a01:cb19:956:1b00:9eb6:d0ff:fe88:c3c7])
 by hera.aquilenet.fr (Postfix) with ESMTPSA id 68592DB29;
 Sat, 14 Mar 2020 22:40:44 +0100 (CET)
Received: from samy by function with local (Exim 4.93)
 (envelope-from <samuel.thibault@gnu.org>)
 id 1jDEWR-004744-Gq; Sat, 14 Mar 2020 22:40:43 +0100
Date: Sat, 14 Mar 2020 22:40:43 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Jason Andryuk <jandryuk@gmail.com>
Subject: Re: [PATCH 3/4] usb-serial: Increase receive buffer to 496
Message-ID: <20200314214043.cgvsaejchqksm5vt@function>
References: <20200312125524.7812-1-jandryuk@gmail.com>
 <20200312125524.7812-4-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312125524.7812-4-jandryuk@gmail.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 185.233.100.1
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Jason Andryuk, le jeu. 12 mars 2020 08:55:22 -0400, a ecrit:
> A FTDI USB adapter on an xHCI controller can send 512 byte USB packets.
> These are 8 * ( 2 bytes header + 62 bytes data).  A 384 byte receive
> buffer is insufficient to fill a 512 byte packet, so bump the receive
> size to 496 ( 512 - 2 * 8 ).
> 
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  hw/usb/dev-serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
> index 96b6c34202..ef33bcd127 100644
> --- a/hw/usb/dev-serial.c
> +++ b/hw/usb/dev-serial.c
> @@ -29,7 +29,7 @@ do { printf("usb-serial: " fmt , ## __VA_ARGS__); } while (0)
>  #define DPRINTF(fmt, ...) do {} while(0)
>  #endif
>  
> -#define RECV_BUF 384
> +#define RECV_BUF (512 - (2 * 8))
>  
>  /* Commands */
>  #define FTDI_RESET		0
> -- 
> 2.24.1
> 

-- 
Samuel
After watching my newly-retired dad spend two weeks learning how to make a new
folder, it became obvious that "intuitive" mostly means "what the writer or
speaker of intuitive likes".
(Bruce Ediger, bediger@teal.csn.org, in comp.os.linux.misc, on X the
intuitiveness of a Mac interface.)

