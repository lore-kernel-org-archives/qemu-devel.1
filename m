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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91130C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 03:02:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B6062098B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 03:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqI793pW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6062098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFqNi-0005Xg-9Z
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 23:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kFqN9-00053w-Tu; Tue, 08 Sep 2020 23:02:11 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43061)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kFqN8-0001Q4-Aj; Tue, 08 Sep 2020 23:02:11 -0400
Received: by mail-ot1-x342.google.com with SMTP id n61so1049332ota.10;
 Tue, 08 Sep 2020 20:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pVMkzWc6IvVvRQsY4bfUMYcpR7BFy0I/GpZyT+EljOU=;
 b=QqI793pWsRCa7W7bjFoqT9I+QStV4tafIyds//LieussPklF9t9tC3ExN5CdkmVx2+
 oNNRHNbwsrQvR+P8Bl+QsrJbFlPPYRJ+OKkN1gYhYLOGrnIHEj+7dHEQvc5HtcYHmQOh
 NaIsOVeY/7+m3qn51WklQaebq1aW7YipTw/iXOWis8JbIIFrfrOYWt/2hIjog3KjtMsL
 7GPE+6ficm7A48anokLrUBB4Av5H/5bLZZJzVYIBt7qSpUHHFhIQh6nNoPaf9qf+lXAg
 tbaomxV+AGfmx72yodQMsFWJ2MvgJpqON0OdHeeGS9OtRRrfK4aUWAv+AvH8FnUfKFL7
 q01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pVMkzWc6IvVvRQsY4bfUMYcpR7BFy0I/GpZyT+EljOU=;
 b=M/xJb/79/raZVue82J+TFZka9pKMsJhZE72cEHMTd+1KNw2m8gOKqNRP2J83bFVRP6
 3URjIrYRgJK6mj9PHYX16wAXctQI3NVAdvEbFCgza47DZ2mSFElSy4H1vxMzTI5z2hLv
 C/0MEO4kaxvl+3H1WtKqvtJi9msXWpU6ca7DYhGbknu1XEM4KAorjxjq+28pZ8F7liI3
 OdUsvGS+l2/8qt4+8eR0N1T/uJNz4jPxCbV3dv7DFp+T5zRsPENh/Uca8DhARHOMjDxN
 TA549NGqVCI2QNF9n5FX3UTFE8KIibcHi/vSK2NoRXxbxQdTR5mmc83O4OBqCjKJ+yeM
 LRDw==
X-Gm-Message-State: AOAM5301Rq/WpqcENfdhEorfkriWEb12VEADCx7Ru2DbdX6u8fyfSkOp
 7uguDnaLN7iMORNX41/2DicC+tMmRGSaBbiF94A=
X-Google-Smtp-Source: ABdhPJwVK8mEdeoFKz/Sq3Wg5yaNZQtvLu1wtwPY17koruaal/UB1hw6ejXcF/7AKrzyvsRKw1rgF07oVZEcAYD2Jb8=
X-Received: by 2002:a9d:5c06:: with SMTP id o6mr1528531otk.262.1599620528693; 
 Tue, 08 Sep 2020 20:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599211479.git.dimastep@yandex-team.ru>
 <4d78746dfa627cc00e810d826b49e9612a74cdff.1599211479.git.dimastep@yandex-team.ru>
In-Reply-To: <4d78746dfa627cc00e810d826b49e9612a74cdff.1599211479.git.dimastep@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Tue, 8 Sep 2020 23:01:57 -0400
Message-ID: <CAFubqFvGNV3DVmnanhMZGaRzodAkAU8MboDd2T9W_P__KpUW8g@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] tests/qtest/libqos/virtio-blk: add support for
 vhost-user-blk
To: Dima Stepanov <dimastep@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-ot1-x342.google.com
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

On Fri, Sep 4, 2020 at 5:34 AM Dima Stepanov <dimastep@yandex-team.ru> wrote:
>
> Add support for the vhost-user-blk-pci device. This node can be used by
> the vhost-user-blk tests. Tests for the vhost-user-blk device are added
> in the following patches.
>
> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> ---
>  tests/qtest/libqos/virtio-blk.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/tests/qtest/libqos/virtio-blk.c b/tests/qtest/libqos/virtio-blk.c
> index 5da0259..959c5dc 100644
> --- a/tests/qtest/libqos/virtio-blk.c
> +++ b/tests/qtest/libqos/virtio-blk.c
> @@ -36,6 +36,9 @@ static void *qvirtio_blk_get_driver(QVirtioBlk *v_blk,
>      if (!g_strcmp0(interface, "virtio")) {
>          return v_blk->vdev;
>      }
> +    if (!g_strcmp0(interface, "vhost-user-blk")) {

Small point but why not merge this conditional with the
!g_strcmp0(interface, "virtio-blk") check above? They both return
v_blk.

Otherwise looks good.

> +        return v_blk;
> +    }
>
>      fprintf(stderr, "%s not present in virtio-blk-device\n", interface);
>      g_assert_not_reached();
> @@ -120,6 +123,17 @@ static void virtio_blk_register_nodes(void)
>      qos_node_produces("virtio-blk-pci", "virtio-blk");
>
>      g_free(arg);
> +
> +    /* vhost-user-blk-pci */
> +    arg = g_strdup_printf("id=drv0,chardev=chdev0,addr=%x.%x",
> +                                PCI_SLOT, PCI_FN);
> +    opts.extra_device_opts = arg;
> +    add_qpci_address(&opts, &addr);
> +    qos_node_create_driver("vhost-user-blk-pci", virtio_blk_pci_create);
> +    qos_node_consumes("vhost-user-blk-pci", "pci-bus", &opts);
> +    qos_node_produces("vhost-user-blk-pci", "vhost-user-blk");
> +
> +    g_free(arg);
>  }
>
>  libqos_init(virtio_blk_register_nodes);
> --
> 2.7.4
>
>

