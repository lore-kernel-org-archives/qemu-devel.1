Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB51C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 15:57:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AE0F20671
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 15:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSg63DBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE0F20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbR69-0005nL-8e
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 11:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jbR3f-0001e6-10
 for qemu-devel@nongnu.org; Wed, 20 May 2020 11:55:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34786
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jbR3c-0001TE-Kf
 for qemu-devel@nongnu.org; Wed, 20 May 2020 11:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589990099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CJe+u57zQRdIUkqebUb4BFsVY2OqQOKjc9iEgUL9Z+Q=;
 b=fSg63DBtOjkqesJ8PeypC7L8JT3QqftuuFm8kNNKu/oKy9+vpDXCN9+pBHnWAwe4VAKqOB
 4TWqj3SZXbOAQfuaE9a2dBESVnAo/tyJ3luAfvvv6A4Weloqgeuxsys4sPMgvOFaFM0jkf
 q9o6P+eqxx9Tv8+6YxXb2PvVEK1L2O4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-bkxYScz4NziaZJ9RnJ3Neg-1; Wed, 20 May 2020 11:54:58 -0400
X-MC-Unique: bkxYScz4NziaZJ9RnJ3Neg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA895A0BDE;
 Wed, 20 May 2020 15:54:56 +0000 (UTC)
Received: from linux.fritz.box (ovpn-115-47.ams2.redhat.com [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 23CE4341FE;
 Wed, 20 May 2020 15:54:45 +0000 (UTC)
Date: Wed, 20 May 2020 17:54:44 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Roman Kagan <rvkagan@yandex-team.ru>
Subject: Re: [PATCH v4 3/3] block: make BlockConf.*_size properties 32-bit
Message-ID: <20200520155444.GG5192@linux.fritz.box>
References: <20200520080657.29080-1-rvkagan@yandex-team.ru>
 <20200520080657.29080-4-rvkagan@yandex-team.ru>
MIME-Version: 1.0
In-Reply-To: <20200520080657.29080-4-rvkagan@yandex-team.ru>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 04:09:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 20.05.2020 um 10:06 hat Roman Kagan geschrieben:
> Devices (virtio-blk, scsi, etc.) and the block layer are happy to use
> 32-bit for logical_block_size, physical_block_size, and min_io_size.
> However, the properties in BlockConf are defined as uint16_t limiting
> the values to 32768.
> 
> This appears unnecessary tight, and we've seen bigger block sizes handy
> at times.
> 
> Make them 32 bit instead and lift the limitation up to 2 MiB which
> appears to be good enough for everybody, and matches the qcow2 cluster
> size limit.
> 
> As the values can now be fairly big and awkward to type, make the
> property setter accept common size suffixes (k, m).
> 
> Also as the devices which use min_io_size (virtio-blk and scsi) pass its
> value to the guest in units of logical blocks in a 16bit field, to
> prevent its silent truncation add a corresponding check to
> blkconf_blocksizes.
> 
> Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
> ---
> v3 -> v4:
> - check min_io_size against truncation [Kevin]
> 
> v2 -> v3:
> - mention qcow2 cluster size limit in the log and comment [Eric]
> 
> v1 -> v2:
> - cap the property at 2 MiB [Eric]
> - accept size suffixes
> 
>  include/hw/block/block.h     |  8 ++++----
>  include/hw/qdev-properties.h |  2 +-
>  hw/block/block.c             | 11 +++++++++++
>  hw/core/qdev-properties.c    | 34 ++++++++++++++++++++++++----------
>  4 files changed, 40 insertions(+), 15 deletions(-)
> 
> diff --git a/include/hw/block/block.h b/include/hw/block/block.h
> index 784953a237..2fa09aa0b1 100644
> --- a/include/hw/block/block.h
> +++ b/include/hw/block/block.h
> @@ -18,9 +18,9 @@
>  
>  typedef struct BlockConf {
>      BlockBackend *blk;
> -    uint16_t physical_block_size;
> -    uint16_t logical_block_size;
> -    uint16_t min_io_size;
> +    uint32_t physical_block_size;
> +    uint32_t logical_block_size;
> +    uint32_t min_io_size;
>      uint32_t opt_io_size;
>      int32_t bootindex;
>      uint32_t discard_granularity;
> @@ -51,7 +51,7 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
>                            _conf.logical_block_size),                    \
>      DEFINE_PROP_BLOCKSIZE("physical_block_size", _state,                \
>                            _conf.physical_block_size),                   \
> -    DEFINE_PROP_UINT16("min_io_size", _state, _conf.min_io_size, 0),    \
> +    DEFINE_PROP_UINT32("min_io_size", _state, _conf.min_io_size, 0),    \
>      DEFINE_PROP_UINT32("opt_io_size", _state, _conf.opt_io_size, 0),    \
>      DEFINE_PROP_UINT32("discard_granularity", _state,                   \
>                         _conf.discard_granularity, -1),                  \
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index f161604fb6..f9e0f8c041 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -197,7 +197,7 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
>  #define DEFINE_PROP_BIOS_CHS_TRANS(_n, _s, _f, _d) \
>      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_bios_chs_trans, int)
>  #define DEFINE_PROP_BLOCKSIZE(_n, _s, _f) \
> -    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint16_t)
> +    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint32_t)
>  #define DEFINE_PROP_PCI_HOST_DEVADDR(_n, _s, _f) \
>      DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostDeviceAddress)
>  #define DEFINE_PROP_OFF_AUTO_PCIBAR(_n, _s, _f, _d) \
> diff --git a/hw/block/block.c b/hw/block/block.c
> index 5f8ebff59c..cd95e7e38f 100644
> --- a/hw/block/block.c
> +++ b/hw/block/block.c
> @@ -96,6 +96,17 @@ bool blkconf_blocksizes(BlockConf *conf, Error **errp)
>          return false;
>      }
>  
> +    /*
> +     * all devices which support min_io_size (scsi and virtio-blk) expose it to
> +     * the guest as a uint16_t in units of logical blocks
> +     */
> +    if ((conf->min_io_size / conf->logical_block_size) > UINT16_MAX) {
> +        error_setg(errp,
> +                   "min_io_size must be no more than " stringify(UINT16_MAX)
> +                   " of logical_block_size");

I'm not a native speaker, but "no more than 65536 of logical_block_size"
sounds odd to me. Maybe "65536 times the logical_block_size"?

> +        return false;
> +    }
> +
>      if (conf->opt_io_size % conf->logical_block_size) {
>          error_setg(errp,
>                     "opt_io_size must be a multple of logical_block_size");

Kevin


