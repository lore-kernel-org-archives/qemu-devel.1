Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0E7C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 09:23:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C17C266AB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 09:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ExCLcfKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C17C266AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39074 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWdlV-0005z6-EI
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 05:23:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWdkM-0005KW-E1
	for qemu-devel@nongnu.org; Fri, 31 May 2019 05:22:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWdkK-0005P4-VF
	for qemu-devel@nongnu.org; Fri, 31 May 2019 05:22:46 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWdkK-0005OV-Os
	for qemu-devel@nongnu.org; Fri, 31 May 2019 05:22:44 -0400
Received: by mail-oi1-x244.google.com with SMTP id y6so3590575oix.2
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 02:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=VFefAcz7vhah8dUJuS0yMaKY1nkmL0rkoR5Q/xK4EqU=;
	b=ExCLcfKSQwE/EWJZnv6uZELWBpQb3OfSRG5MQELEWPsBsvbaFQeF1cqtmDKH3hdp02
	FaEv1WJ+F7tFviNPsCHbLSzLpzM9TmfGIqnG1B1ylWIIIM74cUT5iBCUFLvW0DdVE9uG
	Mw6yd/DrTSIAFMN8ou2C8ZlcFCztgxRtpDDlOJDZw7hLkK0606VyLdosV1iJ0xZKYh+n
	HTwmGx0E3Eac+Qv3ncwXgxBOdbgMKFjbrvU3ey6D7wYeXHyTUQRjuP+kos9CtAGlp5gH
	+mFTKTOLJuH5aLTflpalaja+Ul4V0yQ3i9Hl6uhxBv6JxvrRnJfaiK/I8aYqmJlK6DsK
	CgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=VFefAcz7vhah8dUJuS0yMaKY1nkmL0rkoR5Q/xK4EqU=;
	b=dv9UQ0AiuMmr1fgjzhwLmcWkeNJ1LIa9Tsp8mzSG4CZGTqJU52K31A9me5BndGBtXk
	8FtLovNDhJP6+iPBuS341v7VUa4WilDYfg516HrXtzMIfjPNYtoz7TCUckPYUIyRGz2v
	dYde5g1Cnh5jOJCnOdEs4Kvx16kta4kbQlaeFv9AybnRP6cwyMMmsaauWC61UJU8COzf
	5XMwJnrVzYwEmyj5TYbcE5DAxmESmUhIZAQ19NB4Gzo6UlCbI9uX/P0CmJVrP3BWq26Q
	SAlnVjfp/SLc8EUm4EdM7CW7NtNT1eCNXdhzGmpm479Z5+j9OcT0EM4v4OUgJutad1J3
	VoeQ==
X-Gm-Message-State: APjAAAWci1x9+R1MYw2dAU00C3BpoAUH64TMIQnABWD/wB8X9qORoW0L
	eIluR3y+xwmOIPIPXwNm3PHRkIACJMtf3w==
X-Google-Smtp-Source: APXvYqzZoSeNPPrHwT1MVtAVxECEpsg9kzoSdWS0KwCcfq3KZ2IswR+Wq3J5eytVVXFEPa1DfgQO2Q==
X-Received: by 2002:aca:5054:: with SMTP id e81mr33487oib.74.1559294563542;
	Fri, 31 May 2019 02:22:43 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	s63sm1920417oia.34.2019.05.31.02.22.42
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 02:22:42 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20190523150803.31504-1-richard.henderson@linaro.org>
	<87woib6h5z.wl-ysato@users.sourceforge.jp>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <67c75ec8-f3f8-655b-6b82-86f5fe2648b2@linaro.org>
Date: Fri, 31 May 2019 04:22:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87woib6h5z.wl-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH 0/6] target/rx: Improvements to disassembly
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/27/19 10:39 AM, Yoshinori Sato wrote:
> On Fri, 24 May 2019 00:07:57 +0900,
> Richard Henderson wrote:
>> Obviously there are still a few inconsistencies in the
>> format strings used for the immediates, but the format
>> is readable and it is easy to look at the opcode to see
>> how our decode compares to the manual.
>>
> 
> Hmm.
> The output of the immediate value should be the same as the output of objdump.
> I do not think that it is the proper format, but I did that because
> it was useful for comparing the results.

This is a fair comment.

Of course, we could also simultaneously fix inconsistencies in objdump.  I
doubt that any of these cases are intentionally different.

Something for later, perhaps.


r~

