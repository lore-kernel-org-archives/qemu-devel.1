Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82459C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 09:45:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A6CB206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 09:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bA4PMPY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6CB206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzzh4-0005mo-KJ
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 05:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jzzgQ-0005HT-FV
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 05:44:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44129
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jzzgO-0005t6-RJ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 05:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595843071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EqgHuQDBC2z1a17S9O8w9lXpAFcGcy+hvIUsaf7JH84=;
 b=bA4PMPY5X8z58Dks1w63Ku7OsaR5Jqsu5u73AfZ40gauisq+Xd2Aepf41sMAnMr3d9ea+y
 V10F9iU6IoOXSzBPQsf3Txj1qAzxplWxIBBq2nuiD3pu3D0Unvd7VGJK79v3OM09goPhfC
 KAzsH5fxLYitbV686q/iXU7euvIYXLI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-aTeYoT-pNqCmYxCHzm0gnw-1; Mon, 27 Jul 2020 05:44:27 -0400
X-MC-Unique: aTeYoT-pNqCmYxCHzm0gnw-1
Received: by mail-wm1-f72.google.com with SMTP id l5so7614547wml.7
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 02:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EqgHuQDBC2z1a17S9O8w9lXpAFcGcy+hvIUsaf7JH84=;
 b=D4fP1pi3l0Y7Owu0+A7/lltra8oQhVYv6fcfUCW8+XaPiNjgiOjRg1M7ETne6ig0Gy
 Lt3sPc/IO/Zx14K61IevuJ868WDsQpbsYD4Zag6tm1eLaSOMkos/qdgd3HmWUS3aqWjW
 ySjbgEg4pJ0pRgU5hdvNsCV/hN47G+5/FsDShIqrM8W5yxEU1V+lFgWkQ3+0WgCg0hU+
 ghqwA8rXD3nyMnl3Uv5HDcDX9BGPSndVnfyNCmiv3VMz8oglgRBvfl+caMBqoQu556m+
 4MurjjxmnBCO3dQ6NJuQhWD3Ii4I8aGuCBR/SfedyECipocymUjo3DJCR7Zeaeq7i0Fe
 hukg==
X-Gm-Message-State: AOAM530kQv3fXL4VN6yqSrFeb8svCci5gIGdAdwQVTlTYnGEDr99P3SH
 ndu1YWv9uUHMmk7GaPpGqqhC413SthOYoe7ds3ld7HBlNqmK+vBfY30yNlRjFB3V20HSt3GYDGs
 yU4loLWPC56CnYPs=
X-Received: by 2002:adf:e845:: with SMTP id d5mr13456885wrn.228.1595843066490; 
 Mon, 27 Jul 2020 02:44:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIWYvZrxGeFrVrDwHWQ2CM57aGuF9fi5FJGrB8GZ3HBW2HS57hvgch72P1+aAk2IFwueh9yg==
X-Received: by 2002:adf:e845:: with SMTP id d5mr13456868wrn.228.1595843066336; 
 Mon, 27 Jul 2020 02:44:26 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id n12sm11534063wrg.77.2020.07.27.02.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 02:44:23 -0700 (PDT)
Date: Mon, 27 Jul 2020 05:44:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: Re: [PATCH] qemu-options.hx: Fix typo for netdev documentation
Message-ID: <20200727054335-mutt-send-email-mst@kernel.org>
References: <20200727045925.29375-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20200727045925.29375-1-tianjia.zhang@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, thuth@redhat.com,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, kraxel@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 27, 2020 at 12:59:25PM +0800, Tianjia Zhang wrote:
> This patch fixes the netdev document description typo in qemu-option.hx.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Trivial tree? Jason's ?

> ---
>  qemu-options.hx | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 708583b4ce..92556ed96d 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2684,7 +2684,7 @@ SRST
>      disable script execution.
>  
>      If running QEMU as an unprivileged user, use the network helper
> -    helper to configure the TAP interface and attach it to the bridge.
> +    to configure the TAP interface and attach it to the bridge.
>      The default network helper executable is
>      ``/path/to/qemu-bridge-helper`` and the default bridge device is
>      ``br0``.
> -- 
> 2.17.1


