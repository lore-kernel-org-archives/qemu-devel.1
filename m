Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11F3C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:47:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BD4E21775
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UrSSNwLT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD4E21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izfdH-0004IG-N2
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:47:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izfcd-0003th-9y
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:47:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izfcc-0000GQ-8k
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:47:03 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33583)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izfcc-0000BR-0l
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:47:02 -0500
Received: by mail-wr1-x441.google.com with SMTP id u6so6819461wrt.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 03:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KluV9aMC2r9JPyw11K9tEv8QW6KLH5/FJiOi7TF/d8I=;
 b=UrSSNwLT0FNqpSuUUVYi7bHNyERjHiEQ+ZXmWDz5E9b2HO1TC0TatqNWcZ8Ekzar+H
 lt9ScnWcA9xoUL66P8WPA138HI9DRfJUnsc5FLot4Etbkw5xMMsGaffaSfyJAGqgWTe7
 wUzzFIRVKV0g3YeLOV8HS9gTgtoP5wtX5YHnCzsmZaftJd++9+Y2kKjPa9pbl/1L4Eqh
 lry7L+bUyihTcGrE85krcZD4YKJs6oL/gIpoqiuXkFVXdgKFQmf0m1wKAQ5Go5N4HtJM
 VfiPdKjCOdCigVoHfFydJJ39WyV+52lLq7fl01k/RuZO52kiBXobBrKn2wQ1sfhuepOd
 JWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KluV9aMC2r9JPyw11K9tEv8QW6KLH5/FJiOi7TF/d8I=;
 b=MxlSZLMvO7WSuGRaisNePg3XOf5WpJrm323QGbs8IqNzqYtM1WyUWJWgyQ9KT+E37a
 tgYdhSx1IZ45xUytWDCLaAIydSnfkoC7gfTcPkwrnxlXPQ0t7ql5ibZ/XhZ847v568M2
 U9lw0KeTC76J7nTocffOYcLvgkF1pqvuSuZjObwXQCDwoOlOPx7903W/v4FI8DtPu1nS
 HQRYas4vC6ZJcLojNda3vRgEN+iUkFAYvz0OQ5rPV2px6aMZTwM2gj2Dp/cx5kfUYS4Z
 lgOkVdIVgzhkuBbHpGr69EKtPyhwVO7yAB33dYa4detrhGXj1HQt2rXMxbo4SpQqoRiT
 e2Gw==
X-Gm-Message-State: APjAAAU1tosneZ5HFP1EEzfWFiS+9qbMSI9EKiSigZY993XTy1QQ8n1k
 exMTtMieNXW5QnFUZpF5icCqDw==
X-Google-Smtp-Source: APXvYqxDm93seyn843SH3TE1WtR9cmYoqTdZZCi9fUDnk5qYwkH0PpMPB0ELI0noozKzyjvYOul32A==
X-Received: by 2002:adf:cd92:: with SMTP id q18mr3352789wrj.261.1580989620893; 
 Thu, 06 Feb 2020 03:47:00 -0800 (PST)
Received: from [10.43.13.93] ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id b67sm3481615wmc.38.2020.02.06.03.47.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 03:47:00 -0800 (PST)
Subject: Re: [PATCH v1 05/13] util/mmap-alloc: Factor out calculation of
 pagesize to mmap_pagesize()
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200203183125.164879-1-david@redhat.com>
 <20200203183125.164879-6-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <feb1515f-badf-aea6-24c6-abb0e996f0c4@linaro.org>
Date: Thu, 6 Feb 2020 11:46:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203183125.164879-6-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Greg Kurz <groug@kaod.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/3/20 6:31 PM, David Hildenbrand wrote:
> Factor it out and add a comment.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> Cc: Greg Kurz <groug@kaod.org>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  util/mmap-alloc.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


