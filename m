Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0EBC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 08:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22C9A20714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 08:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ewpH+VyG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C9A20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1nFU-0004AO-9u
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 03:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j1nEo-0003Fy-6e
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 03:19:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j1nEk-0004CF-OI
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 03:19:12 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44933
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j1nEk-00049t-Ga
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 03:19:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581495548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qUXVcjehGq7OvZm9lAbu+qnRwb9r0Dmhj/3TwZjythI=;
 b=ewpH+VyGwPupOyY3ssiyuntvppWQLlx57UkjxQbHsauE+qpRnjTTE/E88RzM/EfWOdfDfZ
 QkgLHTrITQCVeD3iaYAEwaiT8vKeZdN43hROEUnjY8ZkJluOQN9eVNvyIk/1Pk1GfKURW5
 8C5TA+8r+4ZWARACHp7GujtumqY1YNA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-0PNa9B_wNBCyp5f4DHfNcg-1; Wed, 12 Feb 2020 03:19:03 -0500
Received: by mail-qv1-f71.google.com with SMTP id de8so944592qvb.16
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 00:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=EoDtK+hRJA9oLfg2EbJN/Grnn0SbIx7vrfQip2G4KnY=;
 b=jIMgeYxnl5jClhH1G6WO+3hGQpZU0pjROHlzNhlhGuY91hLvRjulkMsNzgtZYKdZSJ
 gkxW/gIfWWCmyUYBbkIxFCkd2lSrJ8beto47snMZU0eOIeyD78lIFnVizTey3CxPDT6p
 mz17GBpVYe8R0SEBDopTKOpXkT9dIJtIRysmWprGD0QS/g5fTxuuMxnVp9HZRMdKbn1f
 8cTswNQe5baJ5I8lQgrsW2T2cXX8XclEtfhDBZzWglh7Qfu/2uMvOSrCxZ/DiejOvGrU
 oQv4OSkY1b4f1GZto4sGkrrTqs6ObQ1Gp+WwAU7xWZtuWk8xW32neD9Egp4lEYwoSaxG
 b2Pg==
X-Gm-Message-State: APjAAAWTHDeiSkHs01CbknYBgD7Kt9Vy6/KZwhEnLWqg6UzHAK+KHNn4
 Bo/IhHNKPqj6787triu2h9aSJnCHElaTncl9iV2BTRjK1L7rsRpnx2e4kB0v4Yo7M+Hua1EeG7j
 mhGIgA4S4WE0hXA8=
X-Received: by 2002:ae9:eb4b:: with SMTP id b72mr5998866qkg.316.1581495543146; 
 Wed, 12 Feb 2020 00:19:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqwTyMar0/OsjMBaqlOf+gA2ZS0CQ7snrBolXpR8Rj24500NDWQIaqutLJBRjx+fU7ShGzK/6w==
X-Received: by 2002:ae9:eb4b:: with SMTP id b72mr5998856qkg.316.1581495542934; 
 Wed, 12 Feb 2020 00:19:02 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id d197sm3455610qkc.16.2020.02.12.00.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 00:19:02 -0800 (PST)
Date: Wed, 12 Feb 2020 03:18:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 1/5] virtio-mmio: add notify feature for per-queue
Message-ID: <20200212024158-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <8a4ea95d6d77a2814aaf6897b5517353289a098e.1581305609.git.zhabin@linux.alibaba.com>
 <20200211062205-mutt-send-email-mst@kernel.org>
 <ef613d3a-0372-64f3-7644-2e88cc9d4355@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ef613d3a-0372-64f3-7644-2e88cc9d4355@redhat.com>
X-MC-Unique: 0PNa9B_wNBCyp5f4DHfNcg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: virtio-dev@lists.oasis-open.org, Zha Bin <zhabin@linux.alibaba.com>,
 slp@redhat.com, jing2.liu@linux.intel.com, linux-kernel@vger.kernel.org,
 qemu-devel@nongnu.org, chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 12, 2020 at 11:39:54AM +0800, Jason Wang wrote:
>=20
> On 2020/2/11 =E4=B8=8B=E5=8D=887:33, Michael S. Tsirkin wrote:
> > On Mon, Feb 10, 2020 at 05:05:17PM +0800, Zha Bin wrote:
> > > From: Liu Jiang<gerry@linux.alibaba.com>
> > >=20
> > > The standard virtio-mmio devices use notification register to signal
> > > backend. This will cause vmexits and slow down the performance when w=
e
> > > passthrough the virtio-mmio devices to guest virtual machines.
> > > We proposed to update virtio over MMIO spec to add the per-queue
> > > notify feature VIRTIO_F_MMIO_NOTIFICATION[1]. It can allow the VMM to
> > > configure notify location for each queue.
> > >=20
> > > [1]https://lkml.org/lkml/2020/1/21/31
> > >=20
> > > Signed-off-by: Liu Jiang<gerry@linux.alibaba.com>
> > > Co-developed-by: Zha Bin<zhabin@linux.alibaba.com>
> > > Signed-off-by: Zha Bin<zhabin@linux.alibaba.com>
> > > Co-developed-by: Jing Liu<jing2.liu@linux.intel.com>
> > > Signed-off-by: Jing Liu<jing2.liu@linux.intel.com>
> > > Co-developed-by: Chao Peng<chao.p.peng@linux.intel.com>
> > > Signed-off-by: Chao Peng<chao.p.peng@linux.intel.com>
> > Hmm. Any way to make this static so we don't need
> > base and multiplier?
>=20
>=20
> E.g page per vq?
>=20
> Thanks

Problem is, is page size well defined enough?
Are there cases where guest and host page sizes differ?
I suspect there might be.

But I also think this whole patch is unproven. Is someone actually
working on QEMU code to support pass-trough of virtio-pci
as virtio-mmio for nested guests? What's the performance
gain like?

--=20
MST


