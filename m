Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F0DC10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:33:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3604E208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KJp3Ql64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3604E208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBuvm-0000Xj-DH
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jBuu3-00070o-CN
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:31:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jBuu2-0005OT-Hd
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:31:39 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:36682)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jBuu2-0005O7-AJ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:31:38 -0400
Received: by mail-pj1-x1041.google.com with SMTP id l41so488955pjb.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 23:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LBtzeqGpeGTyOnbMks2RJYD5NP5/mgzHAaWIk54Qw78=;
 b=KJp3Ql64V17xOtuRjhoGWgQNMD0zsZNDI0x92z0Cka1YYc812k0PcuzpnGt09kFFHt
 2S8EeJBoEphpwTntQKDZtxuQ05RU5oqjWbiUPFjnDh9lugFioZK+SbUd9HEz5ty+fzTJ
 gXF/YgpGjIn4xOkTKhz4K5wkpnBpi2vaLILeOtiCjvKZzkPNZAza0zPlZZRQQUSTvi7y
 OzSQoSeIxHrDdtkhrg81qGDc3wBpLm3h3XzzjEc9vR7LIp5l1c4x9AiGkec83m0QZc3C
 taHEV6IZLnAuKHYcrSM/1UZ8rXvq9cTT4Lh+qRwUSE1MgiacUtDIOD+QjNUTLdLpQWRv
 KfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LBtzeqGpeGTyOnbMks2RJYD5NP5/mgzHAaWIk54Qw78=;
 b=mN1hZQdSCByi/KPdlj9z4KjHlc8gBEGbUJWL8Okqjnq+o6rJSnheRACgVmLyiUI8nv
 R9VFey0x5YAY4CwvAtbVZkgMUK7An1VJIVEVJQjt7KnCBlRff3NaQ5+YhmNJs0XaxfEJ
 6kzTB6T5FiKLgGLkz9DWPz4YWXKyEcKRA7VWNNSZvG1QicBfAUv0tGhn6+r88smhp+WM
 +Ef+SzR/PlFXPpFZoe7Sfz9+Z4slI8BMBFNXhOjNPcWFENh8cctqUYmTinGZ7aXLLtGM
 9q19yzZ+ienC4pmMTetswc3DbpYi9WraiS1zHSXmXh2WlOmST+3S/owEaFJERfWOFf87
 +GJQ==
X-Gm-Message-State: ANhLgQ2+JGlY7Xi23w49zygx/dDVX1TM7Sw4QXd3zGp62CdrHXoXQ5Kz
 HuMZCDvUDX25bQTEWeLxoEru9g==
X-Google-Smtp-Source: ADFU+vtSLdoJx6CPulOstIT5keGTLfJsCnKXN7/OVNgyFpCjaAaC6dlfsYLn1vB+6KlXVPySiHrEJQ==
X-Received: by 2002:a17:902:b909:: with SMTP id
 bf9mr1622471plb.96.1583908297467; 
 Tue, 10 Mar 2020 23:31:37 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 139sm26597664pfy.70.2020.03.10.23.31.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2020 23:31:36 -0700 (PDT)
Subject: Re: [PATCH v4 17/18] configure: Drop texinfo requirement
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200309154405.13548-1-peter.maydell@linaro.org>
 <20200309154405.13548-18-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <283f68e7-08a4-ac1d-ef44-5153a673950e@linaro.org>
Date: Tue, 10 Mar 2020 23:31:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309154405.13548-18-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/9/20 8:44 AM, Peter Maydell wrote:
> We don't need the texinfo and pod2man programs to build our documentation
> any more, so remove them from configure's tests.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  configure | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

