Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86BFC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:16:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 938E42065D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knGB6i4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938E42065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jviDA-0001qd-SU
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 10:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jviCW-0001HY-De; Wed, 15 Jul 2020 10:16:00 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36733)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jviCU-000166-JC; Wed, 15 Jul 2020 10:16:00 -0400
Received: by mail-wr1-x444.google.com with SMTP id k6so2912509wrn.3;
 Wed, 15 Jul 2020 07:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TVq26ecTjZoLMmf2gjuQW6BTFjhqJFm1ME41B+oJzGQ=;
 b=knGB6i4BvXNbgXpQTBXEFigw8mpvy7G8GFiNJBKOyJWqv2S71dro0WWNiqS/6roin/
 VIbMI4hVpTGCZExFWpsuZ+QT2R1I1Mh32v8ilJUwacYGaPaFyy1x53Otj+H8AhTmx6wr
 /1wcjrsyTP/vEqWgBZKawaQHCSdS6HjtuHouFMuOROnibaP0/MNIBOqjsJhSTjX+b8pp
 j1CY25trcHzNmN5sYf6rSfJMRX1ZbLutdsKDkQniudPD2JnO5tyRjkSt+CfsFg+UAPBK
 yec61E2HdksPNQmt0wHnWraTQI1DtsajnOja+VDlOjN0DlPhaw1g+mASAR5GExMP5OxO
 6cVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TVq26ecTjZoLMmf2gjuQW6BTFjhqJFm1ME41B+oJzGQ=;
 b=M0G6StmH0krplhQGStwR+3OG2y7ynTcGX5uyCKSu29xOSjISgD5jtgRezMgl5dKuEd
 A8bhDwsjnl0zLttMb7dPeofw8nMGdleGToGO22j4XU/HsdF6s1X9arxaxot9Mi40XszG
 IAuV8ftfrWnloNSuFUTlrOBQ8RBxbMxK9aIN4WoXt5ZpMSaT4yLMSjxJqrmBeP/EfwLJ
 TQJvS/gVQm2rwwiJVV/CIDqF82WlLHl0DoQRdb6clpsK9TPeYsYEkOUpuytPRleszhQM
 FAdvnnm3m7DX9JX4FncwTKko86dGyEM+nQ98CiC6KKl7H+5OnFEUegPPXdW+8Sjmi6Os
 hQNQ==
X-Gm-Message-State: AOAM532Ok59ztU7rMzKz4Bg3r8MaJfJPQxBBSYyEd1kPa5AMLsOdp5uO
 unRkG5/dGxhiriU4VLe1aLU=
X-Google-Smtp-Source: ABdhPJz8j/TTVJSfLkRCVZ6B08GOBYFKNGX3NQt6QxW1LcwouI4JrLwXi6cJpTFilLyFDguMgU3o+w==
X-Received: by 2002:adf:f04c:: with SMTP id t12mr11218191wro.382.1594822555812; 
 Wed, 15 Jul 2020 07:15:55 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id c194sm3565091wme.8.2020.07.15.07.15.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2020 07:15:53 -0700 (PDT)
Subject: Re: [PATCH for-5.1 1/2] msf2: Unbreak device-list-properties for
 "msf-soc"
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200715140440.3540942-1-armbru@redhat.com>
 <20200715140440.3540942-2-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ef1d7fe4-0558-cc7b-16d7-906c4aa9915b@amsat.org>
Date: Wed, 15 Jul 2020 16:15:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200715140440.3540942-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, qemu-riscv@nongnu.org,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 alistair@alistair23.me, mark.cave-ayland@ilande.co.uk, sundeep.lkml@gmail.com,
 b.galvani@gmail.com, nieklinnenbank@gmail.com, qemu-arm@nongnu.org,
 palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/15/20 4:04 PM, Markus Armbruster wrote:
> Watch this:
> 
>     $ qemu-system-aarch64 -M ast2600-evb -S -display none -qmp stdio
>     {"QMP": {"version": {"qemu": {"micro": 50, "minor": 0, "major": 5}, "package": "v5.0.0-2464-g3a9163af4e"}, "capabilities": ["oob"]}}
>     {"execute": "qmp_capabilities"}
>     {"return": {}}
>     {"execute": "device-list-properties", "arguments": {"typename": "msf2-soc"}}
>     Unsupported NIC model: ftgmac100
>     armbru@dusky:~/work/images$ echo $?
>     1
> 
> This is what breaks "make check SPEED=slow".
> 
> Root cause is m2sxxx_soc_initfn()'s messing with nd_table[] via
> qemu_check_nic_model().  That's wrong.
> 
> We fixed the exact same bug for device "allwinner-a10" in commit
> 8aabc5437b "hw/arm/allwinner-a10: Do not use nd_table in instance_init
> function".  Fix this instance the same way: move the offending code to
> m2sxxx_soc_realize(), where it's less wrong, and add a FIXME comment.

That addresses this other thread, right?
https://www.mail-archive.com/qemu-devel@nongnu.org/msg720658.html

> 
> Fixes: 05b7374a58cd18aa3516e33513808896d0ac9b7b
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/arm/msf2-soc.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
> index 16bb7c9916..33ea7df342 100644
> --- a/hw/arm/msf2-soc.c
> +++ b/hw/arm/msf2-soc.c
> @@ -82,10 +82,6 @@ static void m2sxxx_soc_initfn(Object *obj)
>      }
>  
>      object_initialize_child(obj, "emac", &s->emac, TYPE_MSS_EMAC);
> -    if (nd_table[0].used) {
> -        qemu_check_nic_model(&nd_table[0], TYPE_MSS_EMAC);
> -        qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
> -    }
>  }
>  
>  static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
> @@ -187,6 +183,11 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
>          g_free(bus_name);
>      }
>  
> +    /* FIXME use qdev NIC properties instead of nd_table[] */
> +    if (nd_table[0].used) {
> +        qemu_check_nic_model(&nd_table[0], TYPE_MSS_EMAC);
> +        qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
> +    }
>      dev = DEVICE(&s->emac);
>      object_property_set_link(OBJECT(&s->emac), "ahb-bus",
>                               OBJECT(get_system_memory()), &error_abort);
> 


