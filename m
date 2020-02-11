Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47397C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:31:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 138DC20708
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 16:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GEOIvyOc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 138DC20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1YS3-0003cq-8t
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 11:31:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j1YQx-00030k-ND
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:30:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j1YQv-0003FF-J3
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:30:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58295
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j1YQv-0003Ek-Fa
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 11:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581438644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZKKLvaG4MruHYk5soyWRrVOuAKaqd3a59m6O1Qw24mU=;
 b=GEOIvyOcQJxbX0uX57zl0OYxX43yFveixqgPjuog+X1aS8+UiXUyKdcGqxhu8Oos2hskd9
 DL/TwhQO286xjypNl+Mklx0NBuSiMeugh5k/qK8l1JNbT1q6048yyt5gMF0pcGEKeITQN0
 usJYKNhRxxoOZQHNG8Vm4SxNGQ8l3B8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-crt2faejNQeImrXUK1GnPg-1; Tue, 11 Feb 2020 11:30:42 -0500
Received: by mail-qv1-f72.google.com with SMTP id l1so7517275qvu.13
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 08:30:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WK5vkxsRRO7y1k6SkzO7lAousX7/QuD/JIYyavjDixI=;
 b=W4HAhCTutw3QQdz0QpBvFzggvnlEZ4QcoiinnVIV+tj1cMqWmQEXpvvEQgosj9QNBl
 VHZ4SHO9czeVmttCVf6CTW+/T8HVCWzQjYlNs6Hq9Hkah/zf+aOuRfEvG8w899eYO08D
 HDVgjyxMSV6KManzrVcq+RzyfNX8o9zxVgmmHCG0F9Xtgy3CUYm76PFzh/LdjI3eadms
 c8WZBgbFFM1F6lb9yLeZvn7kiaNIHtDmYcklXIoaUD/Si7Q+vP66Tl/A9Ld9VK4MAVNp
 FUhWDo46wLvan6bC31rtHi8XOHeGBgplID2wrwsu8N/cYOR1UQD/NsUzNwRHmF4EpQr2
 yRxw==
X-Gm-Message-State: APjAAAUplvGdtPOFLekb4HW8ysZaFj+2mGCr+zBfgQGo34YP9D/leRVV
 DwmqHTRpZlsdv+H91Jy01e1mHufMW/RMauOP6/wFzX7yJai1L2lT3AcjwB5nC89W6Y9O2nQXBWo
 3deYvjVWCBlYNNX4=
X-Received: by 2002:ac8:6f0d:: with SMTP id g13mr15277309qtv.56.1581438642020; 
 Tue, 11 Feb 2020 08:30:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqw8pt1dVYhIDlEvHP4vVikgd+h4BH8MgiewrP/p/jiTIQSGlQoc5hkBl4ZGFgRnNHJ52Iigsw==
X-Received: by 2002:ac8:6f0d:: with SMTP id g13mr15277288qtv.56.1581438641791; 
 Tue, 11 Feb 2020 08:30:41 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id f26sm2343160qtv.77.2020.02.11.08.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 08:30:40 -0800 (PST)
Date: Tue, 11 Feb 2020 11:30:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v15 0/9] VIRTIO-IOMMU device
Message-ID: <20200211113000-mutt-send-email-mst@kernel.org>
References: <20200208120022.1920-1-eric.auger@redhat.com>
 <20200211085526-mutt-send-email-mst@kernel.org>
 <CAFEAcA8hWyHYk+PPLsyjyqiRqaWfosJwrpFpsRXnO+toSzaZfw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8hWyHYk+PPLsyjyqiRqaWfosJwrpFpsRXnO+toSzaZfw@mail.gmail.com>
X-MC-Unique: crt2faejNQeImrXUK1GnPg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: jean-philippe@linaro.org, "Tian, Kevin" <kevin.tian@intel.com>,
 tnowicki@marvell.com, Juan Quintela <quintela@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, bharatb.linux@gmail.com,
 qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 11, 2020 at 03:02:28PM +0000, Peter Maydell wrote:
> On Tue, 11 Feb 2020 at 13:56, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Sat, Feb 08, 2020 at 01:00:13PM +0100, Eric Auger wrote:
> > > This series implements the QEMU virtio-iommu device.
> > >
> > > This matches the v0.12 spec (voted) and the corresponding
> > > virtio-iommu driver upstreamed in 5.3. All kernel dependencies
> > > are resolved for DT integration. The virtio-iommu can be
> > > instantiated in ARM virt using:
> > >
> > > "-device virtio-iommu-pci".
> > >
> > > Non DT mode is not yet supported as it has non resolved kernel
> > > dependencies [1].
> > >
> > > This feature targets 5.0.
> > >
> > > Integration with vhost devices and vfio devices is not part
> > > of this series. Please follow Bharat's respins [2].
> > >
> > > Best Regards
> > >
> > > Eric
> >
> >
> > Looks good.
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > I can see this merged through ARM tree, or through my tree with
> > Peters's ack for the ARM bits.
>=20
> Either way would work for me. I left some review comments
> on patch 8 which I think is the only arm-specific one.
>=20
> Can you use the virtio-iommu on x86 ? Would you want to?

Potentially yes.

> If I'm not misreading the MAINTAINERS file the new
> files in hw/virtio aren't covered by any existing
> entry there, so we should probably have a new one.
>=20
> thanks
> -- PMM


