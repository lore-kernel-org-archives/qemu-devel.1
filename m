Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56516C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:39:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CE882071A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nN8W/iPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE882071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqepo-0002zd-Em
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqeot-0001ju-5j
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:38:43 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:43202)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqeor-0007kW-Fu
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:38:42 -0400
Received: by mail-ed1-x543.google.com with SMTP id d15so20324757edm.10
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 08:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a/CXUu1IG63pVRqzAUNR3zqeeKASwFkK9A8KGWfcnjI=;
 b=nN8W/iPSvkEh9SYaC5SyaWIkBTHGgJpF75mZshln56r433Slpe1HBgqrkh60Tkct4e
 mBmxEcEBqCMWH76wUXBeN4oUXevvaKOnlnJBq3b52tjN2kZTY5TOXC3VbkfPYjsyOg4T
 VYPtluV0N5SveEzyzu1QrakfXXCP4fs9ub4pUy6OQ4JiIqDCgYMCjEgEVlGgfX5Qwtyo
 CQ9zPosiGlVs/QAa8CHOSokpXnwEttFyJ7zlHhRZaJnSgHj2EDyPF5yJPZT+V0r+lmUy
 s94bTKM1h4wQCJn7NAPxyMTKXHTrGuSTJyWMg+kUnNCc0Rp6/KxGnO7gwy0Mmy4MY9o3
 2cLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=a/CXUu1IG63pVRqzAUNR3zqeeKASwFkK9A8KGWfcnjI=;
 b=bH/iDP9vKHhXX0bDexMCQ5xD041C5mimfToj0fMWYojoPUzNKLg5N9fQ+sg0fhaqLz
 Oecei4P9slauATEPQlEf8d7V+rwHML+0LDTdJu1e2GSOx2gdIzj/5j6kQcjAP5XEfMgX
 Foimm7UbmQAxo3AeuR2k+hPZa7i+zOxDFFuhV6heC1kPHWF5BujaUerbsrosRkvOLWrg
 MwtNOT8Ta+IxQCkvLPLeL1xyjYh3NyrwGjMpi9DMtQb3r+5JBPAz9H9IuADWYllWhinz
 domYmOPTlGeGjlpotcCN7k2ZI6j0eTNZkiNP+6Gf9DM+P24Sr/e0kERnjKcB0AmxQl7G
 m6+w==
X-Gm-Message-State: AOAM5328hBtHX8IIuUSlhYFf6UVKGfRBr5z9ZZTz6VQZQyIiAxTDlcAQ
 M7yitiLWj4jVAwWIEkf4KLU=
X-Google-Smtp-Source: ABdhPJwyeU4MCsVYfrHDPo9Fqz7D0THgXnhfBkSgjpiHKo5PjkDIZIrZ19xVPOyiHMH3IiVYMgaXxw==
X-Received: by 2002:aa7:da89:: with SMTP id q9mr30206534eds.273.1593617919742; 
 Wed, 01 Jul 2020 08:38:39 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u60sm7010183edc.59.2020.07.01.08.38.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 08:38:38 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] MAINTAINERS: Adjust MIPS maintainership
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-devel@nongnu.org
References: <20200630164653.24880-1-aleksandar.qemu.devel@gmail.com>
 <20200630164653.24880-3-aleksandar.qemu.devel@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <3553a0a3-760f-b69d-f980-09b4c306a3b5@amsat.org>
Date: Wed, 1 Jul 2020 17:38:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200630164653.24880-3-aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x543.google.com
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
Cc: aleksandar.rikalo@syrmia.com, Paul Burton <paulburton@kernel.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/20 6:46 PM, Aleksandar Markovic wrote:
> Paul Burton and Aurelien Jarno removed for not being present.
> 
> Huacai Chen and Jiaxun Yang step in as new energy.
> 
> CC: Paul Burton <paulburton@kernel.org>
> CC: Aurelien Jarno <aurelien@aurel32.net>
> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> ---
>  MAINTAINERS | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5d8acf8d31..7fc16e21c9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -213,7 +213,8 @@ F: disas/microblaze.c
>  
>  MIPS TCG CPUs
>  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> -R: Aurelien Jarno <aurelien@aurel32.net>
> +M: Huacai Chen <chenhc@lemote.com>
> +R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>  S: Maintained
>  F: target/mips/
> @@ -377,6 +378,7 @@ F: target/arm/kvm.c
[...]
>  
>  MIPS TCG target
>  M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> -R: Aurelien Jarno <aurelien@aurel32.net>
> +M: Huacai Chen <chenhc@lemote.com>
> +R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>  S: Maintained
>  F: tcg/mips/
> 

Jiaxun Yang is very active with Loongson on the kernel side, and
is also very motivated. Looking at commit 84878f4c00 ("Fix loongson
multimedia condition instructions") he has enough knowledge to be
listed as TCG maintainer, not a reviewer.

