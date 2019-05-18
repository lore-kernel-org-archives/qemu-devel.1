Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C79C04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 15:28:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BC4920872
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 15:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MRb8+Cgp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC4920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35367 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS1G9-0000mA-MA
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 11:28:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS1Eu-000064-Fy
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS1Et-0004SW-Jm
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:27:12 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536]:43399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hS1Et-0004SF-E5
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:27:11 -0400
Received: by mail-pg1-x536.google.com with SMTP id t22so4681126pgi.10
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 08:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=tOIrOKJWRnjUt1amnqjCFCEwVBZrufBfXu2K8/6+Jdk=;
	b=MRb8+CgpWyt+pdiZv8MYmctwW2ybYqjfckrFew5qZA54Kr0FS1UHhpT0IHNZidHKgK
	M1lDJszH6Sfjmq4gkVCJmePLUtW8q3tL/piVeRjA9DMm9SX+msbNI4fN8IwLmEzSBJP8
	Ge85EC9gYeINbAKa4lV6xphXusMNdtfggqvuTDIhAzHPPvdZLKLqkLxiXWpxUSayn6lW
	Cax+Vg9o/Obx4KHNK+6kAlmXlUI42Qcig9H7anFbKZp8rTQsDzJne8SLxqabsBo5D3fI
	mzWA2aXdhJVrLLwFC3/Bje5tggruVZNhJaLhevDpPiXWeFmt1WJ7+MLAsdimDOOJmOiT
	qauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=tOIrOKJWRnjUt1amnqjCFCEwVBZrufBfXu2K8/6+Jdk=;
	b=ljxOMa48vv4o4GYSRs3KKxYYPTQM48+0tCIKZuktpIu/O4vearuHbCkvw8hxewSSDQ
	mBk/W20pqAldaBTrVpGsQr5X7xJsPiSln4J+0rV2t5HQpeLpFjmMWKOwQFjwlyCGjVmq
	a0o60kOA3j+TiMMe84m02IDKAVvHk2l7dx6oAlYrJmyXpWaNuprmOceZsjOKjtZbttHt
	VLlJ1Rxk5zOkniMCEIExNxtdJ0TTrwysHK8eopIv2dBl29p6EcgTlyNDR0DmibG8qSY3
	RmHM+9lKW/2vf6S0otK6Z+/+nNxCtsNfQATT0mUGCXlpBmZmMSXT9jAEXU7J2u6OUVxf
	X6qw==
X-Gm-Message-State: APjAAAVoQT8GOvj3LOtcNfHheXhERJq9PYggJvHCsF/geLl62zbAEWx5
	63EyAFQWyq6HoH4gdDopLUBVTw==
X-Google-Smtp-Source: APXvYqycgfeFY0jvmX1wujxPyuEo2CuZtxSr6YAb5zU6enGdY0r5qn33jjImisD5+3RJh114KsWSEA==
X-Received: by 2002:a62:2c17:: with SMTP id s23mr37633460pfs.51.1558193230262; 
	Sat, 18 May 2019 08:27:10 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	n35sm17548824pgl.44.2019.05.18.08.27.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 08:27:09 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190517224450.15566-1-jan.bobek@gmail.com>
	<20190517224450.15566-3-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b459b0b5-463c-f2d6-7619-61275f1d613e@linaro.org>
Date: Sat, 18 May 2019 08:27:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517224450.15566-3-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::536
Subject: Re: [Qemu-devel] [RISU v2 02/11] risu_i386: move reginfo_t and
 related defines to risu_reginfo_i386.h
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/17/19 3:44 PM, Jan Bobek wrote:
> In order to build risu successfully for i386, we need files
> risu_reginfo_i386.{h,c}; this patch adds the former by extracting the
> relevant code from risu_i386.c.
> 
> This patch is pure code motion; no functional changes were made.
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  risu_reginfo_i386.h | 37 +++++++++++++++++++++++++++++++++++++
>  risu_i386.c         | 23 +----------------------
>  2 files changed, 38 insertions(+), 22 deletions(-)
>  create mode 100644 risu_reginfo_i386.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


