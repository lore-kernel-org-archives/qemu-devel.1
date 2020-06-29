Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347ACC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:19:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F09CF233EA
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 09:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O46gmB/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F09CF233EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jppx1-0007iL-6F
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 05:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jppwG-0006sU-4A; Mon, 29 Jun 2020 05:18:56 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37371)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jppwE-0005gM-N2; Mon, 29 Jun 2020 05:18:55 -0400
Received: by mail-wm1-x343.google.com with SMTP id o2so15389725wmh.2;
 Mon, 29 Jun 2020 02:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1qH+c6BpcuI+TynzO1Eqq0pfdwbZ+m4JZp4tphwtLak=;
 b=O46gmB/zyAKk+q6DJhZbvqzw7IjmdGg0Srwdk8TgaFVvSYMT0pfB3MYs/G4QwLFsaA
 p80iAM9wLHjqxLkSLR/yKgIUG1Be15GLSS3xqk5TuHO5RQGrA4EtB/5lIFmP8DyqNIjg
 +VPcPWrhbQ6nW2sPR7cm4wNUMIJJp6SfcTTAu2+FhF9VP+86/SLzn97lNkRz16P3ybOx
 rUBjpZrZJtLi4pjLDQK9I8Wv8kZDFzTD8HFEXSXcwyClRhXFiUmQSRxc7Ye2IgpKiuj4
 J6cSfxqhHMNz+rYbjj4zcrryCx7/CIrYeNfMUi9fpZHcUUq6SapmNMlgreNQvXPOmhDR
 DWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1qH+c6BpcuI+TynzO1Eqq0pfdwbZ+m4JZp4tphwtLak=;
 b=tpYao3DwAi0EJ7c5iwSorHqEQj3VJeZQ0oRH3irdUpGx8D/J/xR+PQV7Gaf20t9I+f
 3pTjkvJN9Bf6vRU6DPu8y4auE7MYTAwLVz9EQUpIGfsldPmMWRbpPasl0bVdu//Z1TfK
 g7pAY8vEl1yxwBWHkFGoYlRpeH7QWOp7dLabX875hDntIUmHQY9FwWZvTe45ab9r+LY+
 fcklccVWkXnFSQH4n6veriz/GGYnsKy0FAIccOObL3OcSQofhmJFdTSh2cNL5BO7TWjq
 DEZLZ84bntm2GivD28LNfaOjmyZndxZ3mNuFzPAd6v5f+Wl5sAaaqF2LE/p9owJlBT8l
 AB0w==
X-Gm-Message-State: AOAM5318CiZJ3tESoVDlFGdBrCDy4KLr8OmwnL/Y83BDodU3hDPqL5pn
 UA/sD2S17rucBXZ2kY2SBtM=
X-Google-Smtp-Source: ABdhPJwhMiC/8MphdLRRhq44Z1anl9bx69HzO7aDC8sPXZipLxJrLQcTY3wmLeuWDMlejnhyXr6T2w==
X-Received: by 2002:a1c:ba0b:: with SMTP id k11mr15364472wmf.140.1593422332748; 
 Mon, 29 Jun 2020 02:18:52 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id o205sm13480186wme.24.2020.06.29.02.18.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 02:18:52 -0700 (PDT)
Subject: Re: [PATCH 17/17] Replace uses of FROM_SSI_SLAVE() macro with QOM
 casts
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200628142429.17111-1-peter.maydell@linaro.org>
 <20200628142429.17111-18-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bed3a8e3-278d-ae8c-7110-a3bb695dd51d@amsat.org>
Date: Mon, 29 Jun 2020 11:18:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200628142429.17111-18-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/28/20 4:24 PM, Peter Maydell wrote:
> The FROM_SSI_SLAVE() macro predates QOM and is used as a typesafe way
> to cast from an SSISlave* to the instance struct of a subtype of
> TYPE_SSI_SLAVE.  Switch to using the QOM cast macros instead, which
> have the same effect (by writing the QOM macros if the types were
> previously missing them.)
> 
> (The FROM_SSI_SLAVE() macro allows the SSISlave member of the
> subtype's struct to be anywhere as long as it is named "ssidev",
> whereas a QOM cast macro insists that it is the first thing in the
> subtype's struct.  This is true for all the types we convert here.)
> 
> This removes all the uses of FROM_SSI_SLAVE() so we can delete the
> definition.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/ssi/ssi.h |  2 --
>  hw/arm/z2.c          | 11 +++++++----
>  hw/display/ads7846.c |  9 ++++++---
>  hw/display/ssd0323.c | 10 +++++++---
>  hw/sd/ssi-sd.c       |  4 ++--
>  5 files changed, 22 insertions(+), 14 deletions(-)
> 
[...]
> diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
> index 25cec2ddeaa..25cdf4c966d 100644
> --- a/hw/sd/ssi-sd.c
> +++ b/hw/sd/ssi-sd.c
> @@ -74,7 +74,7 @@ typedef struct {
>  
>  static uint32_t ssi_sd_transfer(SSISlave *dev, uint32_t val)
>  {
> -    ssi_sd_state *s = FROM_SSI_SLAVE(ssi_sd_state, dev);
> +    ssi_sd_state *s = SSI_SD(dev);
>  
>      /* Special case: allow CMD12 (STOP TRANSMISSION) while reading data.  */
>      if (s->mode == SSI_SD_DATA_READ && val == 0x4d) {
> @@ -241,7 +241,7 @@ static const VMStateDescription vmstate_ssi_sd = {
>  
>  static void ssi_sd_realize(SSISlave *d, Error **errp)
>  {
> -    ssi_sd_state *s = FROM_SSI_SLAVE(ssi_sd_state, d);
> +    ssi_sd_state *s = SSI_SD(d);
>      DeviceState *carddev;
>      DriveInfo *dinfo;
>      Error *err = NULL;
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


