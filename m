Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D67C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:25:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 045232088F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fIv2v5GO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045232088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60356 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJhBk-00008u-Pb
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 12:25:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJhAR-0007dF-EU
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJhAP-0007vK-Hh
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:24:11 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJhAN-0007nD-IV
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:24:09 -0400
Received: by mail-pf1-x441.google.com with SMTP id 188so154063pfd.8
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 09:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=0lCgSw3pkjRgaW70M0VCuZ0KEqCUePo8dIOagiwSZc8=;
	b=fIv2v5GOSlEsjg4DsnGZdtUndwIkheplpxmhON4RNk2HtNVBSbbrZ0jRecMvQ9q/lE
	3EeUmZGIQGOyRmhBO3wbiaJU0K557bQDvV8PUWVxaC/G5FVgKXEBqS9yZr8iwDNpGORW
	opL7GJl9rBmqkaR9aZeaqDZiKD26FNdab/nVBHzA5KXXqsUVFYs8FQtcExWB7LNSVsWC
	nbGQv3+nvkgbPgnJa8jRwMPHiuTIxyR0Z+vQDnH3j7nLJDBcovn5U/Ow0kx7oFMpDtup
	QIuXt3lw90c8l+i7O2yICblPVJo0lV82Hu0FyUrqlqQKFrx5yQXCKId5dyjbhAXEp3RO
	nETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=0lCgSw3pkjRgaW70M0VCuZ0KEqCUePo8dIOagiwSZc8=;
	b=U4qEvZ9oGA94OWLAYGQoSSTmaW0PVas/A0JEi5KpiGaOk4BYXrJV+ga8IkXVjT+aiG
	l0/1viw/ghtnNWLqBdeF36ODqr/AluJt+jDoFd8AaxJIXuEtSIcP3+ywToD6Wazl6/Gg
	wzcsIrP36lKYBrEMJ77fGe+jNim7lrCH2yuFDI3TCf2QbzsLjWwup/m5I6gEDrVipjmW
	RquvlNe33lbIQuEp6E/cJ29mhoVMUiJWBL3kpl8SuvKwEXdIiPQHmuLAUZI6NIqhDoT7
	Zq1ALFNhvUj+vzjl07+NwoaSEIqqE6uND1zkrAT/YawoC7BJauNP77FbtVnWzplZRZsA
	jAKw==
X-Gm-Message-State: APjAAAVripYlQK1P4RGJrgv21Yz+VtkNnFtGOdxBQGfaPqA7n8334qo7
	bFI8YBr8jYDHKH/v1ho7qn3mdw==
X-Google-Smtp-Source: APXvYqwwGsovsj+EauvCcpK1hVN15HGeU0lUjGUqjA3CTreN0qxd7Tw1xY9fO5dCmGiPknqo74wibg==
X-Received: by 2002:a63:131d:: with SMTP id i29mr19669525pgl.399.1556209438924;
	Thu, 25 Apr 2019 09:23:58 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	p66sm50908102pfb.4.2019.04.25.09.23.57
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 09:23:58 -0700 (PDT)
To: Palmer Dabbelt <palmer@sifive.com>
References: <mhng-f96f6f0d-cec7-477e-96c8-af5485b43bc7@palmer-si-x1e>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9384b35d-41d0-65b0-17ca-7291c530d13f@linaro.org>
Date: Thu, 25 Apr 2019 09:23:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <mhng-f96f6f0d-cec7-477e-96c8-af5485b43bc7@palmer-si-x1e>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH for-4.1 0/8] target/riscv: decodetree
 improvments
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425162356.hkwEu68PxLRUDVOnYKoOa0ReXE-P3TwBdbdef7RCHzs@z>

On 4/25/19 9:04 AM, Palmer Dabbelt wrote:
> 
> Thanks!  I'm happy taking this as it stands, since all those decode issues I
> pointed out aren't regressions in this patch set.  Let me know if you want to
> fix those or if you want me to -- as you can probably tell my email queue is a
> bit long... :)

I'm happy to fix those, if you'll point me at your branch.


r~

