Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9256CC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 14:16:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07AC420866
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 14:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yisvstR0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07AC420866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59397 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLq2F-0002VQ-2M
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 10:16:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLq17-0001sT-UL
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLq10-0006fK-AC
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:15:22 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:43533)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLq0y-0006eg-ND
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:15:18 -0400
Received: by mail-pl1-x629.google.com with SMTP id n8so8237276plp.10
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 07:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=AaR/jWZxbFEORr7Pg8KcRpvGmry5QEQL1q30DXO3fCE=;
	b=yisvstR0Xv9+2lCuJ7UOkhC3H/nyy2XcjEjhpx2z9K/NVhP/3HAMO/Ce+dHYTovXb3
	39iv8EUqbw78qNDEEXrCShzTt9C4KQjtFUUvd+t5V2nQEg+7O7jDONqzRQQd8glrIr3D
	bZMTYxODYYZ2g3OrrZ0XS1JDfdEYjIZHxck3EIkCfHZTVZ+Ra0ZSXzuZmEDcv7fEzBz8
	mkQYU/QeKSZOJx1NzBVGfeYX8FgKneOnFBMNEqTX1ohnNv8cDXUfoXIiXrSol49Gt32j
	E0LFzC64Os8xjpymBy0RQ2tvo9WNLVOrdkph1homdFOexk8rL2WdLThHJh1Bv/xyc6t6
	dCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=AaR/jWZxbFEORr7Pg8KcRpvGmry5QEQL1q30DXO3fCE=;
	b=DyCgLISeBKxZK1w/hZuGq+uY6rmZjjuL/OTKJcKVYXL1Ad9l+Dd3eqqkLX9LfEuN2D
	PwqKBuFIACg1XiVqG9tIx3/F2tbEFvKV8F2r9hl2EnKM+Nfg+Gm+IdE2cPa4KCbsDrW6
	hbzPeXjKISU2P3GVmqt8WstRR7xL2VlGBU8OHVjFpVi0ETZcEEU6ATI3W5OAMfLtCvgE
	LohiLExyqKM7ZuAMsCA8DN+AhWptytvjtTJzKgz2g7ehGBmTGkZz9eLbwI8soZycnysI
	C2EAbjngqut0QxA5PgN9IcSzRVP7DQoTSlELpr3sQVVVyFIoYk4KnP/DEoVCotrg6fbB
	8kLQ==
X-Gm-Message-State: APjAAAUnz+N4btu35z07b+3GrxkqBdnDArS4WO1447MEJnSI/1MUE9/j
	WdIqIjL4NxnSD9Wj5s/aE51A6Q==
X-Google-Smtp-Source: APXvYqyXs5wsZyEL1g/pKKOaz2QktcJKDIWocVZOHQweP1CKQ70bXkdRin5kQvMD6cAq4MP6qAPnmQ==
X-Received: by 2002:a17:902:5a03:: with SMTP id
	q3mr22132793pli.209.1556720115469; 
	Wed, 01 May 2019 07:15:15 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	e23sm8666087pfi.159.2019.05.01.07.15.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 07:15:14 -0700 (PDT)
To: Alistair Francis <Alistair.Francis@wdc.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <cover.1556666645.git.alistair.francis@wdc.com>
	<c4d2b1de9efadcf1c900b91361af9302823a72a9.1556666645.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <035c917e-be1c-1cda-6b1b-337fa804a69b@linaro.org>
Date: Wed, 1 May 2019 07:15:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c4d2b1de9efadcf1c900b91361af9302823a72a9.1556666645.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::629
Subject: Re: [Qemu-devel] [PATCH v2 5/5] linux-user/elfload: Fix GCC 9 build
 warnings
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
	"alistair23@gmail.com" <alistair23@gmail.com>,
	"riku.voipio@iki.fi" <riku.voipio@iki.fi>,
	"laurent@vivier.eu" <laurent@vivier.eu>,
	"kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501141512.hUrdkbLo1lTiyhg6DE0V00KXFswB9nqY7i0tKI1ugaM@z>

On 4/30/19 4:29 PM, Alistair Francis wrote:
> @@ -2872,7 +2872,7 @@ struct target_elf_prpsinfo {
>      target_gid_t pr_gid;
>      target_pid_t pr_pid, pr_ppid, pr_pgrp, pr_sid;
>      /* Lots missing */
> -    char    pr_fname[16];           /* filename of executable */
> +    char    pr_fname[16] QEMU_NONSTRING; /* filename of executable */

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

