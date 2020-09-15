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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97606C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4663A2145D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6SiPNy9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4663A2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIDem-0005Cx-5z
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 12:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kIDdX-0004C8-MF
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:16:55 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33159)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kIDdQ-0003AE-Va
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:16:55 -0400
Received: by mail-ot1-x341.google.com with SMTP id m12so3814510otr.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 09:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nHLnh84dAOxATum+plR8Pd3g2ntM1Dq6fM0bKJLLgv8=;
 b=o6SiPNy9jm9ecT7GwYtEp/l7RVwvcHZVsCh+/qFAOX7X/aaZr85tJpMEPwFEa624Mx
 s8DiwpM7MJEqS0IkkzMX1fswcW4J+0eMtsSNd31iTuBYSWIC7PzJ8+pZWYUohXI0tCGX
 Wgi+y0EAHGDvUhhNCJfRA/XePkDSiIwRym1JjfNDC0EnQ3oVRpwuogYivpQwPQNGQTbV
 H1RmxZoGAnQ8mt50Z0+7lYdPSLZOY0Qaqbz8l2d2qmvjVznLDTKFcfpBo6UjWlJzxQ/0
 g4PjRvSUzutaoSR52FqcRWiV8XlxLfPcOKGVsX8rgmOYA58XHDZXNro+LZkkjtPdzOnk
 kisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nHLnh84dAOxATum+plR8Pd3g2ntM1Dq6fM0bKJLLgv8=;
 b=bJYAxIuVaTWzTC7fgLHM8nQUIyOglw5OmKX64T/+psG7tBowL3ZpEfTWTgG670BRH9
 RbR8bMhgME1a5zsHsU44z+fV/44FDNDalRGi7MORnXsKaWa+onGdH+nCfemybfX8DIji
 u/P2p+2EuXIfoSiSnDL2reoYMFoRNEWbe8NB/lxCFlxqqM9u01TYWey39nbdB8pKvZTr
 zR4ltT3QG+w2pKaB2HWFKMu86v4lOm3zPHInBxtwXtNnQuMcSQuRpzG3epoeLDA5aGcY
 e4EdPOLj6cavpgws+6B8nsKzg+I5IUwmeaHzbDYDbBoiQnpN+/1ZTE5PuwgNOudK0Uuo
 gCvA==
X-Gm-Message-State: AOAM53122TYiRfIU4DYPIUysTDTrmyLzVSbixwStTeqW696uqTwghAia
 r0G3deVEgYKudrnmSUWGWmV4/SqkZ3cAmIlyPh8=
X-Google-Smtp-Source: ABdhPJx+LVwsamKAm8Ow2DHR6dXoCa6FvTPSKMNJe+Ki9HUx/pwAChuBJs+rbMM2/EzeHJfYiP2TEvdxNCoozHWf3tI=
X-Received: by 2002:a05:6830:610:: with SMTP id
 w16mr12553285oti.353.1600186607606; 
 Tue, 15 Sep 2020 09:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <1600137887-58739-1-git-send-email-zhengchuan@huawei.com>
 <1600137887-58739-2-git-send-email-zhengchuan@huawei.com>
In-Reply-To: <1600137887-58739-2-git-send-email-zhengchuan@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 16 Sep 2020 00:16:10 +0800
Message-ID: <CAKXe6S+KRT-A-6v+jY2+Ryd2f4sA=kDJ_dra4sehELkbir1xYg@mail.gmail.com>
Subject: Re: [PATCH v9 01/12] migration/dirtyrate: setup up query-dirtyrate
 framwork
To: Chuan Zheng <zhengchuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x341.google.com
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
> Add get_dirtyrate_thread() functions to setup query-dirtyrate
> framework.
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: David Edmondson <david.edmondson@oracle.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  migration/dirtyrate.c | 38 ++++++++++++++++++++++++++++++++++++++
>  migration/dirtyrate.h | 29 +++++++++++++++++++++++++++++
>  migration/meson.build |  2 +-
>  3 files changed, 68 insertions(+), 1 deletion(-)
>  create mode 100644 migration/dirtyrate.c
>  create mode 100644 migration/dirtyrate.h
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> new file mode 100644
> index 0000000..bf7fd24
> --- /dev/null
> +++ b/migration/dirtyrate.c
> @@ -0,0 +1,38 @@
> +/*
> + * Dirtyrate implement code
> + *
> + * Copyright (c) 2020 HUAWEI TECHNOLOGIES CO.,LTD.
> + *
> + * Authors:
> + *  Chuan Zheng <zhengchuan@huawei.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "cpu.h"
> +#include "qemu/config-file.h"
> +#include "exec/memory.h"
> +#include "exec/ramblock.h"
> +#include "exec/target_page.h"
> +#include "qemu/rcu_queue.h"
> +#include "qapi/qapi-commands-migration.h"
> +#include "migration.h"
> +#include "dirtyrate.h"
> +
> +static void calculate_dirtyrate(struct DirtyRateConfig config)
> +{
> +    /* todo */
> +    return;
> +}
> +
> +void *get_dirtyrate_thread(void *arg)
> +{
> +    struct DirtyRateConfig config =3D *(struct DirtyRateConfig *)arg;
> +
> +    calculate_dirtyrate(config);
> +
> +    return NULL;
> +}
> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
> new file mode 100644
> index 0000000..5be9714
> --- /dev/null
> +++ b/migration/dirtyrate.h
> @@ -0,0 +1,29 @@
> +/*
> + *  Dirtyrate common functions
> + *
> + *  Copyright (c) 2020 HUAWEI TECHNOLOGIES CO., LTD.
> + *
> + *  Authors:
> + *  Chuan Zheng <zhengchuan@huawei.com>
> + *
> + *  This work is licensed under the terms of the GNU GPL, version 2 or l=
ater.
> + *  See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef QEMU_MIGRATION_DIRTYRATE_H
> +#define QEMU_MIGRATION_DIRTYRATE_H
> +
> +/*
> + * Sample 512 pages per GB as default.
> + * TODO: Make it configurable.
> + */
> +#define DIRTYRATE_DEFAULT_SAMPLE_PAGES            512
> +
> +struct DirtyRateConfig {
> +    uint64_t sample_pages_per_gigabytes; /* sample pages per GB */
> +    int64_t sample_period_seconds; /* time duration between two sampling=
 */
> +};
> +
> +void *get_dirtyrate_thread(void *arg);
> +#endif
> +
> diff --git a/migration/meson.build b/migration/meson.build
> index ac8ff14..b5b71c8 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -37,4 +37,4 @@ softmmu_ss.add(when: ['CONFIG_RDMA', rdma], if_true: fi=
les('rdma.c'))
>  softmmu_ss.add(when: 'CONFIG_LIVE_BLOCK_MIGRATION', if_true: files('bloc=
k.c'))
>  softmmu_ss.add(when: 'CONFIG_ZSTD', if_true: [files('multifd-zstd.c'), z=
std])
>
> -specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files('ram.c'))
> +specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files('dirtyrate.c', 'r=
am.c'))
> --
> 1.8.3.1
>

