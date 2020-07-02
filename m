Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2803CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:25:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E538B206DD
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULX5bAzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E538B206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqwOz-00020g-5K
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 06:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqwOK-0001Zq-1P
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 06:24:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39749
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqwOH-0007dv-NP
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 06:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593685463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MUk2aAcWmM/f12tQIphC8WFrAQrL+dFs4W/fqsOd9Ow=;
 b=ULX5bAzlbISGVKMwHqkmdTcacuVHJYW5AmxXMNJoR4YpAeH+cr1NAsaspk4LUmG0N3TvSw
 h2IZw/zBREe09T4gcgPOwZBDtREgXYIGZfo9flW11ISKWOIP/RnVIrFA6TaqWe2o4Gh+uP
 4zG+Rqbk0k1dm9XYN1zrT4ZyRkxzOXA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-7R_iWXdXMX2XE94BI9z90A-1; Thu, 02 Jul 2020 06:24:22 -0400
X-MC-Unique: 7R_iWXdXMX2XE94BI9z90A-1
Received: by mail-wr1-f69.google.com with SMTP id g14so24765254wrp.8
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 03:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MUk2aAcWmM/f12tQIphC8WFrAQrL+dFs4W/fqsOd9Ow=;
 b=WWiDx8EFBTc9OXD+X7ACJZ+I2xTj5hFukDw9pHd3eIMqAfta/JEFWUeA+JY43VTHO8
 dlnz1cW8faBz5SjaZ928bbJa00D9As0MdLYaiYHvwx9aVAJh1hHVDDOAe5Q6kxEcnfGc
 qt6MJ6aRUXBQaniqc6wP7l8178e1IMYkGbGyDJRAaCkUtWL8i8tfjX4V5vB9vmmbb5Fn
 SloZLWQIxAa9EZDla/K+O+GJDV/IpphlccBucgKL5B6RJ67tgEB0dpPBBDAufyyLOF2C
 JY/r9K0NUuG9kAtMfRKm+kf4nshh95P93t+43WBmYJ/IxVWZFR3+TMgk5wAQUekUMdq4
 WdOg==
X-Gm-Message-State: AOAM531r9qBAH1W7jHUoAootYjaPN9wz8+qNrItk2vj+ScCdbT4FE406
 JaEllS0BH0J4OtIcbxCur9DlL7kTUsmzT0M3T98Vr9AV1u+Xc9GwXqpBDPpuBho29MNDK2tiXRz
 fUplZYEXmom8Oxlo=
X-Received: by 2002:a1c:3c82:: with SMTP id
 j124mr33127208wma.155.1593685460842; 
 Thu, 02 Jul 2020 03:24:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycZgtBn+qYM+eicbvEADuaU+YMouO48rm6S2tQkUt29Q20uUu0b/ofyFM90vzmfwnKDAnaUg==
X-Received: by 2002:a1c:3c82:: with SMTP id
 j124mr33127189wma.155.1593685460648; 
 Thu, 02 Jul 2020 03:24:20 -0700 (PDT)
Received: from redhat.com ([93.157.82.4])
 by smtp.gmail.com with ESMTPSA id r1sm9984689wrw.24.2020.07.02.03.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 03:24:19 -0700 (PDT)
Date: Thu, 2 Jul 2020 06:24:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH RFC] virtio-fs: force virtio 1.x usage
Message-ID: <20200702061631-mutt-send-email-mst@kernel.org>
References: <20200629102758.421552-1-cohuck@redhat.com>
 <20200629104948-mutt-send-email-mst@kernel.org>
 <20200629173933.35cea40f.cohuck@redhat.com>
 <20200629114515-mutt-send-email-mst@kernel.org>
 <20200630113527.7b27f34f.cohuck@redhat.com>
 <20200630064227-mutt-send-email-mst@kernel.org>
 <20200630133043.2be1d209.cohuck@redhat.com>
 <20200630074918-mutt-send-email-mst@kernel.org>
 <20200701155819.55c64224.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200701155819.55c64224.cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:23:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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
Cc: Eric Auger <eric.auger@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 01, 2020 at 03:58:19PM +0200, Cornelia Huck wrote:
> On Tue, 30 Jun 2020 09:02:31 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Tue, Jun 30, 2020 at 01:30:43PM +0200, Cornelia Huck wrote:
> > > On Tue, 30 Jun 2020 06:45:42 -0400
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >   
> > > > On Tue, Jun 30, 2020 at 11:35:27AM +0200, Cornelia Huck wrote:  
> 
> > > > > First, I noticed that virtio-iommu does not force virtio-1, either; I
> > > > > think it should? Eric?
> > > > > 
> > > > > Then, there's the mechanism using different names for transitional and
> > > > > non-transitional devices. Devices that support both usually define both
> > > > > names (with disable_legacy and disable_modern set appropriately) and a
> > > > > base name (where the properties can be set manually for the desired
> > > > > effect). Most virtio-1 only devices set neither the non-transitional
> > > > > nor the transitional name and rely on virtio_pci_force_virtio_1() to
> > > > > disable legacy support. But there are outliers:
> > > > > 
> > > > > * this device: it has only a non-transitional name
> > > > >   ("vhost-user-fs-pci"), which means we automatically get the correct
> > > > >   configuration; in order to define a transitional/legacy device, you
> > > > >   would need to use the base name "vhost-user-fs-pci-base" explicitly,
> > > > >   and it's unlikely that someone has been doing that.
> > > > > * virtio-iommu (which I *think* is a virtio-1 only device): it defines
> > > > >   the full set of transitional, non-transitional, and base names.
> > > > > 
> > > > > How should we proceed?
> > > > > * With this patch here, we can fence off the very unlikely possibility
> > > > >   of somebody configuring a non-modern virtio-fs device for pci. We
> > > > >   probably should do it, but I don't think we need compat handling.
> > > > > * For virtio-iommu, we should get an agreement what the desired state
> > > > >   is. If it really should be modern only, we need compat handling, as
> > > > >   the device had been added in 5.0. (And we need to figure out how to
> > > > >   apply that compat handling.)    
> > > > 
> > > > 
> > > > Well I know it's not really used on x86 yet, so no problem there.
> > > > 
> > > > Which machines are actually affected?  
> > > 
> > > I'd suspect ARM, but breaking even a subset is not nice.  
> > 
> > OK so MMIO does not have transitional at all right?
> 
> IIRC, yes.
> 
> But I think there are ARM machines that use virtio-pci as well, right?


Right :(

I guess we do need a compat property for that.


-- 
MST


