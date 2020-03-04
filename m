Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4A3C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 14:36:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95DD820838
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 14:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpC3BeDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95DD820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9V8o-0000vs-JY
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 09:36:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1j9V8A-0000QO-4a
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 09:36:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1j9V88-0001bb-VI
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 09:36:14 -0500
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:33095)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1j9V86-0001Zd-GP; Wed, 04 Mar 2020 09:36:10 -0500
Received: by mail-qt1-x843.google.com with SMTP id d22so1498594qtn.0;
 Wed, 04 Mar 2020 06:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FEvtamSQPt9SnVyGPVD4R0wUTlrMsAbBDWNqMMbIciM=;
 b=LpC3BeDD9F7wUHWN2FGfnIRGrrxdjy6eO8DkYpNHlCbUgVsdxz7cf67qElH3AcA3uA
 vYC9OcaQz3E3tD/+6nke+5/9IBpTgo9oWnBQgZeSSvcSl5BsRz0vkG05gjIiiosiLwkk
 aVw+NCdvVmF99KxL+GfRRa6ChEKtp6gavrF7BMi9hOP40ct+kzDIaf5Kv8iqJVJqxhuA
 uG+iv1+Geb+XluiNU9GUf05fxCMIFFdXu8qF1H1Z0uFQPElty7kkKHoyZTeKLUIOPYl6
 uXXnMZP6tdtu6LCxVxGsFp5OoYEbWHn4Iotf51bcM5zD0ve6pk7x0UliH7Qn13gDxM72
 bnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FEvtamSQPt9SnVyGPVD4R0wUTlrMsAbBDWNqMMbIciM=;
 b=F7ZYg/ZNe2GlZGrELzF+CZMLxyhrT7Z2YeRY981PzI/DjpcbN3qJcPW4Nceo9TwOAv
 UDntvHMYCjYiZzR/mZVGrTdJRCjmHr6hxeBK1o1fG5TmHE65k2zklzGuOyGzJp2tb3Ja
 CLvh1E2YBwpAa5UInFCglNPXG1bBbIykPutMlCEYUXSs/USmXqAFvJElqUCOtzhF5TQ4
 EehnkqhjWkwlj9LbTTahQLAafcGNJr62xsfzhc26nHkgWh5QT4JfLyalTSJGXMEh0+5W
 QpfQGrePNWCgUeRnk3jWMd1uJkpLpZFj4kZnPB1q0pHJo3YCAkvlBs+C8sigU2y2sCRS
 Uj2Q==
X-Gm-Message-State: ANhLgQ3jDllvdCoKSmNeBSh7g1KOMJQkh1+rS6jJluEmhl6HpMFbtQrU
 YUC4oLpC3zY0iTSiKHKjrvI=
X-Google-Smtp-Source: ADFU+vs8E73D4EXLxDdmK4DdXtJdtecJX4IHNLJjbOtzMySfIjOCKgjtqKSTaHcfuUC+f+KFPaeXzw==
X-Received: by 2002:ac8:e09:: with SMTP id a9mr2624956qti.84.1583332569695;
 Wed, 04 Mar 2020 06:36:09 -0800 (PST)
Received: from ?IPv6:2804:431:c7c6:133d:fed6:da5e:2cb3:8d74?
 ([2804:431:c7c6:133d:fed6:da5e:2cb3:8d74])
 by smtp.gmail.com with ESMTPSA id a141sm14318603qkb.50.2020.03.04.06.36.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2020 06:36:09 -0800 (PST)
Subject: Re: [PATCH v9 0/4] delete created files when
 block_crypto_co_create_opts_luks fails
To: qemu-devel@nongnu.org
References: <20200130213907.2830642-1-danielhb413@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <73a6d0d7-0348-bb84-d9b8-c7a04305385c@gmail.com>
Date: Wed, 4 Mar 2020 11:36:04 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200130213907.2830642-1-danielhb413@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping

On 1/30/20 6:39 PM, Daniel Henrique Barboza wrote:
> The version 8 of this patch series got buried and it's now
> conflicting with master. Rebase and re-sending it.
> 
> Also, I contemplated the idea of moving/copying the password
> verification in qcrypto_block_luks_create() all the way back to the
> start of block_crypto_co_create_opts_luks(), failing early before the
> bdrv_create_file(), avoiding the problem altogether without the
> need of a delete_file API I'm trying to push here (see patch 03
> commit message for detailed info about the bug).
> 
> This idea was dropped after I saw that:
> 
> - We would need to store the resulting password, now being retrieved
> early in block_crypto_co_create_opts_luks(), in a new
> QCryptoBlockCreateOptions string to be used inside
> qcrypto_block_luks_create() as intended. An alternative would be to
> call qcrypto_secret_lookup_as_utf8() twice, discarding the first
> string;
> 
> - There are a lot of ways to fail in qcrypto_block_luks_create()
> other than a non-UTF8 password that would trigger the same problem.
> A more appropiate way of doing what I intended, instead of
> copying/hacking code around to fail before bdrv_create(), is some sort
> of bdrv_validate() API that would encapsulate everything that is
> related to user input validation for the security drivers. This
> API could then be called before the file creation (maybe inside
> bdrv_create itself) and fail early if needed. This is too overkill
> for what I'm trying to fix here, and I'm not sure if it would be
> a net gain compared to the delete_file API.
> 
> 
> All that said, I believe that this patch series presents a sane
> solution with the code we have ATM.
> 
> 
> changes in this version:
> - rebase with current master at 204aa60b37
> - previous version:
> https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg01551.html
> 
> 
> Daniel Henrique Barboza (4):
>    block: introducing 'bdrv_co_delete_file' interface
>    block.c: adding bdrv_co_delete_file
>    crypto.c: cleanup created file when block_crypto_co_create_opts_luks
>      fails
>    qemu-iotests: adding LUKS cleanup for non-UTF8 secret error
> 
>   block.c                    | 26 +++++++++++++++
>   block/crypto.c             | 18 ++++++++++
>   block/file-posix.c         | 23 +++++++++++++
>   include/block/block.h      |  1 +
>   include/block/block_int.h  |  4 +++
>   tests/qemu-iotests/282     | 67 ++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/282.out | 11 +++++++
>   tests/qemu-iotests/group   |  1 +
>   8 files changed, 151 insertions(+)
>   create mode 100755 tests/qemu-iotests/282
>   create mode 100644 tests/qemu-iotests/282.out
> 

