Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D413CC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:17:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A08AD20665
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CsvkUwyd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A08AD20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38660 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTpTF-0006QB-N6
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 11:17:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTpOm-00037y-1x
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:12:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTpOl-0005vj-3T
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:12:52 -0400
Received: from mail-vk1-xa43.google.com ([2607:f8b0:4864:20::a43]:45848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTpOk-0005vE-V5
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:12:51 -0400
Received: by mail-vk1-xa43.google.com with SMTP id r23so1421980vkd.12
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 08:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=QNQKpv2CPlGI9NxgyqLnOGzLix5RD0rVAppORD+LUIE=;
	b=CsvkUwydNuPhla8uuhy1+uX1TPpYxfzKB56xJv/2mHBFUJHjQd6zUBr8mDvVGPbARm
	+NPWnS79w0KyDvp4/FYY4n9K3AEDU7LjWLCucIOqMZACEifuB3+vDEk4uz29gM2GgsL6
	Hv1+R1X07byI3F6mSqcLp5p35uJDFXCiSIJmuoo/+r+jZl8DDoNks4pE4Ar96B2IfUHU
	QY4fNcmx80a7KGs0o3ONyt88tW3ZTYflFutCKfGwdJzEp3Wvrj6b85ijq2R1Ec2uCjjp
	UxpkRYWrd8ck4pwz8jdlcnolr7rBdGz1F78dDxP/ZDoeEGJMKra/0d6c1tp2+kjZ2VbJ
	1l5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=QNQKpv2CPlGI9NxgyqLnOGzLix5RD0rVAppORD+LUIE=;
	b=TXmm0s/3WPAZFH3QLb8u/nuAK//yae5GF6eonNkkLp8jrDmjZg/qz3sp2Yd12koyNH
	a9oupNWh72K/y1ZoGtn8wILlv4/iHERffGukWn+zo0UpIIp6VtTwCahCIRxfEfncq4JW
	AwSuB8iSdclulW7VaV/H3F9sT+aMIqmTbbfj9liTP85Wz+9v6V25QpacKaB1EDM9DZEP
	aEsaa2ejWNGbFjq3mHOV3fjW3/PQQ04E0B+mogen+GNWUdLE7ue+LtCTmPHMHgu0u+Tx
	/y6o0WW+Yfw4eisU/ficiuyRAeW5kNrJXNVrjZ/aK7V3broSvzqxL63BaNw3/1EnDxsx
	nGCg==
X-Gm-Message-State: APjAAAVGfWdeCl/jEpwZ4F81dS3X/IqMO29zlkfPDmhpCL6+fBVFLTTf
	+rguPLRi5jirFClEibp9HTtj2Q==
X-Google-Smtp-Source: APXvYqzWGkHUG0Grl78bAvYjrDbidLqxMD1YAiVKp3KJ5Db4/JGTEFV8e40Qs+PDU/sog4cDa+8P9Q==
X-Received: by 2002:a1f:c2c1:: with SMTP id s184mr1944645vkf.65.1558624370062; 
	Thu, 23 May 2019 08:12:50 -0700 (PDT)
Received: from [192.168.43.94] (ip-173-130-215-183.orldfl.spcsdns.net.
	[173.130.215.183]) by smtp.gmail.com with ESMTPSA id
	e19sm2927405vsc.24.2019.05.23.08.12.48
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 08:12:49 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190523102532.10486-1-alex.bennee@linaro.org>
	<20190523102532.10486-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <14e1cffb-9912-6752-1dc1-566ff86197a5@linaro.org>
Date: Thu, 23 May 2019 11:12:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523102532.10486-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::a43
Subject: Re: [Qemu-devel] [PATCH v2 02/28] semihosting: introduce
 CONFIG_SEMIHOSTING
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Marek Vasut <marex@denx.de>, Aleksandar Rikalo <arikalo@wavecomp.com>,
	Chris Wulff <crwulff@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 6:25 AM, Alex Bennée wrote:
> There isn't much point building semihosting for platforms that don't
> support it. Introduce a new symbol and enable it only for the softmmu
> targets that need it.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  default-configs/arm-softmmu.mak         |  1 +
>  default-configs/lm32-softmmu.mak        |  2 +
>  default-configs/m68k-softmmu.mak        |  2 +
>  default-configs/mips-softmmu-common.mak |  1 +
>  default-configs/nios2-softmmu.mak       |  2 +
>  default-configs/xtensa-softmmu.mak      |  2 +
>  hw/Kconfig                              |  1 +
>  hw/semihosting/Kconfig                  |  3 ++
>  hw/semihosting/Makefile.objs            |  2 +-
>  stubs/Makefile.objs                     |  1 +
>  stubs/semihost.c                        | 66 +++++++++++++++++++++++++
>  11 files changed, 82 insertions(+), 1 deletion(-)
>  create mode 100644 hw/semihosting/Kconfig
>  create mode 100644 stubs/semihost.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

