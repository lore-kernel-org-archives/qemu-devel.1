Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F962C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:58:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8DA42085A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 17:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H/gF1hGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8DA42085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58880 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOnJq-0007w5-7j
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 13:58:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOnEm-0003Uu-2A
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:53:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOnEk-0006gb-3g
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:53:43 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:45105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOnEi-0006at-5D
	for qemu-devel@nongnu.org; Thu, 09 May 2019 13:53:41 -0400
Received: by mail-pl1-x633.google.com with SMTP id a5so1486297pls.12
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 10:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=tZspNkHDi8B5NZIIUZTWWcNPDy926n62xxi1IYNKWpQ=;
	b=H/gF1hGhcPgPCwni3wGQ3VFe2MBb/6CQYvgvF2L/ZYQ44H5slIfni5P9qotMqvkOq6
	n3W8uJPEUg/FdBiVuWv0hRsvPEdQ7J4spMEVqPjrYW1uU4ezRROQSC7lL0npJbHVLNq5
	p6ExPE+CffJF+Wu8LkR2Z4qXdlIhaeH7Uxf6sBN9vbQFooBFae+obsEY2GkZKhGwMqD2
	ns8RUHq5CW9KcoGvUvHmAxumUGLJers2eBf7zqNhaaPwRc8MgndbHsvJ0JMpetfcoLPj
	XVs38QOb8ZStZxuWOIXJXLpLj03Bgfy+Scqws70XHnDC2MxEJscEj47YzuwtKzTCKioL
	7zdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=tZspNkHDi8B5NZIIUZTWWcNPDy926n62xxi1IYNKWpQ=;
	b=UsxA998aKRf5Xddm1ofcd2DgNIA8SX0NKFS/7oiujG90j8tdlH3HbnCWt+S5I7O51e
	ScX16f0Psu58u6EciCf0lJtugjVhszkJYQ/jyVG3cXnKZi3+vL/OZ+/bP7IhZ+XvhGxY
	oKrYgEZ5G5czAOKGvyPoP045D0lobDKiLAC6R5QIpUA31t5HF1SYNmxs0RbA6aCcTk3W
	qC1RfqhIhGZ1j1V+veiQGs9NlsXgqVb5YKBeaJy01Q1ju74EXKf67b2Uo3p+SzZ+xHW+
	uGlXLJRjVlEpLFiMYceklVJ58+oWKfl1QPh3LoTxIsBM1l/TA7Kt/SvNHdjR/aOIN2Tt
	Jc2A==
X-Gm-Message-State: APjAAAUmQ8jDxFybY1k7mbrtvnw6wYAzYpHP4WtQkGWUnKpue3zRA/zd
	9POmRNFynHgeI6EPlSiXVDLP/w==
X-Google-Smtp-Source: APXvYqwmo/IyNC7Dy2evI+0thCJTFVfN03rAch6TRCyrTzuanFjUw9FP6rH/cdfOjb7Ci7EE142X+w==
X-Received: by 2002:a17:902:521:: with SMTP id
	30mr6810185plf.248.1557424410953; 
	Thu, 09 May 2019 10:53:30 -0700 (PDT)
Received: from [172.31.99.192] (50-248-210-99-static.hfc.comcastbusiness.net.
	[50.248.210.99]) by smtp.gmail.com with ESMTPSA id
	i27sm9531986pfk.162.2019.05.09.10.53.29
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 10:53:29 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190509165912.10512-1-alex.bennee@linaro.org>
	<20190509165912.10512-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <37051934-a02b-1461-537d-9f6ed93ae4a9@linaro.org>
Date: Thu, 9 May 2019 10:53:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509165912.10512-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::633
Subject: Re: [Qemu-devel] [PATCH v1 02/23] tests/docker: Test more
 components on the Fedora default image
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
Cc: Fam Zheng <fam@euphon.net>, qemu-arm@nongnu.org,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/9/19 9:58 AM, Alex Bennée wrote:
> From: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Install optional dependencies of QEMU to get better coverage.
> 
> The following components are now enabled:
> 
>   $ ./configure
>   ...
>   Multipath support yes
>   VNC SASL support  yes
>   RDMA support      yes
>   PVRDMA support    yes
>   libiscsi support  yes
>   seccomp support   yes
>   libpmem support   yes
>   libudev           yes
> 
> Note: The udev-devel package is provided by systemd-devel.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Message-Id: <20190504055440.20406-1-philmd@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/dockerfiles/fedora.docker | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

