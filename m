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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE7DC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:29:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69972206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtaW4kLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69972206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVd1t-0002xK-CH
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 11:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jVd0Y-0000gY-Q2; Mon, 04 May 2020 11:27:50 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:43291)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jVd0X-0003H0-SX; Mon, 04 May 2020 11:27:50 -0400
Received: by mail-lj1-x244.google.com with SMTP id l19so10065206lje.10;
 Mon, 04 May 2020 08:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=u6tqTqMn9JlKn3Z0k8TdTvdI+JEFG4xGOoyIIagTdw8=;
 b=MtaW4kLC83nG9oGiiehsEB0UxqRygB8kuL5NQhrjg2oA+wzz2+9pS0dpECdPZcZzXj
 fJxwAH0hcnyGvmvtdzkJwJZro12inyAeNzS4+cxDqCDU6Ex96HstyWSMJqrqHGUj+m2a
 cwQOjJ5MAmabi6zkVNstw2BTNiivzSvrIVyEqoNWvghdsQzndxZji4735d+fDtc/uwT3
 r5kSVxCi5rFj9hF3xibxzm1HJ7xF6sWby2TWUm2dsvv4MnGockGuK3szEqkZrM/6mm5J
 GXWQlN8P3sBHFYtAVQSEzS7AGghWorSBf+JFNuzFZj/i+2kn9EkIu44Bp6h3uJW3Ve5w
 5Law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=u6tqTqMn9JlKn3Z0k8TdTvdI+JEFG4xGOoyIIagTdw8=;
 b=B0haM1SY2K1HzBR9gw6FR8h/e43NPCmPYreGxsLJM35Q5oWvg1/7ZfrKJh5M+cxqXd
 w9vEVasKibRKsHBXao+56UByaHrDNWrjOWxO2FPDZs5DgJvxpxkMuKYTWG21Z869LYSU
 /ao2cwvwRUfDdhJ+S5J016HeoQ71KmT/WgTeEG6pJzpcm06/S7/ByGhfPI8qPU3lfA/s
 A6d0HESTYbqUcutMnfQArWFuTuLhmoGRFFzMs4kw4Oky+Di3vXA4IeCNyFxi39vAdL1k
 3AnI5xK6PMMHpbSRsDyvIJjMFuNEN1iVVCb7pYL6yeG5QT5P03BfviWueSCQx2J5p2GY
 b14w==
X-Gm-Message-State: AGi0PuZj9MjsTXNWw/P0NR5hG4YO3A/Ids+5wiWApYaXRgyGjoD3OLSK
 drT6ZFNSgMkbRggIoqIcCF8=
X-Google-Smtp-Source: APiQypJalhq3Mo+MHqoeN7zywe4EPYGFtz93okBEcN7oSJ0Unb9xP74jiF/veScRKFVSk4aXt7UNwQ==
X-Received: by 2002:a2e:593:: with SMTP id 141mr10078506ljf.271.1588606067980; 
 Mon, 04 May 2020 08:27:47 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id q24sm9942298lfc.29.2020.05.04.08.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 08:27:47 -0700 (PDT)
Date: Mon, 4 May 2020 17:27:46 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v2 08/10] net: cadence_gem: Update the reset value for
 interrupt mask register
Message-ID: <20200504152746.GH5519@toto>
References: <1588601168-27576-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1588601168-27576-9-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588601168-27576-9-git-send-email-sai.pavan.boddu@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x244.google.com
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

On Mon, May 04, 2020 at 07:36:06PM +0530, Sai Pavan Boddu wrote:
> Mask all interrupt on reset.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
>  hw/net/cadence_gem.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 9eb72a2..ac3a553 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -1348,6 +1348,7 @@ static void gem_reset(DeviceState *d)
>      s->regs[GEM_DESCONF2] = 0x2ab12800;
>      s->regs[GEM_DESCONF5] = 0x002f2045;
>      s->regs[GEM_DESCONF6] = GEM_DESCONF6_64B_MASK;
> +    s->regs[GEM_INT_Q1_MASK] = 0x00000CE6;
>  
>      if (s->num_priority_queues > 1) {
>          queues_mask = MAKE_64BIT_MASK(1, s->num_priority_queues - 1);
> -- 
> 2.7.4
> 

