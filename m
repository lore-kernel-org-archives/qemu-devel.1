Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFA1C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 00:00:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75203218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 00:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S+D1IMog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75203218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSUD1-00012y-JW
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 19:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSUCC-0000bE-FS
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 19:59:08 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:46767)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSUCA-0000sV-SH
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 19:59:08 -0400
Received: by mail-pl1-x62a.google.com with SMTP id d6so777294plo.13
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 16:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Wfvet226jKe0fjkrG7ppmof9O45eZxLZ6zBsL3I/S98=;
 b=S+D1IMogCRLRkh3V5gnnes5qm1OlEqDloUKgSq0rJwk+5BAkeQhwog0rGF7IFuJ+XU
 oDXBfeZx+6/ZJ6FqdAbiVZxD47S4WgEgCcTqOd0jJ/fAfMlYnRKwWpzfyrW+pYd79t9Z
 XouvXiSz6XeCV6c2+Uz9g3vnBlnkvGFW8Xs6ar6sRuwXxtlow2xUvVoLcwmhPnXZ0yip
 kRvC9AKUHc5FpYeo6G2fzzo5EZ5lWc5YmY6uRmhX1KTmC36NURsj3lHY+k2WPxWpVuuX
 41EUqkZeMIR5eLQpO2xU8fkPuptemRNUtseEM629t390IJ2U3+eDDd/VOMhhVHCeT9RF
 Niag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Wfvet226jKe0fjkrG7ppmof9O45eZxLZ6zBsL3I/S98=;
 b=PrbsUHbUCzq+S53wjMBiERY0SY+My+UzW9gV58wBSmv1xStg/LrGM1NNmxLmRIrJwZ
 Y6mLe9xvuYedbDDo01tv1MqByk4A9MTZpgmaLz5brEFblcgTZqmvDJzyUJWz9ss2LsLU
 WjoYEIzqbCOeN3jNuUuJLCzj9LlZG7RT5nXTMTOG81edKAdmen+9JHCuoz/I9f9f0hMH
 oJaEKvtr637ZWRarUf4md6yxRlpVKhVWaS9HvuiKPr+htvToonb5s1z0HjQP0xQ8jjQr
 dMn3JkE63FQsd75HVRfIu89R667Frf3d2V+C49czTvo1ZXR/9+oB9z+Nd58Edm2tgHYL
 p+9w==
X-Gm-Message-State: AOAM531erxtO7qn3YQdnWtDueb4/hbp2KhCJty7311UfZ+v5rA2U7V/z
 wemTQtfVhBLd6IamphJqjfeU/A==
X-Google-Smtp-Source: ABdhPJwdAMu85dJq1kZ1zyCylTnEmkKptAlQhHM3ycw8EJjbKLCmWhy+ngd2lQbGFw95dQ5KLcBAQA==
X-Received: by 2002:a17:902:9302:b029:d3:9c6b:9c00 with SMTP id
 bc2-20020a1709029302b02900d39c6b9c00mr2047512plb.77.1602633545042; 
 Tue, 13 Oct 2020 16:59:05 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f9sm388038pjq.26.2020.10.13.16.59.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 16:59:04 -0700 (PDT)
Subject: Re: [PATCH 0/2] hw/mips/malta: Minor housekeeping in mips_malta_init()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201012160503.3472140-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a8cc2f72-766f-b588-06ea-df516a830281@linaro.org>
Date: Tue, 13 Oct 2020 16:59:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012160503.3472140-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/20 9:05 AM, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (2):
>   hw/mips/malta: Move gt64120 related code together
>   hw/mips/malta: Use clearer qdev style

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

