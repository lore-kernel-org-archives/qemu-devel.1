Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AFBC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:23:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CE7320730
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eD7tObuN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE7320730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izfFp-0003gF-OL
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:23:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izfCc-0006yL-3G
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:20:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izfCb-0005ys-58
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:20:10 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:42299)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izfCa-0005sH-Uj
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:20:09 -0500
Received: by mail-wr1-x42c.google.com with SMTP id k11so6649980wrd.9
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 03:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=o4IyrtBSf1wjpQa0Yxf2YW6iXyU0Bii0YrCwN+cD1zI=;
 b=eD7tObuNr144XAhRh1AtdhGNvTiHNcRgq0A+HoYDs0QgOJimYO1hPKsTfTMug7ogtG
 H7n+BK2hHgJQD0/J3hrLpRMuUXTYVPhKq+19FfYhcdKHumi5UYJz5I/XjzIC1ez8DIKv
 OpagPfI5IsJ4EkbFu2G/2tIEzBhRZXKdxVJ5l10iIOtLdK+DQzBb5dqi5Fv5ssXytOx1
 lV4N5SJ8UBtX/fawL1JxfIT4Hlss1Houj3MMG1KeYKeex/MdwBlidX/7MxkDFfbmrPWq
 c3MUSvwuQnMYg1neoMGsMP/EdkA0L1yblYDwgB6WnNVMgteuabam3hhtJjX1GhxZY+uY
 dS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=o4IyrtBSf1wjpQa0Yxf2YW6iXyU0Bii0YrCwN+cD1zI=;
 b=R4h3bxTtzmfvQHhICQtjgOx+FLWaE38fGb/rjSaXMawF9ZW73m3jITeLwcp05UiP5J
 65LHV0LjNUAhBQFu6Q6sh2wJ1LVZ3O4cxkgSIFdw8O8cmrclXaIEOmoCbLwx83YGfyX/
 ZAQDRs4DKuSfSk3dhDOu8hntgNoTQamazjTJ+XYppEqoeNAMMWI7ioMVggSE9e/gWPP5
 skq+qSVtoRpzwliEdG1+R9OWIwEzI4jpTndevi2jPsS/H4BbfyuzBHmmHN/odgYhX+jt
 JmjiOUqxIbxOr4ups3BvddMKhWwAIVUMwiiofpVf4JE0FVg+SI/J1zUxMiD3vvUNiRB7
 5npA==
X-Gm-Message-State: APjAAAVGET8+E1vKkUhwzaF+gapjLlzOoe28nlBssNxfNEeF/vZIhwEJ
 DgdT0EAxeTNl/dIwlRgnbfC5xw==
X-Google-Smtp-Source: APXvYqwAWz/+DLQ1aOaPKoFO5EdE77y3xHxWZgC6qgXHfvIGG0hkoZq1rmUCzc/zihCVwGwlBIZKsQ==
X-Received: by 2002:adf:fa87:: with SMTP id h7mr3548793wrr.172.1580988007975; 
 Thu, 06 Feb 2020 03:20:07 -0800 (PST)
Received: from [10.43.13.93] ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id 5sm3905227wrc.75.2020.02.06.03.20.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 03:20:07 -0800 (PST)
Subject: Re: [PATCH v6 13/22] target/arm: generate xml description of our SVE
 registers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200205171031.22582-1-alex.bennee@linaro.org>
 <20200205171031.22582-14-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3edd3b91-2713-a0d8-303d-055656aad584@linaro.org>
Date: Thu, 6 Feb 2020 11:20:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200205171031.22582-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, luis.machado@linaro.org,
 alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 5:10 PM, Alex Bennée wrote:
> @@ -7143,6 +7255,7 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
>      gdb_register_coprocessor(cs, arm_gdb_get_sysreg, arm_gdb_set_sysreg,
>                               arm_gen_dynamic_sysreg_xml(cs, cs->gdb_num_regs),
>                               "system-registers.xml", 0);
> +
>  }

Stray whitespace.


r~

