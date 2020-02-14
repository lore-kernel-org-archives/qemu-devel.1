Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BFEC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 10:21:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32B12206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 10:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVfl6fK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B12206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Y6b-0004Ff-DC
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 05:21:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34727)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j2Y61-0003qZ-UO
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 05:21:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j2Y60-00053q-Gq
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 05:21:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35296
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j2Y60-00052b-Bx
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 05:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581675675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Ayh2tnJQJdwrE+Izh3eyPQUsTl4xHoZTP2dpD1dWY8=;
 b=EVfl6fK9RHICajNtjFNI0Ic5QLjW2GIChgpgW7fK9LTIsXMP16CkCR3Q+sUwJf38rDSQbX
 sv/NlUBnlsPYO/iSskgPojhjX6hv5REj5m5KEtJOnijXEksRX2ryrwhVXZqfV8gW3NbLYp
 kvzcVGcCGbOCks8RLTZuhV1QPPeHLsg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-tytk9UiWPmGVpa_zEbOjyg-1; Fri, 14 Feb 2020 05:21:13 -0500
X-MC-Unique: tytk9UiWPmGVpa_zEbOjyg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31080A0CC0;
 Fri, 14 Feb 2020 10:21:10 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4BC7A5C115;
 Fri, 14 Feb 2020 10:21:03 +0000 (UTC)
Date: Fri, 14 Feb 2020 11:21:00 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v12 Kernel 1/7] vfio: KABI for migration interface for
 device state
Message-ID: <20200214112100.4e73722b.cohuck@redhat.com>
In-Reply-To: <1581104554-10704-2-git-send-email-kwankhede@nvidia.com>
References: <1581104554-10704-1-git-send-email-kwankhede@nvidia.com>
 <1581104554-10704-2-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: kevin.tian@intel.com, yi.l.liu@intel.com, cjia@nvidia.com,
 kvm@vger.kernel.org, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, dgilbert@redhat.com, zhi.a.wang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 alex.williamson@redhat.com, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 8 Feb 2020 01:12:28 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

(...)

Minor wording nits:

> +/*
> + * Structure vfio_device_migration_info is placed at 0th offset of

"...at the 0th offset..."

> + * VFIO_REGION_SUBTYPE_MIGRATION region to get/set VFIO device related migration
> + * information. Field accesses from this structure are only supported at their
> + * native width and alignment, otherwise the result is undefined and vendor
> + * drivers should return an error.
> + *
> + * device_state: (read/write)
> + *      - User application writes this field to inform vendor driver about the

I'd probably add a definitive article before "user application",
"vendor driver", etc. Not sure if it's too much churn.

> + *        device state to be transitioned to.
> + *      - Vendor driver should take necessary actions to change device state.
> + *        On successful transition to given state, vendor driver should return
> + *        success on write(device_state, state) system call. If device state
> + *        transition fails, vendor driver should return error, -EFAULT.
> + *      - On user application side, if device state transition fails, i.e. if
> + *        write(device_state, state) returns error, read device_state again to
> + *        determine the current state of the device from vendor driver.
> + *      - Vendor driver should return previous state of the device unless vendor
> + *        driver has encountered an internal error, in which case vendor driver
> + *        may report the device_state VFIO_DEVICE_STATE_ERROR.
> + *	- User application must use the device reset ioctl in order to recover
> + *	  the device from VFIO_DEVICE_STATE_ERROR state. If the device is
> + *	  indicated in a valid device state via reading device_state, the user
> + *	  application may decide attempt to transition the device to any valid
> + *	  state reachable from the current state or terminate itself.
> + *
> + *      device_state consists of 3 bits:
> + *      - If bit 0 set, indicates _RUNNING state. When it's clear, that
> + *	  indicates _STOP state. When device is changed to _STOP, driver should
> + *	  stop device before write() returns.

"If set, bit 0 indicates _RUNNING state. If unset, it indicates _STOP
state. When the device is changed to _STOP state, the driver should
stop the device before write() returns."

?

> + *      - If bit 1 set, indicates _SAVING state. When set, that indicates driver
> + *        should start gathering device state information which will be provided
> + *        to VFIO user application to save device's state.

"If set, bit 1 indicates _SAVING state. When it is set, the driver
should start to gather the device state information that will be
provided to the VFIO user application to save the device's state."

?

> + *      - If bit 2 set, indicates _RESUMING state. When set, that indicates
> + *        prepare to resume device, data provided through migration region
> + *        should be used to resume device.

"If set, bit 2 indicates _RESUMING state. When it is set, the driver
should prepare to resume the device, using the data provided via the
migration region."

?

> + *      Bits 3 - 31 are reserved for future use. In order to preserve them,
> + *	user application should perform read-modify-write operation on this
> + *	field when modifying the specified bits.

"In order to preserve them, the user application should use a
read-modify-write operation on the device_state field when modifying
the state."

?


(...)


