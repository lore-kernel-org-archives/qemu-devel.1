Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0361AC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 23:11:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2B272051A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 23:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wKv3Lryd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B272051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irrp1-0001TW-CY
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 18:11:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1irroC-0000Y2-4C
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 18:10:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1irroB-00011M-56
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 18:10:44 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39025)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1irroA-00010U-U7
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 18:10:43 -0500
Received: by mail-pl1-x641.google.com with SMTP id g6so7478872plp.6
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 15:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=iU/M/tMDQtV2QDTx4kgjjdVVZmyjQMec5xKttgTT0iU=;
 b=wKv3Lryd+1PkiZ4E0Ldm0jsUwEDtpqpICQW1ABI968sRRc3R6gAwUKxfi4twvl9etR
 wv8BK4g3IOXfCvT+gd+yXQV6xnu007XfX4uApmSFbxV4a2oszeqrTuWNkwAS9QPLrl4N
 dJ/dJPLs8fvR0RHY/ByQJvUFjKgRxFYDFj0568R0UOuEwdlskBGoF9uE4Fj5CB3ceiTI
 WsvxXLjA2q8DPuIa91/GbdZ7fDk+oTgfXT0g2wTfVonOJzAyhC/4vcuSF5ZElJQ6gK3d
 Bx3Dib/JiRvdgHxvxUhgMIGSMDBr0geZH4vo9NTVYy1IfpT+4P3Dihvnnklhw8LjmVXy
 q7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iU/M/tMDQtV2QDTx4kgjjdVVZmyjQMec5xKttgTT0iU=;
 b=pupU/2B3B7fIhpRnbZdU80Ayp/NdUeSEgBFvZ75tvxTr+gjo+TyYl9jlRpBtFi0Ubm
 FAqUFa8nKOJJIVUnKXsK14sUdRBUzPiEfjH8u7Nn6Ve2dAuZrzufJUq4MSXB3p7Oggkf
 BCIxVeZ92Za4+yauDIsZwBmjOWuwiZv2yiyIa8ZEItyg+vRwHXg8tmnYGd1uevP+lVgg
 Y8GZDz9+FgraHH2yDu8Yu0CkVxgPLoi3HDmlWjdJhCODxXCZYlh21/bMu2x6WGlymIbN
 RzoYrtsVwjJzszQQtbT1FmJunWPnKYBbyNWniVU/zDG9mr4YO25GaAveriPIYYDhk/ur
 1F0w==
X-Gm-Message-State: APjAAAU0c9celJeTsMDNVbsEmxpE3SbZ80nj5cFc23JR5awkoSISTz8g
 RJfwDoxduitNJI4zQNewMsOQdQ==
X-Google-Smtp-Source: APXvYqwIhGuaGuR4vZJPndfMT2sSon6GFwXioKBkwCRY99EPJoyHXHhJcuWi48qsGwMW4550nsxxAw==
X-Received: by 2002:a17:902:d203:: with SMTP id
 t3mr13868095ply.53.1579129841819; 
 Wed, 15 Jan 2020 15:10:41 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id a15sm23549848pfh.169.2020.01.15.15.10.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 15:10:41 -0800 (PST)
Subject: Re: [PATCH v5 21/22] gdbstub: change GDBState.last_packet to
 GByteArray
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200114150953.27659-1-alex.bennee@linaro.org>
 <20200114150953.27659-22-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d490ad2a-4d59-9ecd-6f15-3611af560dfc@linaro.org>
Date: Wed, 15 Jan 2020 13:10:38 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114150953.27659-22-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/14/20 5:09 AM, Alex Bennée wrote:
> From: Damien Hedde <damien.hedde@greensocs.com>
> 
> Remove the packet size upper limit by using a GByteArray
> instead of a statically allocated array for last_packet.
> Thus we can now send big packets.
> 
> Also remove the last_packet_len field and use last_packet->len
> instead.
> 
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Message-Id: <20191211160514.58373-2-damien.hedde@greensocs.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  gdbstub.c | 39 +++++++++++++++++++++------------------
>  1 file changed, 21 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

