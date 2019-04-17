Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5964BC10F12
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 04:54:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 187CD204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 04:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iC1ViTat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187CD204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46893 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGcaV-0000jr-Ey
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 00:54:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGcZg-0000R9-6x
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGcZe-0000ec-TQ
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:53:32 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGcZe-0000dq-II
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:53:30 -0400
Received: by mail-pg1-x542.google.com with SMTP id y3so11392357pgk.12
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 21:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=l+s8vcx5nW1fJoSfCxZSoQgqH90aLxAP24QUgeias8Q=;
	b=iC1ViTat4da8DDi0b/GP+/DNciw4gjvVhbXtRlnIR5S8/swYw8LD/tNPG65RxtUPRH
	CPQ5MWKTHF2S6poo6qHCiLXHwowiUOUjFa+6xgisgA3dP6+aBWsO6xPBQ2UODmz/gM8N
	yGmn9F+Hjf/EXgRz0phWXVSyQJRT5fjuX7iWcyfphkK4t3qyTQY09Qkyf9uxGOyIYRC0
	x/1OD8sOEckME74VbpsUVPPp9xJXVDSfjDbYgBS6ijV37tBevkMFzqKV+g0MvVPREExP
	YpAbXaNozeRFTqCwhBSsCjOMp/twZ+GAArXAzqjXJjB7LHApctUsX8wDAqjGmr+PwA52
	FI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=l+s8vcx5nW1fJoSfCxZSoQgqH90aLxAP24QUgeias8Q=;
	b=f3BzMoebQL9chQbubJ2yt3ITISIOgLbAHvF3czYnLO1SwKkh/itr0JyEcu8Kaw3lEQ
	VBrDnTnhynaPwaUii1YLf/BrrYMbTHGqe065l8MbiNS+vJ/jfRgii7n3oZN0jFZaVs5/
	abfjBIi3dXI+k3/l/qf9kGl75tcfKGFykx6NUgIZB8GZMVGGVP8UbsbVA1yCpT1KF7m2
	9xeRp58Tjpmpl3WUj/NWB/RCTwIMf/CY9Cc3Y6joookPFtewpY46aUNMiaJjLUeaqRQY
	CmrA812njP8JBXGd6/Ff3ZjeFncZr+Iqkm4+CAhtJ6a1jpskUp8gwvQ4Cv0Tp9oKHMVe
	QIEw==
X-Gm-Message-State: APjAAAXGOmDGoJaTpYYw2ewJax0fLaaqGf9htnglvEa/xkz80zTK1iio
	ur0Fw12u6bOuHXOiYc9Wy/5GJQ==
X-Google-Smtp-Source: APXvYqypYMi73CzyZe+uZnneaSwR/PjZs36gPHPPU1X/OSxXo5qhPCYY0DaYOo6882XbBniKWMmtwQ==
X-Received: by 2002:a62:b40b:: with SMTP id h11mr87604604pfn.133.1555476809313;
	Tue, 16 Apr 2019 21:53:29 -0700 (PDT)
Received: from [172.20.101.138] (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155])
	by smtp.gmail.com with ESMTPSA id o14sm605074pgn.4.2019.04.16.21.53.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 21:53:28 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190416185301.25344-1-david@redhat.com>
	<20190416185301.25344-32-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b80951bd-114b-1afe-10ff-f994e3f1b26a@linaro.org>
Date: Tue, 16 Apr 2019 18:53:24 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416185301.25344-32-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v2 31/41] s390x/tcg: Implement VECTOR SHIFT
 LEFT DOUBLE BY BYTE
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
Message-ID: <20190417045324.KbO8UExfdhHlyawuHJbrs2q4L3DLHDEw5WIqJX4FGZU@z>

On 4/16/19 8:52 AM, David Hildenbrand wrote:
> Inline expansion courtesy of Richard H.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 29 +++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


