Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F86C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:36:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A1402067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A1402067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv4FB-00029m-9k
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 15:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>)
 id 1jv4EQ-0000oZ-70; Mon, 13 Jul 2020 15:35:18 -0400
Received: from relay68.bu.edu ([128.197.228.73]:49261)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>)
 id 1jv4EO-0008Se-G4; Mon, 13 Jul 2020 15:35:17 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 06DJYLLj026127
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 13 Jul 2020 15:34:25 -0400
Date: Mon, 13 Jul 2020 15:34:21 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 8/9] hw/sd/sdcard: Update coding style to make
 checkpatch.pl happy
Message-ID: <20200713193421.sca2svuigmdrc4nu@mozz.bu.edu>
References: <20200713183209.26308-1-f4bug@amsat.org>
 <20200713183209.26308-9-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200713183209.26308-9-f4bug@amsat.org>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 15:35:15
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>, qemu-block@nongnu.org,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200713 2032, Philippe Mathieu-Daudé wrote:
> To make the next commit easier to review, clean this code first.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Message-Id: <20200630133912.9428-3-f4bug@amsat.org>
> ---

Reviewed-by: Alexander Bulekov <alxndr@bu.edu>

>  hw/sd/sd.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 5ab945dade..0f048358ab 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1175,8 +1175,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>              sd->data_start = addr;
>              sd->data_offset = 0;
>  
> -            if (sd->data_start + sd->blk_len > sd->size)
> +            if (sd->data_start + sd->blk_len > sd->size) {
>                  sd->card_status |= ADDRESS_ERROR;
> +            }
>              return sd_r1;
>  
>          default:
> @@ -1191,8 +1192,9 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>              sd->data_start = addr;
>              sd->data_offset = 0;
>  
> -            if (sd->data_start + sd->blk_len > sd->size)
> +            if (sd->data_start + sd->blk_len > sd->size) {
>                  sd->card_status |= ADDRESS_ERROR;
> +            }
>              return sd_r1;
>  
>          default:
> @@ -1237,12 +1239,15 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>              sd->data_offset = 0;
>              sd->blk_written = 0;
>  
> -            if (sd->data_start + sd->blk_len > sd->size)
> +            if (sd->data_start + sd->blk_len > sd->size) {
>                  sd->card_status |= ADDRESS_ERROR;
> -            if (sd_wp_addr(sd, sd->data_start))
> +            }
> +            if (sd_wp_addr(sd, sd->data_start)) {
>                  sd->card_status |= WP_VIOLATION;
> -            if (sd->csd[14] & 0x30)
> +            }
> +            if (sd->csd[14] & 0x30) {
>                  sd->card_status |= WP_VIOLATION;
> +            }
>              return sd_r1;
>  
>          default:
> @@ -1261,12 +1266,15 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>              sd->data_offset = 0;
>              sd->blk_written = 0;
>  
> -            if (sd->data_start + sd->blk_len > sd->size)
> +            if (sd->data_start + sd->blk_len > sd->size) {
>                  sd->card_status |= ADDRESS_ERROR;
> -            if (sd_wp_addr(sd, sd->data_start))
> +            }
> +            if (sd_wp_addr(sd, sd->data_start)) {
>                  sd->card_status |= WP_VIOLATION;
> -            if (sd->csd[14] & 0x30)
> +            }
> +            if (sd->csd[14] & 0x30) {
>                  sd->card_status |= WP_VIOLATION;
> +            }
>              return sd_r1;
>  
>          default:
> -- 
> 2.21.3
> 

