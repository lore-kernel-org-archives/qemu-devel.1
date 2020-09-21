Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD3EC4727D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 23:05:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27FBE206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 23:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iy/GGni3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27FBE206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKUsZ-0003cZ-1H
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 19:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kKUrL-0002KO-B9; Mon, 21 Sep 2020 19:04:35 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35420)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kKUrJ-0007su-Et; Mon, 21 Sep 2020 19:04:35 -0400
Received: by mail-oi1-x241.google.com with SMTP id w16so18878384oia.2;
 Mon, 21 Sep 2020 16:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TJMsLOYiarlLUjBdNopD6EaCLmugps6kTjNIe8ughG8=;
 b=Iy/GGni3CQXqW3Uu9kwBK1CEVMgOtwzibzvmJGXldwZ/Of9gUtMMzpfsJ+pA9r03sA
 I+R+34GVI5jzqNE4x/zqH3bZtVA/n4jHj5R7jVsLuCImo2kuWvkbL9MdVzDmtVE7sZO3
 icoFmKuvopTmdNrc/4NpoacfSPg0ai5kcPOQqN7X2Uh7/WcRafiA/qY6yvDzQJ0JJFEl
 Pi09ynC+juDNOCa3MWS6CgkpRcUato3H6OmrG8g/WA6JANuynWFOlfJpuBtJT0KFas0b
 fVuQtLCQq8QDanSjPNVp3GjdltyzLRG7kH3JKl0Qa+npvEhehzPNO8s1nJ3ncqPdji3B
 ++zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TJMsLOYiarlLUjBdNopD6EaCLmugps6kTjNIe8ughG8=;
 b=Y8P8B8Cmt+alwcokHZwOZnjRhc3dEw0jH2/heWqKPcCIMVHorFZLRDHlIjZl9sX3CA
 MJR2S3vntAk7OJZJODSoppt4cSoptiqbYFyekY108zxzpbJpH0HuTRtlXlfIBGw80UrI
 yHzsfyvIr3qDP07BlziO4AbMFiTYDJeNXaz/I0fwLXqzbINpgyDnbZtD9NeQe6b63fv7
 RkF+0QusEn7dKCntE238p4QhbwBiwz1lBeCa5YihGr8kLjSoS9TCnr/BiENLgNPZ+9iB
 UuuXtxhLV/D79aGKbK/kV+2dAYjNvIKMKy5Toni7m4EnBc6sXDlGdRqm8ZfCfFY4a4jn
 IC+w==
X-Gm-Message-State: AOAM530Oql+NwwqQoaJMgEFRclSdepCLkBbkidUJytmQvwcgQNTL97b3
 39TuPbFZe2u1ChK9PDwJ/uQY+ie31oIe9NlAP+g=
X-Google-Smtp-Source: ABdhPJxmKzk3aAZBxZItyblKfoVz9UyUQQIH1+ZKqhkzVLyoYQmmtGCt8qy1/xKxXqbdUTM6YBEnyHi0/xlPTWxdc4Q=
X-Received: by 2002:aca:d653:: with SMTP id n80mr950828oig.51.1600729471048;
 Mon, 21 Sep 2020 16:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599813294.git.dimastep@yandex-team.ru>
 <4d3e683a87557bcef520826c54aa3e5ab7c64111.1599813294.git.dimastep@yandex-team.ru>
 <CAFubqFssie0eqor4sL+v09kwam6aaoa8P7k+y0x=KHLZXs_7bA@mail.gmail.com>
 <20200916221313.GA3324@dimastep-nix>
In-Reply-To: <20200916221313.GA3324@dimastep-nix>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 21 Sep 2020 19:04:20 -0400
Message-ID: <CAFubqFv-YotywwD=aBJg_pgWGMi2qxC6cfRbu7rKzVbzxpr0gw@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] tests/qtest/libqos/virtio-blk: add support for
 vhost-user-blk
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
 "Michael S. Tsirkin" <mst@redhat.com>, stefanha@gmail.com, jasowang@redhat.com,
 QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, fengli@smartx.com,
 yc-core@yandex-team.ru, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MST already sent a PR with all the patches :)

On Wed, Sep 16, 2020 at 6:13 PM Dima Stepanov <dimastep@yandex-team.ru> wrote:
>
> On Mon, Sep 14, 2020 at 09:23:42PM -0400, Raphael Norwitz wrote:
> > On Fri, Sep 11, 2020 at 4:43 AM Dima Stepanov <dimastep@yandex-team.ru> wrote:
> > >
> > > Add support for the vhost-user-blk-pci device. This node can be used by
> > > the vhost-user-blk tests. Tests for the vhost-user-blk device are added
> > > in the following patches.
> > >
> > > Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> >
> > Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> Hi,
>
> Looks like that all the patch set is reviewed except 7/7. If it is an
> issue, we can cut it from the set and merge other six commits.
>
> Raphael,
>
> Will you take it for merge?
>
> Thanks, Dima.
>
> >
> > > ---
> > >  tests/qtest/libqos/virtio-blk.c | 14 +++++++++++++-
> > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tests/qtest/libqos/virtio-blk.c b/tests/qtest/libqos/virtio-blk.c
> > > index 5da0259..c0fd9d2 100644
> > > --- a/tests/qtest/libqos/virtio-blk.c
> > > +++ b/tests/qtest/libqos/virtio-blk.c
> > > @@ -30,7 +30,8 @@
> > >  static void *qvirtio_blk_get_driver(QVirtioBlk *v_blk,
> > >                                      const char *interface)
> > >  {
> > > -    if (!g_strcmp0(interface, "virtio-blk")) {
> > > +    if (!g_strcmp0(interface, "virtio-blk") ||
> > > +            !g_strcmp0(interface, "vhost-user-blk")) {
> > >          return v_blk;
> > >      }
> > >      if (!g_strcmp0(interface, "virtio")) {
> > > @@ -120,6 +121,17 @@ static void virtio_blk_register_nodes(void)
> > >      qos_node_produces("virtio-blk-pci", "virtio-blk");
> > >
> > >      g_free(arg);
> > > +
> > > +    /* vhost-user-blk-pci */
> > > +    arg = g_strdup_printf("id=drv0,chardev=chdev0,addr=%x.%x",
> > > +                                PCI_SLOT, PCI_FN);
> > > +    opts.extra_device_opts = arg;
> > > +    add_qpci_address(&opts, &addr);
> > > +    qos_node_create_driver("vhost-user-blk-pci", virtio_blk_pci_create);
> > > +    qos_node_consumes("vhost-user-blk-pci", "pci-bus", &opts);
> > > +    qos_node_produces("vhost-user-blk-pci", "vhost-user-blk");
> > > +
> > > +    g_free(arg);
> > >  }
> > >
> > >  libqos_init(virtio_blk_register_nodes);
> > > --
> > > 2.7.4
> > >
> > >

