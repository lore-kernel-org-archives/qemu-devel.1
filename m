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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05723C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 03:01:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E9FA2098B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 03:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtaQo0iv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E9FA2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFqMI-0004Yp-P4
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 23:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kFqLR-0003uo-1F; Tue, 08 Sep 2020 23:00:25 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43391)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kFqLN-0000lx-GX; Tue, 08 Sep 2020 23:00:24 -0400
Received: by mail-oi1-x243.google.com with SMTP id i17so902442oig.10;
 Tue, 08 Sep 2020 20:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lu1qO+i1yJWxNXCHPW7JaUeVdESzeH82NAFTr9owFpQ=;
 b=YtaQo0ivP1k2eGfRSYiL/5d/EbeUJoBLqnoHieY0nBAT5vqmcVo+ySVIrvcCVFCktS
 0d4Mp30QEpq199R/cgkLeO7OfJ6Qz7+mJ3kbfr1fluhZmhlEr7bdRsDvmy9X4ajGf0yR
 RL+vXHgluxMDE23+khPyoa3FPu7flkLlcoYpw5z9PrnPs2O7mAOLtqvPvtDRLgFYA2mj
 1HKN2dYxyGm5Tb/71pvEEUTHe2dBR2FPc3xzNl1VxqlCyIceKTA93CYcg8PzTK+vj85M
 SGId+G1q7LEHdFbKHIw8VptgrqupKvOkfxPNtgIRpfxG4/RvkTePm02tvrj/2EJLrCM8
 7Tag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lu1qO+i1yJWxNXCHPW7JaUeVdESzeH82NAFTr9owFpQ=;
 b=EQSPHeUBzAUuS6hPl0Atvns8QHTQnkOw/4YuM/ZO2zltJhuet5kXK0gONS5EOOKiZ5
 sZSgpWExKuFgMmnfvTk/1MEjicTi2EyDtZm571kfa2gY1UI6nta/8alPG9EKUVyxrvDj
 7rcbO33rwAUAs4zfJX3anTM85Z87QANZufuIEsS5FcelmR43TbaVNoGdMlYTm7bHrGQ4
 HJBSC0hehjSIZkc1Esnk7v+guCFo0oXs0jf0ZAK3TFsl7y4kSFKalVeo7aIllo54RdJt
 PGDiJbDBQDtDzH20MlcjUfKFaJvNQleWw0mfw7wFbMwZRjtwMdv/MGwJrcY5zVeHAJ+j
 cEOA==
X-Gm-Message-State: AOAM530lpgSsNhxel0m6W9QKeVT927vbKhZcTMV1iAV0vK+18cpyiWyA
 kF5oe2OmqiPWNG2qiW108v+qj6+6fWS/hsvFIo8=
X-Google-Smtp-Source: ABdhPJymsb69LITXdDk7RsUAMRO3P5Sxp9OvT1iFoMgVp1xK4o0SKpJF7BeOQRV3nGS9GbK8X4HM3HCuTp9buw1D5z8=
X-Received: by 2002:aca:c0c1:: with SMTP id q184mr1439688oif.56.1599620419790; 
 Tue, 08 Sep 2020 20:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599211479.git.dimastep@yandex-team.ru>
 <edd2bb15ad817a12e6aa88b962bed769dd9dbcd5.1599211479.git.dimastep@yandex-team.ru>
In-Reply-To: <edd2bb15ad817a12e6aa88b962bed769dd9dbcd5.1599211479.git.dimastep@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Tue, 8 Sep 2020 23:00:08 -0400
Message-ID: <CAFubqFsRn_+cWqB3TgVqmoQh7qLRMOrSv4SUGoA3=fKDTB5grg@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] tests/qtest/vhost-user-test: prepare the tests for
 adding new dev class
To: Dima Stepanov <dimastep@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-oi1-x243.google.com
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

On Fri, Sep 4, 2020 at 5:32 AM Dima Stepanov <dimastep@yandex-team.ru> wrote:
>
> For now only vhost-user-net device is supported by the test. Other
> vhost-user devices are not tested. As a first step make source code
> refactoring so new devices can reuse the same test routines. To make
> this provide a new vhost_user_ops structure with the methods to
> initialize device, its command line or make a proper vhost-user
> responses.
>
> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> ---
>  tests/qtest/vhost-user-test.c | 105 ++++++++++++++++++++++++++++++------------
>  1 file changed, 76 insertions(+), 29 deletions(-)
>
> diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
> index 9ee0f1e..3df5322 100644
> --- a/tests/qtest/vhost-user-test.c
> +++ b/tests/qtest/vhost-user-test.c
> @@ -135,6 +135,10 @@ enum {
>      TEST_FLAGS_END,
>  };
>
> +enum {
> +    VHOST_USER_NET,
> +};
> +
>  typedef struct TestServer {
>      gchar *socket_path;
>      gchar *mig_path;
> @@ -154,10 +158,25 @@ typedef struct TestServer {
>      bool test_fail;
>      int test_flags;
>      int queues;
> +    struct vhost_user_ops *vu_ops;
>  } TestServer;
>
> +struct vhost_user_ops {
> +    /* Device types. */
> +    int type;
> +    void (*append_opts)(TestServer *s, GString *cmd_line,
> +            const char *chr_opts);
> +
> +    /* VHOST-USER commands. */
> +    void (*set_features)(TestServer *s, CharBackend *chr,
> +            VhostUserMsg *msg);
> +    void (*get_protocol_features)(TestServer *s,
> +            CharBackend *chr, VhostUserMsg *msg);
> +};
> +
>  static const char *init_hugepagefs(void);
> -static TestServer *test_server_new(const gchar *name);
> +static TestServer *test_server_new(const gchar *name,
> +        struct vhost_user_ops *ops);
>  static void test_server_free(TestServer *server);
>  static void test_server_listen(TestServer *server);
>
> @@ -167,7 +186,7 @@ enum test_memfd {
>      TEST_MEMFD_NO,
>  };
>
> -static void append_vhost_opts(TestServer *s, GString *cmd_line,
> +static void append_vhost_net_opts(TestServer *s, GString *cmd_line,
>                               const char *chr_opts)
>  {
>      g_string_append_printf(cmd_line, QEMU_CMD_CHR QEMU_CMD_NETDEV,
> @@ -332,25 +351,15 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
>          break;
>
>      case VHOST_USER_SET_FEATURES:
> -        g_assert_cmpint(msg.payload.u64 & (0x1ULL << VHOST_USER_F_PROTOCOL_FEATURES),
> -                        !=, 0ULL);
> -        if (s->test_flags == TEST_FLAGS_DISCONNECT) {
> -            qemu_chr_fe_disconnect(chr);
> -            s->test_flags = TEST_FLAGS_BAD;
> +        if (s->vu_ops->set_features) {
> +            s->vu_ops->set_features(s, chr, &msg);
>          }
>          break;
>
>      case VHOST_USER_GET_PROTOCOL_FEATURES:
> -        /* send back features to qemu */
> -        msg.flags |= VHOST_USER_REPLY_MASK;
> -        msg.size = sizeof(m.payload.u64);
> -        msg.payload.u64 = 1 << VHOST_USER_PROTOCOL_F_LOG_SHMFD;
> -        msg.payload.u64 |= 1 << VHOST_USER_PROTOCOL_F_CROSS_ENDIAN;
> -        if (s->queues > 1) {
> -            msg.payload.u64 |= 1 << VHOST_USER_PROTOCOL_F_MQ;
> +        if (s->vu_ops->get_protocol_features) {
> +            s->vu_ops->get_protocol_features(s, chr, &msg);
>          }
> -        p = (uint8_t *) &msg;
> -        qemu_chr_fe_write_all(chr, p, VHOST_USER_HDR_SIZE + msg.size);
>          break;
>
>      case VHOST_USER_GET_VRING_BASE:
> @@ -467,7 +476,8 @@ static const char *init_hugepagefs(void)
>  #endif
>  }
>
> -static TestServer *test_server_new(const gchar *name)
> +static TestServer *test_server_new(const gchar *name,
> +        struct vhost_user_ops *ops)
>  {
>      TestServer *server = g_new0(TestServer, 1);
>      char template[] = "/tmp/vhost-test-XXXXXX";
> @@ -495,6 +505,7 @@ static TestServer *test_server_new(const gchar *name)
>
>      server->log_fd = -1;
>      server->queues = 1;
> +    server->vu_ops = ops;
>
>      return server;
>  }
> @@ -669,11 +680,11 @@ static void vhost_user_test_cleanup(void *s)
>
>  static void *vhost_user_test_setup(GString *cmd_line, void *arg)
>  {
> -    TestServer *server = test_server_new("vhost-user-test");
> +    TestServer *server = test_server_new("vhost-user-test", arg);
>      test_server_listen(server);
>
>      append_mem_opts(server, cmd_line, 256, TEST_MEMFD_AUTO);
> -    append_vhost_opts(server, cmd_line, "");
> +    server->vu_ops->append_opts(server, cmd_line, "");
>
>      g_test_queue_destroy(vhost_user_test_cleanup, server);
>
> @@ -682,11 +693,11 @@ static void *vhost_user_test_setup(GString *cmd_line, void *arg)
>
>  static void *vhost_user_test_setup_memfd(GString *cmd_line, void *arg)
>  {
> -    TestServer *server = test_server_new("vhost-user-test");
> +    TestServer *server = test_server_new("vhost-user-test", arg);
>      test_server_listen(server);
>
>      append_mem_opts(server, cmd_line, 256, TEST_MEMFD_YES);
> -    append_vhost_opts(server, cmd_line, "");
> +    server->vu_ops->append_opts(server, cmd_line, "");
>
>      g_test_queue_destroy(vhost_user_test_cleanup, server);
>
> @@ -720,7 +731,7 @@ static void test_migrate(void *obj, void *arg, QGuestAllocator *alloc)
>          return;
>      }
>
> -    dest = test_server_new("dest");
> +    dest = test_server_new("dest", s->vu_ops);
>      dest_cmdline = g_string_new(qos_get_current_command_line());
>      uri = g_strdup_printf("%s%s", "unix:", dest->mig_path);
>
> @@ -730,7 +741,7 @@ static void test_migrate(void *obj, void *arg, QGuestAllocator *alloc)
>      test_server_listen(dest);
>      g_string_append_printf(dest_cmdline, " -incoming %s", uri);
>      append_mem_opts(dest, dest_cmdline, 256, TEST_MEMFD_AUTO);
> -    append_vhost_opts(dest, dest_cmdline, "");
> +    dest->vu_ops->append_opts(dest, dest_cmdline, "");
>      to = qtest_init(dest_cmdline->str);
>
>      /* This would be where you call qos_allocate_objects(to, NULL), if you want
> @@ -831,11 +842,11 @@ connect_thread(gpointer data)
>
>  static void *vhost_user_test_setup_reconnect(GString *cmd_line, void *arg)
>  {
> -    TestServer *s = test_server_new("reconnect");
> +    TestServer *s = test_server_new("reconnect", arg);
>
>      g_thread_new("connect", connect_thread, s);
>      append_mem_opts(s, cmd_line, 256, TEST_MEMFD_AUTO);
> -    append_vhost_opts(s, cmd_line, ",server");
> +    s->vu_ops->append_opts(s, cmd_line, ",server");
>
>      g_test_queue_destroy(vhost_user_test_cleanup, s);
>
> @@ -866,13 +877,13 @@ static void test_reconnect(void *obj, void *arg, QGuestAllocator *alloc)
>
>  static void *vhost_user_test_setup_connect_fail(GString *cmd_line, void *arg)
>  {
> -    TestServer *s = test_server_new("connect-fail");
> +    TestServer *s = test_server_new("connect-fail", arg);
>
>      s->test_fail = true;
>
>      g_thread_new("connect", connect_thread, s);
>      append_mem_opts(s, cmd_line, 256, TEST_MEMFD_AUTO);
> -    append_vhost_opts(s, cmd_line, ",server");
> +    s->vu_ops->append_opts(s, cmd_line, ",server");
>
>      g_test_queue_destroy(vhost_user_test_cleanup, s);
>
> @@ -881,13 +892,13 @@ static void *vhost_user_test_setup_connect_fail(GString *cmd_line, void *arg)
>
>  static void *vhost_user_test_setup_flags_mismatch(GString *cmd_line, void *arg)
>  {
> -    TestServer *s = test_server_new("flags-mismatch");
> +    TestServer *s = test_server_new("flags-mismatch", arg);
>
>      s->test_flags = TEST_FLAGS_DISCONNECT;
>
>      g_thread_new("connect", connect_thread, s);
>      append_mem_opts(s, cmd_line, 256, TEST_MEMFD_AUTO);
> -    append_vhost_opts(s, cmd_line, ",server");
> +    s->vu_ops->append_opts(s, cmd_line, ",server");
>
>      g_test_queue_destroy(vhost_user_test_cleanup, s);
>
> @@ -924,11 +935,47 @@ static void test_multiqueue(void *obj, void *arg, QGuestAllocator *alloc)
>      wait_for_rings_started(s, s->queues * 2);
>  }
>
> +static void vu_net_set_features(TestServer *s, CharBackend *chr,
> +        VhostUserMsg *msg)
> +{
> +    g_assert_cmpint(msg->payload.u64 &
> +            (0x1ULL << VHOST_USER_F_PROTOCOL_FEATURES), !=, 0ULL);
> +    if (s->test_flags == TEST_FLAGS_DISCONNECT) {
> +        qemu_chr_fe_disconnect(chr);
> +        s->test_flags = TEST_FLAGS_BAD;
> +    }
> +}
> +
> +static void vu_net_get_protocol_features(TestServer *s, CharBackend *chr,
> +        VhostUserMsg *msg)
> +{
> +    /* send back features to qemu */
> +    msg->flags |= VHOST_USER_REPLY_MASK;
> +    msg->size = sizeof(m.payload.u64);
> +    msg->payload.u64 = 1 << VHOST_USER_PROTOCOL_F_LOG_SHMFD;
> +    msg->payload.u64 |= 1 << VHOST_USER_PROTOCOL_F_CROSS_ENDIAN;
> +    if (s->queues > 1) {
> +        msg->payload.u64 |= 1 << VHOST_USER_PROTOCOL_F_MQ;
> +    }
> +    qemu_chr_fe_write_all(chr, (uint8_t *)msg, VHOST_USER_HDR_SIZE + msg->size);
> +}
> +
> +/* Each VHOST-USER device should have its ops structure defined. */
> +static struct vhost_user_ops g_vu_net_ops = {
> +    .type = VHOST_USER_NET,
> +
> +    .append_opts = append_vhost_net_opts,
> +
> +    .set_features = vu_net_set_features,
> +    .get_protocol_features = vu_net_get_protocol_features,
> +};
> +
>  static void register_vhost_user_test(void)
>  {
>      QOSGraphTestOptions opts = {
>          .before = vhost_user_test_setup,
>          .subprocess = true,
> +        .arg = &g_vu_net_ops,
>      };
>
>      qemu_add_opts(&qemu_chardev_opts);
> --
> 2.7.4
>
>

