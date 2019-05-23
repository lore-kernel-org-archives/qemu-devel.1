Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AF5C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5B122133D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a6KoRFq2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B122133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36877 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hToDm-0003UA-3N
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:57:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hToCU-0002h5-An
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:56:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hToCT-0001QX-GL
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:56:06 -0400
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d]:44723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hToCT-0001QA-AR
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:56:05 -0400
Received: by mail-ua1-x92d.google.com with SMTP id i48so1522651uae.11
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 06:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=ySPflMh+95t3Ap3ClRcCNrNH4njrfHgY+K3ptimjuXQ=;
	b=a6KoRFq2j21iHnHxoXR9ugX8eY/Z1ZWDbDChGC9YFh2QHTYzBYCCwFgclwL6B3GrZP
	Jm6015O8MtJK4oT70MzbsCt7a1flfxsStWk0L/pmE6kNZbQfqe99iMHgf4owfG494gco
	l1mTgf+/sxBv6ZO/6S1PZv1rLIK4i+RS6z/HFdUIGJH1x063c8bPzgXwPRvew7YdSw58
	1+WUs8uQ8uZDfpqOkimac6LbtMLsSAZTcaeGpmWxvNEWLp2C//c+hCsahPNeqSn2M7AS
	Es9t5jMb/38gtCvrceM+vY5RFzRtlA4jhVpiZOugakXDufw6rMq0oJ0mhqhBHXXMHE4R
	1Fhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ySPflMh+95t3Ap3ClRcCNrNH4njrfHgY+K3ptimjuXQ=;
	b=Tvo5ded45DbVmqWL5M9BoSmDN612lm4hagqxoawgfsSJz9cZzbXE4aQ9CjJZ5Ztdg0
	SRxnyQMkpRUjdno3TiQVqRzlZjM+0fOruswvQ5L1jJ9VuBG9EjPJQpi4C5QJr1AOiNns
	ZvzAG0WRspN2VxG/851Eu2+te75rZbYF1KBL5R6PHfKqOPEYcQQ3gTVU/44ufXLIDZY2
	GxL4g2PtBjjURMeI5dEVXo6aABQ+9zaK7og/s5NqAELuZQ+4r9qUTeC0vs6H3SCHMoB5
	SWwlBDggLRcl171NaT2rayN4ZhyVsx/ztHx0RVcc8RCe3qDg2AMcbVRG4ryWjFGKszB2
	iaew==
X-Gm-Message-State: APjAAAVBMDpwHfg8e7LzBC/tNGMTYt6Fo2DQMioXD2Wk3m3qo2EVST4n
	xhfrfcGoHjndH0BUwvvjDHWU7Q==
X-Google-Smtp-Source: APXvYqwbzd0fuYU+SWK0lU7t0yEPXJekifcBJhzjB9lVH81R78JbcsueojcShIJfrY3jAWOd4/BY+Q==
X-Received: by 2002:ab0:4a14:: with SMTP id q20mr23918872uae.67.1558619763383; 
	Thu, 23 May 2019 06:56:03 -0700 (PDT)
Received: from [192.168.43.94] (ip-173-130-215-183.orldfl.spcsdns.net.
	[173.130.215.183])
	by smtp.gmail.com with ESMTPSA id 102sm269395uar.11.2019.05.23.06.56.02
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 06:56:02 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190523081538.2291-1-armbru@redhat.com>
	<20190523081538.2291-3-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <94df1196-2d99-7e6a-afbf-ee429fd5a778@linaro.org>
Date: Thu, 23 May 2019 09:56:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523081538.2291-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::92d
Subject: Re: [Qemu-devel] [RFC v4 2/7] Makefile: Drop bogus cleaning of
 $(ALL_SUBDIRS)/qemu-options.def
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
Cc: peter.maydell@linaro.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 4:15 AM, Markus Armbruster wrote:
> When commit df2943ba3c7 moved "rm -f qemu-options.def" from distclean
> to clean, it also added "rm -f $$d/qemu-options.def" to the for d in
> $(ALL_SUBDIRS) loop.  That file doesn't exist.  Remove the mistaken
> rm.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  Makefile | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


