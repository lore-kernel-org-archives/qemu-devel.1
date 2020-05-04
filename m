Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06A8C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:51:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE041206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q15pqy9N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE041206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcRT-0002Fg-Ie
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jVcFi-00071F-Qc; Mon, 04 May 2020 10:39:26 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:40957)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jVcFh-0003ab-Qu; Mon, 04 May 2020 10:39:26 -0400
Received: by mail-lj1-x242.google.com with SMTP id y4so9888488ljn.7;
 Mon, 04 May 2020 07:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=rKeNqQ2d2ObLs/zCVsCYYGZ7H33qapCedtGJaSloaCA=;
 b=Q15pqy9NQFvF7fKPq5pgCvmbyxV8h7Af+MCej8OaNJuKmbGx9rEhRu62o1bygHcaBP
 tgOjLFznphtB/QkbHadwW+6ecYqfRs5d/j4E9ruiini8zTh8sy3XeluID7PmoXvyLno/
 YJHWsLeWJRknIovy0m5PyBWNgw2bOvu9zs4AUA1b7GYqKDv1YBG1AXZEzLnJZlOrr6Ap
 iev7Yp3o7u0gDDhaTxnwdJB553RW2841jb8e7NqHonWhytRmWcZXoAmLKpKlkWp9hcdU
 lfdwcsN0wWBb9zqiGR2ulR6tapjbJ7TH/OvKO+PQm9zL6KuAJhC/Bmp9xUL7FHITWFDN
 asEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=rKeNqQ2d2ObLs/zCVsCYYGZ7H33qapCedtGJaSloaCA=;
 b=W/RtWW/qk5yBuxyLSe31+gqnNhDJVclGXztNJ/0Ii1ePCFdPRop55DwomFyiUK45Kr
 oI8xED8+1fQojn6hQv+JkXVe2eR5BzorjfbJSDsqPRhhsobSNEZuCZQFw6VwUGjMg8v+
 wDSufWKP3wiMoJhnSvMe+hSBQOPVOuXv/Ted1hZI78gQ1FA5b4YGHRo3zg4+C+QhgHp5
 HbwhMiqEk8xQ1u2KJAxLMJ84V9zmRHE9rGN5/J+vTMu5o36jlEvCGanlOkfDyBJcYejj
 2lhaiX/eHepP0EVFWEBC1xF/xZ7acw4wMF1TaR1ZfhCkLoPSoQsHn4SyoqvgghOMAc3G
 Px2Q==
X-Gm-Message-State: AGi0PuZ/OcgBVpDhUXwBF8MuvVoY7fCj4+EvDSRdOuA5Vc4mqwqtfM3D
 jdeHXgoBxlLj21OCmpF+vdQ=
X-Google-Smtp-Source: APiQypJLN8DS6CGjU753Woexe7ffKkjgGTfB6j5twIme7KTBsV6CE3jnXEw8Yk5OL1h3dvG8+mRrCQ==
X-Received: by 2002:a05:651c:549:: with SMTP id
 q9mr10768660ljp.236.1588603163597; 
 Mon, 04 May 2020 07:39:23 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id j22sm8389941ljh.107.2020.05.04.07.39.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:39:22 -0700 (PDT)
Date: Mon, 4 May 2020 16:39:22 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v2 01/10] net: cadence_gem: Fix debug statements
Message-ID: <20200504143922.GB5519@toto>
References: <1588601168-27576-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1588601168-27576-2-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588601168-27576-2-git-send-email-sai.pavan.boddu@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x242.google.com
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

On Mon, May 04, 2020 at 07:35:59PM +0530, Sai Pavan Boddu wrote:
> Enabling debug breaks the build, Fix them and make debug statements
> always compilable. Fix few statements to use sized integer casting.
> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
>  hw/net/cadence_gem.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 22a0b1b..2f244eb 100644
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
> @@ -979,7 +978,8 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
>          size += 4;
>      }
>  
> -    DB_PRINT("config bufsize: %d packet size: %ld\n", rxbufsize, size);
> +    DB_PRINT("config bufsize: %" PRIu64 " packet size: %" PRIu64 "\n",
> +             (uint64_t) rxbufsize, (uint64_t) size);

Shouldn't these be %u and %zd rather than casting to uint64_t?


>  
>      /* Find which queue we are targeting */
>      q = get_queue_from_screen(s, rxbuf_ptr, rxbufsize);
> @@ -992,9 +992,9 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
>              return -1;
>          }
>  
> -        DB_PRINT("copy %u bytes to 0x%" PRIx64 "\n",
> -                 MIN(bytes_to_copy, rxbufsize),
> -                 rx_desc_get_buffer(s, s->rx_desc[q]));
> +        DB_PRINT("copy %" PRIu32 " bytes to 0x%" PRIx64 "\n",
> +                MIN(bytes_to_copy, rxbufsize),
> +                rx_desc_get_buffer(s, s->rx_desc[q] + rxbuf_offset));

Looks like this is changing what we print (+ rxbuf_offset), was
that intentional? (it was not mentioned in the commit message)


>  
>          /* Copy packet data to emulated DMA buffer */
>          address_space_write(&s->dma_as, rx_desc_get_buffer(s, s->rx_desc[q]) +
> @@ -1160,8 +1160,8 @@ static void gem_transmit(CadenceGEMState *s)
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

