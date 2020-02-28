Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795B1C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 20:50:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38EE524691
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 20:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUVRqqX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38EE524691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7maR-0002lt-Cj
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 15:50:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j7mZs-0002K6-1e
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 15:49:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j7mZq-0001p7-2D
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 15:49:43 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53844
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j7mZp-0001oo-UJ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 15:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582922980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7gBuxX5O0JttYN1MfkbBNjR5Px/n7LlON1llHCwBrxw=;
 b=LUVRqqX21NCjGdKt+kIxc7A9URYlx/gavHRTv7sFFtbDe+zcWsuFVQgThjNKZFLAO2z+7d
 LGioQPWs06zSKFz/qxhwLH5Ut1TMBD0iNXu+9QgUeSFoIMDIY4Ae0R0SCl77cF62e8atjc
 NUE0V90cuHQpNu91lTCvd+9LyI5WXoM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-kW4ds5YJNl-hIoUREsVeqA-1; Fri, 28 Feb 2020 15:49:37 -0500
X-MC-Unique: kW4ds5YJNl-hIoUREsVeqA-1
Received: by mail-qk1-f199.google.com with SMTP id v189so3923927qkb.16
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 12:49:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=9GoEGTmaqTLZBSXJvskoGi7jMmCg5dEYjbosWKG9x8A=;
 b=eIKxrV7IzvHE0fV+K8ayyL3dKu9+XzSvD/icxCG1DiEQ2jFEbYLFvkiMi5QQFjngwA
 F6MVdI8/fznq8Mbd8wsVv3fDsK/0rJI/PsWaTO1z3foAfAGW4yLIrfGi0gODmBH+Va1d
 i1iPC/LDA+s4sroFRNB1B/fQgLJyuLSoOsOMaJQH5Ukht5/5/G/Ie9yK7Tddg0iZyci+
 Sic5RZgXJw/nCed05UiBTRoFE7tcFLfFb5JDzX37LhxG58uNGOxOguY7mCHYa2mCh5np
 GrUHsHXnpB5pthJTwI1weUkv/juuRTwqgKVoAnMlH8f1bpJDLLeXqoq58LJUTbRnJLZq
 hmDw==
X-Gm-Message-State: APjAAAVOpI1kmlXm751AyTEFj3B5HdKPSAHbXsaq5GPNjLGQs54dP/RY
 tzCZqoGWiHxvJ1A4isdoSi542cCPOsTWNjuVmXHCxm7qQhSWoN3a/Fp3HMLquIw3zjwO7/tvFL7
 +FLjWiswhmwnt4LU=
X-Received: by 2002:a05:620a:2282:: with SMTP id
 o2mr5643730qkh.304.1582922977450; 
 Fri, 28 Feb 2020 12:49:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqyBNIVMAKhOa3xqD0PQVr33U628G8FH+eVz2LWqSGgTf7RavU9dJ3DJBQI+/Lh84IByyBIvuw==
X-Received: by 2002:a05:620a:2282:: with SMTP id
 o2mr5643720qkh.304.1582922977197; 
 Fri, 28 Feb 2020 12:49:37 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id n5sm5710211qkk.121.2020.02.28.12.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 12:49:36 -0800 (PST)
Date: Fri, 28 Feb 2020 15:49:34 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH v3 12/15] util: vfio-helpers: Implement ram_block_resized()
Message-ID: <20200228204934.GC180973@xz-x1>
References: <20200228195522.GY180973@xz-x1>
 <4D19362F-16B2-4C83-8B6D-48AD87046750@redhat.com>
MIME-Version: 1.0
In-Reply-To: <4D19362F-16B2-4C83-8B6D-48AD87046750@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 28, 2020 at 03:19:45PM -0500, David Hildenbrand wrote:
>=20
>=20
> > Am 28.02.2020 um 20:55 schrieb Peter Xu <peterx@redhat.com>:
> >=20
> > =EF=BB=BFOn Thu, Feb 27, 2020 at 11:12:02AM +0100, David Hildenbrand wr=
ote:
> >> +static void qemu_vfio_dma_map_resize(QEMUVFIOState *s, void *host,
> >> +                                     size_t old_size, size_t new_size=
)
> >> +{
> >> +    IOVAMapping *m;
> >> +    int index =3D 0;
> >> +
> >> +    qemu_mutex_lock(&s->lock);
> >> +    m =3D qemu_vfio_find_mapping(s, host, &index);
> >> +    if (!m) {
> >> +        return;
> >> +    }
> >> +    assert(m->size =3D=3D old_size);
> >> +
> >> +    /* Note: Not atomic - we need a new ioctl for that. */
> >> +    qemu_vfio_undo_mapping(s, m->iova, m->size);
> >> +    qemu_vfio_do_mapping(s, host, m->iova, new_size);
> >=20
> > Another way to ask my previous question 1 (in the other reply): Can we
> > simply map/unmap the extra, while keep the shared untouched?
>=20
> As far as I understand the kernel implementation, unfortunately no. You m=
ight be able to grow (by mapping the delta), but shrinking is not possible =
AFAIR. And I *think* with many resizes, there could be an issue if I rememb=
er correctly.

Ah right (and I think the same thing will happen to vfio-pci during
memory_region_set_size()).  Then please double confirm that virtio-mem
is disabled for both vfio-helper users and vfio-pci.  Also, would you
mind comment above the unmap+map with more information?  E.g.:

  For now, we must unmap the whole mapped range first and remap with
  the new size.  The reason is that VFIO_IOMMU_UNMAP_DMA might fail
  with partial unmap of previous mappings, so even we can add extra
  new mappings to extend the old range, however we still won't able to
  always success on shrinking memories.  The side effect is that it's
  never safe to do resizing during VM execution.

Or something better.  With an enriched comment, I think it's fine:

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

--=20
Peter Xu


