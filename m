Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D881C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEE95208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UM43CJFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE95208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBusM-0004dn-0m
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54076)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jBurX-0003Or-62
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jBurW-0000a5-6l
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:29:03 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:34352)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jBurW-0000Z7-0B
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:29:02 -0400
Received: by mail-pj1-x1044.google.com with SMTP id 39so1157827pjo.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 23:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PLl0mg+avyY1qwte1qAlEfzd9XWw/nFSuM9zyjFXo9I=;
 b=UM43CJFFzWXQAmrYGAdnpRKpGPTfBhw64rpacYldcMb6EnOGY7Lu3irMCTn2tDuAbC
 eXWObEPBSdmlt1kYSlxYWm/Sacn0mViIZI2/hZ4Pf63ZU2uyVaZJtOawNEpRYSpOpkBR
 itmnDuBgK11wZAoJeG/+yhH5MqF/ZUk4rLwu2FoUeplG6LqMjTWgXmeTdXkD+bZDGMBc
 Kdk0aUSnOzClbmpnZGP71fdngVT/EDJuNrfVdvBwszurpWt0x+weVCow/4Y9CE59c7f6
 hMiFEp5L9++o1zLhPTwNJdbdC7nbGv0WjCnd+99J4X3OHKLPiqe+aI85endLTsPI05OK
 LdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PLl0mg+avyY1qwte1qAlEfzd9XWw/nFSuM9zyjFXo9I=;
 b=NsdzJQbMsU1vL8YsMzztk2yA23rGYylO4g6r/qXrlq9HgpOJWz1SZWcER/QPtjjhZe
 ModJ9nvoYs9sW6EQgOHv153KZpA0a/UM91fjgqpKSMiIJJgafzvmxX7aadovcaNocTIk
 bMgL5+pBXmtuAqWOhR+abLkFqa4etpNqL/u8mvpE0IbPDPPKivW2tMLtH7Riu9wuP80X
 X07u2aP+36Tt45/2dI2laMQycu2ba9ddCqdwO7CbyKakw/cJgKacwEBJukycwH2Q68ue
 9sTRtG21yKnEB4Mumd7PacJhs61m5PvUnKFHtYoSvcj/Tcg8cv/MWO/I/nRM2JLWu/t4
 mU+g==
X-Gm-Message-State: ANhLgQ3Fv7q+LsIIhfhi0zkhqAEJDHY7jXqbZ1y3GThaQrra4jt7S+sF
 FmRWfXB0OQvP/lovSPrDd2qsqA==
X-Google-Smtp-Source: ADFU+vtFxaXuHuaGlzCx2zVWUHqRWYYdLYVZJ4rgK2TufKNxoGftuON5rgGh5c0x4ZZ3e1uGpWnHfg==
X-Received: by 2002:a17:90a:ac05:: with SMTP id
 o5mr1890701pjq.143.1583908140959; 
 Tue, 10 Mar 2020 23:29:00 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 c201sm4336314pfc.73.2020.03.10.23.28.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2020 23:29:00 -0700 (PDT)
Subject: Re: [PATCH v4 13/18] docs/devel/qapi-code-gen.txt: Update to new rST
 backend conventions
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200309154405.13548-1-peter.maydell@linaro.org>
 <20200309154405.13548-14-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5f42b754-3ffb-bcff-f3ff-55be4f1d21f0@linaro.org>
Date: Tue, 10 Mar 2020 23:25:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309154405.13548-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
> Update the documentation of QAPI document comment syntax to match
> the new rST backend requirements. The principal changes are:
>  * whitespace is now significant, and multiline definitions
>    must have their second and subsequent lines indented to
>    match the first line
>  * general rST format markup is permitted, not just the small
>    set of markup the old texinfo generator handled. For most
>    things (notably bulleted and itemized lists) the old format
>    is the same as rST was.
>  * Specific things that might trip people up:
>    - instead of *bold* and _italic_ rST has **bold** and *italic*
>    - lists need a preceding and following blank line
>    - a lone literal '*' will need to be backslash-escaped to
>      avoid a rST syntax error
>  * the old leading '|' for example (literal text) blocks is
>    replaced by the standard rST '::' literal block.
>  * headings and subheadings must now be in a freeform
>    documentation comment of their own
>  * we support arbitrary levels of sub- and sub-sub-heading, not
>    just a main and sub-heading like the old texinfo generator
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/devel/qapi-code-gen.txt | 90 ++++++++++++++++++++++++------------
>  1 file changed, 61 insertions(+), 29 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

