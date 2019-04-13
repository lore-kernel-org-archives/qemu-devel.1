Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3182C10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 05:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37B0120850
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 05:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nncm1g5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B0120850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47180 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFBbt-0000wR-9z
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 01:53:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFBb0-0000bg-QY
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 01:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFBb0-0001B5-2B
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 01:52:58 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:42239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hFBaz-0001Ag-Oi
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 01:52:58 -0400
Received: by mail-pg1-x533.google.com with SMTP id p6so6156572pgh.9
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 22:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=Ybts9MMxIEdjSQcHC7941EX/FJqvr8Or8W7Mh5fmv0Y=;
	b=nncm1g5CXxkIm7UrmXUwO1n4l0eq2id4XF9v5zrpXhuK6lFXtVFvawL7/UrDr6XOeo
	cbtFYgh8uYCZH5+SJDGhTqspP4mGpNtnE6C8WcDQ9R2pShPO0hKH+aoPeS4hJRUmiImp
	6sNfyhyTPj0YU8tiDfA4sahednZpl25tmEXnHd5ReYV3nIwa417rA92jiOMpETlTL9u8
	bRUIhLaMVjO1Iqe8fXGIlPOgtjfW3+HiWR0EceJ+9DL7D7qjy8JUPmOT6ebbSK3MSmW1
	fQ8tbE9/8TRNvqbqR5rpYIlxpsGRfoEOwoJDx0m3GsCnMcNHsoVDSXAixzjOAjQ3hjuW
	ftpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Ybts9MMxIEdjSQcHC7941EX/FJqvr8Or8W7Mh5fmv0Y=;
	b=Cct6evTHrKN3t+nugFu4hLzDkEeRN+aeaiQhf1tj7x25pUlXnjeF4zOfkIA2sdKKSX
	UU0ATTKPo7H3Hgpkkws+IqRI+TjOm23lxFe04RnDs45U6/3hVP121HAp8f75a1MCgvgI
	TAEk5ASymrEwuNPzRCR+Dipiwx6r62FfKxsWNVerk5XZXxI2r18Ga6zdFZz45h6c+OEv
	Y1FjqLUD08JJIR+OYSypNMbklo7MWYneh7tp++Rs1wEap0tlkctyH9bI+hzZaq2ZRSUM
	zpO3bxWi1n7+E+PGOjr1LzVSL65ip8ssrb9985Z5AXDcO0VBniYVUBHU5K4fh7Tk1PUY
	S28Q==
X-Gm-Message-State: APjAAAWn5BUgmaWt663hnDzw2WrqCMF0Hx+l+jdRXmOeL/NWcZ3GvQJx
	m4M9Q9EIpjLPwxV2OfAtHKF7GA==
X-Google-Smtp-Source: APXvYqzg/Iaj59++60QHS3I0rdIi5ddXwVIOge+35fRGwpqrjEcPlqLZWG7kRL6KrY7ihauOWoSCKQ==
X-Received: by 2002:a63:b48:: with SMTP id a8mr48932469pgl.368.1555134776718; 
	Fri, 12 Apr 2019 22:52:56 -0700 (PDT)
Received: from [172.20.98.58] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	v12sm57437837pfe.148.2019.04.12.22.52.54
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 22:52:56 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-37-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <99a8edde-faea-144e-63dc-fdc4826e47e5@linaro.org>
Date: Fri, 12 Apr 2019 19:52:51 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-37-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::533
Subject: Re: [Qemu-devel] [PATCH v1 36/41] s390x/tcg: Implement VECTOR
 SUBTRACT WITH BORROW INDICATION
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190413055251.9FmRq7Wv0jpLQiz-7dUqfHas8yRbYUy7y9DEAdscg3s@z>

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> Fairly easy as only 128-bit handling is required. Simply perform the
> subtraction and then subtract the borrow.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 27 +++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


