Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2317C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 03:04:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDFD72098B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 03:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VclVsxEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDFD72098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFqPn-0006aH-V4
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 23:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kFqP6-00065x-GB; Tue, 08 Sep 2020 23:04:12 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37103)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kFqP4-00021A-Q7; Tue, 08 Sep 2020 23:04:12 -0400
Received: by mail-ot1-x344.google.com with SMTP id 37so1083461oto.4;
 Tue, 08 Sep 2020 20:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+JM2AIQO9VIVNqBIkAgtGH3T7BQzMF5cHmWdk3am+SI=;
 b=VclVsxEgMHhZjPNGuuSRmjJAcFv2gvqOm8NtONiRQy7BuSe8KvX6fJYjfP04NPG+US
 JEGo1ut/IomE4gVMvA35RJsPfhGjKOOY5aPlyPrb19FeWzafO7xTuIj+iV4yGi09k29B
 AsI1PsVTxzdOVgvad/KBWAXK350z7rhpIru1StS2sfxwWob3QYT8XLrFFQAVnyPr4NMS
 R7WSuVA1f8EiiVg5IhoCnz/FpNf32qiIbB7R95+zZiOWWtTF/sJ4XREFu3mVBgZrdIIV
 go1nfVBMlAIHG9fu2fluWS5cYNvcM4N0aLjnt/UCHcYyNPSlRjZUIaRpRiyaaa3sXIBj
 tGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+JM2AIQO9VIVNqBIkAgtGH3T7BQzMF5cHmWdk3am+SI=;
 b=QA2mwpZ1aa3EsCHK031d7nngDidpgLZivaSfjUq9uL2H1NxA5ZazDRcEZAfmtNFKpA
 v34W4ej+h6gkYRgbZNxvRXcF0Ey0XpVTpcYmcZ+mGgj/gPQKqQViZhDF9+q+Evge8Ehd
 DYRWgJPG6GXU9lY3xJ+ZELOePzeXc9+g3DymV2YuIL72iTYoNPusAM/rcY/Tapv8JPVe
 6i3zoZZjHSyLYehtI3DUclQjGcWkOoX0D92menxm1Fe2GIsr2NtpVYqkavDNIF5vMbBL
 GnAqub9nvj805n5J4s6xC3kC0a9zaO/kgz+ghD0m3NNdMAH+EUE0NhVFJsZvoQDjUHDY
 r8ng==
X-Gm-Message-State: AOAM530cVj/732Db6djuzj972uAdovyy+LmQ7pBxceti05iNnEaiXJnp
 BVo708dTEGLaWbf2fjZPoFdh1rKp6h51DUiJi9M=
X-Google-Smtp-Source: ABdhPJzxuYKylHd6NLxwOPJs11/6Aq07QnnYxIqhpWh0xkrSNuj3KktOsK9pGbXvFKSR80+RwNjoIdxhwEtiQALZwJw=
X-Received: by 2002:a9d:5c06:: with SMTP id o6mr1532743otk.262.1599620649318; 
 Tue, 08 Sep 2020 20:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599211479.git.dimastep@yandex-team.ru>
 <7b407b5b233ec7739d85a9322f8a99a588e7f3aa.1599211479.git.dimastep@yandex-team.ru>
In-Reply-To: <7b407b5b233ec7739d85a9322f8a99a588e7f3aa.1599211479.git.dimastep@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Tue, 8 Sep 2020 23:03:56 -0400
Message-ID: <CAFubqFuzoxNScgOdR3+dMNFDd0jcjQ2OdKeRZuFuXLEJ2hkNrQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] tests/qtest/vhost-user-test: add support for the
 vhost-user-blk device
To: Dima Stepanov <dimastep@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-ot1-x344.google.com
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
 yc-core@yandex-team.ru, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 4, 2020 at 5:35 AM Dima Stepanov <dimastep@yandex-team.ru> wrote:
>
> Add vhost_user_ops structure for the vhost-user-blk device class. Add
> the test_reconnect and test_migrate tests for this device.
>
> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

Just one small suggestion.

> ---
>  tests/qtest/vhost-user-test.c | 139 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 137 insertions(+), 2 deletions(-)

> @@ -857,12 +911,21 @@ static void test_reconnect(void *obj, void *arg, QGuestAllocator *alloc)
>  {
>      TestServer *s = arg;
>      GSource *src;
> +    int nq;
>
> +    if (s->vu_ops->driver_init) {
> +        s->vu_ops->driver_init(obj, alloc);
> +    }
>      if (!wait_for_fds(s)) {
>          return;
>      }
>

Maybe we could break this logic out into a helper? I imagine there may
be other cases where we might want to get a number of rings for a
given device type.


> -    wait_for_rings_started(s, 2);
> +    nq = 1;
> +    if (s->vu_ops->type == VHOST_USER_NET) {
> +        /* tx and rx queues */
> +        nq = 2;
> +    }
> +    wait_for_rings_started(s, nq);
>

