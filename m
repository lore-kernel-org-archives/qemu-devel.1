Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02E7C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:51:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC39224F3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VAPVwvhz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC39224F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXPRz-0004vl-Ou
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 07:51:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iXPRD-0004OK-Tr
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:50:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iXPRB-0005Yd-4f
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:50:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22182
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iXPRA-0005YG-RD
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:50:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574254223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6WmXlO/NHd9/ajdNalxFkaUu8NFe52C917r2+tblOmY=;
 b=VAPVwvhzyVuQ/deHFCbfLPu8JUKX/dBmaoW7MgqAOh2sPkZ/tdhmvqiCPAmY88gcS4HKfa
 vF8vTt81d8IqIT0jAzEB9Ee1mOOtxkYobNEmGykmfEowhcfi5e53HpDqc5X4LmCC+ZjedW
 dLfMi/JctZvFDadhPqocazNuDAaicgY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-qh7X0KeDNamkjeJ7pto0OQ-1; Wed, 20 Nov 2019 07:50:20 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61C71107ACC4;
 Wed, 20 Nov 2019 12:50:19 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E25C10016EB;
 Wed, 20 Nov 2019 12:50:18 +0000 (UTC)
Date: Wed, 20 Nov 2019 13:50:15 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Farman <farman@linux.ibm.com>
Subject: Re: [RFC PATCH v1 8/8] vfio-ccw: Add support for the CRW irq
Message-ID: <20191120135015.359cf054.cohuck@redhat.com>
In-Reply-To: <20191115033437.37926-9-farman@linux.ibm.com>
References: <20191115033437.37926-1-farman@linux.ibm.com>
 <20191115033437.37926-9-farman@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: qh7X0KeDNamkjeJ7pto0OQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Jared Rossi <jrossi@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 Nov 2019 04:34:37 +0100
Eric Farman <farman@linux.ibm.com> wrote:

> From: Farhan Ali <alifm@linux.ibm.com>
>=20
> The CRW irq will be used by vfio-ccw to notify the userspace
> about any CRWs the userspace needs to handle. Let's add support
> for it.
>=20
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>=20
> Notes:
>     v0->v1: [EF]
>      - Check vcdev->crw_region before registering the irq,
>        in case host kernel does not have matching support
>      - Split the refactoring changes to an earlier (new) patch
>        (and don't remove the "num_irqs" check in the register
>        routine, but adjust it to the check the input variable)
>      - Don't revert the cool vfio_set_irq_signaling() stuff

Only the uncool stuff? ;)

>      - Unregister CRW IRQ before IO IRQ in unrealize
>      - s/crw1/crw0/
>=20
>  hw/vfio/ccw.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>=20
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index b16526d5de..b3f4120118 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -48,6 +48,7 @@ struct VFIOCCWDevice {
>      uint64_t crw_region_offset;
>      struct ccw_crw_region *crw_region;
>      EventNotifier io_notifier;
> +    EventNotifier crw_notifier;
>      bool force_orb_pfch;
>      bool warned_orb_pfch;
>  };
> @@ -259,6 +260,34 @@ static void vfio_ccw_reset(DeviceState *dev)
>      ioctl(vcdev->vdev.fd, VFIO_DEVICE_RESET);
>  }
> =20
> +static void vfio_ccw_crw_notifier_handler(void *opaque)
> +{
> +    VFIOCCWDevice *vcdev =3D opaque;
> +    struct ccw_crw_region *region =3D vcdev->crw_region;
> +    CRW crw;
> +    int size;
> +    uint8_t erc;
> +    uint16_t rsid;
> +
> +    if (!event_notifier_test_and_clear(&vcdev->crw_notifier)) {
> +        return;
> +    }

Referring back to the comments I made for the kernel part
(https://lore.kernel.org/kvm/20191119195236.35189d5b.cohuck@redhat.com/),
I think we may have a problem when we have multiple crws pending.

IIUC, the kernel does not provide any guarantees that we get exactly
one interrupt per crw. I'm wondering whether it would make sense to
mimic the behaviour of stcrw, i.e.

(a) get a notification
(b) read the region to obtain a crw
(c) do whatever needs to be done
(d) repeat (b) and (c) until (b) does not return a valid crw

That way, we can also accommodate arbitrary lengths of crw chains, as
we do not have to reserve space for a pre-defined number of crws in the
region.

> +
> +    memset(region, 0, sizeof(*region));
> +    size =3D pread(vcdev->vdev.fd, region, vcdev->crw_region_size,
> +                 vcdev->crw_region_offset);
> +
> +    if (size =3D=3D -1) {
> +        error_report("vfio-ccw: Read crw region failed with errno=3D%d",=
 errno);
> +        return;
> +    }
> +
> +    memcpy(&crw, &region->crw0, sizeof(CRW));
> +    erc =3D crw.flags & 0x003f;
> +    rsid =3D crw.rsid;
> +    css_queue_crw(CRW_RSC_CHP, erc, 0, 0, rsid);
> +}
> +
>  static void vfio_ccw_io_notifier_handler(void *opaque)
>  {
>      VFIOCCWDevice *vcdev =3D opaque;


