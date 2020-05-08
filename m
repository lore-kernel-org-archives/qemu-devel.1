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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AC7C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:45:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7207208DB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 11:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t5raGZJE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7207208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX1R9-0003sv-UL
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 07:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jX1QF-0002sl-Ln; Fri, 08 May 2020 07:44:07 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:44547)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jX1QE-0005bu-Jv; Fri, 08 May 2020 07:44:07 -0400
Received: by mail-lj1-x241.google.com with SMTP id a21so1310944ljj.11;
 Fri, 08 May 2020 04:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Yu8qZZaubaY7D2bQY/ue8Ys5ZBseoparpx54JaaxvcQ=;
 b=t5raGZJELkmV6gnaRc6FvRTOQG9jnSEheYumkYOIeAMCDfLpwXUJuMgFCu+68BqRRN
 ytJ9mo2EExLeTlJjf+ykh15mLyNzn9wxSzZNy8ZrFLK6hbEoaqGaCJWeGGDh39tsSWAx
 xunjsAjiybLm5+8QHvuf/MtCFlh26HtqDWI/hQdhgT0RYorcl7MEAxLbSbzJbrhcVQJg
 /sJ48JoCzcjqFBh6GQCrlzsJZ+tpAODkj2jJRz+u0/Ix5wC7PRvH2R+5Bk+BtS7YXuNR
 zPOuZGC2dZejXFMgEOlyI9rEapisGqeK7nm9mV+QdYbsSA1tYAqhDLI9KpKnOquDBF9U
 oJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Yu8qZZaubaY7D2bQY/ue8Ys5ZBseoparpx54JaaxvcQ=;
 b=ozShttUolMXvwy9C3/OCSQGu8IFcZNEJSq+hmEr2I+yuuBnMgKiuC7txSftrpNZdzh
 C/0K9Wi3/gNI6SgnUhp2sQGQ4uBVxFU67PxA8k0m0EgE647SyaPy7Ew6vdLJQU/koFlR
 jTyICfML+RGlTMG7gP7msVbCUKp0myrA7QM4dGwSG1MJwPNbgPZx0iGbEqFJoBV5XzXe
 Rbbna6ztbJwC7EtZlTSMjpvPF+zlnnt84W6zKaPW/y0WiT3jR+WBEkeaSTLwqLbaALOv
 yc+4o8GSRmPtmhGq4iqh/6XPzmtGZoXKgkN6BX6cXokFyc/wX7CRo7hDbLil4YC+ZjiX
 qFXA==
X-Gm-Message-State: AOAM530sQ4eNV+YSUEyaO7F4qohJcmuMuNDEoYXr5XdmV3oSoKG/C+GW
 4HNglYzm1nmev64W+stHj2I=
X-Google-Smtp-Source: ABdhPJwlXPpZSd3LdCDdYXP5Ym8DLYGL580bg6hNlXqwV8vsWOX9eDAf1DSs42GREPTcL+maTWrKgw==
X-Received: by 2002:a05:651c:54f:: with SMTP id
 q15mr1482286ljp.145.1588938244496; 
 Fri, 08 May 2020 04:44:04 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id u4sm1134907lfu.81.2020.05.08.04.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 04:44:03 -0700 (PDT)
Date: Fri, 8 May 2020 13:43:47 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v3 07/11] net: cadence_gem: Add support for jumbo frames
Message-ID: <20200508114347.GO5519@toto>
References: <1588935645-20351-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1588935645-20351-8-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588935645-20351-8-git-send-email-sai.pavan.boddu@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x241.google.com
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

On Fri, May 08, 2020 at 04:30:41PM +0530, Sai Pavan Boddu wrote:
> Add a property "jumbo-max-len", which can be configured for jumbo frame size
> up to 16,383 bytes, and also introduce new register GEM_JUMBO_MAX_LEN.
> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
>  hw/net/cadence_gem.c         | 21 +++++++++++++++++++--
>  include/hw/net/cadence_gem.h |  1 +
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 5ccec1a..45c50ab 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -61,6 +61,7 @@
>  #define GEM_TXPAUSE       (0x0000003C/4) /* TX Pause Time reg */
>  #define GEM_TXPARTIALSF   (0x00000040/4) /* TX Partial Store and Forward */
>  #define GEM_RXPARTIALSF   (0x00000044/4) /* RX Partial Store and Forward */
> +#define GEM_JUMBO_MAX_LEN (0x00000048 / 4) /* Max Jumbo Frame Size */

Would be nice to align this in the same way as all the others...



>  #define GEM_HASHLO        (0x00000080/4) /* Hash Low address reg */
>  #define GEM_HASHHI        (0x00000084/4) /* Hash High address reg */
>  #define GEM_SPADDR1LO     (0x00000088/4) /* Specific addr 1 low reg */
> @@ -314,7 +315,8 @@
>  
>  #define GEM_MODID_VALUE 0x00020118
>  
> -#define MAX_FRAME_SIZE 2048
> +#define MAX_JUMBO_FRAME_SIZE_MASK 0x3FFF
> +#define MAX_FRAME_SIZE MAX_JUMBO_FRAME_SIZE_MASK
>  
>  static inline uint64_t tx_desc_get_buffer(CadenceGEMState *s, uint32_t *desc)
>  {
> @@ -1343,9 +1345,10 @@ static void gem_reset(DeviceState *d)
>      s->regs[GEM_RXPARTIALSF] = 0x000003ff;
>      s->regs[GEM_MODID] = s->revision;
>      s->regs[GEM_DESCONF] = 0x02500111;
> -    s->regs[GEM_DESCONF2] = 0x2ab13fff;
> +    s->regs[GEM_DESCONF2] = 0x2ab10000 | s->jumbo_max_len;
>      s->regs[GEM_DESCONF5] = 0x002f2045;
>      s->regs[GEM_DESCONF6] = GEM_DESCONF6_64B_MASK;
> +    s->regs[GEM_JUMBO_MAX_LEN] = s->jumbo_max_len;
>  
>      if (s->num_priority_queues > 1) {
>          queues_mask = MAKE_64BIT_MASK(1, s->num_priority_queues - 1);
> @@ -1420,6 +1423,9 @@ static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
>          DB_PRINT("lowering irqs on ISR read\n");
>          /* The interrupts get updated at the end of the function. */
>          break;
> +    case GEM_JUMBO_MAX_LEN:
> +        retval = s->jumbo_max_len;
> +        break;
>      case GEM_PHYMNTNC:
>          if (retval & GEM_PHYMNTNC_OP_R) {
>              uint32_t phy_addr, reg_num;
> @@ -1516,6 +1522,9 @@ static void gem_write(void *opaque, hwaddr offset, uint64_t val,
>          s->regs[GEM_IMR] &= ~val;
>          gem_update_int_status(s);
>          break;
> +    case GEM_JUMBO_MAX_LEN:
> +        s->jumbo_max_len = val & MAX_JUMBO_FRAME_SIZE_MASK;

I don't think writing to this register may increase the max len
beyond the max-len selected at design time (the property).
TBH I'm surprised this register is RW in the spec.

We may need two variables here, one for the design-time configured
max and another for the runtime configurable max.


> +        break;
>      case GEM_INT_Q1_ENABLE ... GEM_INT_Q7_ENABLE:
>          s->regs[GEM_INT_Q1_MASK + offset - GEM_INT_Q1_ENABLE] &= ~val;
>          gem_update_int_status(s);
> @@ -1611,6 +1620,12 @@ static void gem_realize(DeviceState *dev, Error **errp)
>      s->nic = qemu_new_nic(&net_gem_info, &s->conf,
>                            object_get_typename(OBJECT(dev)), dev->id, s);
>  
> +    if (s->jumbo_max_len > MAX_FRAME_SIZE) {
> +        g_warning("jumbo-max-len is grater than %d",


You've got a typo here "grater".

I also think we could error out here if wrong values are chosen.

Best regards,
Edgar

