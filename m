Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC927C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 07:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 002E92225F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 07:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UerBZhJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002E92225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUmY8-00007Y-FC
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 03:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUmXF-0007WA-H1
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 03:58:21 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52051)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUmXD-0004tC-SY
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 03:58:21 -0400
Received: by mail-wm1-x344.google.com with SMTP id d81so761361wmc.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 00:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=J0XgE9teSa5Q1Gs8vEQg9yVbXEfFoWNhRe1Qu8otVZI=;
 b=UerBZhJwpeXvHUkrMApGVqNDy17pGZD6lydqaDIyjY0e1KYqJpNDrsiKh9nFCarnDi
 9HNADi6JhGK1z+z5/oGGSuQF+hiY/+dLz3UhzoqN8kojihJwru94ZMRYFlniDeErZ8wP
 YuVI4fYpLZsfGqWTfeiq9DP/dlYqOumYE/tEN+SnMPKlPZ3jmOZH9Vs7rdCoTP2u7JK4
 Gig1Tza7bhw1m65UGQ7Nf/P6EspMWhbQDatVdjS0HtBXTn1UYOuo3zSsayohQylKgqw+
 mtEQOAny/uueClgiAPvN2yT3yR/l571+6xsWD4a9kiTgKOi1sf4Y0TQ1xP0qkMzk6kKb
 /vIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J0XgE9teSa5Q1Gs8vEQg9yVbXEfFoWNhRe1Qu8otVZI=;
 b=p4hll+xvyuvNVZ+uJX0/96OU3kzhZ9YL7LqiMwOUzCQ1iOSv3Yux1Rt5G/LmTaGuk/
 f67oc9Dgqf9n1/a8TO6txBEbrT98Pni/yOp9DBECtB9e0LBZGNFXi1W9qojvldKMpTIE
 /rWVlTpgJNUCnsIdXFNAQOrssePIXoyqCT8oUN6XEc0/2g6H/oD+IZwf4Tea3xWj7M7J
 g8MPNH6AWW7RFdtLz4Oo+qc/ozfA1cJLLp0P1yHzSu/nYiEffg2XZ7UxBfDS/YCj9F+a
 KFY7XLKtwVPdgdENqxgYIjALFzpc6z4gbraHbfsyob9oa9oCTuoDgeY7dcLBsNucqN09
 GJDw==
X-Gm-Message-State: AOAM531nx6pmXDl42dEqcem3R53diEn75X5ZGRt9CDl8YNGQWS7/uzXs
 86g8T3vEVUSxiiI6MPQ/m6I=
X-Google-Smtp-Source: ABdhPJy6o7ZDFqXo2bNzPGZT7ZUPslKwAmlc/00f7gr2DJGmsksVckIIxtP4MFnJT1M6OM3fgVIwVA==
X-Received: by 2002:a1c:68d5:: with SMTP id d204mr1541599wmc.100.1603180697679; 
 Tue, 20 Oct 2020 00:58:17 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id d30sm1695418wrc.19.2020.10.20.00.58.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 00:58:17 -0700 (PDT)
Subject: Re: [PATCH] hw/core/qdev-clock: add a reference on aliased clocks
To: Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20201020074426.105878-1-luc@lmichel.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <32eb21b8-e63d-87bb-6d94-95d888ec9a3b@amsat.org>
Date: Tue, 20 Oct 2020 09:58:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201020074426.105878-1-luc@lmichel.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Markus/Marc-André too.

On 10/20/20 9:44 AM, Luc Michel wrote:
> When aliasing a clock with the qdev_alias_clock() function, a new link
> property is created on the device aliasing the clock. The link points
> to the aliased clock and use the OBJ_PROP_LINK_STRONG flag. This
> property is read only since it does not provide a check callback for
> modifications.
> 
> The object_property_add_link() documentation stats that with
> OBJ_PROP_LINK_STRONG properties, the linked object reference count get
> decremented when the property is deleted. But it is _not_ incremented on
> creation (object_property_add_link() does not actually know the link).
> 
> This commit increments the reference count on the aliased clock to
> ensure the aliased clock stays alive during the property lifetime, and
> to avoid a double-free memory error when the property get deleted.
> 
> Signed-off-by: Luc Michel <luc@lmichel.fr>
> ---
>   hw/core/qdev-clock.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
> index 6a9a340d0f..5f5e143702 100644
> --- a/hw/core/qdev-clock.c
> +++ b/hw/core/qdev-clock.c
> @@ -59,10 +59,11 @@ static NamedClockList *qdev_init_clocklist(DeviceState *dev, const char *name,
>       } else {
>           object_property_add_link(OBJECT(dev), name,
>                                    object_get_typename(OBJECT(clk)),
>                                    (Object **) &ncl->clock,
>                                    NULL, OBJ_PROP_LINK_STRONG);
> +        object_ref(OBJECT(clk));
>       }
>   
>       ncl->clock = clk;
>   
>       QLIST_INSERT_HEAD(&dev->clocks, ncl, node);
> 

