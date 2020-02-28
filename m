Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3976C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 19:56:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70F2124677
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 19:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODhuJh8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F2124677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7lk1-0007cM-JV
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 14:56:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j7ljN-00078L-Fg
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 14:55:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j7ljM-0001ln-Ah
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 14:55:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50921
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j7ljM-0001lY-70
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 14:55:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582919727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O8FgrYFNwpnNBmYTFcjRVMydqvoHnLDpo0m44GVHuzA=;
 b=ODhuJh8FvNYqBoURkP4ijzBCF+G9mxxfj5JThm8tgF5xvDjHMmVmKTUBCXiE5Fg1wygtLl
 0qWkM0U1vOftWDfZHBp5xYvjOPLsy3mKOpxDrEKIzX5PqUByDeK9y+KUkhpFl1XIEqfvKg
 mU5WsfUeIY/oIDo6n77ZN0U5ZlllB10=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-V9DjvyzzMsu6GiYOfbh7Hw-1; Fri, 28 Feb 2020 14:55:25 -0500
X-MC-Unique: V9DjvyzzMsu6GiYOfbh7Hw-1
Received: by mail-qt1-f197.google.com with SMTP id j35so1571187qte.19
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 11:55:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bL/8zDzIarVP0DKzl8t6dQ5gdeKWwyTrhYMbfauV2sw=;
 b=sfO05JK5bYS/4EzHXLsyABdbBixuHTEmdkKwe9gL0ziKrD5EoattalDuj/slHItODc
 b8ouN6cJazXc8fHnliHquCWcLZJ4Mu5zp4tp2tMC/Voxur3i/NEhcIj2U8etkDP/Vq6U
 klwmuK1CgYZcJRs4fj62FIQGaY9uZZVSWbaXjlwMm22Y3jL6bxPogvujzeVPf8Vin7KL
 KAGJF5HvJ5y6Pth2yhHfdL2DsrXWZSKZJ9YI+bGS+S3TCmcplSXOVvXbVIONAZLNSbBr
 uyp45ocJLIGP8aJgfoTTar2AAT4IhEwyTAmSOOEiaaqP3MS/u6CN/BOtgnaRJG2z4HL5
 YK2w==
X-Gm-Message-State: APjAAAWfvtOM5VUZWynqjwcfEVgY0UDKTDf5IX5o6PDHenBLPlw3wU/Q
 qhkuY6cKe7PbN3Ej0REodyZuVgBqZ8W7wlvRn0LjUOVu06yGoP78ELjg9p1zv+W60t8D1F980GY
 AqtJLGOBgry8m/4k=
X-Received: by 2002:a37:b4c5:: with SMTP id d188mr5716070qkf.27.1582919725229; 
 Fri, 28 Feb 2020 11:55:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZQmWVr8u2+oIziL4hLifuS/f1x69SdVX+I/05XeUgZ3eGUjKApgW3U3/3L8GLlemARd+uLw==
X-Received: by 2002:a37:b4c5:: with SMTP id d188mr5716053qkf.27.1582919725024; 
 Fri, 28 Feb 2020 11:55:25 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id y62sm5642057qka.19.2020.02.28.11.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 11:55:24 -0800 (PST)
Date: Fri, 28 Feb 2020 14:55:22 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 12/15] util: vfio-helpers: Implement ram_block_resized()
Message-ID: <20200228195522.GY180973@xz-x1>
References: <20200227101205.5616-1-david@redhat.com>
 <20200227101205.5616-13-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200227101205.5616-13-david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 27, 2020 at 11:12:02AM +0100, David Hildenbrand wrote:
> +static void qemu_vfio_dma_map_resize(QEMUVFIOState *s, void *host,
> +                                     size_t old_size, size_t new_size)
> +{
> +    IOVAMapping *m;
> +    int index =3D 0;
> +
> +    qemu_mutex_lock(&s->lock);
> +    m =3D qemu_vfio_find_mapping(s, host, &index);
> +    if (!m) {
> +        return;
> +    }
> +    assert(m->size =3D=3D old_size);
> +
> +    /* Note: Not atomic - we need a new ioctl for that. */
> +    qemu_vfio_undo_mapping(s, m->iova, m->size);
> +    qemu_vfio_do_mapping(s, host, m->iova, new_size);

Another way to ask my previous question 1 (in the other reply): Can we
simply map/unmap the extra, while keep the shared untouched?

Thanks,

> +
> +    m->size =3D new_size;
> +    assert(qemu_vfio_verify_mappings(s));
> +
> +    qemu_mutex_unlock(&s->lock);
> +}

--=20
Peter Xu


