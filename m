Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F99C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:45:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3BEB20674
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BkRm8Yg7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BEB20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUCoI-0006Tz-2x
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 11:45:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41251)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iUCLF-0006RR-4C
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:15:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iUCLD-0007aG-U1
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:15:01 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41237
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iUCLD-0007Zg-Pi
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:14:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573488899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OBvWUDiYu62j00yT/+fqATyx7dX8irN1FgZbalznWX0=;
 b=BkRm8Yg7Yj1KfjJPvjYrUNPzwO4HbVYG9sXPbcUoGnw6BQYiCQFlOyKmDCTGgAxMUiZrS7
 3UojwbZjDDEGFEEXHEO/lxlfO6MWDw6GRngow0ifgKHp2ixZ+LJhYuCnW+62j+fA6Vpd2y
 0sqYatNtxhoKO/NlRqC2ESnTLODDoHc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-FYy1bn_fP3uvPG0XzxEkWw-1; Mon, 11 Nov 2019 11:14:56 -0500
Received: by mail-qk1-f197.google.com with SMTP id a13so8068411qkc.17
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 08:14:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=dVkWaw+58rQsHT3SETkIDwx4gS8196YhUcD+YdvGzWE=;
 b=LrNUQHYi/Ee1WUJvWOv5fKGWRYijo6XGCKsFuR+xPo95Tence1QP+ugppq424XO9ak
 CATe4fE0bMFXcQLkzDPqT6CRpm70BJx1kWpLLUm9t3cDFN/okYoSo2DWMRhaw70Q3Pei
 toVqF4aYbEnc4bQx8XpGMkznrI/Jz4q4ykKO7Egbvtw8rttgpaHViL6KAaM6zvEBTK80
 YhQWTf4k/zrHjz2ueUltgvGPnpOskZF5eYl78MgubSF2InQOS1roqsXfNpT80GTjmTdy
 dWOSrYSs7wlC1NdDe8x7SHZQNwTFip6MfpbuQTzytSWFglPyvyuAP4rNpWqX6Sn2PGmO
 UCgQ==
X-Gm-Message-State: APjAAAXo+w4dKjz6PCoIeDVTs37zRHKlXRCgDSjx5uKisWEulUIhvMPG
 qvPhXOkQhgOPATKL/wWW0JI24gkl7f9d5pZsotWavcOGSn2XzLVlgRGn5CcEe8ayVue3fplXR94
 G74vS2lkRzThrIgE=
X-Received: by 2002:a37:9e05:: with SMTP id h5mr1318606qke.76.1573488895894;
 Mon, 11 Nov 2019 08:14:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqwa9bgDG0bi7y5B/GuSwLmsmFvs/g36cOIp2Jt0HR0PZQYrfw/pCXhzJyVttoVaZtiGlFQepA==
X-Received: by 2002:a37:9e05:: with SMTP id h5mr1318577qke.76.1573488895606;
 Mon, 11 Nov 2019 08:14:55 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id x65sm7787226qkd.15.2019.11.11.08.14.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2019 08:14:54 -0800 (PST)
Date: Mon, 11 Nov 2019 11:14:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [RFC][PATCH 2/3] docs/specs: Add specification of ivshmem device
 revision 2
Message-ID: <20191111111203-mutt-send-email-mst@kernel.org>
References: <cover.1573477032.git.jan.kiszka@siemens.com>
 <f5996d934d24775160bcedbf28ac975a95d91101.1573477032.git.jan.kiszka@siemens.com>
 <20191111084327-mutt-send-email-mst@kernel.org>
 <0b0475c1-2564-f433-46d8-ff1a06c13569@siemens.com>
 <20191111100607-mutt-send-email-mst@kernel.org>
 <20191111152743.GM814211@redhat.com>
 <129c527c-1e61-8c0c-3ca1-fe93e26c8bd2@siemens.com>
MIME-Version: 1.0
In-Reply-To: <129c527c-1e61-8c0c-3ca1-fe93e26c8bd2@siemens.com>
X-MC-Unique: FYy1bn_fP3uvPG0XzxEkWw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: liang yan <lyan@suse.com>, Jailhouse <jailhouse-dev@googlegroups.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Claudio Fontana <claudio.fontana@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Hannes Reinecke <hare@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 11, 2019 at 04:42:52PM +0100, Jan Kiszka wrote:
> On 11.11.19 16:27, Daniel P. Berrang=E9 wrote:
> > On Mon, Nov 11, 2019 at 10:08:20AM -0500, Michael S. Tsirkin wrote:
> > > On Mon, Nov 11, 2019 at 02:59:07PM +0100, Jan Kiszka wrote:
> > > > On 11.11.19 14:45, Michael S. Tsirkin wrote:
> > > > > On Mon, Nov 11, 2019 at 01:57:11PM +0100, Jan Kiszka wrote:
> > > > > > +| Offset | Register               | Content                   =
                           |
> > > > > > +|-------:|:-----------------------|:--------------------------=
---------------------------|
> > > > > > +|    00h | Vendor ID              | 1AF4h                     =
                           |
> > > > > > +|    02h | Device ID              | 1110h                     =
                           |
> > > > >=20
> > > > > Given it's a virtio vendor ID, please reserve a device ID
> > > > > with the virtio TC.
> > > >=20
> > > > Yeah, QEMU's IVSHMEM was always using that. I'm happy to make this =
finally
> > > > official.
> > > >=20
> > >=20
> > > And I guess we will just mark it reserved or something right?
> > > Since at least IVSHMEM 1 isn't a virtio device.
> > > And will you be reusing same ID for IVSHMEM 2 or a new one?
> >=20
> > 1110h isn't under either of the virtio PCI device ID allowed ranges
> > according to the spec:
> >=20
> >    "Any PCI device with PCI Vendor ID 0x1AF4, and PCI Device
> >     ID 0x1000 through 0x107F inclusive is a virtio device.
> >     ...
> >     Additionally, devices MAY utilize a Transitional PCI Device
> >     ID range, 0x1000 to 0x103F depending on the device type. "
> >=20
> > So there's no need to reserve 0x1110h from the virtio spec POV.
>=20
> Indeed.
>=20
> >=20
> > I have, however, ensured it is assigned to ivshmem from POV of
> > Red Hat's own internal tracking of allocated device IDs, under
> > its vendor ID.
> >=20
> > If ivshmem 2 is now a virtio device, then it is a good thing that
> > it will get a new/different PCI device ID, to show that it is not
> > compatible with the old device impl.
>=20
> At this stage, it is just a PCI device that may be used in combination wi=
th
> virtio (stacked on top), but it is not designed like a normal virtio (PCI=
)
> device. That's because it lacks many properties of regular virtio devices=
,
> like queues.
>=20
> So, if such a device could be come part of the virtio spec, it would be
> separate from the rest, and having an ID from the regular range would lik=
ely
> not be helpful in this regard.
>=20
> Jan

I agree it needs a separate ID not from the regular range.
It's a distinct transport.
Maybe even a distinct vendor ID - we could easily get another one
if needed.

> --=20
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux


