Return-Path: <SRS0=DeAR=WO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FF5C3A589
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 06:13:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE01C206C1
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 06:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JlZhK7lR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE01C206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzER5-0000C4-VW
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 02:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzEQI-00082V-7t
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 02:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzEQH-00060H-5M
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 02:12:14 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51059)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzEQG-0005zA-Sd
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 02:12:13 -0400
Received: by mail-wm1-x344.google.com with SMTP id v15so318576wml.0
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2019 23:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=h3y0DxyZCwedth1gLqUH8RWTXa+YqOagrUSupMHXTBA=;
 b=JlZhK7lRBpCxl1eyDDxpTQX7KWNeixGrOUuJSaaAnhucCUDrKM1l0167mVNhviLz+9
 ++VIZrdBEIUXrtl5y1Pu4GREJeFKv2/XsGYHxyRLmCBUA4pvdjzs19AobHLRUUcwa3ir
 I1uWPAXSQHqawRDwtvYprOVbErIGLNqOJSONsthI0XBcV43NtXEDF9qJUGjI/oXjwMvm
 P19wI1gJOvwKWCpKPNx8QX1G6wna6U4dvtWkxyEFXE2aqPcaWjF6/bg/lsaO+y9IaFV5
 cN0gCY5Q26qxZdzzLietm932wKr6FIku81r++fwnIkWc/UHigVZnLyaeRY2QO1OdEY3w
 f79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h3y0DxyZCwedth1gLqUH8RWTXa+YqOagrUSupMHXTBA=;
 b=a5Pjlkh2749qkDqEa1AoEmupH1fwNAYbYPTZp/8jHDacmAPFD3FgO2WnawWGkRhXTm
 BTrxgCYkfjeWp2rLnmV2u0tejUaePVm4UPwT2hv3JTKXz+PrvO/5E+SfDgJlBLZ9pPXB
 9yf86cN9O3PiRHKW/jYgK5+z5AZM1BojEDtQzrCp4NsT0qm+0hDFcJ5sxuRzrhLb2qGe
 iw+WLZWjpu6jihEKxD/rJ60FmN8vev/+wvpI5s7UvuwgqQoCb2FOWGl8gw3W2kx1YTSL
 Enm2uPd20wlfgzBg48ieULVNGgiMOeN1DNNn0eJYM8hIHw9Jhy+gDqtMhehja4J4tI1x
 h7mg==
X-Gm-Message-State: APjAAAXRF58huDXO/tDTio4EXRowZgvClYqTjysVs1gxXcXB91vyzKSV
 Pj75M/OCxVuJtjvqdYnSBpJutMkFtRU=
X-Google-Smtp-Source: APXvYqy8RCEHLcTIid/jCcnygPsYzhgOiPcNeUECjdg8ZeDTgukyWKwHRSB9SiDj83pIHxtgUc3rzQ==
X-Received: by 2002:a1c:2015:: with SMTP id g21mr13755308wmg.33.1566108730558; 
 Sat, 17 Aug 2019 23:12:10 -0700 (PDT)
Received: from ?IPv6:2a02:c7f:a69:1700:8897:9507:94c2:b98d?
 ([2a02:c7f:a69:1700:8897:9507:94c2:b98d])
 by smtp.gmail.com with ESMTPSA id 6sm8915257wmf.23.2019.08.17.23.12.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 17 Aug 2019 23:12:09 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190816125802.25877-1-peter.maydell@linaro.org>
 <20190816125802.25877-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <750250d4-e4a0-43de-add5-24488b87cfea@linaro.org>
Date: Sun, 18 Aug 2019 07:12:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816125802.25877-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 1/2] target/arm: Allow ARMCPRegInfo
 read/write functions to throw exceptions
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

On 8/16/19 1:58 PM, Peter Maydell wrote:
> @@ -1729,6 +1729,12 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
>          tcg_temp_free_ptr(tmpptr);
>          tcg_temp_free_i32(tcg_syn);
>          tcg_temp_free_i32(tcg_isread);
> +    } else if (ri->type & ARM_CP_RAISES_EXC) {
> +        /*
> +         * The readfn or writefn might raise an exception;
> +         * synchronize the CPU state in case it does.
> +         */
> +        gen_a64_set_pc_im(s->pc - 4);

This will now need an update for master, but otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

