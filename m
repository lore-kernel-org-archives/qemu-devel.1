Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8E6C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 11:20:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA8272081C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 11:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA8272081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmz1Y-0000gy-1j
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 07:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48098)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hmz1G-0008QY-4l
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:19:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hmz1E-0004Km-19
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:19:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41867)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hmz1B-0004IV-VC
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:19:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so13456224wrm.8
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 04:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=uduoneM+QrM6MHRk9FrHAjwAlnRrfZQdnUtoXqghyFU=;
 b=p9zn9w2EMACFnxtCl+oaDc0uQNSbsiVhY7+g3cOuJezl6tackGtdZtocHsoCdWEYee
 qD+5SG4A4FiIqFkY8chS9p4pd/ebLezBm7DBr+Bxy7lfi2vrsPFgQr0gOjp+RPDx4TEd
 P6Z6UHN2qIhhjHYnzsw7eNLfJyGRZUbclLbg1gD6DtBFEwmth0kADCxgdRMR5N/Z35KS
 WUIf5g36PKH2576F488ue0BrfhwCFIlFY/q9UJ3WFNxjKMFPXg0p/a9XrljnRFSzXTI1
 Br6VjNjfEyIlAwxk8nq6AkgxAVmKW1VvbXeKW9Hs5PuUY0gFaEU28EmbNEk0rk3DrQe4
 arnw==
X-Gm-Message-State: APjAAAU248cLr4Qr+MQwoLm2OIOxcfJMLT6HJBNOfAb8rYxlY8br5EZH
 sKK6kVSlUbB1b5qklCA1IbSv4g==
X-Google-Smtp-Source: APXvYqxiyCRuzbDuyXZeHhEAc0nRgpyZ3n17o42gTbA+c5C+3bpxmwjUOM+RkKzs7RcN/9K2GR7Tow==
X-Received: by 2002:adf:ed41:: with SMTP id u1mr27547900wro.162.1563189573081; 
 Mon, 15 Jul 2019 04:19:33 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id y16sm36025043wrg.85.2019.07.15.04.19.32
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 15 Jul 2019 04:19:32 -0700 (PDT)
Date: Mon, 15 Jul 2019 13:19:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20190715111930.j7bdcq3dtayu66ve@steredhat>
References: <20190715102210.31365-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190715102210.31365-1-philmd@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH] hw/net/e1000: Fix erroneous comment
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
Cc: qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 15, 2019 at 12:22:10PM +0200, Philippe Mathieu-Daudé wrote:
> Missed during the QOM convertion in 9af21dbee14.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/net/e1000.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/net/e1000.c b/hw/net/e1000.c
> index 1dc1466332..ec8ded7252 100644
> --- a/hw/net/e1000.c
> +++ b/hw/net/e1000.c
> @@ -1611,7 +1611,7 @@ static const VMStateDescription vmstate_e1000 = {
>  
>  /*
>   * EEPROM contents documented in Tables 5-2 and 5-3, pp. 98-102.
> - * Note: A valid DevId will be inserted during pci_e1000_init().
> + * Note: A valid DevId will be inserted during pci_e1000_realize().
>   */
>  static const uint16_t e1000_eeprom_template[64] = {
>      0x0000, 0x0000, 0x0000, 0x0000,      0xffff, 0x0000,      0x0000, 0x0000,

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

