Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB64C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F29B02067C
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kotjan6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F29B02067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD60p-0001Lo-6t
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 09:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD60G-0000dY-UW
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 09:07:12 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:33253)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD60F-00045H-8Z
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 09:07:12 -0400
Received: by mail-ej1-x644.google.com with SMTP id h4so1571959ejj.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 06:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=337KvErcJJVNkQKOM4GfPx6Z3ZDWBJ1Cy0HJ9YJmzK0=;
 b=kotjan6yt+8JqLnt6AZhtcxhH2p7pscIVbes8SGopayObV5fSWXu5vxbGlZx+4ZYrK
 HTSSLTYp2zqem1WBS3CwvgJUQIzl/kY6YEV7oTrraEPWEXC7I8TawoUkV901nRIjJtxu
 F6LNocLiSmlZcFU8zlbs+LkWeXSrEGY8xtzbwnE2VH1Cpu2gzeQwmw17ZpzHXN60v43U
 xIVfiGHIZrOan8+sqh8G6D/YVThV5GhT3nOCwqQYj9jP+SUGFV0VOjLcY0h33cljDNFd
 2p6YUSiWs5dqztS8jtqEGkMqQ38fMTnT6hNv54tqrlA0U7Q/iQFSlv5C3YEsfYrr15Uu
 TQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=337KvErcJJVNkQKOM4GfPx6Z3ZDWBJ1Cy0HJ9YJmzK0=;
 b=RvxzFlSl8GM13Teb1aGlrB6O9T8rJqPe3tR/FQZxzGpNL1e/0X7IaTSlsLK8ZVG9xL
 kdn5rulLGdkCR9Y0vawBHVk+BG/xIXTatbx1RpG0b4M9HRjf4XIzGubnpSXGRh+yLTWi
 RKT9cCARO2t9g7xkXKSPr1wrvDj5bKC1cUGEW3W4iBW1YZOP89aN2el+KSzTQSmDxeOM
 eYZkmwwXKkscBPq+1llvvJVItRndtydIZPFtQvcRS7f8MqipEwTHCrgjbkNWZb++S8uc
 ZKzBYD2EuskU5z1GyDK3rRbLxl31Bu6MlFGsRnVHTkGRvNwd8VaVd1TOaUj9r380kvCI
 kD3g==
X-Gm-Message-State: AOAM532DFLxupR6fyR8r6nfIb1shONEHFfwGhyCrVjHZShncHzYiEtG7
 PdbidiwmS2O/4zXfdTjSCcjIFRiz1+E1MrN8oDphqg==
X-Google-Smtp-Source: ABdhPJyWvSE2lcUhdhozPnRVTsM7BllOKSAdKFVskG/RXnXERBjcaq+Jca+g1tv9OcwbTW+QpQgHh7vZKI0k/FsJJNE=
X-Received: by 2002:a17:906:d8ca:: with SMTP id
 re10mr1331365ejb.382.1598965629602; 
 Tue, 01 Sep 2020 06:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200831110716.536808-1-laurent@vivier.eu>
In-Reply-To: <20200831110716.536808-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Sep 2020 14:06:49 +0100
Message-ID: <CAFEAcA88ZzORi0FYKevoGkoRAoUHuT=-GXKuYjvx-uBCNJBeyg@mail.gmail.com>
Subject: Re: [PULL 0/8] Linux user for 5.2 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 31 Aug 2020 at 12:08, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 39335fab59e11cfda9b7cf63929825db2dd3a3e0:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.2-pull-=
> request' into staging (2020-08-28 22:30:11 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-5.2-pull-request
>
> for you to fetch changes up to d6676fc62a52e020df32abf927c2e7183781a2e3:
>
>   linux-user: Add support for btrfs ioctls used to scrub a filesystem (2020-0=
> 8-29 10:14:52 +0200)
>
> ----------------------------------------------------------------
> Add btrfs support

Fails to build with clang, I'm afraid:

In file included from ../../linux-user/syscall.c:4561:
../../linux-user/syscall_types.h:485:33: error: implicit conversion
from enumeration type 'enum btrfs_dev_stat_values' to different
enumeration type 'argtype' (aka 'enum argtype')
[-Werror,-Wenum-conversion]
       MK_ARRAY(TYPE_ULONGLONG, BTRFS_DEV_STAT_VALUES_MAX), /* values */
       ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/home/petmay01/linaro/qemu-for-merges/include/exec/user/thunk.h:45:42:
note: expanded from macro 'MK_ARRAY'
#define MK_ARRAY(type, size) TYPE_ARRAY, size, type
                                         ^~~~
../../linux-user/syscall.c:4559:79: note: expanded from macro 'STRUCT'
#define STRUCT(name, ...) static const argtype struct_ ## name ##
_def[] = {  __VA_ARGS__, TYPE_NULL };

    ~  ^~~~~~~~~~~
1 error generated.

thanks
-- PMM

