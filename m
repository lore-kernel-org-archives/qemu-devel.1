Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD913C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 16:50:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 885222073E
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 16:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HaaET52v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885222073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnPdv-00066Z-Qt
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 12:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnPcG-0004yc-DC
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 12:48:16 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33874)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnPcE-0000DD-Lj
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 12:48:15 -0400
Received: by mail-pg1-x541.google.com with SMTP id t6so582699pgq.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 09:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=chQukggTmBstdzLo3UKBwExa9l0BhvgfjiYmy6JIZfU=;
 b=HaaET52vjWBIDH9iY7y2TUFZYmFNAc5N+TBtCuRqOhVkhiJrVaXojOiTA0HVPhqlUI
 fCW7Yi02jeGoghDCCwL1WbOX0R9HOK/UsLL8RQ94eURYMzDjb/bes7LMbGZK7yT1xO5T
 hMuVkX+TQnWpZfqLVYaO8HoNEeDQPsjB3r1KLzXV5a+sTCFfKCvM91n6cQA978u3AJEH
 zzE2cfD9J0MQZNN+z5yK2QoAUtzU5AeTrgFwZ+x+fAA3hIkayjMHSSRKpDQnSYcVkv2N
 QzYRAnB0f3d7VuELBEfQiAUINhgfVrjIzCVXjdpcbrEon7krV+ofUQljRYTs/lY8sXv9
 n+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=chQukggTmBstdzLo3UKBwExa9l0BhvgfjiYmy6JIZfU=;
 b=NqdDBvwraLD0sExg9N4xdC9BcT/RXeP4OYKnNRj6jU5jQyIRiJIdMV6XNk43trDC+b
 aqwlXv0N3QQkkODx1/D4s/crumpjG3yss1ne7KFbtrYd90A8wcE7dF6hQzlqRC13s3aj
 /1krKKTTV02utAQw14GHDjitxcn91vLbV1JtnfVCBA8A4J7l4/jPf/rTuA/JFDKRK8F3
 W3ArGKuyL3f5alxcfvwZdHKGCkx3f2Ot1VS+c//n3n6xvlygO55lGQXjbE3l9x52wyQ/
 hFkhWFDvyldsU0YI3ezvaL7VJrG8WFUIPWk9LnDvqy00x0gW7YGvDhPiAsa9xE2hDKyd
 IOvQ==
X-Gm-Message-State: AOAM531NL82Q//+12FpsKZSeQFltMyWrFkFQxWu4arNyvXqlW3hBmpEJ
 SBBoR2G2lZK2DAMaFvVxgzHPZg==
X-Google-Smtp-Source: ABdhPJz7+V31if5rIH4eA8VtJoq/Az6prc3umnIcaI3Z25dSj7meMozg0AG1mi1A6iuX08bpwTyT+Q==
X-Received: by 2002:a63:ff54:: with SMTP id s20mr14239378pgk.251.1592844492393; 
 Mon, 22 Jun 2020 09:48:12 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id f191sm14016103pfa.82.2020.06.22.09.48.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 09:48:11 -0700 (PDT)
Subject: Re: [PATCH v3 3/7] hw/misc/led: Emit a trace event when LED intensity
 has changed
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200620230719.32139-1-f4bug@amsat.org>
 <20200620230719.32139-4-f4bug@amsat.org>
 <ae4a7411-7042-3530-3faf-e25368080820@linaro.org>
 <c9e3897b-c711-f59b-d400-0bd01fd320b5@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <191eaa28-7ff4-38f6-9489-612ac984f20f@linaro.org>
Date: Mon, 22 Jun 2020 09:48:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <c9e3897b-c711-f59b-d400-0bd01fd320b5@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/21/20 3:25 PM, Philippe Mathieu-Daudé wrote:
> Anyway I switched to a percent value. What is better to hold
> it, an 'unsigned' or 'uint8_t' type?

Might as well use unsigned; you'll not be saving space with uint8_t.


r~

