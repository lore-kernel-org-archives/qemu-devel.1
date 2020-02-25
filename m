Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D759C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 20:00:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 513F42082F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 20:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="axdQv2nM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 513F42082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6gNL-0005WU-AW
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 15:00:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6gMd-00054X-Cx
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 14:59:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6gMc-0002G9-3N
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 14:59:30 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46455)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6gMa-0002Cj-7z
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 14:59:28 -0500
Received: by mail-pf1-x443.google.com with SMTP id k29so94607pfp.13
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 11:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VXnvwxci0EtSYj2MqdMZZp/Gzb1oPHTK/4tTcRKaQpo=;
 b=axdQv2nMP5gnsC/0kJWjo/Rk/aR8oReuLbn+pJBk7okB2fjeLbYNVPbqUD2Dasx5Td
 vZRAWjmn+dlnlU6bIUW1erXgbgH33KcYGjsrCgLr9TlEU4OOAyaEzia5QYFcsKayTEs1
 AY0lP14tDOkX0V7NXq+h5PvvTASeQ/USn/DLbkcnaN6PPM/FwegLMxKZvLsJMih4etUt
 CGYKMWXc4CJkyM1c8NeZYnDOBAIAFxrogGWa9+tP7iRifpdpnpP+AXm74mzCkG5p7GhC
 39cu1t/emwCd+jG9Yo8cz5BozBSQrkaiSsmJyHxy89vU8ZOGV+4Y/GHa8cQcWpBHVgPV
 EsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VXnvwxci0EtSYj2MqdMZZp/Gzb1oPHTK/4tTcRKaQpo=;
 b=BipotwT7KpXXlZZvVfrZQGDioFEgERUPWBCWKXk9Ub3cW/cMIgT06YaaNQat0xCkF4
 E5uBeud2hoVB2QYeBAwf09b0LoFEiYrZdVVSGkqWlwf6gmkhwOrdh0C9dDvXiz14xOrO
 940PoJ8JZlGUixkIh5QuvMHfr8+br0ZvVl/QkQGNWXRcXCIs0rrmc7VvagTVIaPzH9Za
 yExwLVR1coLh1NmMAXa8xsxP7Hy7VwLhVqe5DO/vGo5KYuj3iu3DFx1LR+z6RMpZsxSg
 7m2fcVhXSI+poWAW1X2q0wpMvZ5UBf5knN8yXS4ZSMDRZqwyeJ2pzAAqmwKHhKYwvH9k
 e3iA==
X-Gm-Message-State: APjAAAV1Tmq1fQJGX16VrNqQWGxQZSm0vBMxWDK6sGmlyLb+TBy4fF/X
 ngf0p460i67kdYQrwcOHMTKf+1lGEs0=
X-Google-Smtp-Source: APXvYqwLNa7cb7RbIk5p62C0wpZXGQNZoApx2jxncwShniwcZyf2+vjPIUStYC90bB9Q5LPQVr3JPA==
X-Received: by 2002:a63:d344:: with SMTP id u4mr166825pgi.153.1582660766472;
 Tue, 25 Feb 2020 11:59:26 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 t11sm4239188pjo.21.2020.02.25.11.59.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2020 11:59:25 -0800 (PST)
Subject: Re: [PATCH v3 0/5] linux-user: Implement x86_64 vsyscalls
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20200213032223.14643-1-richard.henderson@linaro.org>
Message-ID: <01077c2a-e90f-5a91-6e41-2f08e3978789@linaro.org>
Date: Tue, 25 Feb 2020 11:59:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213032223.14643-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/12/20 7:22 PM, Richard Henderson wrote:
> Changes for v3:
> 
>   * Add TARGET_VSYSCALL_PAGE define.
>   * Move the sigsegv goto around.
> 
> v2: https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg03474.html
> v1: https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg02841.html

Ping?


r~

