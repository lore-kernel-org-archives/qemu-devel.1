Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9A1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 10:01:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 021D1207F5
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 10:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QV+A72kM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 021D1207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jacaS-0003Ph-83
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 06:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jacZG-0002Lw-G9; Mon, 18 May 2020 06:00:18 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:34531)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jacZF-0003Ld-Ft; Mon, 18 May 2020 06:00:18 -0400
Received: by mail-lf1-x144.google.com with SMTP id e125so6717255lfd.1;
 Mon, 18 May 2020 03:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Q7eDsroDHDBApJbMxPCEBvy4xuyJpALNN9wlpqDZ6yU=;
 b=QV+A72kMz+JwckS9T01BjwpRyU3P/42m35fLdxYao7FIhbbuEp/mgrlEKFvCfsupIv
 HdNjeoTSHxgC3sDFW5wcRq8Cln1NAwxBnxU/hWDo7FNahKGp4G0yKPdkdDwr249VEYJm
 O1WTDphPaf+NjEloYHO7eaJJZY15RldcLJaVNghm5GcqyJn9IpKYcMPqZ5efddl+SPDT
 0WTzhowmbJrhOF0UoNipzsWfn3z0+tuz7yPbeBzjSos17867z7v4J8eWDx7W24a/+bPT
 Z4j/aNAezWw4QZrS13iPzAUbjmB0jFuqhRiw3oJh3x53WfZ8IsFJLPaMV68+EvJItyYh
 kjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Q7eDsroDHDBApJbMxPCEBvy4xuyJpALNN9wlpqDZ6yU=;
 b=Y6FouWwwpyhso8JhqmmGQUkA5YLFFd0/yFvFoxwLjuSlQ+UIjIKK7Oy8E3vTK6zO/v
 WClLVD3ExC6Xd409lu/JSct9ZtnuFYgoXUgEg/6CW6QfsHKMXYF/X7/e7i5jWZH7Djf2
 xOK5zz5XAFHjGLcnqWXh7V220RQgDTeusG9Tn9IgL7fXPVJpFiMx2/gyVP3KUq6v4lh6
 ohM4Gi7Km1rm94pIJ9O6XCmH+/yjcA/seCWHKvRM+W1/DKZt9PL99S5p80mTwTUTJe8p
 VIp/+IwX3XgD6VLAc6ZKEKVrKXKHvgrNAZKOuGpnqtN9rCufRTlhJP3Y1/PWPMc77gyO
 9RkQ==
X-Gm-Message-State: AOAM532DlU9yprkXg6mmqRtaVpJU/iYRGkHAaB6Y4eRHD+3nuAEN0dN9
 IRhyyvsS7EwsPd/o+zNidFc=
X-Google-Smtp-Source: ABdhPJxJtezRJKWUHFbap3P5Of2F8J1l92LNILacUgqeCEhfvQjhORUSCl+90twfcSjS8yO0vZksXg==
X-Received: by 2002:a19:644f:: with SMTP id b15mr11317960lfj.28.1589796014489; 
 Mon, 18 May 2020 03:00:14 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id o27sm7519375lfi.27.2020.05.18.03.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 03:00:13 -0700 (PDT)
Date: Mon, 18 May 2020 11:59:56 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 02/24] display/xlnx_dp: Fix to realize "i2c-ddc" and
 "aux-to-i2c-bridge"
Message-ID: <20200518095956.GB5519@toto>
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-3-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518050408.4579-3-armbru@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, berrange@redhat.com,
 ehabkost@redhat.com, Alistair Francis <alistair@alistair23.me>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, pbonzini@redhat.com,
 KONRAD Frederic <fred.konrad@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 18, 2020 at 07:03:46AM +0200, Markus Armbruster wrote:
> xlnx_dp_init() creates these two devices, but they're never realized.
> Affects machine xlnx-zcu102.
> 
> I wonder how this ever worked.  If the "device becomes real only on
> realize" thing actually works, then we've always been missing these
> two devices, yet nobody noticed.
> 
> Fix by realizing them in xlnx_dp_realize().

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> 
> Fixes: 58ac482a66de09a7590f705e53fc6a3fb8a055e8
> Cc: KONRAD Frederic <fred.konrad@greensocs.com>
> Cc: Alistair Francis <alistair@alistair23.me>
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/display/xlnx_dp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
> index 3e5fb44e06..bdc229a51e 100644
> --- a/hw/display/xlnx_dp.c
> +++ b/hw/display/xlnx_dp.c
> @@ -1264,9 +1264,13 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
>      DisplaySurface *surface;
>      struct audsettings as;
>  
> +    qdev_init_nofail(DEVICE(s->aux_bus->bridge));
> +
>      qdev_init_nofail(DEVICE(s->dpcd));
>      aux_map_slave(AUX_SLAVE(s->dpcd), 0x0000);
>  
> +    qdev_init_nofail(DEVICE(s->edid));
> +
>      s->console = graphic_console_init(dev, 0, &xlnx_dp_gfx_ops, s);
>      surface = qemu_console_surface(s->console);
>      xlnx_dpdma_set_host_data_location(s->dpdma, DP_GRAPHIC_DMA_CHANNEL,
> -- 
> 2.21.1
> 

