Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944DAC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 10:34:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D60E2073D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 10:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eoGaIuAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D60E2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAAIv-00078E-Ht
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 05:34:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jAAI8-0006gb-PI
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:33:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jAAI6-0001v3-Fd
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:33:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34072
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jAAI4-0001sH-Uf
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:33:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583490792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=icXbmG2jUMZ65eAVx3LrHorxBz7Kt5KAS9+nGQJWYMQ=;
 b=eoGaIuAo92bkh3tAMhw2e5NLm78+UH6i/1bea+rZ6uwFUGE/oVuyhGqJCKf7UUQJpDqFMI
 FkZmEVcgOmpd4exssMwVXBHEHbdUBBMfxEhk/pQJdP3noJJSkGxa6KkjSWYBGa2w8GLvdp
 8kPm2BIP/DYP6zDx6l2q0DdDmXH6Z+8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-9344BJ5yMRyI-EMUpEsa5w-1; Fri, 06 Mar 2020 05:33:10 -0500
X-MC-Unique: 9344BJ5yMRyI-EMUpEsa5w-1
Received: by mail-wr1-f70.google.com with SMTP id u18so811664wrn.11
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 02:33:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=icXbmG2jUMZ65eAVx3LrHorxBz7Kt5KAS9+nGQJWYMQ=;
 b=BCL3qzuGLoRddLIBMfBooaEqmo0m1gCIZj5XCUsVmWTcDMoa0Xu4HwLnW83aP123Pi
 oFjDzRoYNWAG9XfdtkK1AEDTzeT+Am/Zqp1yhKaW7rSMPpFFsqgLqZPy6hzKZqrP6kXz
 9BCTJkkSbzdxsdJw/VhbY6q2uVPO6z2cLIG1JF+bUVoj1QADmPwi8rbTsL7kvrvSf3S7
 QseHY4G2NkTt+dhL70A8kyM39q5ba4hUUtNKudsH9JuFctza/A13SPyr9Lvtko5E2NwH
 NTRU7Sclj8yzLcU+5rvBiui7NOBHOhJ/+u2HAUtyH0rda79C/CRbEDlZZEet4sdjnQjf
 rAbw==
X-Gm-Message-State: ANhLgQ1/SuiAYcV5FtmGBxwwW81H1KRZmcPfe+u/Qg5XV0w8RarFkn7W
 YzmfdOMNLy58WD7BNwuEVsZGkjSq9mQQVlEhGrIiKw++ATkG7JLY4N/Vr9pbWyJhoEQV4AUg8bP
 M/0dQTyBqXyU1t54=
X-Received: by 2002:a1c:f214:: with SMTP id s20mr3184629wmc.57.1583490789645; 
 Fri, 06 Mar 2020 02:33:09 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvaroVNDe0XS+Sf+6p6uHHYo0UWlZnai17O7cvoXYsJTbSLuuZbdSH1pNcEuIwDjHCG7XsnIw==
X-Received: by 2002:a1c:f214:: with SMTP id s20mr3184610wmc.57.1583490789353; 
 Fri, 06 Mar 2020 02:33:09 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id g206sm13147351wme.46.2020.03.06.02.33.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2020 02:33:08 -0800 (PST)
Subject: Re: [PATCH] hw/arm/cubieboard: make sure SOC object isn't leaked
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200303091254.22373-1-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <aef518d0-d8e5-7972-0530-8f8a4c64f1e1@redhat.com>
Date: Fri, 6 Mar 2020 11:33:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303091254.22373-1-imammedo@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: b.galvani@gmail.com, peter.maydell@linaro.org, drjones@redhat.com,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/3/20 10:12 AM, Igor Mammedov wrote:
> SOC object returned by object_new() is leaked in current code.
> Set SOC parent explicitly to board and then unref to SOC object
> to make sure that refererence returned by object_new() is taken
> care of.
> 
> The SOC object will be kept alive by its parent (machine) and
> will be automatically freed when MachineState is destroyed.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reported-by: Andrew Jones <drjones@redhat.com>
> ---
>   hw/arm/cubieboard.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
> index 089f9a30c1..12f8ac798d 100644
> --- a/hw/arm/cubieboard.c
> +++ b/hw/arm/cubieboard.c
> @@ -30,9 +30,14 @@ static struct arm_boot_info cubieboard_binfo = {
>   
>   static void cubieboard_init(MachineState *machine)
>   {
> -    AwA10State *a10 = AW_A10(object_new(TYPE_AW_A10));
> +    AwA10State *a10;
>       Error *err = NULL;
>   

What about using object_new_with_props similarly to commit e4c81e3a451f?

     a10 = AW_A10(object_new_with_props(TYPE_AW_A10, OBJECT(s), "soc",
                                        &err, NULL));
     if (err != NULL) {
         error_propagate(errp, err);
         return;
     }

> +    a10 = AW_A10(object_new(TYPE_AW_A10));
> +    object_property_add_child(OBJECT(machine), "soc", OBJECT(a10),
> +                              &error_abort);
> +    object_unref(OBJECT(a10));
> +
>       object_property_set_int(OBJECT(&a10->emac), 1, "phy-addr", &err);
>       if (err != NULL) {
>           error_reportf_err(err, "Couldn't set phy address: ");
> 


