Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC441C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 17:52:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 823F7206DA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 17:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+gYqWYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823F7206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k317J-0005oT-OJ
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 13:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k316W-0004zf-3Y
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 13:52:00 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:44661)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k316U-00043h-I4
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 13:51:59 -0400
Received: by mail-ej1-x644.google.com with SMTP id bo3so20786737ejb.11
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 10:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bnJgQ96N4hK57RARO+UZKRQXB9rQDCBQzloXPRIZ9Yw=;
 b=f+gYqWYvoYeh1Yz3ujXiSQIo3pb08GMe5FEH+DmCDCHMhd1c23VTFvjsk5jktHoWZh
 s+k4lWbdG/7k8U7iqCGYfThBDHQWAuNa2dMI6nDAWS01DvDfbQKTXngY3DA9fP4/ysKg
 O+sRLxqeOMHpSQ0aAzSpZGnDON+1xTT00mNoeJojllIhppv/IcydD15JjOkFmA5+kRBw
 O9YEqCEcXFhQ05v6c2oOn9NdOZHNlND4aMbA4Rl/w10/WsGJGBni8UOfOjBtT8UR18aV
 qoB6KPUZqJYGlY+0JhesQE/mUx+srTut3yWzXT1lohQ4OZoeBWJJ9UgegU07K3ffhTdH
 /HPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bnJgQ96N4hK57RARO+UZKRQXB9rQDCBQzloXPRIZ9Yw=;
 b=hasYoemHf3dhzGPP0kTcaIjLADKkn2mj4kRPSTq/WZzDJLQ3EQ1n6rA05h7o3UxmDW
 nrgLpRz3LXiUfTtuJBiZl2fvwFhXmINcF6+H9F45MaLXgQGXyvCX8xASUrtAjS/3V/VL
 hpP/e8OSHpCZm6dJMRvDRrDMnGLI1CCctp2ADM1K6IECPfZ8QGFYuT0OYe5hKwAANdGn
 zihNRUCRsLshUVjvo7GbQortHZEjDQs4+8wq8KqMsiSABxmFylrakxYc+0x9HfOJrYgH
 Zo4iQv5BoUrejvj80XVSEFuRNilnjt+Ol8yDNQelnSS7lc6Zp9+msarF3B9eVrLLTrGm
 04WA==
X-Gm-Message-State: AOAM532F0dYU7Ho6c0WH4z11h11SFzZhgGJd8zGEPzTQhTl5g2mN8yXi
 39BQhDdrohIl+V0n2WDtUso=
X-Google-Smtp-Source: ABdhPJxo7Gge+I35j1XN6TU9km8xhqEI5WrrW9N7Th353WD6O90wJqkYBN4dR9AIFlEroZhqPxiKCQ==
X-Received: by 2002:a17:906:a153:: with SMTP id
 bu19mr5925894ejb.142.1596563516775; 
 Tue, 04 Aug 2020 10:51:56 -0700 (PDT)
Received: from [192.168.1.43] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id h8sm19024955ejj.104.2020.08.04.10.51.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2020 10:51:56 -0700 (PDT)
Subject: Re: [PATCH 06/11] tests/Makefile: Add $(EXESUF) to fp-test target
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200804170055.2851-1-thuth@redhat.com>
 <20200804170055.2851-7-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <34a90ec1-610d-556a-f411-8f85bbdb0a9e@amsat.org>
Date: Tue, 4 Aug 2020 19:51:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200804170055.2851-7-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x644.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/4/20 7:00 PM, Thomas Huth wrote:
> In case we ever want to compile this for Windows, we need the $(EXESUF)
> here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 2806e062d0..e2532e12e2 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -687,7 +687,7 @@ check-report.tap: $(patsubst %,check-report-qtest-%.tap, $(QTEST_TARGETS)) check
>  # generic Makefile expansions. Once we are cleanly passing all
>  # the tests we can simplify the make syntax.
>  
> -FP_TEST_BIN=$(BUILD_DIR)/tests/fp/fp-test
> +FP_TEST_BIN=$(BUILD_DIR)/tests/fp/fp-test$(EXESUF)
>  
>  # the build dir is created by configure
>  $(FP_TEST_BIN): config-host.h $(test-util-obj-y)
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

