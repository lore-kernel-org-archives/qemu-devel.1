Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D975C31E49
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 02:17:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 126012089E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 02:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NIqT+37g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126012089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43784 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hchDR-0003Da-6j
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 22:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58235)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hchBS-0002K5-6v
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 22:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hchBQ-000289-Be
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 22:15:46 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37561)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hchBO-00026Y-Kq
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 22:15:43 -0400
Received: by mail-pg1-x541.google.com with SMTP id n65so407122pga.4
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2019 19:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BaULj9AV51aMy4scDO0K4YmfVBSAL1OTfhT3SVNwWhc=;
 b=NIqT+37gBE1VpDd0ml8bxBShuwP/YHcgfVmcy84ktskRmeLygah6kI4A/XpYMP33cj
 BZEO79SJ1SvelEPAHfcd3nSsigghEHsFq8gNAJsSZhcDbV/VieD+WrYJwmgRbcFn+1ne
 I43Rt2hdrrdhXqvLm7oFqzm/oZHnGbpF29bEMDfvz2dJpjHkQmq+ZcFCO2INemHakoly
 RIEw+4+Hy/2QHpmAsCfu0lpEc62MSCFHJKPC+PRcBpPQeDBUx4GdgAIDf+V7t2lDjMgb
 fN5U/FuhKYZ6bLF2JyBilf46NP27PZa+381RvlXgn9ouERPJYo8uv6gUfjrzK/kaXRq6
 IFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BaULj9AV51aMy4scDO0K4YmfVBSAL1OTfhT3SVNwWhc=;
 b=UxZbFI0MllunPM3M/IVh11t/b/HmeVIDQG0+Epzu1kbefQnwIGeBcwB+sKjQOArd3d
 C3OZGcD0zpnVoNCLNmMbSy0C29YWcVBMJt+8qcJ8dSQ5r0EioX0du1CJiN9JV6PykQu3
 /h1kO9+QzlQrvdfpW0EQF9LTxw+81vP5QWlroLZLcd6IZLljHl+Mrn7JKId2YJuoTEDw
 H3oyXwPK89dZQwOYtRXegu92VMXc5ldcy7jkt4v3d62C2St/TpO5XB3HbEV7B5bgkO6o
 LaWvTxGLU45eg8whzzfHP2+yE4NNp8a8VsPrrUY7Wim1nOPyXXiOXLEvTqNQ6DEmtcJf
 QcOw==
X-Gm-Message-State: APjAAAUBOUlKyB3VJ1qV2c9HGyHMizbBWp37/Boj/BSxy61bUSEPz2pJ
 qfEy23xirvdJEH6xVk54ZT7tnQ==
X-Google-Smtp-Source: APXvYqwHVY5JkIBbx19sJoZwl2iMtzew5hb2Q1k4AJYM5fxI/3fj3oez36nwgqCjcbzyA1D4VMd67A==
X-Received: by 2002:a62:4e0c:: with SMTP id c12mr109061649pfb.17.1560737740225; 
 Sun, 16 Jun 2019 19:15:40 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id
 f14sm12314136pfn.53.2019.06.16.19.15.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 16 Jun 2019 19:15:39 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <3a5f9077-930e-cfd0-ab04-fbcd2c0061e4@linaro.org>
Date: Sun, 16 Jun 2019 19:15:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614171200.21078-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH v3 03/50] cpu: introduce
 cpu_in_exclusive_work_context()
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
Cc: "Emilio G. Cota" <cota@braap.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 10:11 AM, Alex Bennée wrote:
>              start_exclusive();
> +            cpu->in_exclusive_work_context = true;
>              wi->func(cpu, wi->data);
> +            cpu->in_exclusive_work_context = false;
>              end_exclusive();

Is there a reason not to put those into start/end_exclusive?
And if not, what does in_exclusive_work_context mean?


r~

