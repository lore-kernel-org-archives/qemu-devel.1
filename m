Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E358EC4321D
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 08:49:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFA1D212F5
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 08:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA1D212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52916 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hacTH-00011q-IJ
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 04:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54046)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hacNg-0004II-5F
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 04:43:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hacFJ-0004WA-LM
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 04:35:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36246)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hacFJ-0004K5-EP
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 04:35:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so11998569wrs.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 01:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IbYKK7JIHi3arHPNORfmRc7ZgDoLoIRhbg7TMUX9TXI=;
 b=sM2i5pOigv0UJG4YAcAElbv0pHNk8vmjSGtdrU3o8TH0cj36ykcSpy/jpxiWqR3I++
 /iTqR47usWtnX7F8Yx32+UuOASjO9DJyIBHs11sa2ITWQ59fn6swY7rwzcqiCLUvGvVq
 nouI1n0yiMhzg3UGKISf07Wx/SP7rOgNUB+2Ui2jlewxGNCjvAcn0ld5swRFzv/1tPmc
 kDHFgzMDVwnFGltF1oVQ7sdVcxqCeYTZL8liq4p4JHHJgKKlz4PBoLUIzZsCaZVUqYaR
 /o9Q7aCYqIoxGcYHsZZO6suFc94MC6rNwuylMDAfujt0ExqQi8iCCfEZtbQaRXkZshA1
 BD6w==
X-Gm-Message-State: APjAAAWEQrl3/hIOAKsjle15ZdVW/Nju1GHdWI7KKmQUOUmAkUZOIkv4
 sheHSfZayhBfUgKKm5z8Z6KyOA==
X-Google-Smtp-Source: APXvYqx2zRHlaCH+OQTdi/0lTqSsfDkTLorwDmxveZnlAG59nTwtWTdyWZF8l69gcq/JZKuC4ChrUw==
X-Received: by 2002:adf:9267:: with SMTP id 94mr26729215wrj.338.1560242096110; 
 Tue, 11 Jun 2019 01:34:56 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2eec:b420:d26b:a0d4:f86e:1389?
 ([2a01:e35:2eec:b420:d26b:a0d4:f86e:1389])
 by smtp.gmail.com with ESMTPSA id o6sm1901175wmc.15.2019.06.11.01.34.55
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 01:34:55 -0700 (PDT)
To: Ramon Fried <rfried.dev@gmail.com>, qemu-devel@nongnu.org
References: <20190609100837.17586-1-rfried.dev@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <04cd3c78-9d8e-8958-1cdf-f65ab7d91dc7@redhat.com>
Date: Tue, 11 Jun 2019 10:34:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190609100837.17586-1-rfried.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH] net: cadence_gem: fix compilation error
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

Hi Ramon,

On 6/9/19 12:08 PM, Ramon Fried wrote:
> defining CADENCE_GEM_ERR_DEBUG causes compilation
> errors, fix that.
> 
> Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
> ---
>  hw/net/cadence_gem.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 7f63411430..5cc5a71524 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -982,8 +982,8 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
>              return -1;
>          }
>  
> -        DB_PRINT("copy %d bytes to 0x%x\n", MIN(bytes_to_copy, rxbufsize),
> -                rx_desc_get_buffer(s->rx_desc[q]));
> +        DB_PRINT("copy %d bytes to 0x%lx\n", MIN(bytes_to_copy, rxbufsize),
> +                rx_desc_get_buffer(s, s->rx_desc[q]));

Your patch fails on 32-bit hosts:

./hw/net/cadence_gem.c:987:18: error: format '%lx' expects argument of
type 'long unsigned int', but argument 4 has type 'uint64_t {aka long
long unsigned int}' [-Werror=format=]
         DB_PRINT("copy %d bytes to 0x%lx\n", MIN(bytes_to_copy, rxbufsize),
                  ^
./hw/net/cadence_gem.c:39:24: note: in definition of macro 'DB_PRINT'
     fprintf(stderr, ## __VA_ARGS__); \
                        ^
./hw/net/cadence_gem.c: In function 'gem_transmit':
./hw/net/cadence_gem.c:1160:26: error: format '%lx' expects argument of
type 'long unsigned int', but argument 5 has type 'unsigned int'
[-Werror=format=]
                 DB_PRINT("TX descriptor @ 0x%x too large: size 0x%x
space " \
                          ^
./hw/net/cadence_gem.c:39:24: note: in definition of macro 'DB_PRINT'
     fprintf(stderr, ## __VA_ARGS__); \
                        ^
cc1: all warnings being treated as errors

QEMU provides "HWADDR_PRIx" format for addresses, see for example few
lines earlier:

    DB_PRINT("read descriptor 0x%" HWADDR_PRIx "\n", packet_desc_addr);


>  
>          /* Copy packet data to emulated DMA buffer */
>          address_space_write(&s->dma_as, rx_desc_get_buffer(s, s->rx_desc[q]) +
> @@ -1156,7 +1156,7 @@ static void gem_transmit(CadenceGEMState *s)
>              if (tx_desc_get_length(desc) > sizeof(tx_packet) -
>                                                 (p - tx_packet)) {
>                  DB_PRINT("TX descriptor @ 0x%x too large: size 0x%x space " \
> -                         "0x%x\n", (unsigned)packet_desc_addr,
> +                         "0x%lx\n", (unsigned)packet_desc_addr,

Here the correct format seems to be "%zd" (difference of sizeof).

>                           (unsigned)tx_desc_get_length(desc),
>                           sizeof(tx_packet) - (p - tx_packet));
>                  break;
> 

Nowadays QEMU prefers to move from the old DB_PRINT() macros to the
trace events API, see for example this commit:

https://git.qemu.org/?p=qemu.git;a=commitdiff;h=da1804d17a9ed7f060c072fbc4889db5fbc9c7d2;hp=a4f667b6714916683408b983cfe0a615a725775f

The first line you changed would be replaced by a trace event, while the
second could be replaced by a qemu_log_mask() call (it is an error
condition).

Also I suggest to include "QEMU Trivial <qemu-trivial@nongnu.org>" in
the list of recipients, so your patch might get reviewed/merged quicker.

Regards,

Phil.

