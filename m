Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22238C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 14:29:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73FF42076C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 14:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JotFhSkQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FF42076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGNZd-0000Ne-Cn
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 10:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kGNYu-00083U-R8
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 10:28:32 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36844)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kGNYs-0007iX-84
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 10:28:32 -0400
Received: by mail-ot1-x341.google.com with SMTP id 60so5503631otw.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 07:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jbNwUorQzel5mddsxvnyhJk4nuW9LfOrfQ8LzTeQf4k=;
 b=JotFhSkQeQ2vhxL6V/A9TF/Yhe4r/eMxoC0MU4nWxKEOikrkCamD++jRxEDJsJOs95
 MirbO0Pbss9bXbIlELQ6Z2HimAw0LXT2l9PzagW/B65AzpO71wiAthJCiNwnSLUJKP8g
 YtKdvFTBuWMJn1/LHBa8Nu64SJqcqjjF0Bcr95jKP1nvZrRbr2YncHRs1iJC69Z+wNB/
 Mcc3s+cHGcmLm/ttrOJgAJPWINnIQ92JRIgohKZl42bewlPxFIE8hTOS3z7qxVtb/0uJ
 3MbAVSVbECSsDQziYjuInCm1sHQsE800qFm6mxBP8w1sptMOhmDWTtCPs/9CLrkK82Fx
 G8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jbNwUorQzel5mddsxvnyhJk4nuW9LfOrfQ8LzTeQf4k=;
 b=cIQA+2fRfCEWkYSGR2Afco1lyj92r8nt/BWwTtjvoOKnjL3kj/EQJLDsQfxVeLRV+p
 /o9lVwnpBYoEMYSD20TYX8woyEnE+qUSJiqr4re+xep78ywdGnO2o+90xi4YsGZfZjsG
 e/yjwARIs0qOWza6ret3NAhqSPor0JPkabK23PvPbOiP45YI7xZX2udlgUpg69Lk/f2n
 ROkcaVic3N3BfvEI54GCuZWgn3u03ulQr5m/eSfz8JjiuRb8YPFfLAjF0SZouyf2lf+k
 +UiAHlUPPOcp6M1G6cfD/Ge9Av6Fuxm6mOgVkRO3tuVtqsovd/hSsXl/nn0d4kV+BXXJ
 twnw==
X-Gm-Message-State: AOAM531JddChXx+bBf4kkbZqMzYyQDKBLTSSIkNWkIVOXUg55i98wdn4
 985lmd5bEP1pw6dShjneGoRpWoADgeGDWZrmiHk=
X-Google-Smtp-Source: ABdhPJz/jZpoMGJKFSvSNy8/yMJoL0ZAbEXYTvpL/cq2SsnflF+XlhY/jP46lfjtpKegpPtLkK+8ZtlK/swZE/nkD9o=
X-Received: by 2002:a05:6830:2302:: with SMTP id
 u2mr3941988ote.181.1599748109101; 
 Thu, 10 Sep 2020 07:28:29 -0700 (PDT)
MIME-Version: 1.0
References: <1599661096-127913-1-git-send-email-zhengchuan@huawei.com>
 <1599661096-127913-3-git-send-email-zhengchuan@huawei.com>
In-Reply-To: <1599661096-127913-3-git-send-email-zhengchuan@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 10 Sep 2020 22:27:52 +0800
Message-ID: <CAKXe6SJeuupVBza=i+5s1j1B1ZVgnNntSSt=jVBi+MxphQD_ww@mail.gmail.com>
Subject: Re: [PATCH v7 02/12] migration/dirtyrate: add DirtyRateStatus to
 denote calculation status
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
 zhanghailiang <zhang.zhanghailiang@huawei.com>, dme@dme.org,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, xiexiangyou@huawei.com,
 Qemu Developers <qemu-devel@nongnu.org>, AlexChen <alex.chen@huawei.com>,
 ann.zhuangyanying@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Chuan Zheng <zhengchuan@huawei.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=889=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8810:08=E5=86=99=E9=81=93=EF=BC=9A
>
> add DirtyRateStatus to denote calculating status.
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/dirtyrate.c | 22 ++++++++++++++++++++++
>  qapi/migration.json   | 17 +++++++++++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index bf7fd24..0a3350a 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -22,6 +22,19 @@
>  #include "migration.h"
>  #include "dirtyrate.h"
>
> +static int CalculatingState =3D DIRTY_RATE_STATUS_UNSTARTED;
> +
> +static int dirtyrate_set_state(int *state, int old_state, int new_state)
> +{
> +    assert(new_state < DIRTY_RATE_STATUS__MAX);
> +    if (atomic_cmpxchg(state, old_state, new_state) =3D=3D old_state) {
> +        return 0;
> +    } else {
> +        return -1;
> +    }
> +}
> +
> +
>  static void calculate_dirtyrate(struct DirtyRateConfig config)
>  {
>      /* todo */
> @@ -31,8 +44,17 @@ static void calculate_dirtyrate(struct DirtyRateConfig=
 config)
>  void *get_dirtyrate_thread(void *arg)
>  {
>      struct DirtyRateConfig config =3D *(struct DirtyRateConfig *)arg;
> +    int ret;
> +
> +    ret =3D dirtyrate_set_state(&CalculatingState, DIRTY_RATE_STATUS_UNS=
TARTED,
> +                              DIRTY_RATE_STATUS_MEASURING);
> +    if (ret =3D=3D -1) {
> +        return NULL;
> +    }
>
>      calculate_dirtyrate(config);
>
> +    ret =3D dirtyrate_set_state(&CalculatingState, DIRTY_RATE_STATUS_MEA=
SURING,
> +                              DIRTY_RATE_STATUS_MEASURED);

Doesn't need to check the 'ret'?
Just curious you checked other places but not here.

Thanks,
Li Qiang

>      return NULL;
>  }
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 5f6b061..061ff25 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1720,3 +1720,20 @@
>  ##
>  { 'event': 'UNPLUG_PRIMARY',
>    'data': { 'device-id': 'str' } }
> +
> +##
> +# @DirtyRateStatus:
> +#
> +# An enumeration of dirtyrate status.
> +#
> +# @unstarted: the dirtyrate thread has not been started.
> +#
> +# @measuring: the dirtyrate thread is measuring.
> +#
> +# @measured: the dirtyrate thread has measured and results are available=
.
> +#
> +# Since: 5.2
> +#
> +##
> +{ 'enum': 'DirtyRateStatus',
> +  'data': [ 'unstarted', 'measuring', 'measured'] }
> --
> 1.8.3.1
>
>

