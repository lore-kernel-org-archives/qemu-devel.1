Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B51C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 07:55:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D672236F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 07:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/pOA5Tk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D672236F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaDdC-0002Jz-Fg
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 02:54:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaDZb-0000n7-CB
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 02:51:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30240)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaDZV-0007IE-0A
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 02:51:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604476268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dPlJx29UvodIKiOv4TY3nk75ZTs0BDbFCQ6eiBjcg4A=;
 b=C/pOA5TkqFx1IYvS1yysKuni8oMdC3xZwUNobRr81HrJan74VgVXqEW4KFkIwqmWxgIxlT
 0P/SIAj+p8cS0RS/eaIla3sAIaXHi4K00+sgcOaAegp/bWGb5Zc/w6+5hEFeKLb88SEkox
 T9fRU+NxkxwfSH3wfBaO8MIigmRNNiw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-SDLxapS9OhK62eqcM4VBmw-1; Wed, 04 Nov 2020 02:51:04 -0500
X-MC-Unique: SDLxapS9OhK62eqcM4VBmw-1
Received: by mail-wr1-f69.google.com with SMTP id t17so8927553wrm.13
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 23:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dPlJx29UvodIKiOv4TY3nk75ZTs0BDbFCQ6eiBjcg4A=;
 b=tAD3BRcZk+VStbqwcXsp049hExAP5AqcBvKdOsJ9D1pPVI6LoSm/pd/fwF/2k4sHp5
 4kpdgt2fI7Gq0W4zS9usXT5SWP8MGfFCPujUKS3OfN+9Em3fpL780X+cl68R0W67+5OM
 5GLfw2/J6X6LjoVPEAhlzNxGa26dCBMt7QI4VYaMuKqxFjc7TmDEFWJ38ZbUDl/fNPJT
 othSKFZu/dPCrUKeI7muGJEKLgVEsLbP7WzfQ1ZHrL1eaxkTWJ6HPZuOBytTH1mqLZSS
 eZEACZ8gDqGJo4jheFftPvbuGZxYX+8DKQhk6o+YG9Bm8Gj0hIiChNabIoz1awB0Fs99
 0HAQ==
X-Gm-Message-State: AOAM5324H8tiWSihA1fcCrA/dGKct8tCANGTUoL61pm1DDrPkWvIsrqU
 2AdbA7lWWF02KtrXOuYrVN5jDBH5ZXFAtIARhTQsRewo0MGkzurStjvZYyDtBXbAPsAfh7G0K8m
 zGL4wBvGCffGqrcs=
X-Received: by 2002:a1c:1b85:: with SMTP id b127mr3240383wmb.163.1604476262969; 
 Tue, 03 Nov 2020 23:51:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxj2LUcyAXmSZf9L4oWcCXF4QjgQg+o5PrSRoyiiiaiBm4xKklod1yjvXkWzl1a4zEWCZObbw==
X-Received: by 2002:a1c:1b85:: with SMTP id b127mr3240354wmb.163.1604476262766; 
 Tue, 03 Nov 2020 23:51:02 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id 3sm1201059wmd.19.2020.11.03.23.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 23:51:01 -0800 (PST)
Date: Wed, 4 Nov 2020 02:50:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: VFIO Migration
Message-ID: <20201104024440-mutt-send-email-mst@kernel.org>
References: <20201102111153.GC42093@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20201102111153.GC42093@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: John G Johnson <john.g.johnson@oracle.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 quintela@redhat.com, Jason Wang <jasowang@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Felipe Franciosi <felipe@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 02, 2020 at 11:11:53AM +0000, Stefan Hajnoczi wrote:
> Device States
> -------------
> The details of the device state representation are not covered in this document
> but the general requirements are discussed here.
> 
> The device state consists of data accessible through the device's hardware
> interface and internal state that is needed to restore device operation.
> State in the hardware interface includes the values of hardware registers.
> An example of internal state is an index value needed to avoid processing
> queued requests more than once.
> 
> Changes can be made to the device state representation as follows. Each change
> to device state must have a corresponding device configuration parameter that
> allows the change to toggled:
> 
> * When the parameter is disabled the hardware interface and device state
>   representation are unchanged. This allows old device states to be loaded.
> 
> * When the parameter is enabled the change comes into effect.
> 
> * The parameter's default value disables the change. Therefore old versions do
>   not have to explicitly specify the parameter.
> 
> The following example illustrates migration from an old device
> implementation to a new one. A version=1 network card is migrated to a
> new device implementation that is also capable of version=2 and adds the
> rx-filter-size=32 parameter. The new device is instantiated with
> version=1, which disables rx-filter-size and is capable of loading the
> version=1 device state. The migration completes successfully but note
> the device is still operating at version=1 level in the new device.
> 
> The following example illustrates migration from a new device
> implementation back to an older one. The new device implementation
> supports version=1 and version=2. The old device implementation supports
> version=1 only. Therefore the device can only be migrated when
> instantiated with version=1 or the equivalent full configuration
> parameters.

So all this is pretty complex and easy for vendors to get wrong.  How
about we introduce a directory under docs/interop/ where each supported
device can list the format of its state and parameters and what is tied
to what?

I am a bit unsure about the usefulness of the version shortcut.
It would be handy if all this was used directly by users
but these are unlikely to want to orchestrate cross version
migrations, and tools do not need shortcuts like these ...

-- 
MST


