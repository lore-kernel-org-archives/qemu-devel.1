Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76249C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 03:36:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E91320708
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 03:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZhn1UqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E91320708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsePa-0000h9-Hr
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 23:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jseP2-0000HB-7E
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 23:36:16 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52766)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jseP0-0005TX-O6
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 23:36:15 -0400
Received: by mail-wm1-x341.google.com with SMTP id q15so41571039wmj.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 20:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SZm6sjyTmknKnlyqzKJoiNHTSgykGGyh91XWQ6QaCcU=;
 b=NZhn1UqXKAqCI5G0EJPjskvonhYS6Un70cRK1zmuonMaNAEgM7ohQpK+Ze4307ndMK
 B+DY9e9lnRr+40gUjDr5IC/dzMINAISzMg/HPZw2yFaVmWCaq2cRZ99ZotacsJx3oZgu
 KTk1va9IgZmcOirr3iC5+nKl51ISTSck6o/dcEncS5iWz+r7yW2YUF9CofK01cMgfpH6
 hZxnD2iu+9gS2V7Ryez/qX8yupyysu2JbC82+HtlpQlWScskjA/np/DQjIf1ttzwNUKG
 XqvRxBaz+5QBQLKjvi8bFIDdASyfiHneHuquuivSO8g2sBU7PZBWVUJnhYtCG5Y+uiMZ
 D7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SZm6sjyTmknKnlyqzKJoiNHTSgykGGyh91XWQ6QaCcU=;
 b=W9mqNTJpaIZgS8fWVtVaiSf/WxgpONMZCS4ZUv6XtXqhG7jncEaiTYS5fhc/IwzS2o
 xpCrg4U7p7VYw65ZliVB63wpswqmEfK2N4cG/WkIyn3EmSgXOcYKzrjN0pM5yvISteQJ
 tbfEEYvMO78VM02ZRkhHObMMCzWkXoIIhO3q6t3sn9yullnVY2q9f+i0PKtfJQB93yQ3
 dLJ3shQrE8dNEACA9+iX4bbf+lUh0JvWTNgC1nLg1b/sT2R0O45CQENSE7H8lrN8OSlh
 zewx7yprSGNJCaQLrV4hZgIngCoJymEewYjbraqLPmHKORi9v0Iu8A/fHfv0J0f+uKAV
 kyYA==
X-Gm-Message-State: AOAM5324xLeTwtO4zblmZgw2IXTNuT+IZi6nabnNdI/rA8C7fAoCrXCm
 mCDDCNbIA8Ihr5y5exUY/LA=
X-Google-Smtp-Source: ABdhPJw5A3PIv4X7NlP+0pzMmeq8deCFKcD+BGWXUCmYjtAWLDGMFjeIeMSaj5nHnxC9C+QdB0+0KQ==
X-Received: by 2002:a05:600c:282:: with SMTP id
 2mr2109159wmk.168.1594092973177; 
 Mon, 06 Jul 2020 20:36:13 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id n125sm1736461wme.30.2020.07.06.20.36.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2020 20:36:12 -0700 (PDT)
Subject: Re: [PATCH v3] hw/core/qdev: Increase qdev_realize() kindness
To: qemu-devel@nongnu.org
References: <20200707033326.19178-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <da36f1d9-9a52-d97a-36a9-3523925a5427@amsat.org>
Date: Tue, 7 Jul 2020 05:36:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200707033326.19178-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 5:33 AM, Philippe Mathieu-Daudé wrote:
> Since commit 510ef98dca5, qdev_realize() aborts if bus-less device
> is realized on a bus. While commits 514db7710b..007d1dbf72 took
> care of converting all mainstream uses, QEMU forks weren't. These

I guess I missed "weren't [converted]".

> forks are usually maintained by hobbyist with interest in following
> mainstream development, but with limited time, so usually rebase
> from time to time. To avoid them to spend time on debugging and
> reading git-log history, display a kind hint about what is wrong.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Since v2:
> - scratch __func__ (armbru)
> - reword to justify this is not an impossible case (armbru)
> ---
>  hw/core/qdev.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 2131c7f951..a16f1270f1 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -392,8 +392,11 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
>  
>      if (bus) {
>          qdev_set_parent_bus(dev, bus);
> -    } else {
> -        assert(!DEVICE_GET_CLASS(dev)->bus_type);
> +    } else if (DEVICE_GET_CLASS(dev)->bus_type) {
> +        error_setg(errp, "Unexpected bus '%s' for bus-less device '%s'",
> +                   DEVICE_GET_CLASS(dev)->bus_type,
> +                   object_get_typename(OBJECT(dev)));
> +        return false;
>      }
>  
>      object_property_set_bool(OBJECT(dev), true, "realized", &err);
> 

