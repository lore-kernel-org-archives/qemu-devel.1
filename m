Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29C5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:00:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9855B206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 14:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9855B206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqGof-0008Ae-OL
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 10:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1jqGnL-0006yt-4W
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 09:59:31 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:37793)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1jqGnI-0001mW-Ki
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 09:59:30 -0400
Authentication-Results: esa3.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: CdQDhhe/vltse0IAgZlqTjOb33oITBRQkWwnnAUWMqaDjQkGRd6MqEuQLO/+CTqMXjFgNhUWqB
 JQBFCCHtm1puW3hrPoIjtPK8ernonrSNiXM8VsGkdgzqFokXl+t43w61LqIv1NHI3ZZfZpWHuk
 9VboYHAo/oukmhdxNbvsIf3tRDtl7Z1SClc12+m0i4kYRHmiUl5tuHkqDpnMmSSkMBySYTQjdy
 MTaGqtKs2CeNWNR+ARHaGj9+wIe/TIJbhnbzg+H/fCR14M0LRAER+lU6hYaKtoACQVCCA34/r4
 0sE=
X-SBRS: 2.7
X-MesageID: 21272894
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,297,1589256000"; d="scan'208";a="21272894"
Date: Tue, 30 Jun 2020 14:59:21 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Jason Andryuk <jandryuk@gmail.com>
Subject: Re: [PATCH] xen: Fix xen-legacy-backend qdev types
Message-ID: <20200630135921.GB2030@perard.uk.xensource.com>
References: <20200624121939.10282-1-jandryuk@gmail.com>
 <000a01d64a23$4a595e90$df0c1bb0$@xen.org>
 <CAKf6xpuiRj_b+M+E0wBzPhraLxdebL6xr_1dMGc-jnzhWb0mhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKf6xpuiRj_b+M+E0wBzPhraLxdebL6xr_1dMGc-jnzhWb0mhg@mail.gmail.com>
Received-SPF: pass client-ip=216.71.145.155;
 envelope-from=anthony.perard@citrix.com; helo=esa3.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 09:59:24
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: xen-devel <xen-devel@lists.xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>, QEMU <qemu-devel@nongnu.org>,
 Paul Durrant <paul@xen.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 24, 2020 at 08:52:44AM -0400, Jason Andryuk wrote:
> On Wed, Jun 24, 2020 at 8:30 AM Paul Durrant <xadimgnik@gmail.com> wrote:
> >
> > > -----Original Message-----
> > > From: Jason Andryuk <jandryuk@gmail.com>
> > > Sent: 24 June 2020 13:20
> > > To: Stefano Stabellini <sstabellini@kernel.org>; Anthony Perard <anthony.perard@citrix.com>; Paul
> > > Durrant <paul@xen.org>; xen-devel@lists.xenproject.org
> > > Cc: Jason Andryuk <jandryuk@gmail.com>; qemu-devel@nongnu.org
> > > Subject: [PATCH] xen: Fix xen-legacy-backend qdev types
> > >
> > > xen-sysdev is a TYPE_SYS_BUS_DEVICE.  bus_type should not be changed so
> > > that it can plug into the System bus.  Otherwise this assert triggers:
> > > qemu-system-i386: hw/core/qdev.c:102: qdev_set_parent_bus: Assertion
> > > `dc->bus_type && object_dynamic_cast(OBJECT(bus), dc->bus_type)'
> > > failed.
> > >
> > > TYPE_XENBACKEND attaches to TYPE_XENSYSBUS, so its class_init needs to
> > > be set accordingly to attach the qdev.  Otherwise the following assert
> > > triggers:
> > > qemu-system-i386: hw/core/qdev.c:102: qdev_set_parent_bus: Assertion
> > > `dc->bus_type && object_dynamic_cast(OBJECT(bus), dc->bus_type)'
> > > failed.
> > >
> > > TYPE_XENBACKEND is not a subclass of XEN_XENSYSDEV, so it's parent
> > > is just TYPE_DEVICE.  Change that.
> > >
> > > Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
> >
> > Clearly we raced. This patch and my patch #1 are identical so I'm happy to give my ack to this.
> 
> Yeah, looks like you beat me by a hair :)
> 
> Either way it gets fixed is fine by me.

Since there's a choice to make, I think I'll take this patch, but I will
add:
Fixes: 81cb05732efb ("qdev: Assert devices are plugged into a bus that can take them")

Thanks,

-- 
Anthony PERARD

