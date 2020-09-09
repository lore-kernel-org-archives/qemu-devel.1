Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B86C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 03:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EE9F206F4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 03:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prt0kl5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE9F206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFqSN-0000BF-Fp
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 23:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kFqRp-0008Bn-Uw; Tue, 08 Sep 2020 23:07:01 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kFqRo-00032Q-7W; Tue, 08 Sep 2020 23:07:01 -0400
Received: by mail-oi1-x241.google.com with SMTP id n2so966532oij.1;
 Tue, 08 Sep 2020 20:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Z03oq+piBHwHN7tUkell3SWW7HfI+0ttVRMaZFtkHZg=;
 b=prt0kl5UksBU8/A1lKAaaORBQNQlCmVjAH40OU4pnC+2a3zbchnLcUeIrez7uduBXl
 cxf20d0z4U00vguP2qc1/HIU7Y9qiDvoXe/tXenHjGO604WErGzXWlkSImUZz+OwnMSx
 P5ikjMYhN3ksSJXWgOr51dByImv3yT4hbJkzYSHwb3Z1hKUmzDTjXCsciZKARLHmCbYG
 6jKIzTtJu9OUxNY8ow8HiY3cbsxjp4aSnN9xnIpeuIcCUWS8qiYTO2xfmi5nBXVdcqnh
 3QFuyNJX3nWk5BkKX9FAtQHJeRfcXaBafOkUEj3PZh1ZAMBPfkgec5rzpasW/Knbrr4l
 yzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z03oq+piBHwHN7tUkell3SWW7HfI+0ttVRMaZFtkHZg=;
 b=rAqMCsIKPub06Nvh6Qu9rYLQ5yyNBbPGKYINt+pC8jdhVt4mUKouB95Oqj4FGoluhm
 PacBxekZc5vnk4XTGAFpbH0JhOZ5M000q0PdMQJr9j4HT2HQTggb/jDWq77VtVk/MHDl
 nTlJd27edbWfI96bgmPrKoGwsF5QnHS/uS8Jfcbo8K5hvuKNbZ64g6+nWnPK3d0A37T3
 ZWh9T4qKauZBmwMpxskCrRtVrkx/xr4vY/jOy/JqdlV6R9pTrLuWw9RESnP5ZQp6eZDv
 RGWe4+KYcAL3K/LjXd0vnjT3ebqnLK61o4wMUfyzIxqLlY1xSW93WP8YZ2RX3t8SxM5R
 Wz0Q==
X-Gm-Message-State: AOAM5322d/7h8M1YVrhCsS05s+uYX/+mL+7gZqNthcYkDYoceguRi6C/
 ibrLtbikBh0tdVMbYhHt0bMpbVhXoMu2+2Nwp1A=
X-Google-Smtp-Source: ABdhPJzoC84JOP1ZxNIyg1peRoFjS3d2JaUqWyMcumn0SQ35wmlQ6MUWTAmotvjILKFvGFfl540R+DgmEHKB+0YVNis=
X-Received: by 2002:aca:4894:: with SMTP id v142mr1336623oia.157.1599620818675; 
 Tue, 08 Sep 2020 20:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599211479.git.dimastep@yandex-team.ru>
 <f487966c45823b095cfbf72dcdcd17bd47591c14.1599211479.git.dimastep@yandex-team.ru>
In-Reply-To: <f487966c45823b095cfbf72dcdcd17bd47591c14.1599211479.git.dimastep@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Tue, 8 Sep 2020 23:06:47 -0400
Message-ID: <CAFubqFvceEaDg7fHetTrox_yr12AFsLORra6-WD7_Xux7E5uhg@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] tests/qtest/vhost-user-test: enable the reconnect
 tests
To: Dima Stepanov <dimastep@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-oi1-x241.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
 QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, fengli@smartx.com,
 yc-core@yandex-team.ru,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This works for me, and looks good, but I figure those who added the
check should confirm that these tests are reliable now.

Marc-Andre - thoughts?

On Fri, Sep 4, 2020 at 5:36 AM Dima Stepanov <dimastep@yandex-team.ru> wrote:
>
> For now a QTEST_VHOST_USER_FIXME environment variable is used to
> separate reconnect tests for the vhost-user-net device. Looks like the
> reconnect functionality is pretty stable, so this separation is
> deprecated.
> Remove it and enable these tests for the default run.
>
> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> ---
>  tests/qtest/vhost-user-test.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
>
> diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
> index 4b715d3..4b96312 100644
> --- a/tests/qtest/vhost-user-test.c
> +++ b/tests/qtest/vhost-user-test.c
> @@ -1140,20 +1140,17 @@ static void register_vhost_user_test(void)
>                   "virtio-net",
>                   test_migrate, &opts);
>
> -    /* keeps failing on build-system since Aug 15 2017 */
> -    if (getenv("QTEST_VHOST_USER_FIXME")) {
> -        opts.before = vhost_user_test_setup_reconnect;
> -        qos_add_test("vhost-user/reconnect", "virtio-net",
> -                     test_reconnect, &opts);
> -
> -        opts.before = vhost_user_test_setup_connect_fail;
> -        qos_add_test("vhost-user/connect-fail", "virtio-net",
> -                     test_vhost_user_started, &opts);
> -
> -        opts.before = vhost_user_test_setup_flags_mismatch;
> -        qos_add_test("vhost-user/flags-mismatch", "virtio-net",
> -                     test_vhost_user_started, &opts);
> -    }
> +    opts.before = vhost_user_test_setup_reconnect;
> +    qos_add_test("vhost-user/reconnect", "virtio-net",
> +                 test_reconnect, &opts);
> +
> +    opts.before = vhost_user_test_setup_connect_fail;
> +    qos_add_test("vhost-user/connect-fail", "virtio-net",
> +                 test_vhost_user_started, &opts);
> +
> +    opts.before = vhost_user_test_setup_flags_mismatch;
> +    qos_add_test("vhost-user/flags-mismatch", "virtio-net",
> +                 test_vhost_user_started, &opts);
>
>      opts.before = vhost_user_test_setup_multiqueue;
>      opts.edge.extra_device_opts = "mq=on";
> --
> 2.7.4
>
>

