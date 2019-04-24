Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72887C10F03
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 00:08:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 309A0218DA
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 00:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y19iwTft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309A0218DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33151 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ5T7-0003mw-DM
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 20:08:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ5SJ-0003Pu-Fb
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ5SI-0001IU-IS
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:08:07 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:40625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ5SI-0001Hp-Ad
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 20:08:06 -0400
Received: by mail-pg1-x532.google.com with SMTP id d31so8417864pgl.7
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 17:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=ndGQwCPP/chzUE9tD3/wdVZGVxUfX+fK6E6PsqQsiEI=;
	b=y19iwTftv4iJ1P2LlcK1Fpey9lEI/o2U7jXpCRRNAjW0UdE6cgJ1tZN9Xr/i1CaSYu
	iA6U97GLKx0RUjupkqO0JjPhsWnhV2AbEXuO53j2ZQ3xBOi+G85/S6F9Dyu2m7rHDhiW
	Br0kJ5gMSjkTK059thgT9dwnhUJVVFxbOypNY7B7Qz06HtkPANdzqHXnoRwkjMrM4lLz
	6dr2Fs/LbEmAobBzn7Wn82Yyn0tYofUxk8agLFoH6jB6Vyq9Kr5/C+OlEObe4PyMjpsx
	YJYfUkT1muHFi9cWwHkFWnV+WOa44QEmVbPcaPb47xRbCN5Txin7l0RFTXAIgA5jZvRF
	j2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ndGQwCPP/chzUE9tD3/wdVZGVxUfX+fK6E6PsqQsiEI=;
	b=H0J6VuEEoc8wY0ZrsBnAMDA3sLFu6jNYdqxkizdNsyTLYVG8tHg2IV1ZfL1wqyg57I
	PKsyW8fpOL/u17YXwMZ8XGU+H5/sVJvMHKQrYTrQkBRpMUAUaEuvv5CB8uPJrX1ALmla
	jvgtqinfqp326jU4UP6mJk89/uu3MH4xjDxOnfi6+TBnV9NivgpmBw7QPCSuh5MdoUPt
	k4NIn7+TZ9P13/nGhUuNPW2R0fh92+P4TT0pyGuXemVBOCdUCKR6fL8lf+RXoPj3PVHr
	Pxi3Mvyg13RxGgCBZNAUPf81CPxZU1LuONrbNphliu643ddBxpTAP8Fo63VJ8DKJrWQW
	N6aw==
X-Gm-Message-State: APjAAAUIMFBh4mbDVP5mgW/QH1a40ZeEn0KQVqKZ89rkGabyoBwjhM2G
	Vd/v3OLM9i8Ti4UF21gvb8iaBmrFiq0=
X-Google-Smtp-Source: APXvYqy+tz40QtsVdvovaiVD7FD/Z9W6uBvNgPmc1fU9wtA/b0p0PvRmBPZvEmKfHF1mx4gCL0x35A==
X-Received: by 2002:a63:6b08:: with SMTP id g8mr27508524pgc.211.1556064484706; 
	Tue, 23 Apr 2019 17:08:04 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	d3sm22876992pfn.113.2019.04.23.17.08.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 17:08:03 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-20-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b888f650-cf17-b249-ecb9-7a9b9c2ae258@linaro.org>
Date: Tue, 23 Apr 2019 17:08:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-20-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::532
Subject: Re: [Qemu-devel] [PATCH 19/26] target/arm: Activate M-profile
 floating point context when FPCCR.ASPEN is set
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424000801.ya6mdxGEtiG6SnTTOzyJE7QU8UQ5Wm_iuGdDUoVtYZQ@z>

On 4/16/19 5:57 AM, Peter Maydell wrote:
> The M-profile FPCCR.ASPEN bit indicates that automatic floating-point
> context preservation is enabled. Before executing any floating-point
> instruction, if FPCCR.ASPEN is set and the CONTROL FPCA/SFPA bits
> indicate that there is no active floating point context then we
> must create a new context (by initializing FPSCR and setting
> FPCA/SFPA to indicate that the context is now active). In the
> pseudocode this is handled by ExecuteFPCheck().
> 
> Implement this with a new TB flag which tracks whether we
> need to create a new FP context.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h       |  2 ++
>  target/arm/translate.h |  1 +
>  target/arm/helper.c    | 13 +++++++++++++
>  target/arm/translate.c | 29 +++++++++++++++++++++++++++++
>  4 files changed, 45 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


