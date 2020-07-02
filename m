Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1F5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:18:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 380CA20780
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iYhJrJam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380CA20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqwIZ-0006ca-HG
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 06:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqwGQ-0004XJ-3v
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 06:16:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44099
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqwGM-0006YF-75
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 06:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593684972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7hm53UklKNaxr72axiNFOHvy+8xmgm9JxKcuqejvbp0=;
 b=iYhJrJamtGl2IshgU2bfmFybsUPSQCRICrBl/FpjruhiUU3WXrnJqa4acLHtsKUbKMhqG9
 +7zfPZEryyfE7y41dgIlNdaSGsho01s7bq1IFYkSf7pJWbJ5F/ngFWu7XExk71ta9dBcUL
 Ryz5GGzA5+Vy3hANXGD9z/VliuK+7r4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-LuVxfKTFNiakluAR4hdltg-1; Thu, 02 Jul 2020 06:16:11 -0400
X-MC-Unique: LuVxfKTFNiakluAR4hdltg-1
Received: by mail-wm1-f71.google.com with SMTP id h6so27833451wmb.7
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 03:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7hm53UklKNaxr72axiNFOHvy+8xmgm9JxKcuqejvbp0=;
 b=hijQaIvkI6M7/uN5zaHBx2SXSZFHgb8DUUDjK14PaPRT5sGKtYEN2FqhIoAVw9hRlq
 y91JQQCdEQdr5XMrZxoAeeSsHi6sAMjplBWpr8HT6AqWT1bJzinaEpUqu+NgODl+e0JY
 mfFCpZ80B9SGpAiHgEukdCVOJHN2uo4R2KshEg0FEbQABM+zMuGY6r5RFh+h+vD8loRE
 0oipOMIj92TVlgiP+XAzFz5V9PKwBAArAdLaV7VL8h5J7qj9KQ9OMUwbndzcLOHcAzE5
 PB3ynRbfn0dlvOaGc8XBZvWx0NIFLhTbxjStQh/HAkdtq4GQ+eoBKDbt/SmYZa02V3ot
 z3dA==
X-Gm-Message-State: AOAM533mMsQ/fdaD4RDfXmqH37sWRnmPgJMmEn3B3grkAVE+Or4yPaic
 IRQ+egNwI/112qNOrMajAKFsEOgpyWNCfGF3x4+r5WvHIgBgLHfHTGD/F0b0CL7WbiJ02mBFFQ0
 haHmRyhUbmqQsZQY=
X-Received: by 2002:adf:e2c9:: with SMTP id d9mr30514718wrj.227.1593684970157; 
 Thu, 02 Jul 2020 03:16:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxslDSVWMCk5cMTy8VcK5wktpF5pOTGcrrCSN1F9Yx/qJqD/JJlWyo5etDXqGw5aqzEhEzUUQ==
X-Received: by 2002:adf:e2c9:: with SMTP id d9mr30514704wrj.227.1593684969949; 
 Thu, 02 Jul 2020 03:16:09 -0700 (PDT)
Received: from redhat.com ([93.157.82.4])
 by smtp.gmail.com with ESMTPSA id d13sm10275286wrq.89.2020.07.02.03.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 03:16:09 -0700 (PDT)
Date: Thu, 2 Jul 2020 06:16:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH RFC] virtio-fs: force virtio 1.x usage
Message-ID: <20200702060555-mutt-send-email-mst@kernel.org>
References: <20200629102758.421552-1-cohuck@redhat.com>
 <20200630121037.GC91444@stefanha-x1.localdomain>
 <20200630142504.688aa989.cohuck@redhat.com>
 <20200630090327-mutt-send-email-mst@kernel.org>
 <20200701181917.62538421.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200701181917.62538421.cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:18:28
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 01, 2020 at 06:19:17PM +0200, Cornelia Huck wrote:
> On Tue, 30 Jun 2020 09:04:38 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Tue, Jun 30, 2020 at 02:25:04PM +0200, Cornelia Huck wrote:
> 
> > > What bothers me most is that you need to explicitly request a device to
> > > be modern-only, while that should be the default for any newly added
> > > device. Hence the approach with the centralized list of device types
> > > mentioned in a parallel thread. The main problem with that is that the
> > > proxy device starts getting realized before the virtio device with its
> > > id is present... I failed to find a solution so far. But I'd really
> > > like an approach that can work for all transports.  
> > 
> > So how about simply validating that the device is modern only,
> > unless it's one of the whitelist?
> 
> Who would do the validation, the virtio core? How can it distinguish
> between transitional and non-transitional? But maybe I'm just not
> getting your idea.

OK I've been thinking about two ideas, we can use them both:
1. virtio core: that can detect VIRTIO_1 being clear
in virtio_validate_features.
2. transports: could use a core API to detect whether
device can be a legacy one, to block device creation.


> Also, ccw does not currently have a way to explicitly configure a
> device non-transitional; the revisions can be used to fence off newer
> features, going down to legacy-only, but fencing off older features is
> not possible (that is only done by the device, if it has no legacy
> support).

I guess for ccw only option 1 works.

-- 
MST


