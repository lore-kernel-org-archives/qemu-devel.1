Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA744C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:46:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4951C20872
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3eycBxv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4951C20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGK5n-00009M-31
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kGK4O-00069B-Iq
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:44:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47055
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kGK4L-0004Yb-N6
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599734682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ox6APuBa9JS0cMoiD7coaRgGCs1a2JeKYl+jKRVTA5s=;
 b=K3eycBxvXGBxD2xkgadbXFbKw79FaPyiwFMVzSrE+hXNsPOxInHumAYZh/musEL26Vxsio
 chAy/rXFv0/zL5QJCTFtRWU3/q4QTwqj0TriUPZOMO20259c9tMZGYhH4GE3qa3f4fykmM
 SF1LedTm6wRL6PIyzQ+cWVnk9lwKva0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-LHE-1e_kMd6CeUo3OVciRQ-1; Thu, 10 Sep 2020 06:44:40 -0400
X-MC-Unique: LHE-1e_kMd6CeUo3OVciRQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7569510082EA;
 Thu, 10 Sep 2020 10:44:39 +0000 (UTC)
Received: from localhost (ovpn-114-5.ams2.redhat.com [10.36.114.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F0EA5C1CF;
 Thu, 10 Sep 2020 10:44:36 +0000 (UTC)
Date: Thu, 10 Sep 2020 11:44:35 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v6 3/4] util/vfio-helpers: Introduce
 qemu_vfio_pci_init_msix_irqs()
Message-ID: <20200910104435.GA45048@stefanha-x1.localdomain>
References: <20200909142354.334859-1-philmd@redhat.com>
 <20200909142354.334859-4-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200909142354.334859-4-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 01:44:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2020 at 04:23:53PM +0200, Philippe Mathieu-Daud=E9 wrote:
> +/**
> + * Initialize device MSIX IRQs and register event notifiers.
> + * @irq_count: pointer to number of MSIX IRQs to initialize
> + * @notifier: Array of @irq_count notifiers (each corresponding to a MSI=
X IRQ)
> +
> + * If the number of IRQs requested exceeds the available on the device,
> + * store the number of available IRQs in @irq_count and return -EOVERFLO=
W.
> + */
> +int qemu_vfio_pci_init_msix_irqs(QEMUVFIOState *s, EventNotifier *notifi=
er,
> +                                 unsigned *irq_count, Error **errp)
> +{
> +    int r;
> +    size_t irq_set_size;
> +    struct vfio_irq_set *irq_set;
> +    struct vfio_irq_info irq_info =3D {
> +        .argsz =3D sizeof(irq_info),
> +        .index =3D VFIO_PCI_MSIX_IRQ_INDEX
> +    };
> +
> +    if (ioctl(s->device, VFIO_DEVICE_GET_IRQ_INFO, &irq_info)) {
> +        error_setg_errno(errp, errno, "Failed to get device interrupt in=
fo");
> +        return -errno;
> +    }
> +    if (irq_info.count < *irq_count) {
> +        error_setg(errp, "Not enough device interrupts available");
> +        *irq_count =3D irq_info.count;
> +        return -EOVERFLOW;
> +    }
> +    if (!(irq_info.flags & VFIO_IRQ_INFO_EVENTFD)) {
> +        error_setg(errp, "Device interrupt doesn't support eventfd");
> +        return -EINVAL;
> +    }
> +
> +    irq_set_size =3D sizeof(*irq_set) + *irq_count * sizeof(int32_t);
> +    irq_set =3D g_malloc0(irq_set_size);
> +
> +    /* Get to a known IRQ state */
> +    *irq_set =3D (struct vfio_irq_set) {
> +        .argsz =3D irq_set_size,
> +        .flags =3D VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TRIGG=
ER,
> +        .index =3D irq_info.index,
> +        .start =3D 0,
> +        .count =3D *irq_count,
> +    };
> +
> +    for (unsigned i =3D 0; i < *irq_count; i++) {
> +        ((int32_t *)&irq_set->data)[i] =3D event_notifier_get_fd(&notifi=
er[i]);
> +    }
> +    r =3D ioctl(s->device, VFIO_DEVICE_SET_IRQS, irq_set);
> +    g_free(irq_set);
> +    if (r <=3D 0) {
> +        error_setg_errno(errp, errno, "Failed to setup device interrupts=
");
> +        return -errno;
> +    } else if (r < *irq_count) {
> +        error_setg(errp, "Not enough device interrupts available");
> +        *irq_count =3D r;
> +        return -EOVERFLOW;
> +    }

EOVERFLOW can occur in two cases: VFIO_DEVICE_GET_IRQ_INFO and
VFIO_DEVICE_SET_IRQS.

If it happens in the second case the notifier[] array has been
registered successfully.

The caller has no way of distinguishing the two cases. Therefore the
caller doesn't know if the eventfds will be used by the kernel after
EOVERFLOW.

If the second case can ever happen then this function should probably
call VFIO_DEVICE_SET_IRQS again with VFIO_IRQ_SET_DATA_NONE to
unregister the eventfds before returning EOVERFLOW.

STefan

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9aA5MACgkQnKSrs4Gr
c8jFSwgAtbtX/m48pRDuP8UIBPUINAnZiRUqVM+f6BswdP5nIFUIZqHJxiISTQBS
QHH7lvSw6oljQ3QHQyY4vOHcJPmZCDW2hLtfy911gDvKw8Wa5EiTLCpSiesV4K/m
AP+twhrNyLAt8UoG/xJm9s2kAbzsS7K2zPWuOjdYbbwzVfXnCZWn4qz6+E/c4QdX
z0hDK0gNWLp8K/4opW4EKOQFxz62idNSoqhSVqDRwORRQ3sdX2Gg8k3Go+33U19f
8vn0Qk9ayivjy8kbEHypYvaGcxDSKh5NXv301ISmmopxFowGWyFTsRkk/GTYVa2K
DI0mYgE2hikYL9PlzYrtNwEy0jtywA==
=AtoE
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--


