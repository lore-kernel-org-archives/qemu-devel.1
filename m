Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB056C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:57:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3979E2225E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoNKYB0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3979E2225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZf1V-0002Hg-4x
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 13:57:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZf0Y-0001Am-QO
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:56:46 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:39890)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZf0W-00033n-2j
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:56:46 -0500
Received: by mail-wm1-x32c.google.com with SMTP id 205so2765047wma.4
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 10:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MOMRJnKORHE0qlSIrx4055Vv53UxqC8FDR0LznOCHVc=;
 b=SoNKYB0COIQlBiW5hzeapKwBNz5WedkcErwRA/lSnwYXypr3d0nc1Kbs7Rx0826vke
 YTvvDjZMeJ+MI/6W672kpO1qAKgw2DTM5zKfhNgshT4uqdBSmxGO3ISxNnoHUWp8QJA8
 ZnRQ3/EGfhqOiplUarm3zw4DJFH8RYK7V3XT0m8dQ1c7G4qggW0ELcwsZ/tcbpnrKE9U
 2wfXU/QrfkTZ3Qonfg56Hc7kvmyOeIwejOd0fStXrLSDtqFyZQm7j0mGwKrHlhbsfhoL
 ABrp5y/LqSYQkn5LgneFL4eQdpr1TnlNDOFAKPW9Jhu/cdGCB8f42H+Z2G1TfZlCeDha
 Oj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MOMRJnKORHE0qlSIrx4055Vv53UxqC8FDR0LznOCHVc=;
 b=AitmDZ/JY2/PXgpaPFpomZh8RcjRueTLuLW9m3YBxs0yXhuWiyBQkaDoOID1ZMvNOx
 TqHJd7J3Amb/R6S00vebZl+YEWnRjqBE4SeuwjCfLBjgXLT9ikxaSxrUPemAFZjdmmc3
 X15fvpm0UHK12vSd/cw9m+gFqClquluk98C8+60OTyQKc91CLbgbzObZmatbJyvgs+ul
 c/TW1LbaU7hG/gX/O/Gs2UpDNTYO+PZfS9J31ilhpb9lQ5M6//I5QCLRQ3jF2aqFiU95
 ofcuhkvMkmmv9nuToinLTYgwZIWGQRLlcMnfgGvCsdUEhdCZLpBr3YuuRHKZbr6ng6wh
 fbGg==
X-Gm-Message-State: AOAM530BbXKvCIfHd0BxQ1B/VJMHwyX/vxnaNoHJ+zr7zJJ1vcYV8Hmq
 QTE0FpmmZP4EPtmzm/PPF14=
X-Google-Smtp-Source: ABdhPJxX7mD0Gqr99+UoQeBe5XNjchhgqSRiYMv+ZViRwcK4NJFybJOl7iWeHevU7poR4y+wNQrtqQ==
X-Received: by 2002:a1c:1bd3:: with SMTP id
 b202mr18632404wmb.169.1604343401680; 
 Mon, 02 Nov 2020 10:56:41 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id 205sm367029wme.38.2020.11.02.10.56.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2020 10:56:41 -0800 (PST)
Subject: Re: linux-user/elfload.c: Seeing a segfault in qemu with a binary
 with no data section
To: Stephen Long <steplong@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Ben Hutchings <ben@decadent.org.uk>,
 Richard Henderson <richard.henderson@linaro.org>
References: <MWHPR0201MB3547611C45D39E28B0377296C7100@MWHPR0201MB3547.namprd02.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <76286ea4-ebfe-0b7a-31b1-4bc8122acf52@amsat.org>
Date: Mon, 2 Nov 2020 19:56:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <MWHPR0201MB3547611C45D39E28B0377296C7100@MWHPR0201MB3547.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/2/20 7:30 PM, Stephen Long wrote:
> Hi, we are seeing a segfault in qemu in the following code snippet in zero_bss():
> 
> if (host_start < host_map_start) {
>   memset((void *)host_start, 0, host_map_start - host_start);
> }
> 
> The elf doesn't have a data section, so host_start isn't mapped. I'm not sure whether this is a qemu issue or the generated elf is no good.

Is it https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=919921 ?
Ben never sent it to qemu-devel.

> 
> Thanks,
> Stephen
> 


