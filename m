Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C940C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:04:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B30A120747
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMZDo+75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30A120747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQWg-00086Q-MN
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 11:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXQ9g-0005M9-5I
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 10:40:56 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:39050)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXQ9e-0002d8-8c
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 10:40:55 -0400
Received: by mail-ej1-x642.google.com with SMTP id bn26so2580153ejb.6
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 07:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=atrdn6JxvV9PBu2/vgtm5bG4A5IALlYh+S+gHEWuMw8=;
 b=jMZDo+75DD/cDFAnGvuYuUiclPjtqMkxX62nqCQFGxIRQiBg7wc54OccK3ZWBNsaFl
 p2K8Mdb/UK8nNmdLPBrdcSYZpooN4BvrY4CXPIRZSLkW+FsZvIyvFvQFD7n0nbAi24np
 UtDNsPM58EwTfBEtjvr3MwAGM+6ucYdrWApNrs3WzdN9ONmh2xz091sCKfjpovQMGBxB
 bTaqIPwvctUa9v2Yn2jKz9VJHYmdjwzWXauIe6ecX5da5z3//4rYhqNd/FBYPm7DCZLV
 Su5tdp/XxHsx1joq8XvpZGh3dKe6GCJBDxCk9yqnSOG8GcFsvvuDNbJjnjPczhc6lniK
 xnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=atrdn6JxvV9PBu2/vgtm5bG4A5IALlYh+S+gHEWuMw8=;
 b=kz72l+xz+2IMM3ThDuYo/AqNG7875GEK6Ej7TSm2PLqtx+bZUuFhOE1CSwIXfCsymp
 bZQ+UTPaWcBEH2C4BHqq7A0ej/AS2fB1mJxXcjsCpAoxQkLsinf9Gd6zJv/mt7uAkW68
 qi3HrN5SGLYRE8SDv9DWEvvpXKmqGjrXUiMZfpmchhV7frBgu3epz78wbyOPEj0v9agr
 lWeHos+cbft9pwfGdH07cuzmnMfEvIp5oEpJ3XSxjt86e8viRH8WZz5qlaiQSJMeWW+X
 Xg0cmNTBE+RSPreqj/cU3+g2PQT6WNTjSMPMSkAVUuDjzrjzkzTJ1H1qbspbcnbfs4HN
 uONg==
X-Gm-Message-State: AOAM532+ks77WDqwKy/LjYILZZ3XaWELuttDDXHNbW6qaouRz7Jyjs0m
 /VPVTJhgamnREuRBtqmu8I+rwC2B7uI=
X-Google-Smtp-Source: ABdhPJwx7aKjlVhlJDUQLrTmQtGhNyb/Hga4V0W+BS1opvOEMN2cN1iPUni3CS1TGvZKS9JX8wu+fw==
X-Received: by 2002:a17:907:435b:: with SMTP id
 oc19mr2616706ejb.311.1603809652415; 
 Tue, 27 Oct 2020 07:40:52 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id d14sm1092294edx.53.2020.10.27.07.40.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2020 07:40:51 -0700 (PDT)
Subject: Re: [PATCH 08/15] mips: remove bios_name
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201026143028.3034018-1-pbonzini@redhat.com>
 <20201026143028.3034018-9-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c02ce052-aade-c596-40e6-0d841beb8308@amsat.org>
Date: Tue, 27 Oct 2020 15:40:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201026143028.3034018-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/20 3:30 PM, Paolo Bonzini wrote:
> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/mips/fuloong2e.c | 6 +++---
>  hw/mips/jazz.c      | 6 +++---
>  hw/mips/malta.c     | 6 +++---
>  hw/mips/mipssim.c   | 6 +++---
>  hw/mips/r4k.c       | 4 +---
>  5 files changed, 13 insertions(+), 15 deletions(-)
...
> diff --git a/hw/mips/r4k.c b/hw/mips/r4k.c
> index 3830854342..b27be138a4 100644
> --- a/hw/mips/r4k.c
> +++ b/hw/mips/r4k.c
> @@ -168,6 +168,7 @@ static const int sector_len = 32 * KiB;
>  static
>  void mips_r4k_init(MachineState *machine)
>  {
> +    const char *bios_name = machine->firmware ?: BIOS_FILENAME;

Don't we have a "redefinition of global variable" warning here?

Anyway,
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>      const char *kernel_filename = machine->kernel_filename;
>      const char *kernel_cmdline = machine->kernel_cmdline;
>      const char *initrd_filename = machine->initrd_filename;
> @@ -221,9 +222,6 @@ void mips_r4k_init(MachineState *machine)
>       * run.
>       */
>  
> -    if (bios_name == NULL) {
> -        bios_name = BIOS_FILENAME;
> -    }
>      filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>      if (filename) {
>          bios_size = get_image_size(filename);
> 


