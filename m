Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82532C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 17:35:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A4A721726
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 17:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lH2yZCQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4A721726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40908 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOQTq-0005x4-L2
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 13:35:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOQQR-0003z3-Li
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOQQQ-0002fs-It
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:32:15 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:34914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOQQQ-0002fC-CK
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:32:14 -0400
Received: by mail-pl1-x644.google.com with SMTP id w24so10259714plp.2
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 10:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=3kSsdI24oJ1S1QAtTOpAo/eJrlqQT3nRCPLuKTBHVWo=;
	b=lH2yZCQNXeXIqlCstPP6tiOn48d4c7REE+9ZmaGRThm013cH5v86irkOfWTOz4IGnA
	wbJXdKj2MgW4bzPyCvP7eJ7d8xNPD9XAaD4h+UwO3YzbWHTWTpnxxl0YhbLNtBIXjLAM
	t7Pro7XflLC/HHCvJ0hJ14/mTzULM6ezdImUR1vuy627OgMXnZ+6EyY+b7TJsbWu6L/T
	VInbf3uHHjw98dNg7TgY/a31kfn/4EZ04fwKcmz9CJcl5xLfs+Ag/KSN9mUBrz7z//Lv
	3vzf/AUsCnDns/j/3ORCl7T6nwO7+cny5OStc6XnhJ+PUeV4DHhB7Qu0kP6StKi/2mZ8
	P8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=3kSsdI24oJ1S1QAtTOpAo/eJrlqQT3nRCPLuKTBHVWo=;
	b=EsbI+pZCoPAHO0OlUgRI5C809jcRW+ATm8nWD/Qf9c2NbPVjcOnjRMfeEEKQ4c5cal
	vz3NymJiITTrETE5yyNqxmZUGgqtc7cvJ2JMQV2RJENfbQg6/68j+gpeBuKoSr69P5rk
	CRXdqpNjXwbMLiJ5Z1uyXKHfFwkrkqatk/ZLxII8UzIwY8TmUcqdo3X+PlJcEurHyWkq
	E5tiTCerm75ptk2JYBO2bmY09N+vD6BE7EROQdi8BIteh3/EPp2Y2oRH+IZfp0Vhu0pD
	SEr1ze4kJl9r4D38IPcFF0qv7lglOk8VE2fR5go2fDctYZX62M4PHmmFwlmOgRyPXCOj
	MCdQ==
X-Gm-Message-State: APjAAAW5zt9sdB4hy/mJBepGYXj4Ncmau2FEGuJBQ5SAtROesbToqPO7
	VdV/hVo1bDoK58gzb6TJYhJm+xAUvY4=
X-Google-Smtp-Source: APXvYqwejGCM6VogF6s80sN5qgcPIsiTISb30a7wEwtUL1lZs/VAlPnvSQF6xjC79XKm2EmaLWqcfw==
X-Received: by 2002:a17:902:302:: with SMTP id
	2mr49401531pld.232.1557336733185; 
	Wed, 08 May 2019 10:32:13 -0700 (PDT)
Received: from [192.168.1.11] (97-113-27-95.tukw.qwest.net. [97.113.27.95])
	by smtp.gmail.com with ESMTPSA id
	q10sm20545037pgh.93.2019.05.08.10.32.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 10:32:12 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190508145611.107133-1-ysato@users.sourceforge.jp>
	<20190508145611.107133-13-ysato@users.sourceforge.jp>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c708ff4a-52c4-aa02-8c3c-c4cd62dd62f8@linaro.org>
Date: Wed, 8 May 2019 10:32:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508145611.107133-13-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH v10 12/13] hw/registerfields.h: Add 8bit
 and 16bit register macros.
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/8/19 7:56 AM, Yoshinori Sato wrote:
> Some RX peripheral using 8bit and 16bit registers.
> Added 8bit and 16bit APIs.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  include/hw/registerfields.h | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


