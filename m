Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07A2C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:26:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C486206D6
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qfphsZKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C486206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX191-0008FK-Mx
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 07:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jX18G-0007Tg-Hw; Fri, 08 May 2020 07:25:32 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:40799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jX18F-0003m3-Ir; Fri, 08 May 2020 07:25:32 -0400
Received: by mail-lf1-x144.google.com with SMTP id u4so1126003lfm.7;
 Fri, 08 May 2020 04:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=4wxIFEFFmesh6LGjya4OycUIY+KvW3qA6x1ds9U+myY=;
 b=qfphsZKUbfoGW67/yjJrlxaDFSOgDeRKkYqzMqShesOLrN3B7qBXe/d527fr1fUZkp
 ZTtRcdCWsmiLBK3Ad/rqVRRIRPI9WndlIY/LIkwcmBdWHAvLfiiDl3E96Pi5nRkbFYid
 huWO+IOAJcdk02pIFMo+QfzgSmWJb9XVp4D8J/O75et6hVqjOeEcvMN2STt65PPhx8qU
 tmqpthFQgi9njrzqqo5+YcCO8jU5EE/BCfpvNJs/n430OdkN+tw2x9R5jXSX4P4JobNV
 0xIizdGhXr4DQ3O2mEpdXxBxoQDhcSYpckppyCMJGidlFtmDlDCLhG9ZUZFfcEGwYE3R
 jotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=4wxIFEFFmesh6LGjya4OycUIY+KvW3qA6x1ds9U+myY=;
 b=rKaqaFkf+a83q9LPq8YswOK4k59s6JRNMgJe+oa5kbQh2oprNOv4SqLNpMWvg7fLpN
 HVCEGmpZRGnKOYZjzUykFNuut/cpOu9+GQcg6RBfM9rNwv8BUscDSe9MfH+at4pNtGJM
 Fg+OYWPUSzZcpSJiCMbWogEE6lajHgE7fqmlnzyw/FPaur69FeWYgWjCFElqPFo+XFFn
 CbAvfk3iwcsoOujWl+Mkgfd4wyShMhGvVBcUeSLHtQGsS/QGIZcv0MKNotuZTmCA5ssT
 Ar/9UMa/m27AlbJU5ynUlIizC9cMlgh052T9OoUz6U6wapckA81sbaoNOSb0v6P/FmK5
 5bew==
X-Gm-Message-State: AOAM5330hdIeILdP09dQsGtugxBPzTS97xTw6sDtjl4JkbnYX3g5AdzC
 spfDAlj84uRX0C2+TMwXt28=
X-Google-Smtp-Source: ABdhPJy05yOZys0QVF2yktfK014C+YKDhaWn+G95HZ9QOQ2tbwfoaJTNo/NymSMZ7B/b4Kjpl79JoA==
X-Received: by 2002:ac2:5290:: with SMTP id q16mr1573550lfm.108.1588937128881; 
 Fri, 08 May 2020 04:25:28 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id w9sm1003312ljw.39.2020.05.08.04.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 04:25:27 -0700 (PDT)
Date: Fri, 8 May 2020 13:25:12 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v3 01/11] net: cadence_gem: Fix debug statements
Message-ID: <20200508112512.GL5519@toto>
References: <1588935645-20351-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1588935645-20351-2-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588935645-20351-2-git-send-email-sai.pavan.boddu@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Tong Ho <tong.ho@xilinx.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Ramon Fried <rfried.dev@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 08, 2020 at 04:30:35PM +0530, Sai Pavan Boddu wrote:
> Enabling debug breaks the build, Fix them and make debug statements
> always compilable. Fix few statements to use sized integer casting.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
>  hw/net/cadence_gem.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 22a0b1b..5476c62 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -35,14 +35,13 @@
>  #include "sysemu/dma.h"
>  #include "net/checksum.h"
>  
> -#ifdef CADENCE_GEM_ERR_DEBUG
> -#define DB_PRINT(...) do { \
> -    fprintf(stderr,  ": %s: ", __func__); \
> -    fprintf(stderr, ## __VA_ARGS__); \
> -    } while (0)
> -#else
> -    #define DB_PRINT(...)
> -#endif
> +#define CADENCE_GEM_ERR_DEBUG 0
> +#define DB_PRINT(...) do {\
> +    if (CADENCE_GEM_ERR_DEBUG) {   \
> +        qemu_log(": %s: ", __func__); \
> +        qemu_log(__VA_ARGS__); \
> +    } \
> +} while (0)
>  
>  #define GEM_NWCTRL        (0x00000000/4) /* Network Control reg */
>  #define GEM_NWCFG         (0x00000004/4) /* Network Config reg */
> @@ -979,7 +978,7 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
>          size += 4;
>      }
>  
> -    DB_PRINT("config bufsize: %d packet size: %ld\n", rxbufsize, size);
> +    DB_PRINT("config bufsize: %u packet size: %zd\n", rxbufsize, size);
>  
>      /* Find which queue we are targeting */
>      q = get_queue_from_screen(s, rxbuf_ptr, rxbufsize);
> @@ -992,9 +991,9 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
>              return -1;
>          }
>  
> -        DB_PRINT("copy %u bytes to 0x%" PRIx64 "\n",
> -                 MIN(bytes_to_copy, rxbufsize),
> -                 rx_desc_get_buffer(s, s->rx_desc[q]));
> +        DB_PRINT("copy %" PRIu32 " bytes to 0x%" PRIx64 "\n",
> +                MIN(bytes_to_copy, rxbufsize),
> +                rx_desc_get_buffer(s, s->rx_desc[q]));
>  
>          /* Copy packet data to emulated DMA buffer */
>          address_space_write(&s->dma_as, rx_desc_get_buffer(s, s->rx_desc[q]) +
> @@ -1160,8 +1159,8 @@ static void gem_transmit(CadenceGEMState *s)
>               */
>              if ((tx_desc_get_buffer(s, desc) == 0) ||
>                  (tx_desc_get_length(desc) == 0)) {
> -                DB_PRINT("Invalid TX descriptor @ 0x%x\n",
> -                         (unsigned)packet_desc_addr);
> +                DB_PRINT("Invalid TX descriptor @ 0x%" HWADDR_PRIx "\n",
> +                         packet_desc_addr);
>                  break;
>              }
>  
> -- 
> 2.7.4
> 

