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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD174C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 03:06:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B3E206F4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 03:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKxqMKxb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B3E206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFqR3-0007hc-II
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 23:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kFqQS-0007Ab-Aa; Tue, 08 Sep 2020 23:05:36 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kFqQP-0002VF-GR; Tue, 08 Sep 2020 23:05:36 -0400
Received: by mail-oi1-x244.google.com with SMTP id 3so969389oih.0;
 Tue, 08 Sep 2020 20:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UCTbn8r6c0fQgwu53DYGIRCTncc5Mpb+Rk/GaG4qgb0=;
 b=UKxqMKxb7z6CXIfRbJwDSVbgD3NoyCpM+0LKFczlxwi5iLjLOxFP4SFOdmFeDBDbxW
 Uxatbv/6SM9QuityWAQYQAncBE//ldcJUgGzKQVRZ0r3gCmzBL1SOO06eJ4TaO79n6Yb
 +MHEZBNQVyON6hZZyXGhqu+zQQdrR/HOa//g4VNi43Ht0n/eRW46BJ3eG/ywN45SwKPH
 zgSSBnHQL8dJODC6Z5AsdKmcdKqvI8N14siTf356MBK5pKUkMD4eXrjWNu1OrELKajTg
 5t5tqBhkINk0aZ4Fdet5T4SiuRkz9RmS4Hl0a7ikNcfG+jktavI8iT0tYhgyDyLkrLdq
 IYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UCTbn8r6c0fQgwu53DYGIRCTncc5Mpb+Rk/GaG4qgb0=;
 b=iUvn9owXGw0BWMOQfqHWukMDoLOPAbxOQvnmnXW8zkDYMEocclgTF24tTXDVn7Vwlx
 DtkDYXRYBVlB8X25vLYlBLOyWWg1iidorIG9xvpEcd+5MLnTDsGKn+B7BWK4s+HBg3lF
 WuyjfVZFVsXKNSZ4Gye1Kzojzf2E/7S7nmS1DmbdjR+uuocN+TIb+aUg0U/0+f4qR3zm
 3yqu64/vjdR4S+xm4e2205C1rlVxR1Dstt05BRWbi9LqA3bvcZqXM2YP1Wlgsjjr1Oxb
 XW+C8gRquM5WYrCpwd0bDFVwq021x33EQXGG51awSgadKNqC7PQTdUXM84RzPrsywejH
 SJ9g==
X-Gm-Message-State: AOAM533UkTqSJHsP69fo/4vnGfNgOKRKyG3sN/G487VNEP1NN64eR+Po
 8fjSptAYtdrj9IzOnevw+ATk6xhYD/HuvjxNbaQ=
X-Google-Smtp-Source: ABdhPJz4kYtExoDDU1eZK/FRirql8uKyFpodyYIJwX6KKFGiqIKUGF1M5M7hI0RhqoJQOwdL8uVzmSrwdbkfDS77i5k=
X-Received: by 2002:aca:c0c1:: with SMTP id q184mr1450832oif.56.1599620731602; 
 Tue, 08 Sep 2020 20:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599211479.git.dimastep@yandex-team.ru>
 <e7c62e6286f6199b1c3caf60cbe225f10ed04846.1599211479.git.dimastep@yandex-team.ru>
In-Reply-To: <e7c62e6286f6199b1c3caf60cbe225f10ed04846.1599211479.git.dimastep@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Tue, 8 Sep 2020 23:05:20 -0400
Message-ID: <CAFubqFvYuojJsOi+AxZodcaeXL2NmJMoM72BLQi=t_GdP0XuuQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] tests/qtest/vhost-user-test: add migrate_reconnect
 test
To: Dima Stepanov <dimastep@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-oi1-x244.google.com
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

On Fri, Sep 4, 2020 at 5:36 AM Dima Stepanov <dimastep@yandex-team.ru> wrote:
>
> Add new migrate_reconnect test for the vhost-user-blk device. Perform a
> disconnect after sending response for the VHOST_USER_SET_LOG_BASE
> command.
>
> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>


> ---
>  tests/qtest/vhost-user-test.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
> index a8af613..4b715d3 100644
> --- a/tests/qtest/vhost-user-test.c
> +++ b/tests/qtest/vhost-user-test.c
> @@ -146,6 +146,7 @@ static VhostUserMsg m __attribute__ ((unused));
>  enum {
>      TEST_FLAGS_OK,
>      TEST_FLAGS_DISCONNECT,
> +    TEST_FLAGS_MIGRATE_DISCONNECT,
>      TEST_FLAGS_BAD,
>      TEST_FLAGS_END,
>  };
> @@ -436,6 +437,15 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
>          qemu_chr_fe_write_all(chr, p, VHOST_USER_HDR_SIZE);
>
>          g_cond_broadcast(&s->data_cond);
> +        /*
> +         * Perform disconnect after sending a response. In this
> +         * case the next write command on the QEMU side (for now
> +         * it is SET_FEATURES will return -1, because of disconnect.
> +         */
> +        if (s->test_flags == TEST_FLAGS_MIGRATE_DISCONNECT) {
> +            qemu_chr_fe_disconnect(chr);
> +            s->test_flags = TEST_FLAGS_BAD;
> +        }
>          break;
>
>      case VHOST_USER_SET_VRING_BASE:
> @@ -737,6 +747,17 @@ static void *vhost_user_test_setup_memfd(GString *cmd_line, void *arg)
>      return server;
>  }
>
> +static void *vhost_user_test_setup_migrate_reconnect(GString *cmd_line,
> +        void *arg)
> +{
> +    TestServer *server;
> +
> +    server = vhost_user_test_setup_memfd(cmd_line, arg);
> +    server->test_flags = TEST_FLAGS_MIGRATE_DISCONNECT;
> +
> +    return server;
> +}
> +
>  static void test_read_guest_mem(void *obj, void *arg, QGuestAllocator *alloc)
>  {
>      TestServer *server = arg;
> @@ -1150,5 +1171,9 @@ static void register_vhost_user_test(void)
>      opts.before = vhost_user_test_setup_memfd;
>      qos_add_test("migrate", "vhost-user-blk",
>                   test_migrate, &opts);
> +
> +    opts.before = vhost_user_test_setup_migrate_reconnect;
> +    qos_add_test("migrate_reconnect", "vhost-user-blk",
> +                 test_migrate, &opts);
>  }
>  libqos_init(register_vhost_user_test);
> --
> 2.7.4
>
>

