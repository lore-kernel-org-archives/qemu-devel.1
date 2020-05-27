Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DE6C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 20:54:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8DE420890
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 20:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="F3RR6S+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8DE420890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je34A-0002t7-OC
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 16:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1je33H-0002ON-Ag; Wed, 27 May 2020 16:53:27 -0400
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:43174)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1je33D-0007cQ-JL; Wed, 27 May 2020 16:53:25 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id BD23D2E157F;
 Wed, 27 May 2020 23:53:16 +0300 (MSK)
Received: from sas2-32987e004045.qloud-c.yandex.net
 (sas2-32987e004045.qloud-c.yandex.net [2a02:6b8:c08:b889:0:640:3298:7e00])
 by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 Xt3ArwXecc-rCfKmK9U; Wed, 27 May 2020 23:53:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1590612796; bh=ZsdCg7tQAxxXKqG44grgO5wkYDTDlvE1HPG0Z1dXtPA=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=F3RR6S+ZRu88QHnYWpbbvafacf6fEC/1xkhzlcxkkqo49KTGptul9Z1Oit3tDKxul
 3qjVktQ/i3tf08IpeyluZJm0G030wnzCELwqcpIsqxOeYX9xHAmPsfA2lnAobH2iI/
 hWck9RjN7KSaV2qfKo+WD+82KTDgWLDtYj5bvMW8=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:8308::1:12])
 by sas2-32987e004045.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 6CLcHCW0d0-rCX0XiYO; Wed, 27 May 2020 23:53:12 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
Date: Wed, 27 May 2020 23:53:11 +0300
From: Roman Kagan <rvkagan@yandex-team.ru>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v6 4/5] block: make size-related BlockConf properties
 accept size suffixes
Message-ID: <20200527205311.GA373697@rvkaganb.lan>
Mail-Followup-To: Roman Kagan <rvkagan@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, xen-devel@lists.xenproject.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Paul Durrant <paul@xen.org>, Fam Zheng <fam@euphon.net>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Keith Busch <kbusch@kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20200527124511.986099-1-rvkagan@yandex-team.ru>
 <20200527124511.986099-5-rvkagan@yandex-team.ru>
 <d2ac3549-e63d-d737-41fa-21965c551175@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2ac3549-e63d-d737-41fa-21965c551175@redhat.com>
Received-SPF: pass client-ip=2a02:6b8:0:1619::183;
 envelope-from=rvkagan@yandex-team.ru; helo=forwardcorp1j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Keith Busch <kbusch@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 27, 2020 at 09:50:39AM -0500, Eric Blake wrote:
> On 5/27/20 7:45 AM, Roman Kagan wrote:
> > Several BlockConf properties represent respective sizes in bytes so it
> > makes sense to accept size suffixes for them.
> > 
> > Turn them all into uint32_t and use size-suffix-capable setters/getters
> > on them; introduce DEFINE_PROP_SIZE32 and adjust DEFINE_PROP_BLOCKSIZE
> > for that. (Making them uint64_t and reusing DEFINE_PROP_SIZE isn't
> > justified because guests expect at most 32bit values.)
> > 
> > Also, since min_io_size is exposed to the guest by scsi and virtio-blk
> > devices as an uint16_t in units of logical blocks, introduce an
> > additional check in blkconf_blocksizes to prevent its silent truncation.
> > 
> > Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
> > ---
> > v5 -> v6:
> > - add prop_size32 instead of going with 64bit
> 
> Would it be worth adding prop_size32 as its own patch, before using it here?

I've no strong opinion on this.  Should I better split it out when
respinning?

> But I'll review this as-is.
> 
> > +++ b/hw/block/block.c
> > @@ -96,6 +96,17 @@ bool blkconf_blocksizes(BlockConf *conf, Error **errp)
> >           return false;
> >       }
> > +    /*
> > +     * all devices which support min_io_size (scsi and virtio-blk) expose it to
> > +     * the guest as a uint16_t in units of logical blocks
> > +     */
> > +    if (conf->min_io_size > conf->logical_block_size * UINT16_MAX) {
> 
> This risks overflow.  Better would be:
> 
> if (conf->min_io_size / conf->logical_block-size > UINT16_MAX)

D'oh.  I kept it in mind and did it right initially in v4, but then
mixed it up.  Thanks for catching!

> 
> > +        error_setg(errp,
> > +                   "min_io_size must not exceed " stringify(UINT16_MAX)
> > +                   " logical blocks");
> > +        return false;
> > +    }
> > +
> >       if (!QEMU_IS_ALIGNED(conf->opt_io_size, conf->logical_block_size)) {
> >           error_setg(errp,
> >                      "opt_io_size must be a multiple of logical_block_size");
> 
> > +++ b/tests/qemu-iotests/172.out
> > @@ -24,11 +24,11 @@ Testing:
> >                 dev: floppy, id ""
> >                   unit = 0 (0x0)
> >                   drive = "floppy0"
> > -                logical_block_size = 512 (0x200)
> > -                physical_block_size = 512 (0x200)
> > -                min_io_size = 0 (0x0)
> > -                opt_io_size = 0 (0x0)
> > -                discard_granularity = 4294967295 (0xffffffff)
> > +                logical_block_size = 512 (512 B)
> > +                physical_block_size = 512 (512 B)
> > +                min_io_size = 0 (0 B)
> > +                opt_io_size = 0 (0 B)
> > +                discard_granularity = 4294967295 (4 GiB)
> 
> Although 4 GiB is not quite the same as 4294967295, the exact byte value
> next to the approximate size is not too bad.  The mechanical fallout from
> the change from int to size is fine to me.

Thanks,
Roman.

