Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F023C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:35:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 175F52067D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/CyPqHL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175F52067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqa53-0008SO-Cw
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 06:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jqa4J-0007VD-M6
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 06:34:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31018
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jqa4H-0007gD-M3
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 06:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593599656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1flWIfsVfHGlYSsmvroLYoQVT/BSFlSG8Jvg589B+EI=;
 b=D/CyPqHLQ0Twydf7KjXvECX8Nd6zbIjynhWWJ9V6hs3qsltKlbMoaiCUiQtCInIhkAppQa
 OOEO2LV1+vYuG+4QopLGnfH56ycxij1jFKiymjnyUaeCl6Xw6rgMMWlbtKhLEbOxXVTCGG
 vQ3X/ybChk/KJS3iovU4Qk/x1E+i7jo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-9vzl-czTN2i805TtQCtISA-1; Wed, 01 Jul 2020 06:34:14 -0400
X-MC-Unique: 9vzl-czTN2i805TtQCtISA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A4E6800D5C;
 Wed,  1 Jul 2020 10:34:12 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-248.ams2.redhat.com [10.36.113.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BE4410013C1;
 Wed,  1 Jul 2020 10:34:09 +0000 (UTC)
Date: Wed, 1 Jul 2020 12:34:07 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: nvme emulation merge process (was: Re: [PATCH 00/10] hw/block/nvme:
 namespace types and zoned namespaces)
Message-ID: <20200701103407.GA11634@linux.fritz.box>
References: <20200630100139.1483002-1-its@irrelevant.dk>
 <20200630125932.GA553472@localhost.localdomain>
 <c10b18a8-44f3-7dab-b9bb-7d017f210934@redhat.com>
 <20200630154228.GB1987534@dhcp-10-100-145-180.wdl.wdc.com>
 <20200630203630.am3a3bc5ze5m2r3k@apples.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200630203630.am3a3bc5ze5m2r3k@apples.localdomain>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 22:25:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Niklas Cassel <Niklas.Cassel@wdc.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 30.06.2020 um 22:36 hat Klaus Jensen geschrieben:
> On Jun 30 08:42, Keith Busch wrote:
> > On Tue, Jun 30, 2020 at 04:09:46PM +0200, Philippe Mathieu-Daudé wrote:
> > > What I see doable for the following days is:
> > > - hw/block/nvme: Fix I/O BAR structure [3]
> > > - hw/block/nvme: handle transient dma errors
> > > - hw/block/nvme: bump to v1.3
> > 
> > 
> > These look like sensible patches to rebase future work on, IMO. The 1.3
> > updates had been prepared a while ago, at least.
> 
> I think Philippe's "hw/block/nvme: Fix I/O BAR structure" series is a
> no-brainer. It just needs to get in asap.

I think we need to talk about how nvme patches are supposed to get
merged. I'm not familiar with the hardware nor the code, so the model
was that I just blindly merge patches that Keith has reviewed/acked,
just to spare him the work to prepare a pull request. But obviously, we
started doing things this way when there was a lot less activity around
the nvme emulation.

If we find that this doesn't scale any more, maybe we need to change
something. Depending on how much time Keith can spend on review in the
near future and how much control he wants to keep over the development,
I could imagine adding Klaus to MAINTAINERS, either as a co-maintainer
or as a reviewer. Then I could rely on reviews/acks from either of you
for merging series.

Of course, the patches don't necessarily have to go through my tree
either if this only serves to complicate things these days. If sending
separate pull requests directly to Peter would make things easier, I
certainly wouldn't object.

Kevin


