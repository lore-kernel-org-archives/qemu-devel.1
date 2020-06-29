Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9ABC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 14:54:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A37B2337F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 14:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BbbUrDU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A37B2337F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpvB8-0004rp-Cy
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 10:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jpvA9-0004Pz-P3
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 10:53:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33015
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jpvA3-0003OK-Tm
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 10:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593442410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XemuANQiAmEssS0829iSqZwMA1GM/3thXXsBgjhpjRk=;
 b=BbbUrDU+FCqngCyQ7DvQ2dGQk55hczbViAMrW8e5ExZJZumH4OdsLJmzjXWR9KMUSDcSLb
 EIZjjY/WuzatpI0S9A8R44kyMAoUnNtIf3hhkvcCGuxH6zwNPs429RRAtrEBhS30ci8gRf
 kWiTpLfEiO3MoE034mZzHz6NVZhdxlc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-uqzqaTqEPb-xpkhWCap1dA-1; Mon, 29 Jun 2020 10:53:27 -0400
X-MC-Unique: uqzqaTqEPb-xpkhWCap1dA-1
Received: by mail-wr1-f71.google.com with SMTP id g14so16640026wrp.8
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 07:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XemuANQiAmEssS0829iSqZwMA1GM/3thXXsBgjhpjRk=;
 b=AWw/m8vAIB+zqwNrWNX3X5dYPBcitcTKYbiAmAmeaOS7S2/fd+PxpSkWPgMfa0vwKC
 qXN/lAqcRE9fKZtEzPxz1hjMFklBJLbuvltvQ10IK5XCcuemu0+V72muTh5yOtOgYxXE
 OI1x926YvdkT1SMIUXctDsYwdHRe1x+BwjGCvE0HsUDQ0mE4BQvKvudBlI+V0qBUffsE
 Q937qJHyEg2pfMbDMRNaywNG40Dmw5GBuySUWjioijpEvVs9d2DTDOxes+0gDHCoRl2h
 ej2enap8xhl2IfqKELVEn1NZ0Jv/JE9HESTRnBR9hX6DrSOtiLeCsqUjMT68qtXnW+P1
 JEHg==
X-Gm-Message-State: AOAM533JS/NxJ/JR6GjfsWOdwu1LanqscR/dRwziq5iEZKkKPDxB9aAp
 i+694l2xt7hSc4RnRR3gOVJUXq+uaqWZ/KPy4PdGKMSbDS5ZgBPY6GeKDePTymFiCAkngyCHPN2
 n9EaRfhTDLOdqopg=
X-Received: by 2002:adf:8b50:: with SMTP id v16mr18170957wra.188.1593442406482; 
 Mon, 29 Jun 2020 07:53:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyD72bWfiytC94LOBqy6O+WRMnyZHdE3uVnRUtSk7YV+nrELEEFmr64Db/KTH/vNOJLorxrkw==
X-Received: by 2002:adf:8b50:: with SMTP id v16mr18170941wra.188.1593442406271; 
 Mon, 29 Jun 2020 07:53:26 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 u74sm16381wmu.31.2020.06.29.07.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 07:53:25 -0700 (PDT)
Date: Mon, 29 Jun 2020 10:53:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH RFC] virtio-fs: force virtio 1.x usage
Message-ID: <20200629104948-mutt-send-email-mst@kernel.org>
References: <20200629102758.421552-1-cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200629102758.421552-1-cohuck@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:06:01
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 29, 2020 at 12:27:58PM +0200, Cornelia Huck wrote:
> virtio-fs devices are only specified for virtio-1, so it is unclear
> how a legacy or transitional device should behave.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> 
> Forcing off legacy now (after the virtio-fs device has already been
> available) may have unintended consequences, therefore RFC.
> 
> By default, a virtio-pci device uses 'AUTO' for disable_legacy, which
> will resolve to different values based upon which bus the device has
> been plugged. Therefore, forcing disable_legacy may result in the same
> device or a quite different one.
> 
> Even though pre-virtio-1 behaviour of virtio-fs devices is simply not
> specified, toggling disable_legacy will have implications for the BAR
> layout, IIRC, and therefore a guest might end up getting a different
> device, even if it always used it with virtio-1 anyway.
> 
> Not sure what the best way to solve this problem is. Adding a compat
> property for disable_legacy=AUTO may be the right thing to do, but I'm
> not quite clear if there are any further implications here.

Well I notice that this device is not migrateable.
So I think that we can just switch it over and be done with it.


> Whatever we do here, we should make sure that the ccw incarnation of
> this device indeed forces virtio-1.

I agree. I notice that the API virtio_pci_force_virtio_1 turned out
to be too fragile. I propose that instead we have a whitelist of
devices which can be legacy or transitional. Force rest to modern.


> ---
>  hw/virtio/vhost-user-fs-pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/virtio/vhost-user-fs-pci.c b/hw/virtio/vhost-user-fs-pci.c
> index e11c889d82b3..244205edf765 100644
> --- a/hw/virtio/vhost-user-fs-pci.c
> +++ b/hw/virtio/vhost-user-fs-pci.c
> @@ -44,6 +44,7 @@ static void vhost_user_fs_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>          vpci_dev->nvectors = dev->vdev.conf.num_request_queues + 2;
>      }
>  
> +    virtio_pci_force_virtio_1(vpci_dev);
>      qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
>  }
>  
> -- 
> 2.25.4


