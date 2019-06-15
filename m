Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371AEC31E47
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 05:40:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 036FC2084B
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 05:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036FC2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58820 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hc1Qc-0006V0-04
	for qemu-devel@archiver.kernel.org; Sat, 15 Jun 2019 01:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53717)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hc1Ox-0005Gv-5A
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 01:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hc1On-00076n-KP
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 01:38:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50405)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hc1Oh-000719-4i
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 01:38:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id c66so4300599wmf.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 22:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EfnrBVu7HaiTAGRTcrTO+ehGnmBoe1i2SF2EEJPUd90=;
 b=d9WuoTA6q7vSXLF6VVr7Inda8o2ZSugnd2x3JYTfj+CdY3xDW6RsNlTTbNlaxGt2Wj
 FyFIfEpgyBpjKlfqn5PRerlMDDWPCz/cdJchN9aVIx/lq6bPaZ3XpmApHJNm8aIx/yN9
 oFmcqL/nkrDVYNOBi56F/JJXwJAtN/ExRLzDbHvPydKEqAZ3Z4Ih4Z6MqZsUlgBjhhmL
 TysgOQo2Jo9/naMTBtnFqNfjS0P0dSqT/upqUWww7QM+tcbudZI0x0ZMOj3CmXztJBMV
 VFFJA88l77evxzFDxXWdmC4BX8eB8ss2Xf3X1LQakQ0T9sq3kjYfPXpI7KYuis0MRkx5
 UdSQ==
X-Gm-Message-State: APjAAAVUEMFf0vCQnmmJq7pAM1xX3BrF//IbLGMM8SM8NrO566lDQkO0
 fwLSTcYziCh7gRoR4vYYLx5/ig==
X-Google-Smtp-Source: APXvYqyqNcvfFWEbNz+2xp57kfkruMRAFCtr4q2/LqUZA2WBYTgVYRT12p1GK3ec+L6fPdCFszk6+Q==
X-Received: by 2002:a7b:c776:: with SMTP id x22mr10133024wmk.55.1560577116726; 
 Fri, 14 Jun 2019 22:38:36 -0700 (PDT)
Received: from [192.168.1.103] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id 139sm5809495wmb.19.2019.06.14.22.38.35
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Jun 2019 22:38:36 -0700 (PDT)
To: Ramon Fried <rfried.dev@gmail.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20190615051559.13767-1-rfried.dev@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d87ea542-7ecc-4fb1-ac1d-929825d23a8a@redhat.com>
Date: Sat, 15 Jun 2019 07:38:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190615051559.13767-1-rfried.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v3] net: cadence_gem: fix compilation error
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

On 6/15/19 7:15 AM, Ramon Fried wrote:
> defining CADENCE_GEM_ERR_DEBUG causes compilation
> errors, fix that.
> 
> Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
> ---
> v2: change %lx to HWADDR_PRIx and %lx to %zdx
> v3: change %zdx to %zx
> 
>  hw/net/cadence_gem.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 7f63411430..ecee22525c 100644
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
> +                         "0x%zx\n", (unsigned)packet_desc_addr,
>                           (unsigned)tx_desc_get_length(desc),
>                           sizeof(tx_packet) - (p - tx_packet));
>                  break;
> 

I still get an error when trying to build on 32bit host with
CADENCE_GEM_ERR_DEBUG enabled (pre-existing to your patch):

  CC      hw/net/cadence_gem.o
./hw/net/cadence_gem.c: In function 'gem_receive':
./hw/net/cadence_gem.c:973:14: error: format '%ld' expects argument of
type 'long int', but argument 4 has type 'size_t {aka unsigned int}'
[-Werror=format=]
     DB_PRINT("config bufsize: %d packet size: %ld\n", rxbufsize, size);
              ^
./hw/net/cadence_gem.c:38:24: note: in definition of macro 'DB_PRINT'
     fprintf(stderr, ## __VA_ARGS__); \
                        ^
cc1: all warnings being treated as errors
./rules.mak:69: recipe for target 'hw/net/cadence_gem.o' failed
make: *** [hw/net/cadence_gem.o] Error 1

However the 64bit host is indeed fixed, so I'm fine with your patch:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Regards,

Phil.

