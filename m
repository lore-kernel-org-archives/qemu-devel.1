Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F476C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:10:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D147207BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Znzhp+c8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D147207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdRI-0008GG-DK
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jqdG0-0004rG-Rw
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:58:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23312
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jqdFz-0005zZ-4h
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593611914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QrIOMOmIcQInM0zOXDMWR1ys83jNQzl68Lwey36atNs=;
 b=Znzhp+c87M/sLrDXWQNgXLceHb1iGVYGGQYMi0RHsZyLRRpe87Ev05laFJxBVKLVXtSA3F
 3za++6rXlr9RTt2ge9gAJovYxv2Ak7EvPys+kscc+lg0wl0qBzVl3fEqy36ysVwotQcMJr
 V30IokLVhePDLKkb0kjifJrwm+HnzVg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-AbH0u8VePca7krFRcpZcjA-1; Wed, 01 Jul 2020 09:58:32 -0400
X-MC-Unique: AbH0u8VePca7krFRcpZcjA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97BAC80183C
 for <qemu-devel@nongnu.org>; Wed,  1 Jul 2020 13:58:31 +0000 (UTC)
Received: from gondolin (ovpn-113-61.ams2.redhat.com [10.36.113.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D2B824F6A4;
 Wed,  1 Jul 2020 13:58:21 +0000 (UTC)
Date: Wed, 1 Jul 2020 15:58:19 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio-fs: force virtio 1.x usage
Message-ID: <20200701155819.55c64224.cohuck@redhat.com>
In-Reply-To: <20200630074918-mutt-send-email-mst@kernel.org>
References: <20200629102758.421552-1-cohuck@redhat.com>
 <20200629104948-mutt-send-email-mst@kernel.org>
 <20200629173933.35cea40f.cohuck@redhat.com>
 <20200629114515-mutt-send-email-mst@kernel.org>
 <20200630113527.7b27f34f.cohuck@redhat.com>
 <20200630064227-mutt-send-email-mst@kernel.org>
 <20200630133043.2be1d209.cohuck@redhat.com>
 <20200630074918-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:05:53
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
Cc: Eric Auger <eric.auger@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jun 2020 09:02:31 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Jun 30, 2020 at 01:30:43PM +0200, Cornelia Huck wrote:
> > On Tue, 30 Jun 2020 06:45:42 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > On Tue, Jun 30, 2020 at 11:35:27AM +0200, Cornelia Huck wrote:  

> > > > First, I noticed that virtio-iommu does not force virtio-1, either; I
> > > > think it should? Eric?
> > > > 
> > > > Then, there's the mechanism using different names for transitional and
> > > > non-transitional devices. Devices that support both usually define both
> > > > names (with disable_legacy and disable_modern set appropriately) and a
> > > > base name (where the properties can be set manually for the desired
> > > > effect). Most virtio-1 only devices set neither the non-transitional
> > > > nor the transitional name and rely on virtio_pci_force_virtio_1() to
> > > > disable legacy support. But there are outliers:
> > > > 
> > > > * this device: it has only a non-transitional name
> > > >   ("vhost-user-fs-pci"), which means we automatically get the correct
> > > >   configuration; in order to define a transitional/legacy device, you
> > > >   would need to use the base name "vhost-user-fs-pci-base" explicitly,
> > > >   and it's unlikely that someone has been doing that.
> > > > * virtio-iommu (which I *think* is a virtio-1 only device): it defines
> > > >   the full set of transitional, non-transitional, and base names.
> > > > 
> > > > How should we proceed?
> > > > * With this patch here, we can fence off the very unlikely possibility
> > > >   of somebody configuring a non-modern virtio-fs device for pci. We
> > > >   probably should do it, but I don't think we need compat handling.
> > > > * For virtio-iommu, we should get an agreement what the desired state
> > > >   is. If it really should be modern only, we need compat handling, as
> > > >   the device had been added in 5.0. (And we need to figure out how to
> > > >   apply that compat handling.)    
> > > 
> > > 
> > > Well I know it's not really used on x86 yet, so no problem there.
> > > 
> > > Which machines are actually affected?  
> > 
> > I'd suspect ARM, but breaking even a subset is not nice.  
> 
> OK so MMIO does not have transitional at all right?

IIRC, yes.

But I think there are ARM machines that use virtio-pci as well, right?


