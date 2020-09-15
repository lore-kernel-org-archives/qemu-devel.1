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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE59C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7704A206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKjoAF5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7704A206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIDi8-0008D3-IB
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 12:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kIDgY-00078x-TL
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:20:02 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kIDgW-0003cg-V8
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:20:02 -0400
Received: by mail-ot1-x341.google.com with SMTP id w25so3772629otk.8
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 09:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fVkDBD+5+8F7+gkxjumJTdXWXoNhPzUhGRjUMh+BGNE=;
 b=KKjoAF5azo5PoXtcegdUCPXD4Ixx4/1RK/usYna0hpbaRNZQtc5bMmOK4d6/aHFT2m
 ns12tvyk/2FPEAsAPhJ0h75//nl+zgvOhC7EI6ZpQ7l8bRljmaF6y/vhRwvWbS4fKAUT
 akB7zI1z4jOANXdrkkLw4VOo8RLVXfmhtS0HEqOQu8KaNJb1Dg/LBRx5JbsUMpds4EcR
 8aAoEm00/UxRlsRPDf1kkRRcT/gYC00vzX4lj7SIoTn9K7tbo0Tc/wxdUXelUPG31nnO
 ebKnptct5q2b5XPO5x3RI/16h6Op9U49bJbxHU1MVgM6kW5cxB2uHdglRZsv1BjsV3Bb
 1gZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fVkDBD+5+8F7+gkxjumJTdXWXoNhPzUhGRjUMh+BGNE=;
 b=ML4RvbtuHmlA1yTsJjKD8PqBOB9xHAuLSksPQqSDQpK0Wfk/6WUzRCf0Xf7KjXdU1t
 GLBXJU8l6RZwBkt7XvJJycDoxEj4DhUZHXggpzT/aS9GVs9aqgndpp5VjoELjea/38+1
 H6eqBI7jhZHfIQikN1qzH4kSy0Cmffxs3rP+Hqk8HhXg6HDy4dtgrzjuW4kLZAO+i8ZQ
 p8nLCEqZy9GzEi/C7Cna5WG+rd2XiOM8d5Jygf92oZPKqDPyVhCvLh7UYV1aaSjBA9Sz
 bfosgv1ciG+g/2vshYZ+oNmfULcQn3emcJgC7BWZpDphYNTjlGZqzM9anpulFtTxcWK9
 o5Bg==
X-Gm-Message-State: AOAM531UXeshUEd42MAih4XrQM3MUvpnrpmO5Uju7iSVrCBhGtVMP/GI
 T9FXXLcAmKYDp9zrN+vI8FjhNmlVsae8p//6e80=
X-Google-Smtp-Source: ABdhPJz0AgB+Tjrz4fkW3N64Yhbn68aRORVNVDEw/ULMg3SfDKLGVkMxj8wSsdaaDIhPhGaCqA2QFeIAeZek+RuuUw4=
X-Received: by 2002:a05:6830:610:: with SMTP id
 w16mr12562100oti.353.1600186799713; 
 Tue, 15 Sep 2020 09:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <1600137887-58739-1-git-send-email-zhengchuan@huawei.com>
 <1600137887-58739-5-git-send-email-zhengchuan@huawei.com>
In-Reply-To: <1600137887-58739-5-git-send-email-zhengchuan@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 16 Sep 2020 00:19:23 +0800
Message-ID: <CAKXe6S+KUr=12NQJB9NiK3hgULEFbR8kVL1om-OSBP55wH+1yA@mail.gmail.com>
Subject: Re: [PATCH v9 04/12] migration/dirtyrate: Add dirtyrate statistics
 series functions
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
> Add dirtyrate statistics functions to record/update dirtyrate info.
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  migration/dirtyrate.c | 32 ++++++++++++++++++++++++++++++++
>  migration/dirtyrate.h | 12 ++++++++++++
>  2 files changed, 44 insertions(+)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 7bea8ff..ab372ba 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -23,6 +23,7 @@
>  #include "dirtyrate.h"
>
>  static int CalculatingState =3D DIRTY_RATE_STATUS_UNSTARTED;
> +static struct DirtyRateStat DirtyStat;
>
>  static int dirtyrate_set_state(int *state, int old_state, int new_state)
>  {
> @@ -34,6 +35,37 @@ static int dirtyrate_set_state(int *state, int old_sta=
te, int new_state)
>      }
>  }
>
> +static void reset_dirtyrate_stat(void)
> +{
> +    DirtyStat.total_dirty_samples =3D 0;
> +    DirtyStat.total_sample_count =3D 0;
> +    DirtyStat.total_block_mem_MB =3D 0;
> +    DirtyStat.dirty_rate =3D -1;
> +    DirtyStat.start_time =3D 0;
> +    DirtyStat.calc_time =3D 0;
> +}
> +
> +static void update_dirtyrate_stat(struct RamblockDirtyInfo *info)
> +{
> +    DirtyStat.total_dirty_samples +=3D info->sample_dirty_count;
> +    DirtyStat.total_sample_count +=3D info->sample_pages_count;
> +    /* size of total pages in MB */
> +    DirtyStat.total_block_mem_MB +=3D (info->ramblock_pages *
> +                                     TARGET_PAGE_SIZE) >> 20;
> +}
> +
> +static void update_dirtyrate(uint64_t msec)
> +{
> +    uint64_t dirtyrate;
> +    uint64_t total_dirty_samples =3D DirtyStat.total_dirty_samples;
> +    uint64_t total_sample_count =3D DirtyStat.total_sample_count;
> +    uint64_t total_block_mem_MB =3D DirtyStat.total_block_mem_MB;
> +
> +    dirtyrate =3D total_dirty_samples * total_block_mem_MB *
> +                1000 / (total_sample_count * msec);
> +
> +    DirtyStat.dirty_rate =3D dirtyrate;
> +}
>
>  static void calculate_dirtyrate(struct DirtyRateConfig config)
>  {
> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
> index 479e222..a3ee305 100644
> --- a/migration/dirtyrate.h
> +++ b/migration/dirtyrate.h
> @@ -42,6 +42,18 @@ struct RamblockDirtyInfo {
>      uint32_t *hash_result; /* array of hash result for sampled pages */
>  };
>
> +/*
> + * Store calculation statistics for each measure.
> + */
> +struct DirtyRateStat {
> +    uint64_t total_dirty_samples; /* total dirty sampled page */
> +    uint64_t total_sample_count; /* total sampled pages */
> +    uint64_t total_block_mem_MB; /* size of total sampled pages in MB */
> +    int64_t dirty_rate; /* dirty rate in MB/s */
> +    int64_t start_time; /* calculation start time in units of second */
> +    int64_t calc_time; /* time duration of two sampling in units of seco=
nd */
> +};
> +
>  void *get_dirtyrate_thread(void *arg);
>  #endif
>
> --
> 1.8.3.1
>

