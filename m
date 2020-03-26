Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E0AC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AE9A20719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pPtrXhF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE9A20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHaSM-0003nP-FA
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 17:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHaQL-00020x-Dy
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:52:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHaQJ-0002eG-Hb
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:52:24 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:40292)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHaQJ-0002aM-Bj
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:52:23 -0400
Received: by mail-pl1-x641.google.com with SMTP id h11so2667717plk.7
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 14:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=yaPa7TcrYg1l8FgG17gMEiEyPUK625BISB2hlAjbjGo=;
 b=pPtrXhF+oZkCNSOvMUnKQ2aMgv2VHjHDvr7/WcAs1miRGNS4QYbFzV94I4WMJiZrM9
 bNkdOHS5CRJScz+Qgnl+gdiwVCyKqiZZ4Z/u83DMeUOIMkKju7azGbrBqGNOvZi8NEH4
 jpD6q1EbLvugmrmVfW2tmgGuuJFHguNPS8BXi58+TpeJrpGsMfJCtIxThdRngqvjLWo+
 fS3LH40ajs76m3InZYkbj7Ib+FpaZQQH3Op8wkBPVLPbE2fTqtkyU19jsHC7gosGiPUp
 /Uu/7X4xi1VBuKEXGSqNINhTIvokHyatTEJlNWzrVgVqyJJc40olNucQR5oKdIJ+Hisy
 Kchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yaPa7TcrYg1l8FgG17gMEiEyPUK625BISB2hlAjbjGo=;
 b=AbfhGbs7mEB6yXe8AdnoBJAs3ojaiUXQnzvTo3l4TrsfGEawTMWmzF8ZoCUF0tCMDF
 LdUyQCD253Ki8y53LzFqsFH4I6Ovp6+O3fkJGUxxERlLjYEQrCF9Sf22adTsKSR2vndX
 oYCvsQYJAD9xoILn4wsbMHzewvOrf9wxvuAVDBVsjabitR51nTwlL+5ehN31u+QsFg2X
 Fhk6TyOEodt2VOKrTIAFc/9hza5pTv4PbaUnw7DfsMQntw4ZSgD6/AA0R+RX5DZbjk0N
 mjRyMgduU2Myp/SqpO2DSnL3L3PnK5dgrRDKuspSai/6YKwAwOaVNnC599m5DaNKxxaJ
 o94w==
X-Gm-Message-State: ANhLgQ10BbIRIqYrz/6jzUzDb13ySixIlZVoKRGAX3Hr/drXhPn2LRKh
 Mgxk/pdCN8wMuVetfImvVZY1BUlIVQY=
X-Google-Smtp-Source: ADFU+vs3P9x21p4kJOisAibK9GJ5h0OxhUryNmZ61z6vb0PmuLPBnRhmIKm8/h+2xJjYUvUGGoUDYA==
X-Received: by 2002:a17:902:ea8a:: with SMTP id
 x10mr10408724plb.328.1585259534941; 
 Thu, 26 Mar 2020 14:52:14 -0700 (PDT)
Received: from [192.168.1.11] (174-21-138-234.tukw.qwest.net. [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id i14sm2400608pgh.47.2020.03.26.14.52.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2020 14:52:14 -0700 (PDT)
Subject: Re: [PATCH v2] hw/arm/collie: Put StrongARMState* into a
 CollieMachineState struct
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200326204919.22006-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eac3876d-c1a8-5bb9-8368-1eb602bafc64@linaro.org>
Date: Thu, 26 Mar 2020 14:52:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200326204919.22006-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/26/20 1:49 PM, Peter Maydell wrote:
> Coverity complains that the collie_init() function leaks the memory
> allocated in sa1110_init().  This is true but not significant since
> the function is called only once on machine init and the memory must
> remain in existence until QEMU exits anyway.
> 
> Still, we can avoid the technical memory leak by keeping the pointer
> to the StrongARMState inside the machine state struct.  Switch from
> the simple DEFINE_MACHINE() style to defining a subclass of
> TYPE_MACHINE which extends the MachineState struct, and keep the
> pointer there.
> 
> Fixes: CID 1421921
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v1->v2: folded in the uncommitted change that fixes the
> arm_load_kernel() first argument.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

