Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA81EC55178
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 15:54:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5631420782
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 15:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yq9D0Vhd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5631420782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kahaR-0002Lo-BT
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 10:54:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kahZA-00019c-UB
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 10:52:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39426)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kahZ5-0000H2-GQ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 10:52:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604591562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f1IsjEETTa+pJ7s7RpfH+uWZH/ki0r+YVl87rVRUGos=;
 b=Yq9D0VhdiPppvVHDlXcjcwoiyfzBnseYXMddCQb35wDdPVk/ucqdz7Sk176IEWSK+OKPWi
 FcMx/SgJskWGpVjwvWkRGyR+Frc933rVDEJ5BbPKa6hJmjbVvILIPFfzRv9Qa/xlgGEsPK
 JYA1/szKZ0RRo16stR2e6KnEi6VVeG4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-dUUJIbFIOSKqIQ4FDnIOUw-1; Thu, 05 Nov 2020 10:52:40 -0500
X-MC-Unique: dUUJIbFIOSKqIQ4FDnIOUw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 083018DF0AC;
 Thu,  5 Nov 2020 15:52:39 +0000 (UTC)
Received: from gondolin (ovpn-112-138.ams2.redhat.com [10.36.112.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 024FD5C5DE;
 Thu,  5 Nov 2020 15:52:22 +0000 (UTC)
Date: Thu, 5 Nov 2020 16:52:20 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC v2] VFIO Migration
Message-ID: <20201105165220.7ad2d1a6.cohuck@redhat.com>
In-Reply-To: <20201105150902.GA472489@stefanha-x1.localdomain>
References: <20201105150902.GA472489@stefanha-x1.localdomain>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: John G Johnson <john.g.johnson@oracle.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, mtsirkin@redhat.com, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, quintela@redhat.com,
 Jason Wang <jasowang@redhat.com>, Felipe Franciosi <felipe@nutanix.com>, "Zeng,
 Xin" <xin.zeng@intel.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>, Yan Zhao <yan.y.zhao@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Nov 2020 15:09:02 +0000
Stefan Hajnoczi <stefanha@redhat.com> wrote:

(...)

<did not fully read through the v1 thread, so apologies if I missed
something>

> VFIO/mdev Devices
> -----------------
> TODO this is a first draft, more thought needed around enumerating supported
> parameters, representing default values, etc
> 
> The following mdev type sysfs attrs are available for managing device
> instances:
> 
>   /sys/.../<parent-device>/mdev_supported_types/<type-id>/
>       create - writing a UUID to this file instantiates a device
>       migration/ - migration related files
>           model - unique device model string, e.g. vendor-a.com/my-nic
> 
> Device models supported by an mdev driver can be enumerated by reading the
> migration/model attr for each <type-id>.

IIUC, we're grouping together all users of a specific mdev_type, but
support a variety of sub-configurations? Does that include parameters
or not? If not, shouldn't we already be covered by mdev_type?

> 
> The following mdev device sysfs attrs relate to a specific device instance:
> 
>   /sys/.../<parent-device>/<uuid>/
>       mdev_type/ - symlink to mdev type sysfs attrs, e.g. to fetch migration/model
>       migration/ - migration related files
>           applied - Write "1" to apply current migration parameter values or
>                     "0" to reset migration parameter values to their defaults.
>                     Parameters can only be applied or reset while the mdev is
>                     not opened.
>           params/ - migration parameters
>               <my-param> - read/write migration parameter "my-param"
>               ...
> 
> When the device is created the migration/applied attr is "0". Migration
> parameters are accessible in migration/params/ and read 0 bytes because they
> are at their default values.  At the point opening the mdev device will fail
> because migration parameters must be applied first. Migration parameters can be
> set to the desired values or left at their defaults. "1" must be written to
> migration/applied before opening the mdev device.
> 
> If writing to a migration/params/<param> attr or setting migration/applied to
> "1" fails, then the device implementation does not support the migration
> parameters.
> 
> An open mdev device typically does not allow migration parameters to be changed
> at runtime. However, certain migration/params attrs may allow writes at
> runtime. Usually these migration parameters only affect the device state
> representation and not the hardware interface. This makes it possible to
> upgrade or downgrade the device state representation at runtime so that
> migration is possible to newer or older device implementations.
> 
> An existing mdev device instance can be reused by closing the mdev device and
> writing "0" to migration/applied. This resets parameters to their defaults so
> that a new list of migration parameters can be applied.
> 
> The migration parameter list for an mdev device that is in operation can be
> read from migration/params/. Parameters that read 0 bytes are at their default
> value.

I'm trying to figure out what that means for the mdevs I'm most
familiar with, ccw and ap. Both of them currently support a single
mdev_type.

For ccw, there are some things that I could imagine as parameters, like
the device number, or channel paths. Maybe we could include the channel
path type (FICON, ...) in the migration device model? We should not
include device numbers etc. in the device model.

For ap, we have matrices covering tuples (APQNs) derived from a
cross-product of card/domains configure via sysfs attributes. I think
later modification of these is desired. I think we also might be able
to mix-and-match different types within the same matrix, so not sure if
we can put these into any device model. In fact, I'm a bit at a loss
how the device model for ap would look like (other than simply
'matrix'). Can we deal with dynamic parameters?

(...)


