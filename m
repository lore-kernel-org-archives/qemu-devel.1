Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B667CC47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:05:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E97C206B6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E97C206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIJ9G-0006ll-HA
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 17:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iIHQA-0007kr-DV
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iIHQ7-0005GC-5x
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:14:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40364)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iIHQ6-0005FW-SY
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:14:47 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 293D7C04D932
 for <qemu-devel@nongnu.org>; Wed,  9 Oct 2019 19:14:45 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id g65so2962303qkf.19
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 12:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5HMe4iY7ZpgxFwiPKX2MfjdttrwfGNrf+k4LC3JHN8k=;
 b=XujvjE/dJjICT2EgRTFENYvA5J59oLpBoyGiZmZLaR9BDW1v3ps2GIXu2bRjcsmRt0
 qTr0nvznIB9ZEOLxYkKxtM7GjNDHJUJsis70nnX/XwF1Q3atFpxOTjciuYYZyJNRnyT2
 GmCSmH2RPnOxr81NgtaL9yqIulx+PrT60MD6ZgTRSV4AF4IDxKI2SAoie9F26tmzhIGr
 v31IOxGCw6PTKzQij8s+bVmgUoH605Qx0zOElhhlHuKxA6772fubm5nQ/ps2wg8G82e6
 nLJDZ0JWPM1DWblKtKUpXJDqZ2oImYB5/+5Z2JP2HcmFzlnvtokMo3i8xl05SKWhy1oV
 oLtw==
X-Gm-Message-State: APjAAAVRAyB+CRu+JA56cgaBTszaNxdVjUEiwm4PTmwz+WcKusFb3aWi
 YBY2tQmxfHaclTv38wEPe89BRPlNgjKfv1GqrKsKGWgLVVH1BPucQqBR39yJy/b7VlH3s0rGome
 uQmP0HxONVcYIBNQ=
X-Received: by 2002:a0c:814d:: with SMTP id 71mr5395803qvc.226.1570648484385; 
 Wed, 09 Oct 2019 12:14:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw6J1KXq1T8FHsQVGFicsJUvpAHjMi8m2HCC3+UugTE5wot0XCMBaJZjAFYrzOHXG0/St/aeg==
X-Received: by 2002:a0c:814d:: with SMTP id 71mr5395780qvc.226.1570648484096; 
 Wed, 09 Oct 2019 12:14:44 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 c201sm1449458qke.128.2019.10.09.12.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2019 12:14:43 -0700 (PDT)
Date: Wed, 9 Oct 2019 15:14:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC PATCH] virtio-blk: advertise F_WCE (F_FLUSH) if
 F_CONFIG_WCE is also advertised
Message-ID: <20191009151337-mutt-send-email-mst@kernel.org>
References: <1568980590-806043-1-git-send-email-wrfsh@yandex-team.ru>
 <20191008132416.GA28104@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008132416.GA28104@stefanha-x1.localdomain>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: yc-core@yandex-team.ru, qemu-block@nongnu.org, stefanha@redhat.com,
 Evgeny Yakovlev <wrfsh@yandex-team.ru>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 08, 2019 at 02:24:16PM +0100, Stefan Hajnoczi wrote:
> On Fri, Sep 20, 2019 at 02:56:30PM +0300, Evgeny Yakovlev wrote:
> > Virtio spec 1.1 (and earlier), 5.2.5.1 Driver Requirements: Device
> > Initialization:
> > 
> > "Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it if
> > they offer VIRTIO_BLK_F_CONFIG_WCE.
> > 
> > It looks like currently F_CONFIG_WCE and F_WCE are not connected to each
> > other. qemu will advertise F_CONFIG_WCE if config-wce argument is
> > set for virtio-blk device. While F_WCE is advertised if underlying block
> > backend actually has it's caching enabled.
> > Those two things are not related to each other.
> > 
> > Signed-off-by: Evgeny Yakovlev <wrfsh@yandex-team.ru>
> > ---
> >  hw/block/virtio-blk.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > index 1885160..b45dc0c 100644
> > --- a/hw/block/virtio-blk.c
> > +++ b/hw/block/virtio-blk.c
> > @@ -990,7 +990,8 @@ static uint64_t virtio_blk_get_features(VirtIODevice *vdev, uint64_t features,
> >          virtio_add_feature(&features, VIRTIO_BLK_F_SCSI);
> >      }
> >  
> > -    if (blk_enable_write_cache(s->blk)) {
> > +    if (blk_enable_write_cache(s->blk) ||
> > +        virtio_has_feature(features, VIRTIO_BLK_F_CONFIG_WCE)) {
> >          virtio_add_feature(&features, VIRTIO_BLK_F_WCE);
> >      }
> >      if (blk_is_read_only(s->blk)) {
> > -- 
> > 2.7.4
> 
> Sorry for the very late response.  I have been ill and am still
> recovering.
> 
> The motivation for this change looks correct but this patch may cause
> host_features to change across live migration to a newer QEMU version.
> If the guest accesses VIRTIO_PCI_HOST_FEATURES before and after live
> migration it may see different values, which is unexpected.
> 
> The safe way of introducing guest-visible changes like this is to make
> the change conditional on the machine type version so that old guests
> see old behavior and new guests see new behavior.
> 
> Live migration compatibility can be guaranteed by adding a new property
> to virtio_blk_properties[]:
> 
>   DEFINE_PROP_BOOL("enable-wce-if-config-wce", VirtIOBlock,
>                    conf.enable_wce_if_config_wce, true),


is this a useful thing for users to control?
If not we don't need to make this property part of
the stable API - blacklist it by prefixing x- to the name:
x-enable-wce-if-config-wce

> Then tweak the patch:
> 
>   if (blk_enable_write_cache(s->blk) ||
>       (s->conf.enable_wce_if_config_wce &&
>        virtio_has_feature(features, VIRTIO_BLK_F_CONFIG_WCE))) {
> 
> And finally disable enable_wce_if_config_wce for older machine types to
> retain compatibility:
> 
>   GlobalProperty hw_compat_4_2[] = {
>       { "virtio-blk-device", "enable-wce-if-config-wce", "off" },
>   };
> 
> (I have omitted some steps like defining
> VirtIOBlkConf.enable_wce_if_config_wce field and hooking up
> hw_compat_4_2[], but you can figure that out from the existing code.)
> 
> Stefan



