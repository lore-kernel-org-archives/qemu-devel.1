Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47349C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 00:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20B7523A61
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 00:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="ufG4q/dd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B7523A61
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKWbE-0007Rg-Rk
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 20:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kKWaL-0006px-TA; Mon, 21 Sep 2020 20:55:10 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:47722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1kKWaH-0002mL-Ha; Mon, 21 Sep 2020 20:55:08 -0400
Received: from iva8-d077482f1536.qloud-c.yandex.net
 (iva8-d077482f1536.qloud-c.yandex.net
 [IPv6:2a02:6b8:c0c:2f26:0:640:d077:482f])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id CF2122E159A;
 Tue, 22 Sep 2020 03:54:59 +0300 (MSK)
Received: from iva8-88b7aa9dc799.qloud-c.yandex.net
 (iva8-88b7aa9dc799.qloud-c.yandex.net [2a02:6b8:c0c:77a0:0:640:88b7:aa9d])
 by iva8-d077482f1536.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 hwMocanruS-swvKSpml; Tue, 22 Sep 2020 03:54:59 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1600736099; bh=9FTthf4JcJytK48DfDvq5/Cw17R0lm+Kl5QD/gFaChA=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=ufG4q/ddkEOdrm9gyCm6PYM2PNMAgqZCs7jXLLqSF1g7EiSA3lKjVZFnuD6Llt2eG
 nl/1vhPoR4aw0WxJmZg/4WacDGDx9Q37cSykap9ogFDqRutiQQVCxImOu5A2g/1Vj9
 MYGf8UYWblpft595QNoTa/JE+OumhQXlrsKuz/Oc=
Authentication-Results: iva8-d077482f1536.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-iva.dhcp.yndx.net (dynamic-iva.dhcp.yndx.net
 [2a02:6b8:b080:9018::1:0])
 by iva8-88b7aa9dc799.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 D71TUrk78P-srnG5lvN; Tue, 22 Sep 2020 03:54:58 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
Date: Tue, 22 Sep 2020 03:54:49 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: Re: [PATCH v5 4/7] tests/qtest/libqos/virtio-blk: add support for
 vhost-user-blk
Message-ID: <20200922005448.GA5538@dimastep-nix>
References: <cover.1599813294.git.dimastep@yandex-team.ru>
 <4d3e683a87557bcef520826c54aa3e5ab7c64111.1599813294.git.dimastep@yandex-team.ru>
 <CAFubqFssie0eqor4sL+v09kwam6aaoa8P7k+y0x=KHLZXs_7bA@mail.gmail.com>
 <20200916221313.GA3324@dimastep-nix>
 <CAFubqFv-YotywwD=aBJg_pgWGMi2qxC6cfRbu7rKzVbzxpr0gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFubqFv-YotywwD=aBJg_pgWGMi2qxC6cfRbu7rKzVbzxpr0gw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=77.88.29.217;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 20:55:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
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

On Mon, Sep 21, 2020 at 07:04:20PM -0400, Raphael Norwitz wrote:
> MST already sent a PR with all the patches :)

Thank you! )

> 
> On Wed, Sep 16, 2020 at 6:13 PM Dima Stepanov <dimastep@yandex-team.ru> wrote:
> >
> > On Mon, Sep 14, 2020 at 09:23:42PM -0400, Raphael Norwitz wrote:
> > > On Fri, Sep 11, 2020 at 4:43 AM Dima Stepanov <dimastep@yandex-team.ru> wrote:
> > > >
> > > > Add support for the vhost-user-blk-pci device. This node can be used by
> > > > the vhost-user-blk tests. Tests for the vhost-user-blk device are added
> > > > in the following patches.
> > > >
> > > > Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> > >
> > > Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> > Hi,
> >
> > Looks like that all the patch set is reviewed except 7/7. If it is an
> > issue, we can cut it from the set and merge other six commits.
> >
> > Raphael,
> >
> > Will you take it for merge?
> >
> > Thanks, Dima.
> >
> > >
> > > > ---
> > > >  tests/qtest/libqos/virtio-blk.c | 14 +++++++++++++-
> > > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/tests/qtest/libqos/virtio-blk.c b/tests/qtest/libqos/virtio-blk.c
> > > > index 5da0259..c0fd9d2 100644
> > > > --- a/tests/qtest/libqos/virtio-blk.c
> > > > +++ b/tests/qtest/libqos/virtio-blk.c
> > > > @@ -30,7 +30,8 @@
> > > >  static void *qvirtio_blk_get_driver(QVirtioBlk *v_blk,
> > > >                                      const char *interface)
> > > >  {
> > > > -    if (!g_strcmp0(interface, "virtio-blk")) {
> > > > +    if (!g_strcmp0(interface, "virtio-blk") ||
> > > > +            !g_strcmp0(interface, "vhost-user-blk")) {
> > > >          return v_blk;
> > > >      }
> > > >      if (!g_strcmp0(interface, "virtio")) {
> > > > @@ -120,6 +121,17 @@ static void virtio_blk_register_nodes(void)
> > > >      qos_node_produces("virtio-blk-pci", "virtio-blk");
> > > >
> > > >      g_free(arg);
> > > > +
> > > > +    /* vhost-user-blk-pci */
> > > > +    arg = g_strdup_printf("id=drv0,chardev=chdev0,addr=%x.%x",
> > > > +                                PCI_SLOT, PCI_FN);
> > > > +    opts.extra_device_opts = arg;
> > > > +    add_qpci_address(&opts, &addr);
> > > > +    qos_node_create_driver("vhost-user-blk-pci", virtio_blk_pci_create);
> > > > +    qos_node_consumes("vhost-user-blk-pci", "pci-bus", &opts);
> > > > +    qos_node_produces("vhost-user-blk-pci", "vhost-user-blk");
> > > > +
> > > > +    g_free(arg);
> > > >  }
> > > >
> > > >  libqos_init(virtio_blk_register_nodes);
> > > > --
> > > > 2.7.4
> > > >
> > > >

