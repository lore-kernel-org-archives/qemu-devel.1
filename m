Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3180C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 16:49:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DD6620881
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 16:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sHd6/etN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD6620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39783 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQx5u-00042E-Uj
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 12:49:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQx52-0003fX-2N
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:48:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQx50-0004j3-V0
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:48:36 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQx50-0004hp-Nv
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:48:34 -0400
Received: by mail-pf1-x444.google.com with SMTP id y11so242228pfm.13
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 09:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=RMGkwM3XSApYIV+P3GR3GIgyJDcH5SsU5AbBli8SMdU=;
	b=sHd6/etNw3t5lCoLgXlvlNUvlrN+4F2wIB9Iz6DrS2kpftsD50vyMD5GsaLNXHArqR
	3Km2OXvx16LkJsE6OYEIUtxgu1C5VKs9TRSHhBa/jGOxbsqn0S7BSlEo7c29ONHb+KBC
	8jyI0vad6PsKf7NlNwQh3+qGq5eIuSGP3WlG5kOzrMkyPZv7/4ZkC68GSScoF+v6waxt
	YhRd4UQdZW2CfM7oYziq+3vA3AxQzmXpG+5pFdaYrzvgu5N5S01sLvfwmcZT1xao6SxG
	+LRTB9BXzHZ+tbLsFV3gXB2v+8xlOquQf2X62OLDYQld05h/suOZRJJQHpUgY+f394kV
	3c4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=RMGkwM3XSApYIV+P3GR3GIgyJDcH5SsU5AbBli8SMdU=;
	b=YWLbS1O4HbWtET7+PE9Ui59BAikDqdl/B9yhyCmQJ6ZVlYL07l+6/OPUBctkLyQynl
	c1STDGFgy8nAdnwPxzH0hpRqnxW5zYkMPWrkEkqXTK7fpvClboXcJDHsZMGDEQ3luEZo
	/NtcUeiYdam18b7tLXhVFdmkkFPuv78x80F7jqbk6wpBhS+1YNJu6Bx5jqOPu/pGdZBl
	BEDjXr6C4y0D9qDCprJ1RtLdVKhSHN/YDf55fVuQ5G19+sRXRzPhY0yGMRpYUtzsfrpp
	HWPJ2zYcsvtxAP96yiZ4eeWE+TvSPbJa28toZjmbIHuKJnHAeQ5agfeao++KnLLjMEy3
	2s4g==
X-Gm-Message-State: APjAAAXpfLBosOS8umi0UQKy59taFkSQU6GV7h0JqpOtm3HF1iKejHjZ
	P4/EPlWA7YzqW4KKqjhp4UlVzw==
X-Google-Smtp-Source: APXvYqyeVj2GPe29m6QwpFOkMBWthQRk2HkwmwUgK5umkMLyaKB80/ZGBhJy0zUZhX6PKu6fExNu8w==
X-Received: by 2002:a62:414a:: with SMTP id o71mr49130448pfa.240.1557938912932;
	Wed, 15 May 2019 09:48:32 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	c15sm3601899pfi.172.2019.05.15.09.48.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 15 May 2019 09:48:31 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190514061458.125225-1-ysato@users.sourceforge.jp>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ffcd9051-9c72-30ed-f53e-8d0351a76250@linaro.org>
Date: Wed, 15 May 2019 09:48:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514061458.125225-1-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v12 00/12] Add RX archtecture support
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
Cc: peter.maydell@linaro.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/13/19 11:14 PM, Yoshinori Sato wrote:
> This patch series is added Renesas RX target emulation.
> 
> I fixed the ROM address because v11 was incorrect.
> 
> My git repository is bellow.
> git://git.pf.osdn.net/gitroot/y/ys/ysato/qemu.git tags/rx-20190514
> 
> Testing binaries bellow.
> u-boot
> Download - https://osdn.net/users/ysato/pf/qemu/dl/u-boot.bin.gz
> 
> starting
> $ gzip -d u-boot.bin.gz
> $ qemu-system-rx -bios u-boot.bin
> 
> linux and pico-root (only sash)
> Download - https://osdn.net/users/ysato/pf/qemu/dl/zImage (kernel)
>            https://osdn.net/users/ysato/pf/qemu/dl/rx-qemu.dtb (DeviceTree)
> 
> starting
> $ qemu-system-rx -kernel zImage -dtb rx-qemu.dtb -append "earlycon"
> 
> Changes for v11.
> - Fix ROM address.

I think this is ready to be committed, but it is difficult to tell because you
have not retained the Reviewed-by: tags that have been given to previous versions.

Looking at

https://patchwork.ozlabs.org/project/qemu-devel/list/?series=&submitter=7114&state=&q=&archive=&delegate=

	Review	Tested

>From v10:
13/13	-	-
12/13	1	-
11/13	-	-
10/13	2	1
09/13	1	1
08/13	-	1
07/13	-	-
06/13	-	1
05/13	1	-
04/13	1	1
03/13	1	-
02/13	1	-
01/13	1	1

>From v8:
08/12	1	-
07/12	1	-
06/12	1	-

In summary, only the last patch is unreviewed, and it appears that you've fixed
the issue I pointed out in v11.  I have now sent reviews for those.

In future, please retain the tags as you go through the development process.

Rather than having you send out a v13 with only changes to the tags, I will
apply them myself while preparing an initial pull request for this.

Thanks for your patience.


r~

