Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F713C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3966F214F1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RF5YO91S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3966F214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAwY1-000416-Fw
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 10:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAwXH-0003K3-EB
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:36:23 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:33988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAwXF-00065i-PV
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:36:23 -0400
Received: by mail-pj1-x1043.google.com with SMTP id n3so1174921pjq.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 07:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Eh6+GpmDE6hk0DKyJiE8fSA2HIvq5qm0rc1hmOz/q9U=;
 b=RF5YO91SFwA9oS7nYuU14nj+DD22bBGIo41L6gQaelBK6YaKXoSYiJgE+clm6oOD+C
 dfyHlFfg6oUoDZZFEqPXeHMU/SJ71ClhUI+yR+BsttSolUYuO5PhplRzD7CwEPVkvGTB
 TUSTt0XHgNTbR9MaJXTnhPGKLEopIv/jzXml22zna0o1tXshHVtkywRdNC8eYFTnZPrQ
 q1vKUaZAFxcmQVx7+PQT7SfJdscvlJa5OO9ogWuACTruzxknBdpKbYNrK43Ucn7FZ733
 DCLhjHsuBrYsw+o4v6+juT4jot4n+MTwEsHrzaJGp+MxkzD2lswZPwXgc8D1rAPXZ/Et
 tOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Eh6+GpmDE6hk0DKyJiE8fSA2HIvq5qm0rc1hmOz/q9U=;
 b=StxuOo6c/4i26/0iKZMdA3ait9Dg6CbsP7gpAwKEPLGsJzUKupq9lN3u75Nb3kktL4
 qUPop//BvXucGnS2eTM2mgi25+mFmXC2j1w7g0lXnl2hRnFJ29aXy6Gd4zCZorUQiqwB
 CgMaSjGfS5RO+4aivgiM9Ger6Et7M0sttcWcgZHUIyCSI/GSsUxyC37vzaGxRIr+880e
 EQMjm5g/QHFVxM/DTGa6yTnNPBepfQrtH2RHHL+Wero+0Chh9xrXcdTVzvlcIdnqe3ZB
 tGVxug6uoLbl/PrJybGdSud4bfA+Ea3TQSZyJws1ARgM7UV6fH0HF6ub//WJR39TTVHw
 HZCQ==
X-Gm-Message-State: AOAM531UXHc+BNRG20cEIvZ3ncoBkEjb8tbaNE7eB4O/iss+6IaP8RrW
 CPxl5QCNxrfK7EqI72th8keSgw==
X-Google-Smtp-Source: ABdhPJzoAmIDqhg9wmcP4KpYaaPg3oqmR+VO8eKxu4E/PpjT14OwCXKt1Vqlp2CjjRoaL4S52S9t7g==
X-Received: by 2002:a17:902:b20d:: with SMTP id
 t13mr12182252plr.312.1598452580269; 
 Wed, 26 Aug 2020 07:36:20 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id u8sm2478900pju.5.2020.08.26.07.36.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2020 07:36:19 -0700 (PDT)
Subject: Re: [RFC PATCH v3 13/34] Hexagon (target/hexagon) register map
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-14-git-send-email-tsimpson@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a890bdc1-97ae-c9b4-8886-e51c3af138a9@linaro.org>
Date: Wed, 26 Aug 2020 07:36:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597765847-16637-14-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.239,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: ale@rev.ng, riku.voipio@iki.fi, philmd@redhat.com, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/18/20 8:50 AM, Taylor Simpson wrote:
> +#ifndef HEXAGON_REGMAP_H
> +#define HEXAGON_REGMAP_H
> +
> +        /* Name   Num Table */
> +DEF_REGMAP(R_16,  16, 0, 1, 2, 3, 4, 5, 6, 7, 16, 17, 18, 19, 20, 21, 22, 23)
> +DEF_REGMAP(R__8,  8,  0, 2, 4, 6, 16, 18, 20, 22)
> +DEF_REGMAP(R__4,  4,  0, 2, 4, 6)
> +DEF_REGMAP(R_4,   4,  0, 1, 2, 3)
> +DEF_REGMAP(R_8S,  8,  0, 1, 2, 3, 16, 17, 18, 19)
> +DEF_REGMAP(R_8,   8,  0, 1, 2, 3, 4, 5, 6, 7)
> +DEF_REGMAP(V__8,  8,  0, 4, 8, 12, 16, 20, 24, 28)
> +DEF_REGMAP(V__16, 16, 0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30)

Given that DEF_REGMAP itself is defined in decode.c, and not even in another
header file, why do these not live in decode.c as well?


r~

