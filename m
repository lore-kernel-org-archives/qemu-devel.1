Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510E3C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2066B20707
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oXDo/S39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2066B20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVetm-00087O-56
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 13:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVeqU-0002ua-DI
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:25:34 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43596)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVeqT-0005bP-FO
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:25:34 -0400
Received: by mail-pf1-x441.google.com with SMTP id v63so5849780pfb.10
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 10:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cBftozG75XZ9tnTiXii2K0wKsMELOBp2QoXzaoyyjQY=;
 b=oXDo/S397K7y6x61GxpnziSgcS4P9AAcNV5T6vlx7luu/0hb34oRDUBWSEwHJ98pZ+
 i8c9PxXTyZ6iVqfAGvIeGRGL0Khobq46j7Rty7wofMLCrPcFaaC8qqTrx3Tix6hRUMzC
 DtKrN1gYZvfxGlab2bunBnvLlrIl4mPsh0wB959MASnkaeSr9E4NwV+AZ1ii2tdMFRiA
 YyolZ7JHKtSTCQMeb1CpLT8ruNmdaY019prbNWlSbboEHZl01c4uetuTcCyOYITwtxb6
 K0t4D438RQxwqPv1oC7iHybLKGO4mZcML9NXjnSHQSZ2oOjg6u9Cxa+ntA3nXL3GvBHQ
 6mVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cBftozG75XZ9tnTiXii2K0wKsMELOBp2QoXzaoyyjQY=;
 b=LeCgeCYUP47q/FmoZUb7DDYUPNS1aKFe+l8ZVx/w7Z4WDtSlExbEVG4vBzGQDk9R3O
 8KPjBheO7sA1QHjApNqsQSzjsgJ/TRh8ITfH+sNP0620YWPcjr8688/rXOZ+kXZ1j9sY
 +0x4jRubmpLAopATl6+cRyjU7gvv7aJOhR0oRnEUU8TDiX/EzG9MjxRnEeMB7UVUhO+O
 1HqbJFYx6CPmsJ/KNwt2sfyuTP1vFBcy+EWAEqUO9RLPuzOw+gmgW7QSqv2yZwny9nme
 iojCm5c8MFb9HcPy+FUKCDSAkjukHeM04dFfHIPcQ4l9bJNJhD7f5abu6nJp5ePMCLJ7
 dKXg==
X-Gm-Message-State: AGi0PubtpZo2I1VKaq3jFmKx6l6wp32WCcIdDtvsB8jqMP/vMwydNFyy
 x3s21DVrLaGvcfR6dv02/4eWWw==
X-Google-Smtp-Source: APiQypIIv+zwZlwb6Grc3eKS4MIDdsmebLnyuc5C1B6zC9TkNebcVEPal+M0GZHUwM+6nJEdc9MGGA==
X-Received: by 2002:a62:ed02:: with SMTP id u2mr19143186pfh.60.1588613131885; 
 Mon, 04 May 2020 10:25:31 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id x13sm9078061pfq.154.2020.05.04.10.25.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 10:25:31 -0700 (PDT)
Subject: Re: [PATCH 3/4] hw/i386: Add 'vmport.h' local header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200504083342.24273-1-f4bug@amsat.org>
 <20200504083342.24273-4-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ff00827f-d553-d5f1-1c9d-f135e1999bc5@linaro.org>
Date: Mon, 4 May 2020 10:25:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504083342.24273-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 1:33 AM, Philippe Mathieu-Daudé wrote:
> Move 'vmport' related declarations in a target-specific header.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/i386/vmport.h     | 34 ++++++++++++++++++++++++++++++++++
>  include/hw/i386/pc.h |  3 ---
>  hw/i386/pc.c         |  1 +
>  hw/i386/vmmouse.c    |  1 +
>  hw/i386/vmport.c     |  1 +
>  5 files changed, 37 insertions(+), 3 deletions(-)
>  create mode 100644 hw/i386/vmport.h

> +typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);

Maybe get rid of the useless parenthesis here.

Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

