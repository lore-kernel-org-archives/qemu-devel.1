Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E12C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 22:32:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B643F2051A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 22:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KzxWcurG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B643F2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDbo7-0006rK-Gm
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 18:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43282)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDbgf-0004ft-Rp
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 18:24:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDbgc-0006X6-Vh
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 18:24:48 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34779)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDbgc-0006NW-O4
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 18:24:46 -0400
Received: by mail-pg1-x543.google.com with SMTP id t3so8563896pgn.1
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 15:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9mjBBfe3+8zPJaHBRLiYmfQcPAPAAxt138O5VWEq76o=;
 b=KzxWcurGxhDC9gfEd/zuPmRjeGYTt0iZTAnFLaG70gCncUgZw6L7tLm4Smbuxi7wYM
 FPP5NNb+OG/mZUWTBmlQQ6QJm1/xg2THnxh1tC5SoBZ8k38GljPrwIpZYUdLzwuW+kGX
 udYckSmg7sfXLHrJjGXB9c3Wqb86SSgc0DfQY2JGVZl5PeD0o6YNeLjHt7XJmYQV05Sp
 oWIjicxHkSDmj0ZqmVxNxDW2AbCNpTjsmdGoMG2VaPmgTQHWvIgQMHaYLorS9Kfp6G24
 Y0D7r6NyHhdxl537pXW5UIMuvWIzHfvBmC4NCiN5QKmGxcZf5lopCmka0gblZfY5MhzU
 FzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9mjBBfe3+8zPJaHBRLiYmfQcPAPAAxt138O5VWEq76o=;
 b=Z3DlwqQC8eejCR5GdpxVnoqIF+bidB8Y1+uPR4LCN7A7aj/kS5imDOTx3Vz3lhrLOT
 7IyofB8W/RqeLviQOVzMaGQW2WAPfkGwXF41qxkK2SVpLkkALkQWaSbYWOf9VBdcGy3y
 z5BiEc6XJccycc9uzbAbESjuYao+Sv2oc2oPYx4uv3z1V51JfGUcABEeg2CdxLNpe65I
 8dNldH9M9U/iTTeGW+KKMkj5qfctsslpNhOV5nDCzPRZ9W4aPOrOZJU+Dtav0NkYLKNA
 r4dK2shF4XpA0C+hPbl8c8lEo8r8DPDiBNnmgRtFDGfWgKGDPNyxAv/F6en0NIRHYsfE
 npcw==
X-Gm-Message-State: ANhLgQ2FAcs3NCYY2ySzIyEd5gzcu6/eScU/L+Wf9x3sUVGd2SBSDUU5
 C5kKnNaVaRsgdh7jR5W5o4vLRQ==
X-Google-Smtp-Source: ADFU+vt88oFC1Up8LM6v8beQ5c7tgdPzlzoeW61S1kthVurNqvWOjZIW7WFPwTjgyhw6PIPjezMyPw==
X-Received: by 2002:a63:2ec1:: with SMTP id u184mr8558408pgu.446.1584311084976; 
 Sun, 15 Mar 2020 15:24:44 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 mg16sm14411265pjb.12.2020.03.15.15.24.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 15:24:44 -0700 (PDT)
Subject: Re: [PATCH 3/9] hw/core/qdev-properties: Fix code style
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200313184607.11792-1-philmd@redhat.com>
 <20200313184607.11792-4-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1c7f7bcf-fa8c-51d0-2291-dc6f3bc8be3e@linaro.org>
Date: Sun, 15 Mar 2020 15:24:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200313184607.11792-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 11:46 AM, Philippe Mathieu-Daudé wrote:
> We will soon move this code, fix its style to avoid checkpatch.pl
> to complain.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/core/qdev-properties.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

