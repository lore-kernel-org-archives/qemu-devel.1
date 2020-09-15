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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D79AC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:39:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9437206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTf5RrsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9437206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIDyx-0004eT-Ha
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 12:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kIDyA-0004AT-72
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:38:14 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36057)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kIDy8-0006tH-Le
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:38:13 -0400
Received: by mail-ot1-x343.google.com with SMTP id 60so3864375otw.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=trtCF4Dqi283hADrgQODZdJ7KN+OAZpm5JvtOG5IqsQ=;
 b=LTf5RrsQ9Pb+TtWykTd+9LtMknP8X51fTnQHLbdei9R5GEAcEJKDUW/gVBmn5rGogp
 6oMsnhH1tRXrsIDmDmvX7rRxaj0e89K2QWntwJqSHooQWnrqD2DUVe8a6bA35ezENt2W
 BnyPArSRphn+VcjGQ+liZgT1IX+Ph9DhkPa3OG8mOSaY63dpphrnaKA/ahTh/4bCRH9+
 QI8Ewb2gErejQebLS/NV5gQyCrdy3RVqUxhHe34A62w4pcIYjjsYBz0sLtLLPj5RE4xf
 ycnl99WcwKp4fSdnJ0lm/NZUrl46ZG0JyDulEQT/1I02P11yZBLEjkyktE44LWi5sHUA
 ioUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=trtCF4Dqi283hADrgQODZdJ7KN+OAZpm5JvtOG5IqsQ=;
 b=B2DgvB7tMY4pIlY/uDziWJX2jM23nXap7D+IEe6Qy0CiytquLqeLt2TgM56IOgcTS7
 nwrwYSix16tfENUsfuOxehwdebcMh9TAZxtGP2dbN7yokMcciPWsw9uTNtkowSCEdiAx
 fK/eKlxZ+OSWIQB4R9+aHqbJDgEfNn2lLPxhSOK49Vf+pXIcukHguNa0p/ZYpMYRqLJ4
 Kg8vMMKZQGmiBLCAru/6ekLMCy8DVbT0f3jBdIVzP6xR+mWCykl1JGAb+K9mQzfKHOu8
 xCM+TYYALSnsR5XrIfDfc81/1hQ3MB0lOM5zKTSE2n4/c38wyF/vGsX5fTVvneptu/TX
 SwQQ==
X-Gm-Message-State: AOAM532zJZynTw6yX0a2tkvJvKs7/ltS4vjbuzrhs7QlWP0OHelKibrW
 9GXXa5jA94SP6ZA+iLMan1usHl8XvcY6BPKo2zg=
X-Google-Smtp-Source: ABdhPJyaiW7AOC1Bip/co3wX3OgUe0yzkuKy8ep+U//m3Ogq6CtyXkyZ/jNumQTWYdppfW++1TsDyuFopcD9yZdi3vE=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr13092758oti.333.1600187891467; 
 Tue, 15 Sep 2020 09:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <1600137887-58739-1-git-send-email-zhengchuan@huawei.com>
 <1600137887-58739-10-git-send-email-zhengchuan@huawei.com>
In-Reply-To: <1600137887-58739-10-git-send-email-zhengchuan@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 16 Sep 2020 00:37:35 +0800
Message-ID: <CAKXe6SLctnUgyp0qoHF_-KqqqUG5vkovRK6W1Jt_L-W8=1wA9g@mail.gmail.com>
Subject: Re: [PATCH v9 09/12] migration/dirtyrate: Implement
 set_sample_page_period() and is_sample_period_valid()
To: Chuan Zheng <zhengchuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x343.google.com
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
> Implement is_sample_period_valid() to check if the sample period is vaild=
 and
> do set_sample_page_period() to sleep specific time between sample actions=
.
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: David Edmondson <david.edmondson@oracle.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  migration/dirtyrate.c | 24 ++++++++++++++++++++++++
>  migration/dirtyrate.h |  6 ++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 903f728..bcff10e 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -27,6 +27,30 @@
>  static int CalculatingState =3D DIRTY_RATE_STATUS_UNSTARTED;
>  static struct DirtyRateStat DirtyStat;
>
> +static int64_t set_sample_page_period(int64_t msec, int64_t initial_time=
)
> +{
> +    int64_t current_time;
> +
> +    current_time =3D qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +    if ((current_time - initial_time) >=3D msec) {
> +        msec =3D current_time - initial_time;
> +    } else {
> +        g_usleep((msec + initial_time - current_time) * 1000);
> +    }
> +
> +    return msec;
> +}
> +
> +static bool is_sample_period_valid(int64_t sec)
> +{
> +    if (sec < MIN_FETCH_DIRTYRATE_TIME_SEC ||
> +        sec > MAX_FETCH_DIRTYRATE_TIME_SEC) {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  static int dirtyrate_set_state(int *state, int old_state, int new_state)
>  {
>      assert(new_state < DIRTY_RATE_STATUS__MAX);
> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
> index faaf9da..8f9bc80 100644
> --- a/migration/dirtyrate.h
> +++ b/migration/dirtyrate.h
> @@ -29,6 +29,12 @@
>   */
>  #define MIN_RAMBLOCK_SIZE                         128
>
> +/*
> + * Take 1s as minimum time for calculation duration
> + */
> +#define MIN_FETCH_DIRTYRATE_TIME_SEC              1
> +#define MAX_FETCH_DIRTYRATE_TIME_SEC              60
> +
>  struct DirtyRateConfig {
>      uint64_t sample_pages_per_gigabytes; /* sample pages per GB */
>      int64_t sample_period_seconds; /* time duration between two sampling=
 */
> --
> 1.8.3.1
>

