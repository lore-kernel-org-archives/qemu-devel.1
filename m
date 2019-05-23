Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA47C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 19:28:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DD0F217D9
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 19:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CySjN19v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD0F217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42286 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTtOS-0000X8-RF
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 15:28:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTtNV-00005h-FJ
	for qemu-devel@nongnu.org; Thu, 23 May 2019 15:27:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTtNU-0002Bn-KQ
	for qemu-devel@nongnu.org; Thu, 23 May 2019 15:27:49 -0400
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41]:32980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTtNU-0002BL-F8
	for qemu-devel@nongnu.org; Thu, 23 May 2019 15:27:48 -0400
Received: by mail-vs1-xe41.google.com with SMTP id y6so4308255vsb.0
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 12:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:from:to:cc:references:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=j32XvWBGGBxi+OyGzPqO4XTBy7g/mRGmFxDqnLTqmi8=;
	b=CySjN19vmJWYVMF6UczTKubybflG6OlH0XofBAB+RESpZX4KDrF5xM0rrh/YYnSlVF
	OG3LIqYSDd56/fhdXjofImLHiZ7vofrhjmo8V+OV5l9ZEBPXy9zk4naOhUe6LEzGh4o/
	81Cqujv7fYo3Mz6bL5+QftJYgQQm6P3bfJg4UF7YIFx8DgtTMk4tEYgkxYq1dD8cpg15
	I0gZ+jgrOOYfdP9Yypg5OLFrEKiAZHy1p2vwdOunv9m8XhDqo/+WJi6EN+BipUskTbg9
	35YaHOc/Jwz2LRUsl0vz2IgyYVuFiXQR0y0ZS2ZFpGOOnAWAp5CBFrCdaD3vsfFtsxt0
	8vuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=j32XvWBGGBxi+OyGzPqO4XTBy7g/mRGmFxDqnLTqmi8=;
	b=U0IZ6B+jgbxOydR28owSUXzmdJ9izlfF4/7AFQhmEpSd67piybVyIcj4LUQ2Hg1l6p
	Q3JOnpeuZdL6YJSi42rAGETge3DpEV1rum8n3a0U3/JucouJDzQF4WnWJvEe8StIw+HC
	sg0ChH8aSKRIBeF0XStG/qyKUc/b1GgVOAm2CnNVsFxcAg8ddWTajh7XsZWdZCvRi+2S
	pJqpUWLhx/Zf8yxsW5VYtuy7JPtCpZfMEO3xvQQxWTyzQcIokfMhIDPdQHm3QnUZVi7O
	TXn/5sv9ha5jHA/PibvGaOf3qIc18W6GBan6C9OTTS5CBBSEJjwhcygAi/Qd0ljLxsiG
	2ZuQ==
X-Gm-Message-State: APjAAAVFv0fOzOU4ToQbp2C6t4y2rTNArt2T9JVw44zNYeE3vvXBoXuT
	dfXi7fHqOPi4fB5PV9FFoM/B/g==
X-Google-Smtp-Source: APXvYqyNdUL90eUaMADyPoz9+gSdLYDpA8//EWfSw8FcZ4wCdzMVEF0H72yPrzRvfN01wP5lStaX5A==
X-Received: by 2002:a67:6881:: with SMTP id
	d123mr17205944vsc.100.1558639667076; 
	Thu, 23 May 2019 12:27:47 -0700 (PDT)
Received: from [192.168.43.94] (ip-173-130-172-85.orldfl.spcsdns.net.
	[173.130.172.85])
	by smtp.gmail.com with ESMTPSA id d6sm37453vsq.1.2019.05.23.12.27.45
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 12:27:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20190523024229.1158-1-richard.henderson@linaro.org>
	<20190523024229.1158-4-richard.henderson@linaro.org>
	<1c073eb0-b7d0-f5dd-ed16-5d59e7531fe1@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <45a2f1c6-639e-3a25-1a09-9bc5c973527f@linaro.org>
Date: Thu, 23 May 2019 15:27:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1c073eb0-b7d0-f5dd-ed16-5d59e7531fe1@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::e41
Subject: Re: [Qemu-devel] [PATCH 3/3] capstone: Enable disassembly for s390x
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
Cc: alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 3:26 PM, Richard Henderson wrote:
> On 5/22/19 10:42 PM, Richard Henderson wrote:
>> Enable s390x, aka SYSZ, in the git submodule build.
>> Set the capstone parameters for both s390x host and guest.
>> Install a skipdata hook to keep capstone in sync with the
>> instruction stream for unknown opcodes.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  Makefile           |  1 +
>>  disas.c            | 40 ++++++++++++++++++++++++++++++++++++++++
>>  target/s390x/cpu.c |  4 ++++
>>  3 files changed, 45 insertions(+)
> 
> I'm going to put this patch on hold for now, as I'm trying to get this fixed
> upstream.  If that fails, I'll re-introduce it here.

Bah.  What I meant is the skipdata hook portion of the patch.  I'll split out
the bare "enable s390" portion for v2.


r~

