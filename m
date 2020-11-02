Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C65C4742C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:06:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2F8E22265
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NdXymMJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F8E22265
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZcLf-0007s3-R6
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 11:06:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kZcKk-0007A0-Vq
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:05:27 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:44493)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kZcKj-0005Qk-1w
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:05:26 -0500
Received: by mail-pf1-x42a.google.com with SMTP id 133so11485987pfx.11
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 08:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1LfXzIFbs89q+yEWqV8izajTVKXkD0RPvkRZYLlBUUw=;
 b=NdXymMJtUX7WCkqX7ui3JvF0BsnzOHflfKVP9pE4QnlBYjoan8hW492UnVmVvKToZJ
 8+f1PszeC07JPIX3Wv0UxDdpLdto8/z8k06RhohKG7hmnDy3Unool1Qnxo3reFoZZ2k+
 zgLpApDZFFauQCTunmvXPa11qMFx9cAQ+hrAH99zXucPkkS3DgzSDnsBbz/zg8uhX4Lc
 5NYTVHFCmPsBGubn6uxZqMSW1b9fbcoYe/ThOr0N56A4bXml6b/E8xnwtWfZ4b77hi7a
 qGRxj468h5Fna/Vz03SnKPcQxjcCLx/kUP+prJ28e7b4yxz6Tc4vLB6vhZF0ciNvOQrv
 0HYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1LfXzIFbs89q+yEWqV8izajTVKXkD0RPvkRZYLlBUUw=;
 b=Yzm3KR61ihjfnNubhzP+jNt+WVZV+ILYZuWUg0hvvUTqss3Pcu7vQVDxXD6oLbQYUa
 l6GgKPmsDqWNkxa4mGXrYa7btHzOf3zOa4CgggPHB3qETerJ0re81py3XKbZArC3Ux23
 aEbvdFzGo3BdWXXHjl51G9VZxVza5MH/DD4yp//2bDfArBRA67AJuWy4YARVn3LUnKeb
 xXNBtcpB9eZvTPHGDCRI6ShTXEfZAyO8chUFUT1HIx92O7L1N50Z1xvn8PsJ6B6mEcrW
 b7Udk+u8RLSqXTFxzmE2W5o0xV4teDdtBNfOtdc9JJOEp6U/stjMuG4UX8j+JQODkyQR
 Fnug==
X-Gm-Message-State: AOAM532FUpeC38lajiX3VpgP3ZUwi/ui2FhP81Cq9SyUGoadHv7PoY7z
 vE/jAoD2w2+6VlGn1V5XdVM2IA==
X-Google-Smtp-Source: ABdhPJyG+VdD+FujQ4fY+oiSji4hJ5Z5UmzuHaGxWK2MJl8v6C/k93YBtOlPZLyE+qBNoEGONYSJ2w==
X-Received: by 2002:a63:3c1b:: with SMTP id j27mr6927442pga.79.1604333123503; 
 Mon, 02 Nov 2020 08:05:23 -0800 (PST)
Received: from [192.168.101.174] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id j11sm14021736pfh.143.2020.11.02.08.05.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 08:05:22 -0800 (PST)
Subject: Re: target/mips: Deprecate nanoMIPS ISA?
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Matthew Fortune <matthew.fortune@mips.com>,
 Paul Burton <paulburton@kernel.org>,
 Stefan Markovic <Stefan.Markovic@mips.com>,
 Robert Suchanek <Robert.Suchanek@mips.com>
References: <CA+Lzsy=o9yshAAAacuTwcs3Hfr4MfWiX-SiUf5A2Fds3vGOrAQ@mail.gmail.com>
 <CAFEAcA9ap=c=1XZ6wpphiE=FYtCU+vdNCX8THW-m-hUp_XyGmg@mail.gmail.com>
 <b384912c-0e62-604d-df0b-b5181c2e7f3d@linaro.org>
 <05afa227-3db0-4b11-d541-7fce7139729d@amsat.org>
 <38441531-1509-724f-4643-2ff2db253e3f@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3fdc46f1-34a9-77ad-1183-249c17cfb3e9@linaro.org>
Date: Mon, 2 Nov 2020 08:05:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <38441531-1509-724f-4643-2ff2db253e3f@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: James Hogan <jhogan@kernel.org>,
 Marcin Nowakowski <marcin.nowakowski@fungible.com>,
 zou xu <iwatchnima@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 2:00 AM, Philippe Mathieu-Daudé wrote:
> The toolchain page mention LLVM but simply links http://llvm.org/
> where I couldn't find any reference on nanoMIPS.
> 
> The only reference in the GCC mailing list, is the nanoMIPS
> announcement: https://gcc.gnu.org/pipermail/gcc/2018-May.txt
> 
> 
> It looks safe for QEMU to declare nanoMIPS deprecated (it has no
> maintainer), to give time to interested parties to finish upstreaming
> process and step in to maintain it.
> Thoughts?

I think that's reasonable.


r~

