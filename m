Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCA3C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:25:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2931120862
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kQb8qi2f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2931120862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36201 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTnj5-00044y-90
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:25:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTnPp-0003HA-FY
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTnPn-0000pG-FP
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:05:49 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:39166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTnPl-0000Zx-IN
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:05:46 -0400
Received: by mail-yw1-xc41.google.com with SMTP id w21so2228093ywd.6
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 06:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=4hlWBSJm8/YnWP1+dZEH1htQbYquoD3x45ip40KalsY=;
	b=kQb8qi2fe+l/dO5fcsxxkmXraxp7+AJkVvZbDAzdScAN3GdAmfXppbmKZDRQQ7LKfM
	g7EM5bC6eLUs2MoOhw+ZQ8Xoz5/MoqcRa19mELj+ZwvNc7XPkJRW+rvtp4Z8hvM3XtP+
	DqYiUu2kKjad42nWASp7l/3RC3ODxuTqBVnCVy5w0k1Sq5uDHDl2YSV587dg/9tdu9a1
	P4paF4exR+HL8sGGEitw6DqX4S8jM6WAMNCQQhtcm1BxO1NCjR8MaaFHUeSCS8sYYOEI
	PkorltBOwL17xL1iP+kPxrBYLUzhhdN0+1AFImgQtrMMTctPnKaFpsjAYG2PYeM41R72
	xAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=4hlWBSJm8/YnWP1+dZEH1htQbYquoD3x45ip40KalsY=;
	b=luXN+PNpFZ+Uc1Cm9yJGITDtSOdA5O0YXvd8T6BGpUNhW79YyM0kgsvgtW8ETrRpc5
	JBvKVSN2t4mQvBCzsVC1rnup8WIZdxIDD/r6WFCUdqu7UtdCaiuKMdU3doT33cWteKyz
	avhxQFkUSk111abS/BhjDJpzJ7hud0HGz74Gk2ZEuo1rlRMBgIB0xlpWjF5DYi90W9PU
	HUq4b6dyyj0hfgadzAGEGF8kA+jy8m1/gPXkjY3JSBxCcayu3uaMTps7eI1Ps5kNukru
	Pj4b51n9oXiE+/BNCpfvnTGT8A1BLcKDfRTblCnqD0diCh1hBMrI4sRBDS4OFej2647b
	W5Lg==
X-Gm-Message-State: APjAAAW/ogVLRk74EoSf9XEUnfz7mb+s+M4s3eFFM/exSQs0RxBqNsXt
	aTKe/DvjhQMwhJnw2pGF52fTIei42pw=
X-Google-Smtp-Source: APXvYqw42EHK+VAEzJXgCLmDIxcVSxR6KFXq3Rl61P4xlcU51igIbKXCZsMyVpwHn5gZDLMMUD+Bmg==
X-Received: by 2002:a81:1bcc:: with SMTP id
	b195mr43461581ywb.492.1558616719922; 
	Thu, 23 May 2019 06:05:19 -0700 (PDT)
Received: from [10.240.8.143] ([71.46.56.63]) by smtp.gmail.com with ESMTPSA id
	v128sm7012499ywd.24.2019.05.23.06.05.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 06:05:19 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190523024229.1158-1-richard.henderson@linaro.org>
	<20190523024229.1158-2-richard.henderson@linaro.org>
	<20190523110736.GD20973@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <8a9b53d9-0bcc-06c0-4eac-894b4d1208c3@linaro.org>
Date: Thu, 23 May 2019 09:05:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523110736.GD20973@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c41
Subject: Re: [Qemu-devel] [PATCH 1/3] capstone: Adjust include of capstone.h
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
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 7:07 AM, Daniel P. Berrangé wrote:
> On Wed, May 22, 2019 at 10:42:27PM -0400, Richard Henderson wrote:
>> Since v4.0, capstone.h has moved to <capstone/capstone.h>.
> 
> NB this was a regression bug in capstone pkg-config file which has been
> fixed upstream
> 
>    https://github.com/aquynh/capstone/pull/1276
> 
> In Fedora we pulled in the fix to our v4.0 builds and I'd suggest
> other distros should do the same

Heh.  And here's me thinking this was an intentional change.


r~

