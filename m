Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DB5C04AB4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 03:05:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4519A20645
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 03:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F3YggyKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4519A20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56916 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSYbx-0000Qq-EZ
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 23:05:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSYae-0008Gb-Hl
	for qemu-devel@nongnu.org; Sun, 19 May 2019 23:03:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSYad-0007cs-FY
	for qemu-devel@nongnu.org; Sun, 19 May 2019 23:03:52 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:38350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSYad-0007ck-9i
	for qemu-devel@nongnu.org; Sun, 19 May 2019 23:03:51 -0400
Received: by mail-pl1-x642.google.com with SMTP id f97so5988025plb.5
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 20:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=jTllUmxlZYppCQDauRX2Ul+puj/9PD6zqtUPs1mwDGQ=;
	b=F3YggyKftq003UyPIbmmwdA3ORbcxIXfeAnvzSjBv+1oHj17BUIaVS40zAkQ00EfYJ
	0MKbaxkf6c8N+kiRbI0sTd5wZQNFF0Slbtj4BYwfGcQU/9/oGxl2ak4NRxHtExchW01w
	/hSU03fIDjFCLEFaDGqXqpp1sBDSFtOLjPSyY4VOdh4cOSJKKxfCDjB3eoQIYsO5UvBJ
	ic+nddB1XjFCGRWzHHKy25ue1L6UwjF7Webe7sTuH8T56xcIAR+BzAF6pLNZaHT1aYrN
	G4XLiukgllLRg6AzjoJx92zJYVV6+muAG4HmOQuYtHIOAm7GpvFquuNJA95SNuIRJC8Y
	o3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=jTllUmxlZYppCQDauRX2Ul+puj/9PD6zqtUPs1mwDGQ=;
	b=eXty3RHfY2/S7F9XVka7yPpzfHtzl3fBZmCZdT6v2KkhYMhf1YCjkLdGNS9Dw8HPyL
	9ALgWschDs0poZqSd+Bd8zRs/MyJqan+gI9xxqyrNNEzhwJNgaAkG4GveP9da7WIXG38
	jJcBhG4D2//95cKyxXzSGZmWt8uaxwNyaght+IM0VfoMFTLl8sBXmeyV0aoUuBnhW5MK
	clX/+yNiorpHIb74CvSpmgr3CNgv14WiT6LRugvUAeKnYni2PIWjE/YoDCkAmZmjMYbn
	bGx0neBEpoXMEj/AAu9xgoX5EgogQqA1A5Nkrqh2PnoxWP7nqw37c1DkfJJMVl/CJo9a
	ZcNw==
X-Gm-Message-State: APjAAAULsL3YNXj97TpJenE2LDaX8OUKlBHrQdZH7tEeziSxSfd52bt/
	C5v8vED5gvBc1O1jQyO1qj6SPg==
X-Google-Smtp-Source: APXvYqwH+PJqXPvDQeo8gBKgOBuzfHTB8bn5R+3NzOJdHGzGJ42EmI9xllwad2rQK8mykaCZ89tI6Q==
X-Received: by 2002:a17:902:aa97:: with SMTP id
	d23mr73405846plr.313.1558321430499; 
	Sun, 19 May 2019 20:03:50 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	k192sm15751953pga.20.2019.05.19.20.03.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 20:03:49 -0700 (PDT)
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20190517133149.19593-1-laurent@vivier.eu>
	<20190517133149.19593-3-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <11462a4e-6020-2c79-32b8-5239d1d6dcc2@linaro.org>
Date: Sun, 19 May 2019 20:03:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517133149.19593-3-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v2 2/2] linux-user: add pseudo
 /proc/hardware for m68k
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
Cc: Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/17/19 6:31 AM, Laurent Vivier wrote:
> Debian console-setup uses /proc/hardware to guess the keyboard layout.
> If the file /proc/hardware cannot be opened, the installation fails.
> 
> This patch adds a pseudo /proc/hardware file to report the model of
> the machine. Instead of reporting a known and fake model, it
> reports "qemu-m68k", which is true, and avoids to set the configuration
> for an Amiga/Apple/Atari and let the user to chose the good one.
> 
> Bug: https://github.com/vivier/qemu-m68k/issues/34
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/syscall.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


