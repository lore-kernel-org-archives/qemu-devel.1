Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98ECCC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 10:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51618205CB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 10:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kv4+XnTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51618205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc4aV-00040Z-IX
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 06:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1jc4Zm-0003ZW-8X
 for qemu-devel@nongnu.org; Fri, 22 May 2020 06:06:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20361
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1jc4Zj-0002jl-Qj
 for qemu-devel@nongnu.org; Fri, 22 May 2020 06:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590142005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dXZ8UtVTjPhRW/qkxoWSL3pyAiqLcgQTdNe1vty9BIs=;
 b=Kv4+XnTcwAUDpXtulFUY+zpA9jmjkBZ0H1rf2+c1RjHAWn7ib/plwjgtz9paOc306EUM64
 WzHgIhd1MWfBQUjL81rp5SM7XX47ErQtkYW99/8dlRC28QVjzbqaPUMfFt9MmrySiQkHBB
 AAnzwguQgkxFAUdiE/1LWAr14TAHo4c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-wcUed07QOJKj1glE9t9vfQ-1; Fri, 22 May 2020 06:06:43 -0400
X-MC-Unique: wcUed07QOJKj1glE9t9vfQ-1
Received: by mail-wr1-f72.google.com with SMTP id e14so4168234wrv.11
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 03:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dXZ8UtVTjPhRW/qkxoWSL3pyAiqLcgQTdNe1vty9BIs=;
 b=SJv8Lu2T+EjterLPA/i4NpCmzTHUZNjHX1HwdF8xZN1FqeM9NZg9jlspOz4Mst+QVR
 1lHx0ieRG9TRSHcocVY/vPHfaOSMh5+zDI2tgKRZOwwaoFtoKqLeOU2DNOhGY+4Ln+gI
 z9OjSQu2MzBusBNCYxz7r/JHblbIG49EUDFGSi3zQQVx9GUQ3Z0CpVja8FM3nX+KkD1H
 1Ol6k4ZzQsHyebnZi+HBmHjCPzKgRC9idDjARs+PdkjaBBn0plwtfVN3VlTqpgqHrBCW
 4/Ta4/xnkyWCWGBDvfWhFGjYbbXWgTs25DW1w8qswpHbetuuUxYucxqeSfgCXwprhIoI
 0rig==
X-Gm-Message-State: AOAM533rTdKr9FevtbvJKZ9CEURWoRu8ezkAONKLURAzsMvdWS4k+DXY
 qsES3VgDAYfWPIQVVGTa33mTuKNp6OqAlVGBRXFkHL1hBjgEGS50pnTYKx9XJB9u9+zEalt0iTF
 rgVHKOT441BLSAu0=
X-Received: by 2002:adf:a396:: with SMTP id l22mr2703835wrb.76.1590142002560; 
 Fri, 22 May 2020 03:06:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1JuY/GwikxX/5z/8wZ0Vaqr+MF0dwArNgBD9wHjJ69qf6AOPPJiQ3DKg5Pk7CJ/Jqhw3JqA==
X-Received: by 2002:adf:a396:: with SMTP id l22mr2703820wrb.76.1590142002334; 
 Fri, 22 May 2020 03:06:42 -0700 (PDT)
Received: from steredhat (host108-207-dynamic.49-79-r.retail.telecomitalia.it.
 [79.49.207.108])
 by smtp.gmail.com with ESMTPSA id b65sm9623179wmc.30.2020.05.22.03.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 03:06:41 -0700 (PDT)
Date: Fri, 22 May 2020 12:06:39 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 0/3] virtio: add vhost-user-vsock device
Message-ID: <20200522100639.ikxgfoacggxkljo6@steredhat>
References: <20200515152110.202917-1-sgarzare@redhat.com>
 <20200521143559.GL251811@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200521143559.GL251811@stefanha-x1.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 02:24:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Julio Montes <julio.montes@intel.com>,
 Sebastien Boeuf <sebastien.boeuf@intel.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 21, 2020 at 03:35:59PM +0100, Stefan Hajnoczi wrote:
> On Fri, May 15, 2020 at 05:21:07PM +0200, Stefano Garzarella wrote:
> > This series add vhost-user-vsock base device and its PCI version
> > (vhost-user-vsock-pci).
> > The vhost-user-vsock device can be used to implement the virtio-vsock
> > device emulation in user-space.
> > An use case might be Kata, where they prefer to emulate devices
> > in user-space.
> 
> Looks good.
> 
> My main concern is live migration. If it hasn't been tested, please
> remove the live migration code.
> 

Migration is not working:

    QEMU 5.0.50 monitor - type 'help' for more information
    (qemu) migrate -d tcp:0:3333
    Error: Migration disabled: vhost-user backend lacks VHOST_USER_PROTOCOL_F_LOG_SHMFD feature.

Thanks for pointing that out, I'll remove it in v2.

Stefano


