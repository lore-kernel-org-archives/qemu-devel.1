Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12859C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:16:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2DF820863
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m6n5Rr3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2DF820863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37224 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hToWS-0004Hn-2s
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:16:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hToQc-0006VT-JV
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hToQa-0004LX-GS
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:10:42 -0400
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44]:39241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hToQY-0004K1-PX
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:10:38 -0400
Received: by mail-vs1-xe44.google.com with SMTP id m1so3660585vsr.6
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 07:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=KWjK6hLY8B/BGfRs1gjmpk6wOISaGDkUCaxppGFOLBw=;
	b=m6n5Rr3ReFxYQenxU2oHGcyP6gSNkYR3JOFzW3qPLjttQgt0qOI+hWRs9VwH90dS8G
	Xrebqrv66uWyY6MnnSCC6cnc9fqtyKo3jpXxhjDdkGu1aMiZGNr/2TjBvBuhBecOnqDI
	KyDaSAX8Ks8iAC+DJtH7091cx7CgV0i1myTz99wr1HXAtCd4cETh6m6FnSxoTD7uHHsw
	IJilxF5uSMYcf8Vb78XrUOg8J+XCl/ONoDyFgrLVfxmVvhNaAfmImAt2c3mlXsjJewCw
	qzYgiMou5C46UWyx+CCoamaBC1j/+wLiFLfAze7JdsJ1R2jYNuanQf9MqZp2E/oc7Ctp
	Qdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=KWjK6hLY8B/BGfRs1gjmpk6wOISaGDkUCaxppGFOLBw=;
	b=mPtTJEWGZpQTwT1flX+3s26Vd9m5dIFtl9H2z34eW3xO34Ed49NMVw5FdYNkRJr58I
	zlc1sMDpKdsDR9y+UAJESCa4rbhbwmWJvMonV8SuBckLx28N5BPPsTAZovnQS32RKh4Y
	IR6a+ytqMcZuo97FNiSrZQ9lZokQ3c08bN54LrMDuVOOZG1pGrYCH5Lt9Zk42Z6Q/DNT
	o0zaJTKdeMgqIOCwDk26UA+jCdkUWLaWbZ4tEbWuHESp71QpKzrrTCLiTzgRzt8oOxn+
	Kp4zh5yy2vlXTVDCcTUzVOIEF2rTA/Vcif8pllKTaY0oeezjlxjVK9Li5V7fhjL6WTN7
	yRpw==
X-Gm-Message-State: APjAAAWzm1hJs20iVf0uK1A/xqo1+gkD+9HjT4NHqGZXrXN4XwYu0vcE
	MdyRzhxEPXKMremzjyFBZK/now==
X-Google-Smtp-Source: APXvYqwu78+ZB4trH2L9AtHfmLVP00705ZsKjkEU4/fBFyTJPvCmqXgv507ynlTt+XcLiWuznkrFoQ==
X-Received: by 2002:a67:e04e:: with SMTP id n14mr1692160vsl.182.1558620637687; 
	Thu, 23 May 2019 07:10:37 -0700 (PDT)
Received: from [192.168.43.94] (ip-173-130-215-183.orldfl.spcsdns.net.
	[173.130.215.183]) by smtp.gmail.com with ESMTPSA id
	d79sm6174643vkd.23.2019.05.23.07.10.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 07:10:36 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190523081538.2291-1-armbru@redhat.com>
	<20190523081538.2291-4-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <3563da82-bc4f-f64d-74f6-d9ee32a95242@linaro.org>
Date: Thu, 23 May 2019 10:10:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523081538.2291-4-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::e44
Subject: Re: [Qemu-devel] [RFC v4 3/7] Makefile: Rename targets for make
 recursion
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
> We make a few sub-directories recursively, in particular
> $(TARGET_DIRS).
> 
> For goal "all", we do it the nice way: "all" has a prerequisite
> subdir-T for each T in $(TARGET_DIRS), and T's recipe runs make
> recursively.  Behaves nicely with -j and -k.
> 
> For other goals such as "clean" and "install", the recipe runs make
> recursively in a for loop.  Ignores -j and -k.
> 
> The next commit will fix that for "clean" and "install".  This commit
> prepares the ground by renaming the targets we use for "all" to
> include the goal for the sub-make.  This will permit reusing them for
> goals other than "all".
> 
> Targets subdir-T for T in $(TARGET_DIRS) run "make all" in T.  Rename
> to T/all, and declare phony.
> 
> Targets romsubdir-R for R in $(ROMS) run "make" in pc-bios/R.  Default
> goal is "all" for all R.  Rename to pc-bios/R/all, and declare phony.
> 
> The remainder are renamed just for consistency.
> 
> Target subdir-dtc runs "make libbft/libfdt.a" in dtc.  Rename to
> dtc/all, and declare phony.
> 
> Target subdir-capstone runs make $(BUILD_DIR)/capstone/$(LIBCAPSTONE)
> in $(SRC_PATH)/capstone.  Rename to capstone/all, and declare phony.
> 
> Target subdir-slirp runs "make" in $(SRC_PATH)/slirp.  Default goal is
> all, which builds $(BUILD_DIR)/libslirp.a.  Rename to slirp/all, and
> declare phony.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  Makefile               | 30 ++++++++++++++++++------------
>  configure              |  6 +++---
>  tests/Makefile.include |  3 ++-
>  3 files changed, 23 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


