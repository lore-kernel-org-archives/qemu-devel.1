Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D13C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 02:30:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D63E214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 02:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LuxnKsYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D63E214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifEF7-00074V-7E
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 21:30:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifEEE-0006Vr-4j
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 21:29:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifEEC-0000eZ-C6
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 21:29:21 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39645)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifEEB-0000Ya-9I
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 21:29:19 -0500
Received: by mail-pl1-x641.google.com with SMTP id o9so365738plk.6
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 18:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dnSs02hUKWgYOXF+wicFs/wEm5XHaRR03CSW1fVdNiY=;
 b=LuxnKsYV2P5jw3pWhC4NqH4SbsEWMDd423hp+nxFYkWo4Nej8Twbhm5a8L3IU+Y/ux
 0dZCuIl7GmeLYBWt/NHe8hjC2YYt/ibogZfwz8+QSxVSuTj92NAfX62Et4lHAax/v1oN
 wrWO72GBJmzc1ZuQ/iT67LVSCE8gY82aDeqG9/UH0J3sdwjYusRmt8fZ1C6AqVeklo3c
 obxAx7E/vwtsmizQc7PitJDbDkJgjpQ6UDhUvC+z+eFSQ9NJPzE/GPVfJ3XjxlLuJMKR
 Tzdw7EO8DVtVCMp6pwkhI7qMDypNEZnqPCCt/0x+IJIO2szSvqQE8XtjlSZy1ZxxCJk1
 zddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dnSs02hUKWgYOXF+wicFs/wEm5XHaRR03CSW1fVdNiY=;
 b=kFJqx/4PzZI7BzeYGZSyqVI8oJJZJEBbiFeCmNod5Gjb3HfSc+Lew//QAeieMrUP6M
 g8Ef5d5aaBVn/dvbIxx6ke1Tb+BOIkeXk0F3EtP5v3uDVNktgp53Fee0yzsWP1M1VQ0t
 /Z25c4VURNHZGvBP8cFaW4yeN+679u1h+AJvFhMSVoMswMjIAhef4l/SPOu7I2pWz0i1
 Rcyt+UkHEXSBkIe0FDi2WxTpvaPxttBsKvchyb6rCrGr1HpO49rK3lZCCXD5x/zg7F6t
 mUYypRJimRmIXNflrMxxWX0ftfavJ0j9sG26jjn/aJLbzRM3Se3px7UZi7g3AXXKKY4V
 qrNA==
X-Gm-Message-State: APjAAAXWhS7/Zxqp2VgpXtgx/r38WF/X8f/BFgv5XeADyzLkODEJvCWN
 Cg4Th4lr+imGxO9HYBvMCTyKVw==
X-Google-Smtp-Source: APXvYqwujqZ69gHWsNo4ORP98IGcjIhEFx7KOpNlkYeIETtq2doROUzqX2vhdew6XoMaU9NXa1BjoA==
X-Received: by 2002:a17:902:ac97:: with SMTP id
 h23mr7050556plr.237.1576117751180; 
 Wed, 11 Dec 2019 18:29:11 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z14sm2677828pfg.57.2019.12.11.18.29.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2019 18:29:10 -0800 (PST)
Subject: Re: [PATCH v3 14/20] target/arm: don't bother with id_aa64pfr0_read
 for USER_ONLY
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191211170520.7747-1-alex.bennee@linaro.org>
 <20191211170520.7747-15-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c6de7384-0e22-c03c-1a02-ad288d3f7eec@linaro.org>
Date: Wed, 11 Dec 2019 18:29:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191211170520.7747-15-alex.bennee@linaro.org>
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, luis.machado@linaro.org,
 alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/11/19 9:05 AM, Alex Bennée wrote:
> For system emulation we need to check the state of the GIC before we
> report the value. However this isn't relevant to exporting of the
> value to linux-user and indeed breaks the exported value as set by
> modify_arm_cp_regs.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - extend the ifdef and make type CONST with no accessfn
> ---
>  target/arm/helper.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

