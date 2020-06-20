Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14282C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 17:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCA9323E55
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 17:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HM9Go5QA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA9323E55
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmhTF-0005vT-29
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 13:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmhSR-0005TP-LK
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 13:39:11 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35141)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmhSQ-0006Ju-57
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 13:39:11 -0400
Received: by mail-pl1-x641.google.com with SMTP id k1so5482914pls.2
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2020 10:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JWQwPAcDcUMEFm/UmcouwvWGwawUqAePNHJCGVw1534=;
 b=HM9Go5QAvQRTs+sFN0QJny3BLjI8cpolTvk6EsrvZ+JqpxWOmtrDl1ftD/UIjhPVQZ
 7ilk05dL6sDhx4bj41qTUPH2DLUNz+uWzsiqxxVJFqFAOur6yElY39fGS5ROzD4E7jJ3
 HcQcw91v0I/qj86Ah6DbnOqHIAkxX2YjFovP99Nl4dO6exI6mhGu/9fYaMF3xhE0ejx+
 S3a9rCK/1vv1g0csy3wExwH77gGzEc8KznzoIonVFPvic4aHF8hm08Cj/agxdRbjILSb
 tt0GOqiCkbLO2Ipg8VoWQHACrVxeZK4nzSVO/XOgNjUbTostn79/oxzZYmZmjh0oAXBG
 q4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JWQwPAcDcUMEFm/UmcouwvWGwawUqAePNHJCGVw1534=;
 b=Tod+/UnITD23kVDW62mxa6LdGWFpus3DRcKYatoKmPkaVQuf0u/FRYWKEqi9774G4j
 jxOHHdEf/4pJXijG7rYkXa4BFZtObz9ETDXslWnRR5COCcC2VnU4B2lISNW7FTu0khqg
 4E9yKdpTXgsgoqKV0fcu8ERmZvtOhT93VRx8ZQx1MSXBS29W3mfHA7wh6Qy4tD8QbeII
 OhcISGIZZpi2QaWAtURki4H6sVWaR/LD+GaplvHWTqbqE79kRRT/ykJzuI2Othv0Oopt
 FMeQr37kGcJuKQ/cJwEd502HwN1MOwuZKoE7U1FpmuAKeHV6e7VEXG8dl0xCdXf4V5c9
 dZfA==
X-Gm-Message-State: AOAM531zd1NYMdwqsTRQ9AgTS/MF6GjbnwBFsMQKgY4erNBnyO9hdCkO
 BENp3bwGE9Lkh0qWLcR3vimTjA==
X-Google-Smtp-Source: ABdhPJywofZIW1WCleHzgGDsXG0Bk5LaprqqHuCTAhkf4J+pn8IuShjO0gYGWUDxua7BH+2UwhQxhw==
X-Received: by 2002:a17:902:7:: with SMTP id 7mr11793346pla.209.1592674748245; 
 Sat, 20 Jun 2020 10:39:08 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id o22sm9110196pfd.114.2020.06.20.10.39.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jun 2020 10:39:07 -0700 (PDT)
Subject: Re: [PATCH rc1 15/15] docs: Document the RX target
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20200617191519.14842-1-f4bug@amsat.org>
 <20200617191519.14842-16-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c9f19ea5-e02d-bcff-3486-0f86b64fd2e2@linaro.org>
Date: Sat, 20 Jun 2020 10:39:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200617191519.14842-16-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/20 12:15 PM, Philippe Mathieu-Daudé wrote:
> From: Yoshinori Sato <ysato@users.sourceforge.jp>
> 
> Add rx-virt target specification document.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> Message-Id: <20200308130637.37651-1-ysato@users.sourceforge.jp>
> [PMD: Cover in MAINTAINERS, rename as gdbsim, use machine argument]
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  docs/system/target-rx.rst | 36 ++++++++++++++++++++++++++++++++++++
>  docs/system/targets.rst   |  1 +
>  MAINTAINERS               |  1 +
>  3 files changed, 38 insertions(+)
>  create mode 100644 docs/system/target-rx.rst

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

