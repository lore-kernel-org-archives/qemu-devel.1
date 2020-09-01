Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982D7C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:08:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D6FC206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdAkgua4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6FC206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD3DB-0005k3-Et
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 06:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD31d-0006aY-Ps; Tue, 01 Sep 2020 05:56:25 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35271)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD31c-00045L-3g; Tue, 01 Sep 2020 05:56:25 -0400
Received: by mail-wr1-x443.google.com with SMTP id e16so812064wrm.2;
 Tue, 01 Sep 2020 02:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BPj8pCKrN87JHajxIyx3+VAS4AWba8CtadfEaJs8fTo=;
 b=PdAkgua4YtK+c+dyopCGiOIH5d9MMe9JHqbnl2gcqXcvJhie+nLhpSYWJGdhpJ+R1x
 d6hpy5p+AGQ7nAbY81kUpQnzH/wc0QpfMg91n8YSz+/DczKTDWRrle9+puAnXHX63vJO
 5nXhGcqbAbC+isLkzrQ8A7i7obK4rADcad0eD1g7VVJ5/SUk5hYWr1DdIya82ucP+sCg
 NV5VvEv8H7bdPb2GDmvpSQXx5w2B8PQpswpVFWVFX8z5DrVqOx/3jHy7B2QR7cCCz4q5
 01TBRef3DGhtXtxEfySXIbgt3BsADGNp5O2rZ2jzzBHgZqhT+N4L7CNXjflEuNNmuhVN
 HQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BPj8pCKrN87JHajxIyx3+VAS4AWba8CtadfEaJs8fTo=;
 b=uXMXW9K/sfgK0jwE7GJs925QPaGBB8oUkz6kjZcV9m5GRNVtBFZp1M+wRsVvKeM7Rc
 TCUR334YaaZFme9Se81GwdeXIKe7CD1eEtABOP9iC4vk2z7qHPqNHetoVmIi5vRSHijN
 IQxo7tWYSKlXnf6GyJOFGtCr9b3brDVoWPLaeC1itwo4/tZ6toiJeTzXAYrL+XWfXPUh
 vU2zuf4uDWEabIvcCQ5yTQwbZKD5xeGgd18c+Esj/m0ke8MDSehPsK6TLlftmrpW1lBW
 lz/Z5cfwk0HEfib0T/dGZCUv8V2mI2AREAd7+5wpTpsGp9ezixaV2rzvpixubRnBuIoG
 g2bw==
X-Gm-Message-State: AOAM532bKMcqod6Er7XbV682E/5epHPu1OcG08Jjp61PF+ar/JzV/uuh
 B+VAjny8yMSg8BI/ubhsv0hdY5A2ig0=
X-Google-Smtp-Source: ABdhPJx/VN7hprSikTj67Qbl6bSz2q+pu5JnX/HqEElkRiWpbAPbKy0KjDH6zcNgIX7wExamcnWwkw==
X-Received: by 2002:adf:c404:: with SMTP id v4mr977138wrf.17.1598954182032;
 Tue, 01 Sep 2020 02:56:22 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id n11sm1397405wrx.91.2020.09.01.02.56.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 02:56:21 -0700 (PDT)
Subject: Re: [PATCH 1/3] adb: Correct class size on TYPE_ADB_DEVICE
To: David Gibson <david@gibson.dropbear.id.au>, ehabkost@redhat.com
References: <20200825111627.2007820-1-david@gibson.dropbear.id.au>
 <20200825111627.2007820-2-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <51aba67e-07eb-77c1-638c-d9af8296a0cb@amsat.org>
Date: Tue, 1 Sep 2020 11:56:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825111627.2007820-2-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-2.13,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/25/20 1:16 PM, David Gibson wrote:
> The TypeInfo incorrectly just lets the class size be inherited.  It won't
> actually break things, since the class is abstract, but we should get it
> right.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/input/adb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/input/adb.c b/hw/input/adb.c
> index 013fcc9c54..84331b9fce 100644
> --- a/hw/input/adb.c
> +++ b/hw/input/adb.c
> @@ -309,6 +309,7 @@ static void adb_device_class_init(ObjectClass *oc, void *data)
>  static const TypeInfo adb_device_type_info = {
>      .name = TYPE_ADB_DEVICE,
>      .parent = TYPE_DEVICE,
> +    .class_size = sizeof(ADBDeviceClass),
>      .instance_size = sizeof(ADBDevice),
>      .abstract = true,
>      .class_init = adb_device_class_init,
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

