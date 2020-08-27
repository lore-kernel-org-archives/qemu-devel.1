Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1736C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:20:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B416122CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cIovM4AY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B416122CB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBGtS-0004TX-0I
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 08:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBGsm-00043L-L4
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:19:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38682)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBGsk-0003H0-EY
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598530793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bf+OftH49N6l7PUMIlyY/NYRyXHl4CnG20tH5dG/GEM=;
 b=cIovM4AYqnvUiUvA8IsgeAF9smOkvl+NISE6uEyRTCQc60yNJR0da5VwfgMCmiptW5v7UQ
 utBBUYAYSydc5yAPyEXz87pJ8Zc4Up05fmlw0xy+L4QQvoW/8GqhJk/ra9GWDoZ2+2hvEm
 qGByiINz2zqFqzCfbzyncw6sppmTQdA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-eH7KUh8tNlC7AOPbK3-QjQ-1; Thu, 27 Aug 2020 08:19:49 -0400
X-MC-Unique: eH7KUh8tNlC7AOPbK3-QjQ-1
Received: by mail-wr1-f70.google.com with SMTP id 3so1485211wrm.4
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 05:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bf+OftH49N6l7PUMIlyY/NYRyXHl4CnG20tH5dG/GEM=;
 b=seJOfDbqGvo+JiBDp7arwCF9ijE1Wj0mJhwnYjm+vq6YnyWMHTKQl895h7tnyFw3Hf
 mpscEvISOZ3g5MRBjDi38VBzG7T9QGb+0XO7EieCNpxM1LQmX414/kS7oPTWz8Ja4SBj
 dcsJNJR7Yo8qP936sAHckVW66a+kt6jguxTbEva8M8zK3xdYY4V9lSmrYSO2BvXUI4iO
 CR9fpJVKvYB0F6Sqjl8Go4JP2N3NwO2FQX0mmPYG9RRAg8P1dO044QOyoEvP6xG78l9H
 Quc04KuYH2LY6GEUylB6INqAzuTytff4DC6OUd6WPcsxyOZwDtxy3k2ba76BA5k0gsPa
 F5sg==
X-Gm-Message-State: AOAM530+YkTh2GrGSBLyVNtVCalSkyd7lsVBlE1P7zrOmTylcBwh5zDo
 lnLDXHsCv9IJ50eQn+kkroB6PrVIN3I+WeQBDXCoB5OwXmZ8A13n2hUIGw5iVVF3K3G/H6wsrGC
 KDBr2QyGziJu95YA=
X-Received: by 2002:adf:c981:: with SMTP id f1mr19942127wrh.14.1598530788119; 
 Thu, 27 Aug 2020 05:19:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8RJJZg3JqZ+pNLVfdbSMoNV2C3USB9lWOdubrlWyVDsT5nMVSwRp9j3TsRA3Sdn4NFYimjg==
X-Received: by 2002:adf:c981:: with SMTP id f1mr19942107wrh.14.1598530787897; 
 Thu, 27 Aug 2020 05:19:47 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id j7sm5065291wmj.38.2020.08.27.05.19.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 05:19:46 -0700 (PDT)
Date: Thu, 27 Aug 2020 08:19:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [PATCH 0/2] Enable virtio-fs on s390x
Message-ID: <20200827081857-mutt-send-email-mst@kernel.org>
References: <20200730140731.32912-1-mhartmay@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200730140731.32912-1-mhartmay@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:54:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 30, 2020 at 04:07:29PM +0200, Marc Hartmayer wrote:
> This patch series is about enabling virtio-fs on s390x. For that we need
>  + some shim code (first patch), and we need
>  + libvhost-user to deal with virtio endiannes for non-legacy virtio
>    devices as mandated by the spec.


Please rebase, address Cornelia's minor comments and repost.
Thanks!

> How to use?
> 
> For general instructions how to use virtio-fs (on x86) please have a
> look at https://virtio-fs.gitlab.io/howto-qemu.html. Most of the
> instructions can also be applied on s390x.
> 
> In short:
> 
> 1. Install self-compiled QEMU with this patch series applied
> 2. Prepare host and guest kernel so they support virtio-fs
> 
> Start virtiofsd on the host
> 
>  $ virtiofsd -f --socket-path=/tmp/vhostqemu -o source=/tmp/shared
> 
> Now you can start QEMU in a separate shell on the host:
> 
>  $ qemu-system-s390x -machine type=s390-ccw-virtio,accel=kvm,memory-backend=mem \
>    -object memory-backend-file,id=mem,size=2G,mem-path=/dev/shm/virtiofs,share=on,prealloc=on,prealloc-threads=1 \
>    -chardev socket,id=char0,path=/tmp/vhostqemu -device vhost-user-fs-ccw,queue-size=1024,chardev=char0,tag=myfs \
>    -drive if=virtio,file=disk.qcow2 \
>    -m 2G -smp 2 -nographic
> 
> Log into the guest and mount it
> 
>  $ mount -t virtiofs myfs /mnt
> 
> Changelog:
>  RFC v2 -> v1:
>  - patch 1:
>   + Added `force_revision_1 = true` (Conny)
>   + I didn't add the r-b from Stefan Hajnoczi as I've added the
>     changes suggested by Conny
>  - squashed patches 2 and 3:
>   + removed assertion in performance critical code path (Stefan)
>   + dropped all dead code (Stefan)
>   + removed libvhost-access.h
>   
>  RFC v1 -> RFC v2:
>   + rebased
>   + drop patch "libvhost-user: print invalid address on vu_panic" as it's not related to this series
>   + drop patch "[RFC 4/4] HACK: Hard-code the libvhost-user.o-cflags for s390x"
>   + patch "virtio: add vhost-user-fs-ccw device": replace qdev_set_parent_bus and object_property_set_bool by qdev_realize
>   + patch "libvhost-user: handle endianness as mandated by the spec":
>     Drop support for legacy virtio devices
>   + add patch to fence legacy virtio devices
> *** BLURB HERE ***
> 
> Halil Pasic (1):
>   virtio: add vhost-user-fs-ccw device
> 
> Marc Hartmayer (1):
>   libvhost-user: handle endianness as mandated by the spec
> 
>  contrib/libvhost-user/libvhost-user.c | 77 +++++++++++++++------------
>  hw/s390x/Makefile.objs                |  1 +
>  hw/s390x/vhost-user-fs-ccw.c          | 75 ++++++++++++++++++++++++++
>  3 files changed, 119 insertions(+), 34 deletions(-)
>  create mode 100644 hw/s390x/vhost-user-fs-ccw.c
> 
> -- 
> 2.25.4


