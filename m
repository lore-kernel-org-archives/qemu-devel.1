Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC58C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:03:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AFCB20720
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1z63qQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AFCB20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX7mP-0006dZ-6x
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 15:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kX7fy-0008AZ-Qf
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:57:02 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:39970)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kX7fw-0005Yb-R7
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:57:02 -0400
Received: by mail-ed1-x544.google.com with SMTP id p93so180196edd.7
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 11:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5iRZzwGRpl1qaGmKQA+0rVxNbSutW8IZYnSNWNohPrQ=;
 b=i1z63qQuEh7W2PEkdibhq4ObJOUr0iwRFbHB49KZtAJdLcNEhcaL352UHIibiMIKjw
 XT/XgdZD9J8k9hM/y90nQPmT0CKyGWZ8XAEdf6J7485ShLc4+izhzNn2VrR+rw9S7kvF
 qEQlHUleoUzlU+ca9b35uQc1yEK/S/EJ6BlCxkza6tdAwFyAqLx++ZV9Jl3y+XqTg4zh
 EykhgLAQveo6ksfE7X4FcFm31MMYGAXi2Kr+gY/UBfiehxMs1hObFYpkT0Wgng/ClrGe
 WmrGJpbFtjACu1T4DQN5sE9MIVtUF8HiMOdpYu1UCZi/jW3Ofaa6fJptsOU4Ryp9cH30
 mq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5iRZzwGRpl1qaGmKQA+0rVxNbSutW8IZYnSNWNohPrQ=;
 b=s17W/JD/bMmoenZT49GQmXxHwQZXbZR/rzTmGYIYKN+u+RFFqoMseWKb58zRNWavVs
 1jfUZ8248c+s2ExyZz/diKVWoQrhhl7w3boSWkzc2GdiINvikCAsAsuBJkeIkCnONbRH
 d9Kp+v1uo4ojTnCVp8Ret0fkhG4cgFcxWwTUISCo4qEXw2kLD/mnAvDQTy1ZDg4bDL8s
 S7AjHbQ5Z4w3yEPluwdDoTLRWK6Fc5tBz7nfAEpUaac6HNh7ZadHWsmUTsn/voPObm/g
 8aYCwq9LUVRDJK2AL+Gr8pSPNpQIcWhrRlc2+RMNEuNWAkB+iJwsv72oPBn3e7kVpIvH
 gCUQ==
X-Gm-Message-State: AOAM531hBLFREScyDXw7bln6oNJLxEhjpgvr1Z46g/dnslo/t7BIU9M3
 fmmBGhM8eLUHCIhEJyXwsD1QQ1Y97OY=
X-Google-Smtp-Source: ABdhPJyjMtXD0aicBgVnmfRNttyHDvW7n1Glf/YUj7UVQDARNIYpb2F8W+fN6i5XxM8vWCIbBnac+Q==
X-Received: by 2002:a05:6402:b2e:: with SMTP id
 bo14mr16843311edb.111.1603738618785; 
 Mon, 26 Oct 2020 11:56:58 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id v21sm5622425edt.80.2020.10.26.11.56.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 11:56:58 -0700 (PDT)
Subject: Re: [PATCH 13/15] sh4: remove bios_name
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201026143028.3034018-1-pbonzini@redhat.com>
 <20201026143028.3034018-14-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <74f0b053-9380-32e7-8ceb-dbb57c752f22@amsat.org>
Date: Mon, 26 Oct 2020 19:56:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201026143028.3034018-14-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-2.167,
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/20 3:30 PM, Paolo Bonzini wrote:
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/sh4/shix.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


