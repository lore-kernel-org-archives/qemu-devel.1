Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1379FC7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 12:14:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF1F8218B8
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 12:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1F8218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hptgR-0005iJ-5g
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 08:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37587)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hptgH-0005Je-LZ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 08:14:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hptgG-0007EG-Ky
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 08:14:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36048)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1hptgG-00079g-Cc
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 08:14:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 57B5F81F11;
 Tue, 23 Jul 2019 12:14:06 +0000 (UTC)
Received: from gondolin (dhcp-192-181.str.redhat.com [10.33.192.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3AC0C5B684;
 Tue, 23 Jul 2019 12:13:59 +0000 (UTC)
Date: Tue, 23 Jul 2019 14:13:57 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190723141357.7b10c4f2.cohuck@redhat.com>
In-Reply-To: <20190716145632.3b73b73d@x1.home>
References: <1562665760-26158-1-git-send-email-kwankhede@nvidia.com>
 <1562665760-26158-2-git-send-email-kwankhede@nvidia.com>
 <20190716145632.3b73b73d@x1.home>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 23 Jul 2019 12:14:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v7 01/13] vfio: KABI for migration interface
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
 eskultet@redhat.com, ziye.yang@intel.com, qemu-devel@nongnu.org,
 Zhengxiao.zx@Alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, Kirti Wankhede <kwankhede@nvidia.com>,
 eauger@redhat.com, felipe@nutanix.com, jonathan.davies@nutanix.com,
 yan.y.zhao@intel.com, changpeng.liu@intel.com, Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jul 2019 14:56:32 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Tue, 9 Jul 2019 15:19:08 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:

I'm still a bit unsure about the device_state bit handling as well.

> > + * device_state: (read/write)
> > + *      To indicate vendor driver the state VFIO device should be transitioned
> > + *      to. If device state transition fails, write on this field return error.

Does 'device state transition fails' include 'the device state written
was invalid'?

> > + *      It consists of 3 bits:
> > + *      - If bit 0 set, indicates _RUNNING state. When its reset, that indicates
> > + *        _STOPPED state. When device is changed to _STOPPED, driver should stop
> > + *        device before write() returns.

So _STOPPED is always !_RUNNING, regardless of which other bits are set?

> > + *      - If bit 1 set, indicates _SAVING state.
> > + *      - If bit 2 set, indicates _RESUMING state.
> > + *      _SAVING and _RESUMING set at the same time is invalid state.  

What about _RUNNING | _RESUMING -- does that make sense?

> 
> I think in the previous version there was a question of how we handle
> yet-to-be-defined bits.  For instance, if we defined a
> SUBTYPE_MIGRATIONv2 with the intention of making it backwards
> compatible with this version, do we declare the undefined bits as
> preserved so that the user should do a read-modify-write operation?

Or can we state that undefined bits are ignored, and may or may not
preserved, so that we can skip the read-modify-write requirement? v1
and v2 can hopefully be distinguished in a different way.

(...)

> > +struct vfio_device_migration_info {
> > +        __u32 device_state;         /* VFIO device state */
> > +#define VFIO_DEVICE_STATE_RUNNING   (1 << 0)
> > +#define VFIO_DEVICE_STATE_SAVING    (1 << 1)
> > +#define VFIO_DEVICE_STATE_RESUMING  (1 << 2)
> > +#define VFIO_DEVICE_STATE_MASK      (VFIO_DEVICE_STATE_RUNNING | \
> > +                                     VFIO_DEVICE_STATE_SAVING | \
> > +                                     VFIO_DEVICE_STATE_RESUMING)  
> 
> Yes, we have the mask in here now, but no mention above how the user
> should handle undefined bits.  Thanks,
> 
> Alex
> 
> > +#define VFIO_DEVICE_STATE_INVALID   (VFIO_DEVICE_STATE_SAVING | \
> > +                                     VFIO_DEVICE_STATE_RESUMING)

As mentioned above, does _RESUMING | _RUNNING make sense?

