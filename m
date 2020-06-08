Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4660BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:05:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11B5A2072F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDBWLni7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B5A2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiIP3-0001Wb-5k
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 10:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiINg-0000NT-Qq; Mon, 08 Jun 2020 10:04:04 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53780)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiINf-000274-NL; Mon, 08 Jun 2020 10:04:04 -0400
Received: by mail-wm1-x343.google.com with SMTP id l26so15438672wme.3;
 Mon, 08 Jun 2020 07:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=T2oe+gwxFBhgixhqSY+RgXD+/aVPtBz9dFqh2VkRat8=;
 b=MDBWLni7EYt2aal//8CGId4Z0HQ4bz9VxQWwzclpM1LuI2fa8LJ9cPoC/7y/QxgIwU
 i81Mcqk5qHjvW/mtZRywk4AFgOBQuPj/yFmI2OODLHBm2fwhu4yeJ/T3YnokW0dQvLRM
 Q0rqwC5jkC43xafDFdw8Q3KECXzFRJiXtSNQOJ8gUE0iZhpv/gRajdG5WtbIH8QAASJp
 5WiRWgR9xG66VgXIENZe/1n5GuVB6BKujZKngmkbUepl9RVz2mDcdSTUT+jDyUjh8OBX
 wpH60ondytoQcgTGkvMA4kN5zo+IJtSPPNbf3xiRTTYQEIBTkr216fvbTjSdhGQpM8kn
 snhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=T2oe+gwxFBhgixhqSY+RgXD+/aVPtBz9dFqh2VkRat8=;
 b=oDD9dKqqSSH4bh3CRVQ9Dzj/rkQBUmyEZ7djGyI3ZgsyTMHrJCyKQaLWy29TyEakQO
 Bit2+dQLKZvKvr0IR6y1XShfULAutKdycdBPGySAhRTzQE0fsrIqXFIUCgZL3w1ohF0y
 xGvdoX+jSFTw+4xUseX2Ao0QgCkks0WxNx2KtdQ5clm44gqnJvjYavjI7L7bqaE57Enh
 P985xB7ZHt6mJh05UrdPH2I7KacRHTECBJMJm2y/3uT9yR0ANmEBtiU672A63fop0jCo
 C+8iJ5bq0N6fS2+sjEO6FtEY4mkq+r9LhUuCFLzpx2AJnt83XwSCWV00sgn/3aJ1N6UY
 vYAw==
X-Gm-Message-State: AOAM531uroVS0sf9F83WTLCra6bzObtnLFujK22TVSvCGLNnsiEegvke
 mLwLk0po+Cq1ohtWeY0vhjs=
X-Google-Smtp-Source: ABdhPJw00nGS7yUul02N0L2g+GM9VaUb+8biepK9NhVg6F03br+ki1K5tiupabU5n/wPYkRnArPVnw==
X-Received: by 2002:a1c:7305:: with SMTP id d5mr17157314wmb.85.1591625041759; 
 Mon, 08 Jun 2020 07:04:01 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id w10sm23516502wrp.16.2020.06.08.07.04.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2020 07:04:01 -0700 (PDT)
Subject: Re: [PATCH v2 14/24] macio: Put "macio-nvram" device on the macio bus
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200528110444.20456-1-armbru@redhat.com>
 <20200528110444.20456-15-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c7dab7dd-4c62-70a5-ab02-75e591129112@amsat.org>
Date: Mon, 8 Jun 2020 16:04:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200528110444.20456-15-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: berrange@redhat.com, ehabkost@redhat.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 pbonzini@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/28/20 1:04 PM, Markus Armbruster wrote:
> macio_oldworld_init() creates a "macio-nvram", sysbus device, but
> neglects to but it on a bus.
> 
> Put it on the macio bus.  Affects machine g3beige.  Visible in "info
> qtree":
> 
>              bus: macio.0
>                type macio-bus
>                [...]
>     +          dev: macio-nvram, id ""
>     +            size = 8192 (0x2000)
>     +            it_shift = 4 (0x4)
> 
> This also makes it a QOM child of macio-oldworld.  Visible in "info
> qom-tree":
> 
>      /machine (g3beige-machine)
>        [...]
>        /unattached (container)
>          [...]
>          /device[6] (macio-oldworld)
>            [...]
>     -    /device[7] (macio-nvram)
>     -      /macio-nvram[0] (qemu:memory-region)
>     +      /nvram (macio-nvram)
>     +        /macio-nvram[0] (qemu:memory-region)
>          [rest of device[*] renumbered...]
> 
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/misc/macio/macio.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
> index b3dddf8be7..ebc96cc8f6 100644
> --- a/hw/misc/macio/macio.c
> +++ b/hw/misc/macio/macio.c
> @@ -245,7 +245,8 @@ static void macio_oldworld_init(Object *obj)
>  
>      macio_init_child_obj(s, "cuda", &s->cuda, sizeof(s->cuda), TYPE_CUDA);
>  
> -    object_initialize(&os->nvram, sizeof(os->nvram), TYPE_MACIO_NVRAM);
> +    macio_init_child_obj(s, "nvram", &os->nvram, sizeof(os->nvram),
> +                         TYPE_MACIO_NVRAM);
>      dev = DEVICE(&os->nvram);
>      qdev_prop_set_uint32(dev, "size", 0x2000);
>      qdev_prop_set_uint32(dev, "it_shift", 4);
> 


