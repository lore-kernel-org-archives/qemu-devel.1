Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2A2C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 18:04:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5BDF20771
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 18:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfN7vXi8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5BDF20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6e41-0000d6-Sp
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 14:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6e36-0007vh-10
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 14:03:28 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34117)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6e33-0003sf-FE
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 14:03:26 -0400
Received: by mail-wr1-x444.google.com with SMTP id f7so9117442wrw.1
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 11:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3UPXS15TldMHs3waluVKOVQRZ5QzUEQC3rtvpiZShCo=;
 b=GfN7vXi8SHYAvkuApR/TGqh1cPPI2Y+X98K33ZD1agn0ns8I3c1fhaSeH0mHtIF4ss
 93CQ9pGlkvVX7NGRKJzA3Blf/Zb+qWi/dxj7uu90ExsIKmjnqDV28pHKMTmAXZJPnWpx
 QQu1bH1KWjth4YIayrBkVbCTtDg86REaUf4AdbKL1EpLTF9c7DxQJcn5GA3Yvw98cQkO
 BjY/PpSRHyZKfBCOPVPIPAjwREpD7tbDyd1LAJ+1NDuAeKchnLmLhpcKoHCcON/xWfSG
 ahQsx7PYsC/K73RdBIvaMI3N8za3UjK0x1Onk4AWViknzS6o+g+hRH3rzMtnMj6xpkML
 zXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3UPXS15TldMHs3waluVKOVQRZ5QzUEQC3rtvpiZShCo=;
 b=ZTNLSpkkey60NGENKTWYfHWL+ssoVdPYpMBTUjg+SgvILU13DV7lbxklJN2y4i0Tup
 NVsS4PwU2dsZ0zmEQfqNi6v4LxWgJaw86LGxXmMpdLMKWvUPfoq8Sqhhm0X5sa3XjD7Y
 AA70c0o400SuTZWA4dAUr+BnyFY03YwHHKr0zpjmx634Ooi8bLdJ3CR3Rm2ZYyUbAb6P
 XKVklOdKOBA2LA9UITnMjy1KCSwi8d7r2UrT6bNNWn6R5B4YPZxNkixd8Kw0q5TVdOrV
 0alnOFsJ9ZJ/2fw9S+vNLqNPTgkPMDSX4mh/9prpkd0FItiL/wOyRBXWtJIRjNJrXouw
 bBXQ==
X-Gm-Message-State: AOAM533kxFe2hRT0wzdNQwLWRkwAuAPCRM59pNI6SZez76cuBCjWlqoj
 X+yaBs0DuTBElNu7dbWNuKbB39kqM5k=
X-Google-Smtp-Source: ABdhPJxKIbKSvBWGQSANVt87Jt0eeconVKFSJ/ZRYlB34nx4gB6WAo3bW/Osl2iJD1kR4ItQK8mmVw==
X-Received: by 2002:a5d:6702:: with SMTP id o2mr3647037wru.364.1597428203325; 
 Fri, 14 Aug 2020 11:03:23 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id b123sm16631989wme.20.2020.08.14.11.03.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 11:03:22 -0700 (PDT)
Subject: Re: [PATCH 23/41] nubus: Delete unused NUBUS_BRIDGE macro
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200813222625.243136-1-ehabkost@redhat.com>
 <20200813222625.243136-24-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a243c583-a40d-ad2b-c778-330e2f964026@amsat.org>
Date: Fri, 14 Aug 2020 20:03:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200813222625.243136-24-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/14/20 12:26 AM, Eduardo Habkost wrote:
> The macro never worked because the NubusBridge typedef doesn't
> exist.  Delete it.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/hw/nubus/nubus.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/hw/nubus/nubus.h b/include/hw/nubus/nubus.h
> index a8634e54c5..c350948262 100644
> --- a/include/hw/nubus/nubus.h
> +++ b/include/hw/nubus/nubus.h
> @@ -29,7 +29,6 @@
>  #define NUBUS_BUS(obj) OBJECT_CHECK(NubusBus, (obj), TYPE_NUBUS_BUS)
>  
>  #define TYPE_NUBUS_BRIDGE "nubus-bridge"
> -#define NUBUS_BRIDGE(obj) OBJECT_CHECK(NubusBridge, (obj), TYPE_NUBUS_BRIDGE)
>  
>  typedef struct NubusBus {
>      BusState qbus;
> 


