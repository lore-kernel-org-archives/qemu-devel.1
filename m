Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B1BC004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 14:50:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC0BE208C0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 14:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pwm+RW3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0BE208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42109 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNITf-0002SU-IO
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 10:50:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNIST-0001hV-Hw
	for qemu-devel@nongnu.org; Sun, 05 May 2019 10:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNISS-00072V-Gd
	for qemu-devel@nongnu.org; Sun, 05 May 2019 10:49:41 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNISS-000721-7I
	for qemu-devel@nongnu.org; Sun, 05 May 2019 10:49:40 -0400
Received: by mail-pf1-x443.google.com with SMTP id l132so399772pfc.8
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 07:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=fwTGUID9CJ7HBma0SeQAmv3nHEqhS1jnmYMdnBB4GDo=;
	b=Pwm+RW3+EXSwfZa/3mGtGvTNQ+D56mavwad6owUV159ku/qiKk186OOHGoULw2gwrg
	0asi2st7QJ2vihsm+/dHzJk26NoZIA8igCb8L1AyIViB2mZ+Pjv1li1/wCW39tOj4feX
	dFWp2QTaSOFzRKEhxsLXMBwus3JOoyVSSjqJzN03Zt/x2o1WMuncHFjBv9EgFMDeAZnn
	4yD78+KLXctPRY43BH65PlPTcFWa4TmkP+LhRVT8AmzD1Bt0ULU9+MSLKNFsxlPMZ8yj
	860SbRw7uTfz9xe1/OKq3fzjh3/4LxaoA9Ip3zB6liMhDLa/eSBCn7Gm9SaN9FemgSnc
	SB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=fwTGUID9CJ7HBma0SeQAmv3nHEqhS1jnmYMdnBB4GDo=;
	b=gRGqb3Bgnz5W3l3RRa8NsHqFQdLUFQkokRHu4Y6va88wNVYcO8vkEIlNvmPCkLHwk0
	2vMFQao9CZg0cYjog0QBQGQxTgn5Hzv7QHqfTNj/7G2iQjdmdRGPa/wa4hS05sLUKSfe
	fmr0yjKDft2It6JRYcJF2dZ4D++qGdv7mQod3gAYi/zfIrlTBpramxsKUq3KzRh9zkvx
	L8MQDpNYakR7fdVJpB4u9Ag7QdqkZf22V/vKcMSbz0qr26prZ5k4j9eTsdODWFUxEd2Z
	2h3mS/HXbb2r2nMAkVSIQo+sikwtNdoYTFOJNJgHK72449melHWVeFmnflZH3deWRuAx
	72QA==
X-Gm-Message-State: APjAAAW40o1uJ9Mul/lXArhLSq/LMIM9oqvCOgIJmoWH+YrmNtR9vbaX
	DVCAY53osI5yy1uEFMAsg8T2fkupqzw=
X-Google-Smtp-Source: APXvYqypt8ZE8II7Zyp+CXIKvOPKE14CRmxeHHQFAx8lrTB/SUAXjCi6GNfgbcp0DwOlOYKXzPAxLw==
X-Received: by 2002:a63:5c5f:: with SMTP id n31mr25620229pgm.325.1557067778868;
	Sun, 05 May 2019 07:49:38 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	y17sm11581136pfb.161.2019.05.05.07.49.37
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 05 May 2019 07:49:37 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net,
	gkurz@kaod.org
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-5-mark.cave-ayland@ilande.co.uk>
	<557b6776-45ab-0c00-7e1e-45fe33705d0b@linaro.org>
	<ea616832-33ca-eeed-03f9-708394e72ecb@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6b249770-2b30-ef94-dc37-67cded8e6880@linaro.org>
Date: Sun, 5 May 2019 07:49:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ea616832-33ca-eeed-03f9-708394e72ecb@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 04/14] target/ppc: introduce
 GEN_VSX_HELPER_X3 macro to fpu_helper.c
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
Message-ID: <20190505144936.1mFgMM9cZaEe2dDg4ApS5z8URZQoaFDGCuVd3uYmCAI@z>

On 5/5/19 2:52 AM, Mark Cave-Ayland wrote:
> Right, it looks like VSX_CMP is the culprit here. Am I right in thinking that it's
> best to remove the opc parameter from GEN_VSX_HELPER_X3 above, and then have a
> separate gen and helper function for just the VSX_CMP instructions? Presumably this
> reduces of the overhead at both translation and execution time for the instructions
> that don't require it.

Yep.

I think the best fix for VSX_CMP is to return the value that is to be assigned
to cr[6], and let it assign like so:

  gen_helper_foo(cpu_crf[6], other, arguments);

(Or if the opcode bit is unset,

  TCGv_i32 ignored = tcg_temp_new_i32();
  gen_helper_foo(ignored, other arguments);
  tcg_temp_free_i32(ignored);
)

at which point these functions do not modify tcg globals, so the decl
can be improved to

  DEF_HELPER_FLAGS_2(xvcmpeqdp, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr)

To keep the assignment vs exception order, you remove the direct call to
do_float_check_status and use gen_helper_float_check_status.


r~

