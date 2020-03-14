Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1143C10DCE
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 00:08:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C44AA2074E
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 00:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C44AA2074E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCuMA-00079M-0M
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 20:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <samuel.thibault@gnu.org>) id 1jCuLK-00062t-LM
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 20:07:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <samuel.thibault@gnu.org>) id 1jCuLJ-0000rn-FZ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 20:07:54 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:47980)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <samuel.thibault@gnu.org>)
 id 1jCuLH-0000em-Ji
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 20:07:52 -0400
Received: from localhost (localhost [127.0.0.1])
 by hera.aquilenet.fr (Postfix) with ESMTP id 38CE1D137;
 Sat, 14 Mar 2020 01:07:49 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s2ChzSIllCZK; Sat, 14 Mar 2020 01:07:47 +0100 (CET)
Received: from function.home (lfbn-bor-1-797-11.w86-234.abo.wanadoo.fr
 [86.234.239.11])
 by hera.aquilenet.fr (Postfix) with ESMTPSA id CC66AD136;
 Sat, 14 Mar 2020 01:07:47 +0100 (CET)
Received: from samy by function.home with local (Exim 4.93)
 (envelope-from <samuel.thibault@gnu.org>)
 id 1jCuLC-001B12-Lq; Sat, 14 Mar 2020 01:07:46 +0100
Date: Sat, 14 Mar 2020 01:07:46 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Jason Andryuk <jandryuk@gmail.com>
Subject: Re: [PATCH 2/4] usb-serial: chunk data to wMaxPacketSize
Message-ID: <20200314000746.pe5j7b2jqcbt3v7k@function>
References: <20200312125524.7812-1-jandryuk@gmail.com>
 <20200312125524.7812-3-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312125524.7812-3-jandryuk@gmail.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a0c:e300::1
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

Jason Andryuk, le jeu. 12 mars 2020 08:55:21 -0400, a ecrit:
> usb-serial has issues with xHCI controllers where data is lost in the
> VM.  Inspecting the URBs in the guest, EHCI starts every 64 byte boundary
> (wMaxPacketSize) with a header.  EHCI hands packets into
> usb_serial_token_in() with size 64, so these cannot cross the 64 byte
> boundary.  The xHCI controller has packets of 512 bytes and the usb-serial
> will just write through the 64 byte boundary.  In the guest, this means
> data bytes are interpreted as header, so data bytes don't make it out
> the serial interface.
> 
> Re-work usb_serial_token_in to chunk data into 64 byte units - 2 byte
> header and 62 bytes data.  The Linux driver reads wMaxPacketSize to find
> the chunk size, so we match that.
> 
> Real hardware was observed to pass in 512 byte URBs (496 bytes data +
> 8 * 2 byte headers).  Since usb-serial only buffers 384 bytes of data,
> usb-serial will pass in 6 64 byte blocks and 1 12 byte partial block for
> 462 bytes max.
> 
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  hw/usb/dev-serial.c | 43 +++++++++++++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
> index 71fa786bd8..96b6c34202 100644
> --- a/hw/usb/dev-serial.c
> +++ b/hw/usb/dev-serial.c
> @@ -360,15 +360,16 @@ static void usb_serial_handle_control(USBDevice *dev, USBPacket *p,
>  
>  static void usb_serial_token_in(USBSerialState *s, USBPacket *p)
>  {
> -    int first_len, len;
> +    const int max_packet_size = desc_iface0.eps[0].wMaxPacketSize;
> +    int packet_len;
>      uint8_t header[2];
>  
> -    first_len = RECV_BUF - s->recv_ptr;
> -    len = p->iov.size;
> -    if (len <= 2) {
> +    packet_len = p->iov.size;
> +    if (packet_len <= 2) {
>          p->status = USB_RET_NAK;
>          return;
>      }
> +
>      header[0] = usb_get_modem_lines(s) | 1;
>      /* We do not have the uart details */
>      /* handle serial break */
> @@ -380,21 +381,31 @@ static void usb_serial_token_in(USBSerialState *s, USBPacket *p)
>      } else {
>          header[1] = 0;
>      }
> -    len -= 2;
> -    if (len > s->recv_used)
> -        len = s->recv_used;
> -    if (!len) {
> +
> +    if (!s->recv_used) {
>          p->status = USB_RET_NAK;
>          return;
>      }
> -    if (first_len > len)
> -        first_len = len;
> -    usb_packet_copy(p, header, 2);
> -    usb_packet_copy(p, s->recv_buf + s->recv_ptr, first_len);
> -    if (len > first_len)
> -        usb_packet_copy(p, s->recv_buf, len - first_len);
> -    s->recv_used -= len;
> -    s->recv_ptr = (s->recv_ptr + len) % RECV_BUF;
> +
> +    while (s->recv_used && packet_len > 2) {
> +        int first_len, len;
> +
> +        len = MIN(packet_len, max_packet_size);
> +        len -= 2;
> +        if (len > s->recv_used)
> +            len = s->recv_used;
> +
> +        first_len = RECV_BUF - s->recv_ptr;
> +        if (first_len > len)
> +            first_len = len;
> +        usb_packet_copy(p, header, 2);
> +        usb_packet_copy(p, s->recv_buf + s->recv_ptr, first_len);
> +        if (len > first_len)
> +            usb_packet_copy(p, s->recv_buf, len - first_len);
> +        s->recv_used -= len;
> +        s->recv_ptr = (s->recv_ptr + len) % RECV_BUF;
> +        packet_len -= len + 2;
> +    }
>  
>      return;
>  }
> -- 
> 2.24.1
> 

-- 
Samuel
We are Pentium of Borg. Division is futile. You will be approximated.
(seen in someone's .signature)

