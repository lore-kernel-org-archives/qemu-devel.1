Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CC8C7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 17:00:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97C8821848
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 17:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gR15lyEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C8821848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnnIS-0005MA-Gb
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 13:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60416)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hnnIH-0004uf-Rk
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 13:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hnnIG-0001XD-VZ
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 13:00:41 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40991)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hnnIG-0001UO-OF
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 13:00:40 -0400
Received: by mail-pl1-x642.google.com with SMTP id m9so12230652pls.8
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 10:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zdRLmcLU1Jtzp0I6KGZETWRZXg17Vg6WwjOfzWu7bYM=;
 b=gR15lyExVDjlbo5q+wz/E5V33sA4HsJRXk6FCfVFaJvSqC07cUitvKrFSrLobk2xD4
 UokDjTu8E85cxnT/3/BZsZgMRUmSnD9nINp4ESD2NG4KzK0LFquiItCGfKO3RWcbIZNg
 Cb8J0osip6zFvGxhFDVO4LwrkXcSiBXdoC5GisAruxWZFK0LWp818le5jn61e4X0tI9j
 NtkmVJC7Jtd6X2iviMz86mvx8ukL0wEa79L8qNUSNta+FRXMgs0rIpKkSN8ComnagtGI
 5WaXH4tTad03RTIsKTlqPFlQV0ZMGSjMugGDo34JTZusNIJTw0xquZaRxLXb+tXBmxIy
 n6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zdRLmcLU1Jtzp0I6KGZETWRZXg17Vg6WwjOfzWu7bYM=;
 b=NValfpdYCKCYyYGwYN7A6664JDvTBnI1U8XDoRdgkAUXl55g1Rme3vzSRQFeZeOONf
 1zve+yvGeMo5m9citWJI1qJlRyBsRdMGPR703AaWHrA7MGO3UXpmPn19eJJUJk+h6vTU
 liRSHvjEgU9NUWX6oubR/ZieI5hgPKh3kLiAuTgzrB6O4OcKDIl/rTTfUrn+1bH3qz1N
 3SX01w9OS27d34+L2KA89v0ygSjm0BXgzd4U3IeCzra/XUoY1Ah/z4Bt3AnTCCqtLUbR
 Vpr+2hHFixz3B2+kSs6Gp7Xa8r9E6XKYKCSYu0gniTVHfjnK4AcFJRBCxsr9nzcrMDlC
 FIbQ==
X-Gm-Message-State: APjAAAVxs7eZt4k6LoJ2z5muK5EAJGzmpIF629BQEA/xeH5A7k1Fmd4D
 cQB6wYx9JCtiq2bR+QRiAusctg==
X-Google-Smtp-Source: APXvYqxmQUtxJagBLjvSjkef0rS+QqXM4vWSiK4uAeMzPB4+fdErx7CDG9Kind0x6VmK9W7pN5BiHQ==
X-Received: by 2002:a17:902:5998:: with SMTP id
 p24mr44099177pli.110.1563382838975; 
 Wed, 17 Jul 2019 10:00:38 -0700 (PDT)
Received: from [192.168.1.11] (97-113-176-6.tukw.qwest.net. [97.113.176.6])
 by smtp.gmail.com with ESMTPSA id t2sm22185621pgo.61.2019.07.17.10.00.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Jul 2019 10:00:37 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190711223300.6061-1-jan.bobek@gmail.com>
 <20190711223300.6061-9-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <146e30c1-e9e2-d504-f9fa-e496e8be4acc@linaro.org>
Date: Wed, 17 Jul 2019 10:00:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190711223300.6061-9-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [RISU PATCH v3 08/18] risugen: add command-line
 flag --x86_64
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/11/19 3:32 PM, Jan Bobek wrote:
> This flag instructs the x86 backend to emit 64-bit (rather than
> 32-bit) code.
> 
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  risugen | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

