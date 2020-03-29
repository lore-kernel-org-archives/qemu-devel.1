Return-Path: <SRS0=qvFP=5O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF547C43331
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 14:48:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B1142073E
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 14:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UICiUOFE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1142073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIZFC-0002rn-NP
	for qemu-devel@archiver.kernel.org; Sun, 29 Mar 2020 10:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36671)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jIZEb-0002Qs-Ju
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 10:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jIZEY-0000vk-Ot
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 10:48:20 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:54565)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jIZEY-0000vM-G6
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 10:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585493297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fx1mwIFxYnx+npRb2dVqTEQeCxBSw2mmpVP+EMPfnzE=;
 b=UICiUOFEAg1sSRVXhkwtm5j4TPQCiU4UiY0jsAggdKX0/n86YVFWu0UwI7q1X7/duE+DL9
 ujZNBVWzteN1782RCkxp5pj+W+nheVx1ARRz2OWvloQvLQz57cxQxj7jaibgNRDRl2PfJW
 SikKJNwD0Nla+A6O4LerIplKOk/UOCg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-SSQ5qO1XOB693RZg-5dEHA-1; Sun, 29 Mar 2020 10:48:15 -0400
X-MC-Unique: SSQ5qO1XOB693RZg-5dEHA-1
Received: by mail-qk1-f200.google.com with SMTP id h9so10435142qkm.5
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2020 07:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4QDuGQZPm8+dYh1M0kpT205ZWUVagYn7OCUNcZRw73A=;
 b=Aox/KyD6GhGNfEFptSwYNhRk5YF1XuVnmi4bj8qc/iQX2oeHGLQ1PkBYAs2paY7DO2
 sI7D4Nv7h0WWccMvzXFMzpzq9KIw9S9lweYEHHr4FMsSnOIoCbIVEYewwixc+VAdygkO
 U6pGUhOYFK+X5FyyqodXEWtErPU5DO4mrFQoJk6wCDyY0DapXG8RPCqdyH5ychbup9uG
 GrtuI36O4qr/Qc+840jJUgM37dSZmHOZ8XXAN3CQMftYBfsCBhhpXuF6OUkHyYjPhnhu
 8EH5LpHdRbW7q3JbV+AwJX/UCxouiMuTNPEczsbKd8hdYmWRA999SleH88g83AVGweQp
 LUwQ==
X-Gm-Message-State: ANhLgQ32mqFiQGvJb+bKPAUAEgzN1YZi0dVd1pZJmO3GbagXV2Mh3iMb
 fdsXoIPmHo81NWXz+DrNMzBheejyYWgVAU+k4wUjfe/wbOnuwZuEa3M69hxrqlN8HBYt50wTAca
 D0IFlweFKor0v+Ow=
X-Received: by 2002:a37:8903:: with SMTP id l3mr7578327qkd.486.1585493295494; 
 Sun, 29 Mar 2020 07:48:15 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsXxY2uR952Gen5MXaaHvn8NyDNaLuruOUlDdLU9qEPpBfWv6SZy6IJfcZUTL/v8oNU18iJoA==
X-Received: by 2002:a37:8903:: with SMTP id l3mr7578310qkd.486.1585493295208; 
 Sun, 29 Mar 2020 07:48:15 -0700 (PDT)
Received: from redhat.com (bzq-79-183-139-129.red.bezeqint.net.
 [79.183.139.129])
 by smtp.gmail.com with ESMTPSA id p191sm8181042qke.6.2020.03.29.07.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2020 07:48:14 -0700 (PDT)
Date: Sun, 29 Mar 2020 10:48:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v5 07/18] s390x: protvirt: Inhibit balloon when switching
 to protected mode
Message-ID: <20200329104114-mutt-send-email-mst@kernel.org>
References: <20200226122038.61481-1-frankja@linux.ibm.com>
 <20200226122038.61481-8-frankja@linux.ibm.com>
 <ed51d194-1b63-1c54-953a-d2031336a90e@redhat.com>
 <58a51f40-21c7-5737-4f4c-568fdd2477fa@linux.ibm.com>
 <20200227132402.67a38047.pasic@linux.ibm.com>
 <8622efeb-1a4a-338f-d363-53818b00d195@redhat.com>
 <20200319133710-mutt-send-email-mst@kernel.org>
 <dc38f7a3-2bc8-084c-b36f-7f99bd129007@redhat.com>
MIME-Version: 1.0
In-Reply-To: <dc38f7a3-2bc8-084c-b36f-7f99bd129007@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Janosch Frank <frankja@linux.ibm.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 20, 2020 at 10:36:53AM +0100, David Hildenbrand wrote:
> On 19.03.20 18:45, Michael S. Tsirkin wrote:
> > On Thu, Mar 19, 2020 at 02:54:11PM +0100, David Hildenbrand wrote:
> >> Why does the balloon driver not support VIRTIO_F_IOMMU_PLATFORM? It is
> >> absolutely not clear to me. The introducing commit mentioned that it
> >> "bypasses DMA". I fail to see that.
> >=20
> > Well sure one can put the balloon behind an IOMMU.  If will shuffle PFN
> > lists through a shared page.  Problem is, you can't run an untrusted
> > driver with it since if you do it can corrupt guest memory.
> > And VIRTIO_F_IOMMU_PLATFORM so far meant that you can run
> > a userspace driver.
>=20
> Just to clarify: Is it sufficient to clear VIRTIO_F_IOMMU_PLATFORM in
> the *guest kernel driver* to prohibit *guest userspace drivers*?

No it isn't sufficient.

> I would have thought we would have to disallow on the hypervisor/device
> side. (no expert on user space drivers, especially how they
> detect/enable/access virtio devices)

QEMU does exactly this:

static int virtio_validate_features(VirtIODevice *vdev)
{
    VirtioDeviceClass *k =3D VIRTIO_DEVICE_GET_CLASS(vdev);

    if (virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM) &&
        !virtio_vdev_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
        return -EFAULT;
    }
...
}


> >=20
> > Maybe we need a separate feature bit for this kind of thing where you
> > assume the driver is trusted? Such a bit - unlike
> > VIRTIO_F_IOMMU_PLATFORM - would allow legacy guests ...
>=20
> Let's take virtio-mem as an example. You cannot zap memory outside of
> the scope of a virtio-mem device. So I assume having a user space driver
> would be ok (although most probably of limited use :) )?
>=20
> Still, for virtio-mem, special s390x handling, similar to virtio-balloon
> - (un)sharing of pages - would have to be performed.
>=20
> So some feature bits to cleanly separate the different limitations would
> be great. At least in regard to s390x, I guess we don't have to worry
> too much about legacy guests.

So if you have the cycles to think through and document how balloon
interacts with different access limitations, that would be great!

> --=20
> Thanks,
>=20
> David / dhildenb


