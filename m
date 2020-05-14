Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1AAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:59:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64AFB205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMsfFxEr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64AFB205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEOZ-0005co-HM
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 09:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jZELt-0000Uq-DL; Thu, 14 May 2020 09:56:45 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:42227)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jZELs-0000MA-D9; Thu, 14 May 2020 09:56:45 -0400
Received: by mail-lf1-x144.google.com with SMTP id r17so2699318lff.9;
 Thu, 14 May 2020 06:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=AM7iNf6fLa7IegAF+g2oxI9yxQDbM3YK7gZa3wIUCJQ=;
 b=VMsfFxErnA1SSAMUW1cSi3HAXRvk49VR8p8Wz2enYTaOwn+o4AP4y1TxkH9/HqudMT
 DcWJGxdVcd15/QIPBzJnlILdfyjqr6zDrCcOvQU/jlHFxZAtxAQuljFmAo1PU6/ptjCt
 mNe2RxZQHW8Mb839FWq2EW9iul0prd8K81ox5CMd70aDnF/uFhRX4rSQ2YlmIL7DQOzb
 /ZSCnpSxHh986CM0dXkqAnqx+afsTHTPdfs2bgz5mTNCH/Myn9rxDjJefV9hliXVa8et
 EOuc2ykBN7qhoKuNZKb7t5pecU80Ua8T1T+hlFF1il+wXfXkD/cKDUaQ1grQ8xmfy3g1
 L4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=AM7iNf6fLa7IegAF+g2oxI9yxQDbM3YK7gZa3wIUCJQ=;
 b=djhmQpVDxmJNtZrvUGQ4EkLSIGXchWHnulZVuzNY82TF6caIHvgytvUGHU/YCmlAh4
 iw4xc1U2C5wX3qkxctOycm1Z2rRkWrlJgE66ehpM+HBQJelhKD1L5o2/pYCKIYr5bqXe
 2hgAfwFvFM7FSLI21RmoxR70Mg7YaOO7Yef49dyHst4K1WZDAqUnT1yPeg3ZMEp6MdN7
 vxXaNqFg0sbf0d+KKFHhqUNkfbZPDXk72w0pTokn0Lm8UPFBycaHIaAdkN9JJZrREGSk
 rC5nud2aIJ9I+13Ml1rMuT1mbT/OzIILiZgpgvGVYmfOczEtrlaKLvQFC5sqmkPMiwDu
 UCkA==
X-Gm-Message-State: AOAM5334q7Ki6Ijdx2O5GIZ930L0SfnDPULqUXH7RzUtoC06gWtw5xI5
 D5OjXt9LO8n8/0SRKvWXvjI=
X-Google-Smtp-Source: ABdhPJyppC4UQj13qXurb9ulsVQUjmOof259oBTp+RVudhmQ0e8XYzWGp2PSYIM92WDVM77+tXqXhw==
X-Received: by 2002:ac2:5046:: with SMTP id a6mr3394837lfm.103.1589464602281; 
 Thu, 14 May 2020 06:56:42 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id x11sm1894311lfe.6.2020.05.14.06.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 06:56:41 -0700 (PDT)
Date: Thu, 14 May 2020 15:56:25 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 4/5] docs/system: Document the various MPS2 models
Message-ID: <20200514135625.GZ5519@toto>
References: <20200507151819.28444-1-peter.maydell@linaro.org>
 <20200507151819.28444-5-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507151819.28444-5-peter.maydell@linaro.org>
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 07, 2020 at 04:18:18PM +0100, Peter Maydell wrote:
> Add basic documentation of the MPS2 board models.
>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/system/arm/mps2.rst   | 29 +++++++++++++++++++++++++++++
>  docs/system/target-arm.rst |  1 +
>  MAINTAINERS                |  1 +
>  3 files changed, 31 insertions(+)
>  create mode 100644 docs/system/arm/mps2.rst
> 
> diff --git a/docs/system/arm/mps2.rst b/docs/system/arm/mps2.rst
> new file mode 100644
> index 00000000000..3a98cb59b0d
> --- /dev/null
> +++ b/docs/system/arm/mps2.rst
> @@ -0,0 +1,29 @@
> +Arm MPS2 boards (``mps2-an385``, ``mps2-an505``, ``mps2-an511``, ``mps2-an521``)
> +================================================================================
> +
> +These board models all use Arm M-profile CPUs.
> +
> +The Arm MPS2 and MPS2+ dev boards are FPGA based (the 2+ has a bigger
> +FPGA but is otherwise the same as the 2). Since the CPU itself
> +and most of the devices are in the FPGA, the details of the board
> +as seen by the guest depend significantly on the FPGA image.
> +
> +QEMU models the following FPGA images:
> +
> +``mps2-an385``
> +  Cortex-M3 as documented in ARM Application Note AN385
> +``mps2-an511``
> +  Cortex-M3 'DesignStart' as documented in AN511
> +``mps2-an505``
> +  Cortex-M33 as documented in ARM Application Note AN505
> +``mps2-an521``
> +  Dual Cortex-M33 as documented in Application Note AN521
> +
> +Differences between QEMU and real hardware:
> +
> +- AN385 remapping of low 16K of memory to either ZBT SSRAM1 or to
> +  block RAM is unimplemented (QEMU always maps this to ZBT SSRAM1, as
> +  if zbt_boot_ctrl is always zero)
> +- QEMU provides a LAN9118 ethernet rather than LAN9220; the only guest
> +  visible difference is that the LAN9118 doesn't support checksum
> +  offloading
> diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
> index 4779293d731..15bcf9f81f0 100644
> --- a/docs/system/target-arm.rst
> +++ b/docs/system/target-arm.rst
> @@ -71,6 +71,7 @@ undocumented; you can get a complete list by running
>     :maxdepth: 1
>  
>     arm/integratorcp
> +   arm/mps2
>     arm/realview
>     arm/versatile
>     arm/vexpress
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 74cff1c3818..ea7bdd359e0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -699,6 +699,7 @@ F: hw/misc/armsse-cpuid.c
>  F: include/hw/misc/armsse-cpuid.h
>  F: hw/misc/armsse-mhu.c
>  F: include/hw/misc/armsse-mhu.h
> +F: docs/system/arm/mps2.rst
>  
>  Musca
>  M: Peter Maydell <peter.maydell@linaro.org>
> -- 
> 2.20.1
> 
> 

