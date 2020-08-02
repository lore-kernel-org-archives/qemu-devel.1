Return-Path: <SRS0=xk1j=BM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC26C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2020 05:14:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E514D2075A
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2020 05:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XjbTw9/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E514D2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k26KW-000671-4f
	for qemu-devel@archiver.kernel.org; Sun, 02 Aug 2020 01:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k26Jx-0005gi-N0
 for qemu-devel@nongnu.org; Sun, 02 Aug 2020 01:14:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44216
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k26Jv-0004kj-B4
 for qemu-devel@nongnu.org; Sun, 02 Aug 2020 01:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596345241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VTnxfCts2RzMRFnCi4ffrOF3VbZeyt+xTn4uuuB9KuM=;
 b=XjbTw9/RaNAmG96v1itl42WT6NcPDRuJIpdu6z/A63FtcuBTWaSp6KGui1b5LWH5ZiUvOI
 jQrJeGGEzK2ZxX577YqigatxbJ7YGv9AfounroaLCi25aqfrngZDT74Wbo9isTezHs8I4s
 cmyc98Nfh3B6vH/URV7ceeyfiN4ObqM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-9D2r9xDHOKeGU0nTmG8hcQ-1; Sun, 02 Aug 2020 01:13:58 -0400
X-MC-Unique: 9D2r9xDHOKeGU0nTmG8hcQ-1
Received: by mail-wr1-f69.google.com with SMTP id b8so635823wrr.2
 for <qemu-devel@nongnu.org>; Sat, 01 Aug 2020 22:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VTnxfCts2RzMRFnCi4ffrOF3VbZeyt+xTn4uuuB9KuM=;
 b=mTNapk1d/g486B1JBIxY11DjgMr8PdgbasnCxlTcBEKpxIlDGXRXEBUbeJ6awTzpZc
 vYGDAh4gKFlpmvpFP/uTPXIpU0anjKbczrGZjW+1lX8uuEgIBFxLbPV+FGU7lGJbf6pN
 eDP1ydv2hU7kjPKD09X0fp117OYAsNgb+PFfmIonxgJdNcW28mAPQGDeaMYsZ5CRwm90
 CZZjnaFoGODuBF+VhMabK61e+7VqpwEB+v3T/GDqU47xiuMPmHw++IvPZh8QN5RD0dnE
 qwtwLO9qtDtmvzHAIzIIhOvcIfcEwFs85pGe7DvF3wh+xIo36Z8t/yQkypdkKIXmmzNe
 VQfw==
X-Gm-Message-State: AOAM533LcL3Qh0Kox8UC/O30uuFiJsp00lHSmQm36JvoBWuzusDAKZd2
 JxxxXP4zhsXzQ/OjqZ3AMZ5fyC0AeB+covnYhPopBwTinmmwoWhD28/Pfmw1PHAOqOe1RDrtRkC
 hzF+rFhwVThmFvyI=
X-Received: by 2002:a1c:6446:: with SMTP id y67mr10443478wmb.49.1596345237406; 
 Sat, 01 Aug 2020 22:13:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbqrRrpjzcbZiN70pmuewDCHBr5bMQ9tlZ7hVrrTqNfNrG20SkfUrNzaUYchA3vUHc8m7BIg==
X-Received: by 2002:a1c:6446:: with SMTP id y67mr10443464wmb.49.1596345237225; 
 Sat, 01 Aug 2020 22:13:57 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
 by smtp.gmail.com with ESMTPSA id g188sm20416034wma.5.2020.08.01.22.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2020 22:13:56 -0700 (PDT)
Date: Sun, 2 Aug 2020 01:13:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [PATCH 0/2] Enable virtio-fs on s390x
Message-ID: <20200802011337-mutt-send-email-mst@kernel.org>
References: <20200730140731.32912-1-mhartmay@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200730140731.32912-1-mhartmay@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/02 01:03:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
> 
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

Who's merging this? My tree?

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


