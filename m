Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0396FC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 15:32:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C11CE206CB
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 15:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYUAcKmu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11CE206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihbJm-00038w-Pc
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 10:32:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ihbIm-0002jw-VI
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 10:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ihbIl-0002mH-Ms
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 10:31:52 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:37374)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ihbIl-0002fa-E6
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 10:31:51 -0500
Received: by mail-pj1-x1041.google.com with SMTP id m13so1040172pjb.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 07:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=UvLm4Dra+KEKrEzBNLUg7ufAkJQKyX1fO/Wi/nDlMWc=;
 b=YYUAcKmuZ+EYW404LXi99YCPmlKE/3e0dUrAAHzCoTD/B/v0eIHH9QuwAB9J1o4wj6
 /shQllYfldnOdwh7CmDdivRDoe7OCrN/aoyMZ1jFJPvxLcukHWq0/3KAIZ6uPMaLqPVR
 Z5zb91segW8K6W+24nwqRPyVCprBHjtByW9DxNAbW5L+oMd5Ah+LaaJIPdCaCaPEApKg
 ufwvS/5cp/VY127jsAGJzaccSi80OBdnKqzWB23WTfCn9I2b0Du5HQnTR9BltBl0TyWx
 1nmCIkVi6VNHlrz66+V9M9vlnbk8s8Xoe7mAO47ww/49IJdo71zLx70RmggK6kbFT8UF
 TOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UvLm4Dra+KEKrEzBNLUg7ufAkJQKyX1fO/Wi/nDlMWc=;
 b=ppWom1Z61LaNy/Uxo0J2BSnd3wxADMJ1kE2w54NAOAnIvdZCBprxB/k7Bf/A8/1rzF
 XsKeWSAMvQavfj0CmMus9vsk5PdoO/OEgj7vP9o4i2DWXZmqb2jG8/mLBDHRGoJsHMg+
 JjHdaF41aMwLncuPGIsWxQPFvd4llNeZxT2nI7XKtx86qeGPRZD80dBCi4Bx46yqCjLl
 41xbI1Xqlgv7cHmvKuDwXjTZ/koiyo5Ubc74twNulfelKY6qbpGIgIc+e7+lYN9ELCtC
 /pxHEa25OkJaL4SoXUiH++4sRe05YlWWkCJ6qYq1lJzHYBB378lSkTKqHbu9TorMAPj5
 uYxA==
X-Gm-Message-State: APjAAAU73Q+HWAAfpkxf4dM/NNIJX3NlJZ07ot5cD/It1w29l6qKhJrL
 HNPpglrfUJdP5oCnmO6OxxY=
X-Google-Smtp-Source: APXvYqzP05ZPDJnWO3vLXhObwNhz3CNpcaX8gw1OSwnlo8yCfU1naZw6t5BNjvqixlZv9Yu5IRzyfg==
X-Received: by 2002:a17:902:b785:: with SMTP id
 e5mr3354987pls.327.1576683109872; 
 Wed, 18 Dec 2019 07:31:49 -0800 (PST)
Received: from ?IPv6:2804:431:c7c7:2336:5ba2:6450:4367:bbc2?
 ([2804:431:c7c7:2336:5ba2:6450:4367:bbc2])
 by smtp.gmail.com with ESMTPSA id f43sm2371994pje.23.2019.12.18.07.31.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 07:31:49 -0800 (PST)
Subject: Re: [PATCH v8 0/4] delete created files when
 block_crypto_co_create_opts_luks fails
To: qemu-devel@nongnu.org
References: <20191111170131.13742-1-danielhb413@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <1a56e26d-ec25-98a5-89e0-1f537c325a99@gmail.com>
Date: Wed, 18 Dec 2019 12:31:38 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191111170131.13742-1-danielhb413@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: kwolf@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping

On 11/11/19 2:01 PM, Daniel Henrique Barboza wrote:
> changes from previous version 7 [1], all suggested by Kevin Wolf:
> 
> - patch 1:
>      * removed function comment of raw_co_delete_file;
>      * removed 'done' label from raw_co_delete_file;
>      * removed 'local' remark from bdrv_co_delete_file comment. The comment
>        is now single-lined;
>      * added missing space in the commit msg;
> - patch 2:
>      * ditched bdrv_delete_co_entry and bdrv_delete_file, now it's a single
>        coroutine_fn bdrv_co_delete_file;
>      * BlockDriverState != NULL dropped - the caller will need to ensure it
>        is not null;
>      * changed the error message of '!bs->drv' condition;
>      * s/delete/deletion in the error message of !bs->drv->bdrv_co_delete_file;
>      * 'out' label removed - function will return immediately on error;
> - patch 3:
>      * check for (ret && bs);
>      * drop the ENOENT verification;
>      * do not prepend the filename in the error message;
>      * removed an extra blank line.
> 
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg00282.html
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
>   tests/qemu-iotests/273     | 67 ++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/273.out | 11 +++++++
>   tests/qemu-iotests/group   |  1 +
>   8 files changed, 151 insertions(+)
>   create mode 100755 tests/qemu-iotests/273
>   create mode 100644 tests/qemu-iotests/273.out
> 

