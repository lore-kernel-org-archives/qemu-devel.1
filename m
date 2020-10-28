Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34952C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 09:27:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5540321481
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 09:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTl6pDRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5540321481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXhk9-0003ZD-2W
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 05:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXhjW-000340-U3; Wed, 28 Oct 2020 05:27:06 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:42189)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXhjV-0001kx-0G; Wed, 28 Oct 2020 05:27:06 -0400
Received: by mail-ej1-x641.google.com with SMTP id h24so6168930ejg.9;
 Wed, 28 Oct 2020 02:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VZjbPnbLr83H0LBI1s9UvyclVapuF6URFmGmb2oiGeI=;
 b=iTl6pDRm3p6ZobY/g9fIF7BF/VTCp19Y6EsYuG5ecORaOCfVSPA+xyhOcmLbmr7pUc
 ZuV6Sll70X8YGaCK+ZUbuXGaK1TGFmTDTFhh7t2H6wZyT1IW6gKfyAmNbalibzjlRACI
 5uczFQ5IRsqn1sGqtMpAGE1mOk54rr0Ykiq5On69Yih2Af6cCgCl/K3yv8LsUQB2Qefv
 yq/OwlXct3l/oEXxXQAUKGw8CXnbrLWPPa8L40jGfcjoJoFFfqr7iFxRdIMKdk9Xg40J
 9gZW3lSdWwj2dqpUV9N61v+0SAfDMXLpcwhttBU0it1QmiFwE9iYb+ZpcK/3vkkrXpSZ
 ZWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VZjbPnbLr83H0LBI1s9UvyclVapuF6URFmGmb2oiGeI=;
 b=ZSsA15L6lMWNZCuMqcwu9ClsmXRfbJx+oxd/ZVmvkiFaY8cCFkukzLJEN62zeySsRq
 kFoxiRH+gqj0S2t2NhJubkFm1so010geOF5eDRed2CP3NKCQAIZp3aKCqn7XAIQQvKr/
 DlOsA3Lk1gRCBQj9KS4s9W6XxAV5aBK3t66Yp9K1Z4pHmG80YpZSVrQumtstgrgDSTD7
 VxPta1AJdDi+suRayzHCJfC1zD1xU7Z/E8zSoUGAzTishxoaTSnEW6un6NwibQkvFjLC
 bzVnJm8Sys+hTsPKkw0zLiaVFYO3R9gJ+J9HoaTlennvGMNmJ1p7t2+cnVtT8H89mnpT
 rs7A==
X-Gm-Message-State: AOAM533tzwSXi+zmjik3+S9B0OnNSmqbF3Apb6oV6G8A0GXz4fpbgMX7
 GRdCrOZL4ET9qusKg73YEJc=
X-Google-Smtp-Source: ABdhPJzby+5C+SVKAcCYLi2eACPKvZvWTZCtNM1DzwfHdrqXimbh+QHoTU1E+ZoJwtIEjZW+aj5Qow==
X-Received: by 2002:a17:906:b197:: with SMTP id
 w23mr7120842ejy.166.1603877222224; 
 Wed, 28 Oct 2020 02:27:02 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id u13sm2644027ejj.4.2020.10.28.02.27.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 02:27:01 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] hw/block/m25p80: Fix Numonyx fast read dummy cycle
 count
To: Joe Komlodi <joe.komlodi@xilinx.com>, qemu-devel@nongnu.org
References: <1603842220-215321-1-git-send-email-komlodi@xilinx.com>
 <1603842220-215321-2-git-send-email-komlodi@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <453e55d5-3433-0865-a902-8851ca563e48@amsat.org>
Date: Wed, 28 Oct 2020 10:26:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1603842220-215321-2-git-send-email-komlodi@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-2.167,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: figlesia@xilinx.com, kwolf@redhat.com, alistair@alistair23.me,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Joe,

On 10/28/20 12:43 AM, Joe Komlodi wrote:
> Numonyx chips determine the number of cycles to wait based on bits 7:4 in the
> volatile configuration register.
> 
> However, if these bits are 0x0 or 0xF, the number of dummy cycles to wait is
> 10 on a QIOR or QIOR4 command, or 8 on any other currently supported
> fast read command. [1]
> 
> [1] https://www.micron.com/-/media/client/global/documents/products/data-sheet/
> nor-flash/serial-nor/mt25q/die-rev-b/mt25q_qlkt_u_02g_cbb_0.pdf
> ?rev=9b167fbf2b3645efba6385949a72e453

Please use single line for URL (even longer than 80 characters):
https://www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/die-rev-b/mt25q_qlkt_u_02g_cbb_0.pdf

Or use

Datasheet: "MT25QU02GCBB Rev. H 05/19 EN"

> Page 34, page 39 note 5

The note 5 is not restricted to QIOR/QIOR4 commands,
so your patch seems incomplete.

> 
> Signed-off-by: Joe Komlodi <komlodi@xilinx.com>
> ---
>  hw/block/m25p80.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 483925f..302ed9d 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -820,6 +820,26 @@ static void reset_memory(Flash *s)
>      trace_m25p80_reset_done(s);
>  }
>  
> +static uint8_t numonyx_extract_cfg_num_dummies(Flash *s)
> +{
> +    uint8_t cycle_count;
> +    uint8_t num_dummies;
> +    assert(get_man(s) == MAN_NUMONYX);
> +
> +    cycle_count = extract32(s->volatile_cfg, 4, 4);

Could be easier to review as:

       num_dummies = extract32(s->volatile_cfg, 4, 4);

       switch (s->cmd_in_progress) {
       /* note 5 comment ... */
       case FAST_READ:
       case ...
           /* field erased or reset in NVRAM */
           if (cycle_count == 0x0 || cycle_count == 0xf) {
               switch (s->cmd_in_progress) {
               case FAST_READ:
               case ...:
                   num_dummies = 10;
                   break;
               case ...:
               case ...:
                   /* assert(s->quad_enable); */
                   num_dummies = 8;
                   break;
               default:
                   qemu_log_mask(GUEST_ERROR, ...);
                   break;
               }
           }
           break;
       default:
           break;
       }

       return num_dummies;

> +    if (cycle_count == 0x0 || cycle_count == 0x0F) {
> +        if (s->cmd_in_progress == QIOR || s->cmd_in_progress == QIOR4) {
> +            num_dummies = 10;
> +        } else {
> +            num_dummies = 8;

Note, this is only true if s->quad_enable.

Maybe clever to use the dumbest approach and copy the table...

static uint8_t numonyx_extract_cfg_num_dummies(Flash *s)
{
    static const unsigned dummy_clock_cycles[0x100][3] = {
      [FAST_READ] = {8, 8, 10},
      ...
    };
    uint8_t num_dummies = extract32(s->volatile_cfg, 4, 4);

    if (cycle_count == 0x0 || cycle_count == 0xf) {
        num_dummies = dummy_clock_cycles[s->cmd_in_progress][mode];
    }

    return num_dummies;
}

> +        }
> +    } else {
> +        num_dummies = cycle_count;
> +    }
> +
> +    return num_dummies;
> +}
> +
>  static void decode_fast_read_cmd(Flash *s)
>  {
>      s->needed_bytes = get_addr_length(s);
> @@ -829,7 +849,7 @@ static void decode_fast_read_cmd(Flash *s)
>          s->needed_bytes += 8;
>          break;
>      case MAN_NUMONYX:
> -        s->needed_bytes += extract32(s->volatile_cfg, 4, 4);
> +        s->needed_bytes += numonyx_extract_cfg_num_dummies(s);
>          break;
>      case MAN_MACRONIX:
>          if (extract32(s->volatile_cfg, 6, 2) == 1) {
> @@ -868,7 +888,7 @@ static void decode_dio_read_cmd(Flash *s)
>                                      );
>          break;
>      case MAN_NUMONYX:
> -        s->needed_bytes += extract32(s->volatile_cfg, 4, 4);
> +        s->needed_bytes += numonyx_extract_cfg_num_dummies(s);
>          break;
>      case MAN_MACRONIX:
>          switch (extract32(s->volatile_cfg, 6, 2)) {
> @@ -908,7 +928,7 @@ static void decode_qio_read_cmd(Flash *s)
>                                      );
>          break;
>      case MAN_NUMONYX:
> -        s->needed_bytes += extract32(s->volatile_cfg, 4, 4);
> +        s->needed_bytes += numonyx_extract_cfg_num_dummies(s);
>          break;
>      case MAN_MACRONIX:
>          switch (extract32(s->volatile_cfg, 6, 2)) {
> 


