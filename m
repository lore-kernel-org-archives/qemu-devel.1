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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C86C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A00B206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0D5DYzY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A00B206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcxp-0004ji-IZ
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 11:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jVcwO-0002m8-Nr; Mon, 04 May 2020 11:23:32 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:37341)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jVcwN-0002Ha-Es; Mon, 04 May 2020 11:23:32 -0400
Received: by mail-lf1-x141.google.com with SMTP id t11so10086728lfe.4;
 Mon, 04 May 2020 08:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=t7umT61VFs5Cczfn6S4IzK+OH7rPLyL1w6s03PauFPw=;
 b=r0D5DYzYrr91Owjd9SDsi8C78O38LsEvFXjh19jUMe8AMuzX5ZUdGZ2NdPhmErb9QZ
 5oQvPnYyGRe9zBNZ79hKIHy2oXja/XkGEn0PSaXHeIenFKR98JpU6IEFKeDhLHUZEtco
 Z324rEzj+ar4TyWDVbaVkrPrFXhcdpZe5XOykj9+CUiNmvlFdipbpjWSxqwUI0Y13z/Q
 8FpIjRJoD1MiE8m1KYYHRBpvvZeTH3HeD4XjSqM1roLKAGxyZAfN9vc6iM3SNYBPw32/
 9Cm4CFpvYQ8Efrxj6wOnmGYSjsVd4hOs2NHevwdb95bLfc0q59QkgibMxrifKIaLrVNW
 Cwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=t7umT61VFs5Cczfn6S4IzK+OH7rPLyL1w6s03PauFPw=;
 b=eG84VdN3mjQ6+UPsmwwbu2X4s9CQNIosGLXZA9xnFlc4GwMqm//iy+An4v9YegnTvC
 1m45a0vdj+jxs1zgdCk+WhgSMSIRTEKQpYdGXUsY7g4vEY2I+1FLlWs7oWIfY5awJH5N
 gRbLc/zKtSVPJ5AZN82p+qZDsM/qnJUk3RpoOs8HbiWFltxSDY5Lfm6wNIXicO9XrT4l
 qT+ccw85Vl+OalImXPU+qn4Uz7+11Uim8o+EPrCtTaZE4H09PRGkyocQQvzUpsAI49uX
 pfLhoz7S+hQh/CrgWbbckh9qLk1w3n/ytguQVGDnE1y9vA5kB1YsxUYg3Cvd0gSuM64k
 ULGg==
X-Gm-Message-State: AGi0PuZ1D8hBvjHXMb7xJBrrPD7HmqHmeThO6gFqV/sdrpLcHWigJgLF
 VytRgGTJlTHtL++GdDZBXxM=
X-Google-Smtp-Source: APiQypJ3RtwOSp67961WxUp+IoSnHa5rFedrmiCllVbETf6PdkhGge5Urpj99DEXYy71IivgxD0pMA==
X-Received: by 2002:ac2:57d4:: with SMTP id k20mr12075902lfo.84.1588605809100; 
 Mon, 04 May 2020 08:23:29 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id e16sm11614042lfc.63.2020.05.04.08.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 08:23:29 -0700 (PDT)
Date: Mon, 4 May 2020 17:23:20 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v2 06/10] net: cadence_gem: Add support for jumbo frames
Message-ID: <20200504152320.GF5519@toto>
References: <1588601168-27576-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1588601168-27576-7-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588601168-27576-7-git-send-email-sai.pavan.boddu@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x141.google.com
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

On Mon, May 04, 2020 at 07:36:04PM +0530, Sai Pavan Boddu wrote:
> Jumbo frames of size 10240 bytes is added.

Hi Sai,

I think we should make this a property since it's a design
configuration option (10240 being the default).

> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
>  hw/net/cadence_gem.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index beb38ec..848be3f 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -313,6 +313,7 @@
>  #define DESC_1_RX_EOF 0x00008000
>  
>  #define GEM_MODID_VALUE 0x00020118
> +#define MAX_TX_FRAME_SIZE 10240

This applies to RX aswell, better to rename to MAX_FRAME_SIZE.

>  
>  static inline uint64_t tx_desc_get_buffer(CadenceGEMState *s, uint32_t *desc)
>  {
> @@ -1143,7 +1144,7 @@ static void gem_transmit(CadenceGEMState *s)
>  {
>      uint32_t desc[DESC_MAX_NUM_WORDS];
>      hwaddr packet_desc_addr;
> -    uint8_t     tx_packet[2048];
> +    uint8_t     tx_packet[MAX_TX_FRAME_SIZE];

rxbuf in gem_receive needs the same.
We also may want to consider moving these buffers from the stack
to CadenceGEMState *s.


>      uint8_t     *p;
>      unsigned    total_bytes;
>      int q = 0;
> @@ -1344,7 +1345,7 @@ static void gem_reset(DeviceState *d)
>      s->regs[GEM_RXPARTIALSF] = 0x000003ff;
>      s->regs[GEM_MODID] = s->revision;
>      s->regs[GEM_DESCONF] = 0x02500111;
> -    s->regs[GEM_DESCONF2] = 0x2ab13fff;
> +    s->regs[GEM_DESCONF2] = 0x2ab12800;


We need to add and populate the following register:
#define GEM_JUMBO_MAX_LEN   (0x00000048/4) /* Maximum Jumbo Frame Size */


>      s->regs[GEM_DESCONF5] = 0x002f2045;
>      s->regs[GEM_DESCONF6] = GEM_DESCONF6_64B_MASK;
>  
> -- 
> 2.7.4
> 

