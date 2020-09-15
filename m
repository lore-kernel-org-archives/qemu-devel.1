Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC9DC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:22:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C0FE206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFGYwFot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0FE206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIDid-0000DX-8g
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 12:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kIDh5-0007dz-HT
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:20:35 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41570)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kIDh3-0003rI-QR
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:20:35 -0400
Received: by mail-oi1-x243.google.com with SMTP id x69so4501400oia.8
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 09:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=d4X1Ucqxt32mwSJd9qppgsc2SU8MaE++M4ORwc45mAc=;
 b=LFGYwFotXlWKgMuLQgbKC2nqnvg089hlOZkh/qprhtAnlDr3yO12kS80uq89g/0YMc
 0glU3TxDSv8MbF6a6GL9nnkr23Q+UfkeQ3dYsFjFc6IfGTod5boNaBp8d2IrDPNOH4oX
 yxQ4IVJqBv6TZxM0b3QyaZ2R8lMFdMuieyt4WCbH4qkmBKzAFRKwV1mAVVE0509w/dKJ
 14OEIPhg+eH4ONx1TK4AoOWN49KiyfwyQazoY/W5z1T+nIxbNfbeOq4yslIbB9yUtSzT
 no6WWB/X2lqDkRFH6exjfEKuvGAU2byPPP8LIStl7UpSrUfjZnaZZZX+tuRU/0AsZCmi
 5/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=d4X1Ucqxt32mwSJd9qppgsc2SU8MaE++M4ORwc45mAc=;
 b=WXsUXXM6BlJDQPjQxlMd1s6xFnyGBO1DEgNJMgr7rM8wah6LLnB7QxK9k6/pir6egV
 OmqIaGxMzbVkNGknWhItYetgcv6cmTloTd9gWgZCOgWnhwd76vy/e8l50DaDe5OGKjEU
 xIqnWVCYq5bJ1JgoxFOddjIcMLwVEy12ew1+wkjUeJ818DrvG57oz6uWY8gSv77FbUs5
 45oI6I7njdgCWAyLsnEdfkAkdIqQPSZtLtvaHpJ54/SEWtuScpawpWVxzuWfr4QF1gwb
 GbZLLDWOVx1/TzSXmh7jule1AvIZWgyp8a2MDGBLMtED5IkcjmuimREnbIiizpkFongb
 dmbA==
X-Gm-Message-State: AOAM532/Kuyzl5HNtkKbuUuWpAmfHGI3D25TRNTyAqjPCwL3ei15cHQI
 rlo5GoiUEQmmgeqiSndVG2wlXVdKzQFwGGpt19glE8op5DjwVA==
X-Google-Smtp-Source: ABdhPJxPIcjEOKS7NIX4Xhkj3YxC9MCqBT9TZhWtji5ry0jYVCvS0MAJVogGDQgJOZQzwTxxraleYmp3rtR3yqifOE0=
X-Received: by 2002:aca:904:: with SMTP id 4mr121533oij.97.1600186831320; Tue,
 15 Sep 2020 09:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <1600137887-58739-1-git-send-email-zhengchuan@huawei.com>
 <1600137887-58739-6-git-send-email-zhengchuan@huawei.com>
In-Reply-To: <1600137887-58739-6-git-send-email-zhengchuan@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 16 Sep 2020 00:19:55 +0800
Message-ID: <CAKXe6SKejNcOgkbOtyv32zJP5t3B2=LqF9QMsgGFq9J+CWcXpg@mail.gmail.com>
Subject: Re: [PATCH v9 05/12] migration/dirtyrate: move
 RAMBLOCK_FOREACH_MIGRATABLE into ram.h
To: Chuan Zheng <zhengchuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Juan Quintela <quintela@redhat.com>, yuxiating@huawei.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, xiexiangyou@huawei.com,
 Qemu Developers <qemu-devel@nongnu.org>, AlexChen <alex.chen@huawei.com>,
 jinyan12@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Chuan Zheng <zhengchuan@huawei.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8815=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8810:34=E5=86=99=E9=81=93=EF=BC=9A
>
> RAMBLOCK_FOREACH_MIGRATABLE is need in dirtyrate measure,
> move the existing definition up into migration/ram.h
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: David Edmondson <david.edmondson@oracle.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  migration/dirtyrate.c |  1 +
>  migration/ram.c       | 11 +----------
>  migration/ram.h       | 10 ++++++++++
>  3 files changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index ab372ba..7366bf3 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -20,6 +20,7 @@
>  #include "qemu/rcu_queue.h"
>  #include "qapi/qapi-commands-migration.h"
>  #include "migration.h"
> +#include "ram.h"
>  #include "dirtyrate.h"
>
>  static int CalculatingState =3D DIRTY_RATE_STATUS_UNSTARTED;
> diff --git a/migration/ram.c b/migration/ram.c
> index 76d4fee..37ef0da 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -158,21 +158,12 @@ out:
>      return ret;
>  }
>
> -static bool ramblock_is_ignored(RAMBlock *block)
> +bool ramblock_is_ignored(RAMBlock *block)
>  {
>      return !qemu_ram_is_migratable(block) ||
>             (migrate_ignore_shared() && qemu_ram_is_shared(block));
>  }
>
> -/* Should be holding either ram_list.mutex, or the RCU lock. */
> -#define RAMBLOCK_FOREACH_NOT_IGNORED(block)            \
> -    INTERNAL_RAMBLOCK_FOREACH(block)                   \
> -        if (ramblock_is_ignored(block)) {} else
> -
> -#define RAMBLOCK_FOREACH_MIGRATABLE(block)             \
> -    INTERNAL_RAMBLOCK_FOREACH(block)                   \
> -        if (!qemu_ram_is_migratable(block)) {} else
> -
>  #undef RAMBLOCK_FOREACH
>
>  int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque)
> diff --git a/migration/ram.h b/migration/ram.h
> index 2eeaacf..011e854 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -37,6 +37,16 @@ extern MigrationStats ram_counters;
>  extern XBZRLECacheStats xbzrle_counters;
>  extern CompressionStats compression_counters;
>
> +bool ramblock_is_ignored(RAMBlock *block);
> +/* Should be holding either ram_list.mutex, or the RCU lock. */
> +#define RAMBLOCK_FOREACH_NOT_IGNORED(block)            \
> +    INTERNAL_RAMBLOCK_FOREACH(block)                   \
> +        if (ramblock_is_ignored(block)) {} else
> +
> +#define RAMBLOCK_FOREACH_MIGRATABLE(block)             \
> +    INTERNAL_RAMBLOCK_FOREACH(block)                   \
> +        if (!qemu_ram_is_migratable(block)) {} else
> +
>  int xbzrle_cache_resize(int64_t new_size, Error **errp);
>  uint64_t ram_bytes_remaining(void);
>  uint64_t ram_bytes_total(void);
> --
> 1.8.3.1
>

