Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7B0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 06:04:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 675B3206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 06:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nqu/+JUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675B3206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfdYX-0007O6-Jo
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 02:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfdXr-0006xm-Qk
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 02:03:35 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37293
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfdXp-0005pK-NH
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 02:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590991412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F7u3vEVScVSajVXDeO3PPY/h2QxQlwNTJqJ+3zV0jqE=;
 b=Nqu/+JUrbCBI4XkJ1UhDDWMqZ3IkBBRB5Ul4aFxmewUGKkfsuzTcEGW7pD/+/JjlhIm2T/
 gm6dvCHUcDr6VgcJOoa1BfwSWwo5NZk4qi6R6eOKLo+0SO2x1Ks73TzyH8NL/fh3aekpXG
 V2lCpt/buLVq/gFJZgym0wsY3i3Ov90=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-zeemRTLbMDi-IMGOJcyyhg-1; Mon, 01 Jun 2020 02:03:30 -0400
X-MC-Unique: zeemRTLbMDi-IMGOJcyyhg-1
Received: by mail-il1-f197.google.com with SMTP id q14so5707883ils.18
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 23:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=F7u3vEVScVSajVXDeO3PPY/h2QxQlwNTJqJ+3zV0jqE=;
 b=K+LPepte6X4KDZhFWpCf5YZp8DiAg27XPpNIZEQEvK6eJS/9T7QB8TMmKvbd09gg9U
 vTTqiTiG2p2Hl1cMOg9XTqK67C/dczLJ+uhTgNxmWUCiVoZFf2SBEXo60iN9GuF/UdxK
 fwF9MSR0ulGP3fH47BzSBAtBtfAqjx65XD+rGrUCSch4ieBMoOkZTEAb58mn93lL7jgz
 LT1q3DI/oFYZhhsxf23zuUMbH3z93LCuaujwrDETz5ezGtKnidsgnbifUTSaE63Z1NV4
 1sB5SHdaCmPoCC83GkX9FdL/M1/kMJ07tgtBwNM4Wj634W+V8K+nkjRqAN7RrNr/neAX
 HnPQ==
X-Gm-Message-State: AOAM530wV3DNQWl+NgdqA6H02YIBziANbTBaFBEHYO9aK3JZnJDvXzIs
 4+66locKSNwj6n+ibVrgEaWT/1aoFUW+UicgTUndO3H0MxURHMz0NTVHeIXUL5nX4LydZAkMQLb
 cqp7kd8W6tKpt1/gyN2bGNI5tq7XORzg=
X-Received: by 2002:a02:1c83:: with SMTP id
 c125mr19567329jac.112.1590991409818; 
 Sun, 31 May 2020 23:03:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiQM9WIx8eFhNH+Io8j0QPfVH++vZzr34l5CMczjJxNVRK5Apn3BC9u5ocRVdgEI8TzC8asAtN3yOvH+ExUhM=
X-Received: by 2002:a02:1c83:: with SMTP id
 c125mr19567307jac.112.1590991409522; 
 Sun, 31 May 2020 23:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200601051454.826415-1-ppandit@redhat.com>
 <729e8bd2-ee11-5e6a-4b09-86bc1c56b9d3@redhat.com>
In-Reply-To: <729e8bd2-ee11-5e6a-4b09-86bc1c56b9d3@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Mon, 1 Jun 2020 08:03:18 +0200
Message-ID: <CAP+75-Ur5quvHu-mu8C5Vxwdfx1VFVLz2GEVfAR_v4BX72=kzg@mail.gmail.com>
Subject: Re: [PATCH] msix: add valid.accepts methods to check address
To: P J P <ppandit@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 02:02:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Alexander Bulekov <alxndr@bu.edu>,
 Anatoly Trosinenko <anatoly.trosinenko@gmail.com>, Ren Ding <rding@gatech.edu>,
 Hanqing Zhao <hanqing@gatech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 1, 2020 at 8:02 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
> On 6/1/20 7:14 AM, P J P wrote:
> > From: Prasad J Pandit <pjp@fedoraproject.org>
> >
> > While doing msi-x mmio operations, a guest may send an address
> > that leads to an OOB access issue. Add valid.accepts methods to
> > ensure that ensuing mmio r/w operation don't go beyond regions.
> >
>
> Fixes: CVE-2020-xxxxx

Oh and please also add:

Cc: qemu-stable@nongnu.org

>
> > Reported-by: Ren Ding <rding@gatech.edu>
> > Reported-by: Hanqing Zhao <hanqing@gatech.edu>
> > Reported-by: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
> > Reported-by: Alexander Bulekov <alxndr@bu.edu>
> > Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> > ---
> >  hw/pci/msix.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/hw/pci/msix.c b/hw/pci/msix.c
> > index 29187898f2..d90d66a3b8 100644
> > --- a/hw/pci/msix.c
> > +++ b/hw/pci/msix.c
> > @@ -193,6 +193,15 @@ static void msix_table_mmio_write(void *opaque, hw=
addr addr,
> >      msix_handle_mask_update(dev, vector, was_masked);
> >  }
> >
> > +static bool msix_table_accepts(void *opaque, hwaddr addr, unsigned siz=
e,
> > +                                    bool is_write, MemTxAttrs attrs)
> > +{
> > +    PCIDevice *dev =3D opaque;
> > +    uint16_t tbl_size =3D dev->msix_entries_nr * PCI_MSIX_ENTRY_SIZE;
> > +
> > +    return dev->msix_table + addr + 4 <=3D dev->msix_table + tbl_size;
>
> Can be simplified as:
>
>        return addr + 4 <=3D dev->msix_entries_nr * PCI_MSIX_ENTRY_SIZE;
>
> > +}
> > +
> >  static const MemoryRegionOps msix_table_mmio_ops =3D {
> >      .read =3D msix_table_mmio_read,
> >      .write =3D msix_table_mmio_write,
> > @@ -200,6 +209,7 @@ static const MemoryRegionOps msix_table_mmio_ops =
=3D {
> >      .valid =3D {
> >          .min_access_size =3D 4,
> >          .max_access_size =3D 4,
> > +        .accepts =3D msix_table_accepts
> >      },
> >  };
> >
> > @@ -221,6 +231,15 @@ static void msix_pba_mmio_write(void *opaque, hwad=
dr addr,
> >  {
> >  }
> >
> > +static bool msix_pba_accepts(void *opaque, hwaddr addr, unsigned size,
> > +                                    bool is_write, MemTxAttrs attrs)
> > +{
> > +    PCIDevice *dev =3D opaque;
> > +    uint16_t pba_size =3D QEMU_ALIGN_UP(dev->msix_entries_nr, 64) / 8;
> > +
> > +    return dev->msix_pba + addr + 4 <=3D dev->msix_pba + pba_size;
>
> Can be simplified as:
>
>        return addr + 4 <=3D QEMU_ALIGN_UP(dev->msix_entries_nr, 64) / 8;
>
> > +}
> > +
> >  static const MemoryRegionOps msix_pba_mmio_ops =3D {
> >      .read =3D msix_pba_mmio_read,
> >      .write =3D msix_pba_mmio_write,
> > @@ -228,6 +247,7 @@ static const MemoryRegionOps msix_pba_mmio_ops =3D =
{
> >      .valid =3D {
> >          .min_access_size =3D 4,
> >          .max_access_size =3D 4,
> > +        .accepts =3D msix_pba_accepts
> >      },
> >  };
> >
> >
>


