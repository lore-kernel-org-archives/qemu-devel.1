Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F340C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:57:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143C6206F1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nH4mjvJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143C6206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnJCz-0008CZ-CP
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 05:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnJC0-0007HM-DU; Mon, 22 Jun 2020 05:56:44 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50532)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnJBy-00065q-Rf; Mon, 22 Jun 2020 05:56:44 -0400
Received: by mail-wm1-x343.google.com with SMTP id l17so14264650wmj.0;
 Mon, 22 Jun 2020 02:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QspcduoJo3RG4AddvPS2f5EZc3dAyNj6iKCIvo0Uvjc=;
 b=nH4mjvJOE0FPw5AiuxgXiXtBFxe+wnUZTus7nwslQALO4KOE3WPRr0ieyjpw62H9Z9
 6GdWAUO0GIaCaElXwOKXNydq0doudM9WgyjvJGZ6m/s2kdflIh1TjRsIc5oKsT3GiL+W
 xp0bDYZRAYFPp1Mdn1oOAO2kjoxCMxlK9mf6SaqfPr3iLiMi1jkJtoWOMVpyMz8d6Dys
 /EUAkLwIJ6ozMHwmfDxsHMeXIGy/2wUOXdQq6fXWbPeVHtB/YMGDkYOMF4HuI/BIAWYv
 BEvdyTkp5fcJcXFdRDG3GyNNaZgMod94oTTZxzFhaCPByLLgQFgOo9/Rxjt9fXdKH74o
 NUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QspcduoJo3RG4AddvPS2f5EZc3dAyNj6iKCIvo0Uvjc=;
 b=b+a+etkrrG5sLcKZ1cvxppqO1K4pTHtzTYBpp1CZlhttCZKvu2TuthvReHcuEZgK9x
 PqvYbycfMlXVRbO8cxqQCUfxtSBN7UmQAFiJuax2fN8fcysXAN6kv2RGiyp61J/I4Cuw
 3FOhaCA4MzSL6UwvEOzvtICJIyWXF0fUAbsaLT+/COLKo4paaJLewTPpjUak7tu1K37+
 a0OsVGBcZynmYkQmGUDuM7ijH4bDlYFsiGlGs3NOGP9/f/4ISXbjXUCiu0Bk4TUAjkC8
 7KZDe+MEmyFm0M1ANdnqBT/Y3ntvKHDkAtGnAX4971cZ3cKFNh0wF5kVov7NrAQKyNsy
 JK1w==
X-Gm-Message-State: AOAM530xpFLjCA/UzngnWnZ0ZnZH+4RBpt/7irLLlhXARAbqRv+iIoOM
 FEs1fHAOU94VkQ8T1FnbmVs=
X-Google-Smtp-Source: ABdhPJxLSGeM+WJG/1GepAuBjluIsjdkajXnUJ3CP3VcrHKNIWe7OYHYa/YQCy9ne0ribZQgWqwZnw==
X-Received: by 2002:a7b:c345:: with SMTP id l5mr18503287wmj.31.1592819801095; 
 Mon, 22 Jun 2020 02:56:41 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 11sm11748652wmg.41.2020.06.22.02.56.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 02:56:40 -0700 (PDT)
Subject: Re: [PATCH v2 16/16] sd/milkymist-memcard: Fix error API violation
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200622094227.1271650-1-armbru@redhat.com>
 <20200622094227.1271650-17-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <57e88af4-9590-5786-ea9d-5575fcb675f2@amsat.org>
Date: Mon, 22 Jun 2020 11:56:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200622094227.1271650-17-armbru@redhat.com>
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
Cc: kwolf@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com, Michael Walle <michael@walle.cc>,
 pbonzini@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/22/20 11:42 AM, Markus Armbruster wrote:
> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
> pointer to a variable containing NULL.  Passing an argument of the
> latter kind twice without clearing it in between is wrong: if the
> first call sets an error, it no longer points to NULL for the second
> call.
> 
> milkymist_memcard_realize() is wrong that way: it passes &err to
> qdev_prop_set_drive_err() and qdev_realize_and_unref().  Currently
> harmless, because the latter uses it only as first argument of
> error_propagate().
> 
> Making qdev_prop_set_drive_err() fail involves abuse of -global.
> Leave handling that to qdev_prop_set_drive(), like we do elsewhere.
> 
> Cc: Michael Walle <michael@walle.cc>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/sd/milkymist-memcard.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
> index 1c23310715..482e97191e 100644
> --- a/hw/sd/milkymist-memcard.c
> +++ b/hw/sd/milkymist-memcard.c
> @@ -279,7 +279,7 @@ static void milkymist_memcard_realize(DeviceState *dev, Error **errp)
>      dinfo = drive_get_next(IF_SD);
>      blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
>      carddev = qdev_new(TYPE_SD_CARD);
> -    qdev_prop_set_drive_err(carddev, "drive", blk, &err);
> +    qdev_prop_set_drive(carddev, "drive", blk);
>      qdev_realize_and_unref(carddev, BUS(&s->sdbus), &err);
>      if (err) {
>          error_setg(errp, "failed to init SD card: %s", error_get_pretty(err));
> 


