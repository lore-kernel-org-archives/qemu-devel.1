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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734C6C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39401206D7
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxpyphBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39401206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVd9A-0006NJ-D4
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 11:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jVd4Y-0007qx-5X; Mon, 04 May 2020 11:31:59 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:41096)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jVd4X-0007J1-9z; Mon, 04 May 2020 11:31:57 -0400
Received: by mail-lj1-x243.google.com with SMTP id j3so10081911ljg.8;
 Mon, 04 May 2020 08:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=DAkGWiYCEBGONE/7ZtcTXQF56VZHlgRuV4N1X0KUVb0=;
 b=JxpyphBCvJkAZk4q20zhdvizJXoguO08FUgg52CgGNN82R9H97CW2ZQ8mBe9hp909N
 EIbtFCNFq2DWdW3ljcZpa20heXsw7Q31tV/nVA27wWo+8xY2roSz+No4mrG1mXIq9SDx
 GjpEwZpGODQ0Ufk7asu3W/k76kvwfnfzuNqyYplZZNykYdOrxwxtQ94DG6T6uG4XaiMv
 8en/0lCN2P5zKhpxz2U0A2TNP9X0N1z29BPIcn9IWn1oEt4wbwlgoTrOi1BGfsGEyXoD
 WBYsh5doUIp0PN7A7PsS6Z3jwb0VaL5KO8YtqhCfIMldurtDuFjwy2IXADPrlhoYUhrE
 C3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=DAkGWiYCEBGONE/7ZtcTXQF56VZHlgRuV4N1X0KUVb0=;
 b=gu9i2NpZwG9cciKmXHVH7Xra3XCnu/etitYY6mKJCPchCDXAvkPeU8rV7zjJ/u8vJ1
 hGyS4h84c+Lq6jDTjTyCuCNgvjcW/R6Ekx3EKYykHrK4aWUy2wMVHCAqGlHAJN8uvPLQ
 8asCEw4KCN/f1EfCZu/R6twX7g8IhDzZ1j3lC43i+0GnEHcAYDEskNPmXgRIppIFWVa5
 IbYSsHTyQ7Lc6szieAERQRiFmCNMCpLUkzFEi6nW0Th8RGlNY1c/JfzDpTjL+MH3Aunn
 Br59gy9atv98/uR1tXznvUF8pv9KP24igsgHvhl974rQh7LU8w7SEdiQqiMB30FRpPTG
 Rcww==
X-Gm-Message-State: AGi0PuZbHutSkwS/XoNMXH8VMHAdKQ4M8PVu8aNzK4DohSU8hlMjHJcX
 K9c6kqptpOfLxxgNltYOC60=
X-Google-Smtp-Source: APiQypJ6aiYWtgpSreBSjaqLOxpgRjA4XTs31Gfm6t5FzHNl53jhNqVKHFFtx3v9EAVKkG9qW2IRfw==
X-Received: by 2002:a2e:9455:: with SMTP id o21mr10825454ljh.245.1588606315161; 
 Mon, 04 May 2020 08:31:55 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id w29sm10045758lfq.35.2020.05.04.08.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 08:31:52 -0700 (PDT)
Date: Mon, 4 May 2020 17:31:51 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v2 09/10] net: cadence_gem: TX_LAST bit should be set by
 guest
Message-ID: <20200504153151.GI5519@toto>
References: <1588601168-27576-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1588601168-27576-10-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588601168-27576-10-git-send-email-sai.pavan.boddu@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x243.google.com
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

On Mon, May 04, 2020 at 07:36:07PM +0530, Sai Pavan Boddu wrote:
> TX_LAST bit should not be set by hardware, its set by guest to inform
> the last bd of the frame.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  hw/net/cadence_gem.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index ac3a553..f0bf2e7 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -345,11 +345,6 @@ static inline unsigned tx_desc_get_last(uint32_t *desc)
>      return (desc[1] & DESC_1_TX_LAST) ? 1 : 0;
>  }
>  
> -static inline void tx_desc_set_last(uint32_t *desc)
> -{
> -    desc[1] |= DESC_1_TX_LAST;
> -}
> -
>  static inline unsigned tx_desc_get_length(uint32_t *desc)
>  {
>      return desc[1] & DESC_1_LENGTH;
> @@ -1270,7 +1265,6 @@ static void gem_transmit(CadenceGEMState *s)
>  
>              /* read next descriptor */
>              if (tx_desc_get_wrap(desc)) {
> -                tx_desc_set_last(desc);
>  
>                  if (s->regs[GEM_DMACFG] & GEM_DMACFG_ADDR_64B) {
>                      packet_desc_addr = s->regs[GEM_TBQPH];
> -- 
> 2.7.4
> 

