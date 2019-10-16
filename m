Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4094FA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 15:49:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9058121A49
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 15:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chNScY/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9058121A49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKlXv-0006fh-6I
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 11:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhangckid@gmail.com>) id 1iKlWc-0005mz-DW
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 11:47:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhangckid@gmail.com>) id 1iKlWa-0000jg-Hl
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 11:47:46 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33129)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1iKlWa-0000hk-Bs
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 11:47:44 -0400
Received: by mail-wr1-x442.google.com with SMTP id b9so28675702wrs.0
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 08:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=Xb5v9ZJf0Np4qLVXzWMyMOn1cIToqMjUDmZphZ7zdy0=;
 b=chNScY/DPFrsIjo0Rr+P8b4/gC3Faq9/D+XiQu2cFbM3zBkUY/hf+Z+cO2ZbIPqpc5
 YBiBa2A8AUTMMMtBJLJtcuSC9luSCezN2VA5qtq5+eOMZE8d8+4gJRJ48aVQ433pFXxx
 m0oGUA0UaLRZV+zbGdSQIA5k73DyKB/fyjt1RgbIJ3LDRIXYvkidvxSD7lLAGryz/2y1
 4Td4txjHCivMJbmRQrNIkcdCdfbx5omKXxQW6F0NJYOr0GbiL7lbBzASCqJ76XBMJ2cZ
 A+nujuH6e+SrlSBLBywAD3B5WqIuRJKFE3Qdm2gfF+VHgU2zmpZEj3Y0xDm9pkaC2Ieu
 8BKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=Xb5v9ZJf0Np4qLVXzWMyMOn1cIToqMjUDmZphZ7zdy0=;
 b=FmcaQ2EpnVdlvx34/pDZjXCMj6CxZX10qxiM+/yZq0vFOwueu5fsQ7WwbEBdxflPbP
 VIMI9AUjWtekUvNr6YTa8GfLP3wIpATgaxB1VNfi3db3tMtkjUJQDc9UYGedrP0fGnwZ
 LR6wCTnB8HgQCAqVMRiXQ0yeRsse84X/z0R85L4s71Bo+8c8QeUjx4QHojSgItmFj16u
 wwFB5XP7/etj+oN4eEBBFMngsln49leMtOC3JF0gampX9Rl1KGR/WiQvJ0c0pvwXqHfe
 3e4ZkkRZN+zviIWZWjnoXDN+6jDjhOVTTc8q16yAbYwLos4kyWLkWL9LykjxePnOf+XJ
 5L4w==
X-Gm-Message-State: APjAAAWNtEeB1Z4yiva1KIvVzwadFmjRiIN46Wcgm34kBqN6SxFSTAyV
 47PasjOuCYoLVRz7YRnendMyAQ3lmdvkRAULYKXY5kcU
X-Google-Smtp-Source: APXvYqzMAujs0ebseRGlsKkA+QGFIVHLIDI0+T6oSJQwKgUWcWGlPBtnxSvVPmQ50ymlKpStmsOgd+43wv/+4DALNwU=
X-Received: by 2002:adf:e8c6:: with SMTP id k6mr3348042wrn.78.1571240861500;
 Wed, 16 Oct 2019 08:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20191016112209.9024-1-chen.zhang@intel.com>
 <157124010247.15388.11052477009886074916@37313f22b938>
In-Reply-To: <157124010247.15388.11052477009886074916@37313f22b938>
From: Zhang Chen <zhangckid@gmail.com>
Date: Wed, 16 Oct 2019 23:40:53 +0800
Message-ID: <CAK3tnv+QcXrGyOsb5LYN8MvL+t_K1vPGdB-V7p57QALbno1k8Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Introduce Advanced Watch Dog module
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 16, 2019 at 11:35 PM <no-reply@patchew.org> wrote:
>
> Patchew URL: https://patchew.org/QEMU/20191016112209.9024-1-chen.zhang@intel.com/
>
>
>
> Hi,
>
> This series failed the docker-quick@centos7 build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
>
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> make docker-image-centos7 V=1 NETWORK=1
> time make docker-test-quick@centos7 SHOW_ENV=1 J=14 NETWORK=1
> === TEST SCRIPT END ===
>
> Clone of 'https://git.qemu.org/git/dtc.git' into submodule path 'dtc' failed
> failed to update submodule dtc
> Submodule 'dtc' (https://git.qemu.org/git/dtc.git) unregistered for path 'dtc'
> make[1]: *** [/var/tmp/patchew-tester-tmp-2eq69u33/src/docker-src.2019-10-16-11.34.59.10123] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-2eq69u33/src'
> make: *** [docker-run-test-quick@centos7] Error 2
>

It looks this problem dose not caused by my patch series?

Thanks
Zhang Chen

> real    0m3.762s
> user    0m2.349s
>
>
> The full log is available at
> http://patchew.org/logs/20191016112209.9024-1-chen.zhang@intel.com/testing.docker-quick@centos7/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com

