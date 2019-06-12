Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CCEC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 09:08:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D0162063F
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 09:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0162063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57752 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hazFI-0001VI-Tu
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 05:08:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39627)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1haz72-0006NE-N7
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 05:00:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1haz70-0006K2-SH
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 05:00:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35728)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1haz70-00065z-M5
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 05:00:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id m3so16017300wrv.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 01:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zgUbtKkYU09l3Z343qmbN5oUGjT+4e9ZBZHffQ9lbCw=;
 b=DY2MaN4xDxzeIMw3tTfBM3mYsqUglwIkN5pA+1FloSv2Ak+8ELTi9LV3Hqce7W8nLT
 VXLcpK4Qn5FJ8GAIuVXgogHxRotEShylWtMKxubg7CPW9twGda9ahWiBnRZfjkbJ4ZQ5
 rjj+DwaV3cGjbK8TqKogmmEBhGKM9Ylx94T3Zx9p76WkaYlDJTSFJo+fMRzLqQxWXqoi
 GiiQ8YR7I5e/wtnf7KB8jn4i89mXBw46kU8dSPuSm4Bow8J0DTbbmHxmF9Z7b7nto6r0
 7lOjpI9LI1y/RKd6mCIVKC/gP1578MNlWCsmAQ/0T7Z+Xtrae0HqffcL+eHQMht6VXqt
 vYuQ==
X-Gm-Message-State: APjAAAW8sxpVO0ay4L768u3pEty18Og5/lbfYh9+Ls8deET5idtM0ifL
 97T/zZbFKkB6AEmp/O8vMvmgKw==
X-Google-Smtp-Source: APXvYqzzsWL7OwpTO+oBc2iaBU6YTQshWprpg7uec4UcsBtCY4A0XlHOEuoWt8AU3hwzrLpxTPRBQw==
X-Received: by 2002:a5d:69ce:: with SMTP id s14mr5909075wrw.135.1560329988417; 
 Wed, 12 Jun 2019 01:59:48 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2eec:b420:bca5:71b1:6738:c7ee?
 ([2a01:e35:2eec:b420:bca5:71b1:6738:c7ee])
 by smtp.gmail.com with ESMTPSA id a81sm7400399wmh.3.2019.06.12.01.59.47
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Jun 2019 01:59:47 -0700 (PDT)
To: Ramon Fried <rfried.dev@gmail.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20190611145556.12940-1-rfried.dev@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <eba0a139-d9c6-4e4c-b6cf-5013da84c908@redhat.com>
Date: Wed, 12 Jun 2019 10:59:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190611145556.12940-1-rfried.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v2] net: cadence_gem: fix compilation error
 when debug is on
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:Xilinx Zynq" <qemu-arm@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/19 4:55 PM, Ramon Fried wrote:
> defining CADENCE_GEM_ERR_DEBUG causes compilation
> errors, fix that.
> 
> Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
> ---
> v2: change %lx to HWADDR_PRIx and %lx to %zdx
> 
>  hw/net/cadence_gem.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 7f63411430..e9b1b1e2eb 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -982,8 +982,8 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
>              return -1;
>          }
>  
> -        DB_PRINT("copy %d bytes to 0x%x\n", MIN(bytes_to_copy, rxbufsize),
> -                rx_desc_get_buffer(s->rx_desc[q]));
> +        DB_PRINT("copy %d bytes to 0x%" HWADDR_PRIx "\n", MIN(bytes_to_copy, rxbufsize),
> +                rx_desc_get_buffer(s, s->rx_desc[q]));
>  
>          /* Copy packet data to emulated DMA buffer */
>          address_space_write(&s->dma_as, rx_desc_get_buffer(s, s->rx_desc[q]) +
> @@ -1156,7 +1156,7 @@ static void gem_transmit(CadenceGEMState *s)
>              if (tx_desc_get_length(desc) > sizeof(tx_packet) -
>                                                 (p - tx_packet)) {
>                  DB_PRINT("TX descriptor @ 0x%x too large: size 0x%x space " \
> -                         "0x%x\n", (unsigned)packet_desc_addr,
> +                         "0x%zdx\n", (unsigned)packet_desc_addr,

The format is either "zd" or "zx". I misunderstood how you want to print
it, if you want hexadecimal, it should be "zx" then.

>                           (unsigned)tx_desc_get_length(desc),
>                           sizeof(tx_packet) - (p - tx_packet));
>                  break;
> 

