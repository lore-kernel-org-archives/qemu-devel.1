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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B7FC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:39:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CD8A20721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMju+477"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD8A20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdCA-000451-Qd
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 11:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1jVd2l-0004sf-D7; Mon, 04 May 2020 11:30:07 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:42354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1jVd2k-00044Y-Cv; Mon, 04 May 2020 11:30:06 -0400
Received: by mail-lj1-x241.google.com with SMTP id a21so10060526ljb.9;
 Mon, 04 May 2020 08:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=6PZIFsge5wwg13tfAZH+RE+7GMgniH7oKbx9miwxAIY=;
 b=dMju+477ywu+nvoqwEHBBwHGIH+EAq6Xzkga5CVx6TndFoOwJySmkuTdCxhvb/4BFn
 PmbMeUiYrw7U1FJcU5b6Ei+3aK8Wa+1jmDGEZuGLc/7G/ydS1DfDZa+zamzr0OXrOG1X
 1+DsRBPmzrp4DmH9JYn90sjp0gV8AVz6nBrb5KmL0CZbW4ZE7sX/S2tOZBatzBXKGy0I
 txp7j5uamCuWyB/TH0nvtZibr6hrwJRVdZTk+gAOLDRl3Bd5w8bBql5ZU16zkxTVRigT
 D2RZ8AR63XbXMqRI/t8ayBeJSIG02LxoTgBUTmbciM/gJbn8eldXfcsFOBDOyCbKICLD
 SOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=6PZIFsge5wwg13tfAZH+RE+7GMgniH7oKbx9miwxAIY=;
 b=j8zkdlq6gMoc2PChjBE32DxIDIdg0Zi66X+b3VPlunOCq9q0cHIfJvA2oJMlYaw+cL
 M8KmkEdy3m3oeNXwDn//+AWwuj/0GxfwsbWvTYyccwFOWtQQnmcoCPHb8+OwMiHjhlLE
 uJST50+JJWyhm8GJQ6/lJwc3GNSWu0k92ntb5a/82z3L+jdc4xpwBQotp9mT3HWWTC9U
 yYr78/AiyLXrarwisIIV2k7mmhFT0bWeEXBluySCRf8fh1SaKSaHqvqlB90mNnDMvKGi
 CfK+yMnJhT9JkLFyjpx9rlkhZw3Yu0UvvnujBf2xM2wUHnm+ITXsEyd5Zvne8JIHGRdp
 j56A==
X-Gm-Message-State: AGi0PubatC+l/9ZwMD8d890eGHx+sCXzNQh1bPT23enpGd3g0WXlCf69
 5S4PX6F0VhdBYaMkL4dunog=
X-Google-Smtp-Source: APiQypKYvnHQePnXR1UYDpGSCfdPjvMgTFj2/zN5XLtyemZRMXu6tIRRoAI3dHNhrZ0mldOznmL+Ug==
X-Received: by 2002:a05:651c:32a:: with SMTP id
 b10mr11146766ljp.111.1588606204165; 
 Mon, 04 May 2020 08:30:04 -0700 (PDT)
Received: from fralle-msi (31-208-27-151.cust.bredband2.com. [31.208.27.151])
 by smtp.gmail.com with ESMTPSA id
 n23sm8462302ljj.48.2020.05.04.08.30.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 04 May 2020 08:30:03 -0700 (PDT)
Date: Mon, 4 May 2020 17:30:01 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v1 3/9] hw/net/xilinx_axienet: Remove unncessary cast
Message-ID: <20200504153000.eenrgpbywluzgo7a@fralle-msi>
References: <20200430162439.2659-1-edgar.iglesias@gmail.com>
 <20200430162439.2659-4-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430162439.2659-4-edgar.iglesias@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -1020
X-Spam_score: -102.1
X-Spam_bar: ---------------------------------------------------
X-Spam_report: (-102.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001,
 USER_IN_WHITELIST=-100 autolearn=_AUTOLEARN
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
Cc: damien.hedde@greensocs.com, peter.maydell@linaro.org,
 sstabellini@kernel.org, edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 jasowang@redhat.com, alistair@alistair23.me, qemu-devel@nongnu.org,
 frederic.konrad@adacore.com, qemu-arm@nongnu.org, philmd@redhat.com,
 luc.michel@greensocs.com, figlesia@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On [2020 Apr 30] Thu 18:24:33, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Remove unncessary cast, buf is already uint8_t *.
> No functional change.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>

> ---
>  hw/net/xilinx_axienet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
> index 84073753d7..c8dfcda3ee 100644
> --- a/hw/net/xilinx_axienet.c
> +++ b/hw/net/xilinx_axienet.c
> @@ -918,7 +918,7 @@ xilinx_axienet_data_stream_push(StreamSlave *obj, uint8_t *buf, size_t size)
>          uint16_t csum;
>  
>          tmp_csum = net_checksum_add(size - start_off,
> -                                    (uint8_t *)buf + start_off);
> +                                    buf + start_off);
>          /* Accumulate the seed.  */
>          tmp_csum += s->hdr[2] & 0xffff;
>  
> -- 
> 2.20.1
> 

