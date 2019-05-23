Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67E4C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:14:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 839AA204EC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ypFqGqnD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839AA204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38587 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTpPv-0003nC-Kf
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 11:14:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTpOE-0002dC-53
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:12:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTpOD-0005Tk-Ba
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:12:18 -0400
Received: from mail-ua1-x941.google.com ([2607:f8b0:4864:20::941]:35883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTpOD-0005Sn-7a
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:12:17 -0400
Received: by mail-ua1-x941.google.com with SMTP id 94so2312863uam.3
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 08:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=VtX4706PwqW+Myap8+XCUmAg/m3A5RvWOGN+9V+MaPc=;
	b=ypFqGqnDy2VJFE3RjhUVHdp5AEDZQzvID8CAm2X/ews9H9kfm4Ck65QjIoFCOSD7s4
	vgo8NAaBkpsZhw1ycf1LwJKz3mrxR2+uKcZG0x3jByN99pTzm49K7hZUG0kWN01t8nrj
	p5pVc9tf1iexOlUukJZCn2vyxCxtfDBlur3udmbG0S5nSQLernDfjw+8YVCKHRPJzTv6
	f1bzmvzo72lCpdnmcMjeeZTEC5n/agjqXBdFb6aXDR8oJ/MjfIR0X+rti00HyJ6K4UeJ
	e5uv+8FpvYeLZ1FG7J34yWcVFm3UCm2/NrSJkvoMve+amLzn3vjPaSffVsd/4Ml3g/mn
	aXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=VtX4706PwqW+Myap8+XCUmAg/m3A5RvWOGN+9V+MaPc=;
	b=LL+Ums7sLfDiFmjqpBpFtsOYslkzcG3fD1MFrkCXZQAp2A6KjAPu8ZmVPugsxrgd2y
	YyDWDqAT6cI4XC3ro8qLkhDoerKTUUW6RzlEllB9lQxSSY82kGPVNwDBEfFiqKJkhTdv
	YQAJi2+gZQHiDzceEsaNt0KTXboeO1t5z84369MeDUWeFNFUyDflg+qNyy7AAuFz1WqE
	KOc1nPR6HYL/Wa2w7kVj944+9Ws3nF5tizQ/qW7oQkNFt1w/4E3allMn2bWp5u8jX2in
	oEkVFJE/1gY6lmAQJpQv8UwOVk9zb5wilFfwNL4zjVQKa8ZnQtrgd2J6eLJz4Ab1mVpJ
	JiHw==
X-Gm-Message-State: APjAAAUyoaSfCix03gavcpBHiGjc+FVDnKhV/C2iojx7V5Czf8t4GGCY
	Q86T3UYVUliAfjREP42ZgkoaIw==
X-Google-Smtp-Source: APXvYqzT3Kwo2woL6jg4oUyvmyCrNYbrR+4hmpr8v/MUKLqLAig7EoKu4Pj+niVmhPAg5l864B2UYQ==
X-Received: by 2002:a9f:3dc6:: with SMTP id e6mr45710277uaj.33.1558624336440; 
	Thu, 23 May 2019 08:12:16 -0700 (PDT)
Received: from [192.168.43.94] (ip-173-130-215-183.orldfl.spcsdns.net.
	[173.130.215.183]) by smtp.gmail.com with ESMTPSA id
	e76sm18055059vke.54.2019.05.23.08.12.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 08:12:15 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190523102532.10486-1-alex.bennee@linaro.org>
	<20190523102532.10486-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ff7b3b75-1e08-cb51-5070-2042b9a329ab@linaro.org>
Date: Thu, 23 May 2019 11:12:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523102532.10486-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::941
Subject: Re: [Qemu-devel] [PATCH v2 06/28] target/arm: use the common
 interface for WRITE0/WRITEC in arm-semi
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
	Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 6:25 AM, Alex Bennée wrote:
>      case TARGET_SYS_WRITEC:
> -        {
> -          char c;
> -
> -          if (get_user_u8(c, args))
> -              /* FIXME - should this error code be -TARGET_EFAULT ? */
> -              return (uint32_t)-1;
> -          /* Write to debug console.  stderr is near enough.  */
> -          if (use_gdb_syscalls()) {
> -                return arm_gdb_syscall(cpu, arm_semi_cb, "write,2,%x,1", args);
> -          } else {
> -                return write(STDERR_FILENO, &c, 1);
> -          }
> -        }
> +    {
> +        qemu_semihosting_console_out(env, args, 1);
> +        return 0xdeadbeef;
> +    }
>      case TARGET_SYS_WRITE0:

You can drop the braces now that "char c" is gone,
which will then fix the indentation.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

