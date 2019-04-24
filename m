Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7432DC10F03
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 01:28:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35234218DA
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 01:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sVvYziBO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35234218DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33901 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ6iM-0003j1-FE
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 21:28:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ6h4-0002zp-IA
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 21:27:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ6h3-00079e-Jg
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 21:27:26 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ6h1-00077B-Kw
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 21:27:25 -0400
Received: by mail-pf1-x443.google.com with SMTP id 8so8403729pfr.4
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 18:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=NBLEvRIjRGhMKAVexH9SVdSYnNnSzp3ixEGv6UvlgBo=;
	b=sVvYziBOPKz5Axa5XEkWdQtjlSwadGKxnows590qfsGX3MIcVJgpjEv1Qx+v8lz8S7
	MtdZyqGZ/byQHynn5a+u6QmzE2kfQXPPf4UMFVPG6nwXSWtpl7ZDSfZLH1myNKc3ycje
	gxoUsXHu9X8EFCyxGnzroGckU0YT5oyNC5hxZRqGX21gfG6xCMo/VbxjKlkyKhJn71jb
	8Zch/EMmyEL0pO0ZnPe/1jzmCRqIukXtXB+o4pP9egInRn1C/r3cFd5O/OU9hAEMbEOb
	b0bgfh+TbPqmxJumpYznPRmVmTxTU0oFuOb3yqwizjW6qt7erDyKurvXWB5sfyU1So74
	GsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=NBLEvRIjRGhMKAVexH9SVdSYnNnSzp3ixEGv6UvlgBo=;
	b=tl2FApcJk8EaiJ7IM5tO2+nOt5zt2wRwmqu/+cS4VjdLYzj+dbumuky6cfu5HQQhxi
	aW8bVl3Sat1wRopvUfPCDiqGrTio4Nl3jjksYHjcRRwQl+WsWk/Sir3OjE5/bciaGbdM
	bZI5y80l1OXwTpS1tLCipeYCpdJ50uGOiB6JRyrCo+hycrhVUuqIs4HHksPiW6IhdhXD
	+ck5IKJV54IrETq7MMs62QYDhcNnEoSdddEG6FTSEZ9LZfX2Xkkm5YgZrEXMWTPXn+Ai
	MMSVJMs5qa4mKB9GWoAwR0BfMy7L5p6s+OivUh9xAGU6KLeKGsciVd9Ytwj+lemv8C/H
	MkjA==
X-Gm-Message-State: APjAAAUG0tsljKg4OSp8cug/p1GgtX1o5SvmQvg5F+WextIS+42Bl8e1
	lxIlVxbYY8p8NR5Zj/dBs2Cz7vOxXYU=
X-Google-Smtp-Source: APXvYqwUEtm5YGN2o/w8XY4gpt+6w61PoghYabrZ6Eu0DTWT60A33zmcmbEymU4n5Zshv44BEgV4iw==
X-Received: by 2002:a63:e304:: with SMTP id f4mr27788981pgh.374.1556069240792; 
	Tue, 23 Apr 2019 18:27:20 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id r5sm1545142pgv.52.2019.04.23.18.27.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 18:27:20 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-23-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <59198f7b-231e-939a-6bf4-77649513f881@linaro.org>
Date: Tue, 23 Apr 2019 18:27:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-23-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 22/26] target/arm: Add lazy-FP-stacking
 support to v7m_stack_write()
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
Message-ID: <20190424012717.U3zQAePXBmZ4HQQt_qj9bvVP2Hp-QTfoFUqnz69muM4@z>

On 4/16/19 5:57 AM, Peter Maydell wrote:
> Pushing registers to the stack for v7M needs to handle three cases:
>  * the "normal" case where we pend exceptions
>  * an "ignore faults" case where we set FSR bits but
>    do not pend exceptions (this is used when we are
>    handling some kinds of derived exception on exception entry)
>  * a "lazy FP stacking" case, where different FSR bits
>    are set and the exception is pended differently
> 
> Implement this by changing the existing flag argument that
> tells us whether to ignore faults or not into an enum that
> specifies which of the 3 modes we should handle.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 118 +++++++++++++++++++++++++++++---------------
>  1 file changed, 79 insertions(+), 39 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


