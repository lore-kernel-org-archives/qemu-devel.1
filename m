Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DF7C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:10:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A6AC2087D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qy5XReJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6AC2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIskC-0003Y7-Vm
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 08:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kIsjb-000384-RE
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 08:09:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46751
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kIsja-0001kh-8w
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 08:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600344593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=abBBFR1Y2UxM9EfpNxeZU8aFA0XSAIUvz2SAb7IJX6E=;
 b=Qy5XReJVRL+N9CQCyaAOSQWk7+kq41TWSjMXER10v3WA0MQmpuB3jKgPFY+iHrt4S1VrAY
 v50T25AVPSgzzh9zewFh9ddAGAqV+l58X5XZ5f/fYV2bjGbniCUsPmOdoL/vx0fQZwEu4c
 xsrJuNRya5iCD39rwo3U6v14kc2og9A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-yejLpCJJM8aSP5jHneAoZw-1; Thu, 17 Sep 2020 08:09:51 -0400
X-MC-Unique: yejLpCJJM8aSP5jHneAoZw-1
Received: by mail-wr1-f72.google.com with SMTP id 33so796963wrk.12
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 05:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=abBBFR1Y2UxM9EfpNxeZU8aFA0XSAIUvz2SAb7IJX6E=;
 b=VOR+x377wUSXl5ubM3NliQSQTLc3QfZKevtKyiL0YW9rUuY4cqJl2mRDLDFeAlqxF+
 cHPl0X3I0TkgYypbFHmFzovW1AWMAC0woLP+ws+zidPUyZfpkJWmcB6gekOFohYoLLKh
 xC4QqV7G74UMaVpFEVxy7wEQ/v5tVrL4c7YLogD2GAu0vEY3hSFeAWEln9EfZBNZJLZ2
 V02TKflfXa2uYOO93dijsKQxmawZauFgBSjWFJ4uRu66Nd48+SoDCP9kDEznwg7fGef4
 hqUR2ljTW1HjO8BXpJ09ZGLBHDdLPxTr3juE7e9gbdZtkIxLazBeZGPCH5FAr7lgQiDy
 kkeg==
X-Gm-Message-State: AOAM530PKVoisEaJqDWXE1aaKcEWobx7AmpsbAzRBHsiRKfx5VAZEZg3
 NtvqBa/W/Q0gySjpNJoUZKXITVQO4gAUJodUdL4xQJu9aW6vyWsW73u46MnAwk/Te1j6ky4VPNC
 NLw5KDEw3KTucAt4=
X-Received: by 2002:a5d:4e8a:: with SMTP id e10mr32327915wru.329.1600344590370; 
 Thu, 17 Sep 2020 05:09:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxAO3INnUiOiMhp0EGBV7+U3Gm7i7B2sFdVkPfz+6GKH83fukFr+2UP/C2AxOTHVaS62UUaQ==
X-Received: by 2002:a5d:4e8a:: with SMTP id e10mr32327895wru.329.1600344590170; 
 Thu, 17 Sep 2020 05:09:50 -0700 (PDT)
Received: from steredhat (host-79-51-197-141.retail.telecomitalia.it.
 [79.51.197.141])
 by smtp.gmail.com with ESMTPSA id f14sm38549606wrv.72.2020.09.17.05.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 05:09:49 -0700 (PDT)
Date: Thu, 17 Sep 2020 14:09:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2] virtio: skip legacy support check on machine types
 less than 5.1
Message-ID: <20200917120946.i4phvtpbkgyuouxk@steredhat>
References: <20200915130514.80989-1-sgarzare@redhat.com>
 <20200916110848.47395807.cohuck@redhat.com>
 <20200917084828.p7j3fc6p4almxbxw@steredhat>
 <20200917112256.796f620d.cohuck@redhat.com>
 <20200917100000.GF2793@work-vm>
 <20200917104721.pbfik4t6zszflama@steredhat>
 <20200917130008.79a1637b.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200917130008.79a1637b.cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 03:47:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 17, 2020 at 01:00:08PM +0200, Cornelia Huck wrote:
> On Thu, 17 Sep 2020 12:47:21 +0200
> Stefano Garzarella <sgarzare@redhat.com> wrote:
> 
> > Okay, so I'll leave the device property.
> > 
> > 
> > I also need to update a series [1] that I sent to force virtio version 1
> > on vhost-vsock devices.
> > Also in this case I need to care about migration and force it only on new
> > machine types.
> > 
> > Do you think I can reuse the same property also in vhost-vsock-pci and
> > vhost-vsock-ccw to force virtio version 1, or it is better to add a new
> > property for each device.
> > 
> > The two things (disable legacy check and force version 1) are related,
> > so maybe I can use a single property in the virtio-device class,
> 
> So, 'x-disable-legacy-check==false' -> 'we need to force version 1'?

Exaclty :-)

> Seems reasonable to me.

Thanks for the feedback, I'll go this way!

Stefano


