Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EECC35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 18:40:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7577C2084E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 18:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXbTdBck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7577C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6f7m-0008JZ-Iv
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 13:40:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6f6w-0007jl-W1
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:39:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6f6v-0005x3-OX
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:39:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31711
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6f6v-0005wC-IU
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 13:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582655952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZQ7op8ukBwm6R4fltMGNBXII2YOgN7PGUmCvhQMNj5o=;
 b=SXbTdBckSaSa95XfjU7QI2J73j0ZtB5X25GjCRItEPlq+Y6vLdowRNrqQp2GXR/09tHW0V
 mxneiLHRV23ZhonZXxXJRGO8JPOjiK330Aea2X4T+7GcuS4NlJsxNQneeXqabYRSq+D9kp
 SQB97IXEAFrbsdNu3gasyvGxve3Mges=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-kaiRDZSbMje77xeserusog-1; Tue, 25 Feb 2020 13:39:10 -0500
X-MC-Unique: kaiRDZSbMje77xeserusog-1
Received: by mail-qk1-f198.google.com with SMTP id z124so16116188qkd.20
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 10:39:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9Z9FFifr106KcZRD0UrCyxdl2G8zIVW+hHhhfTddiGo=;
 b=kLQF/Ou5y9ClnhYjg74J0hlaB3DvFjUJmUBMskurtJSFS2Y+iBfw9C/2yiODzQbX3T
 AYcfTG9LJ8XjJ0YFTQsxXCXxxy9ShZr8DhrxxGLZcDEGodvajfX5pBDNiJrgcaANc482
 rcAmb/M1GMIrBpgaXvXJUynNTrsdx8dO/aNdhMtQOTBu1iQwu1/ExA8v8tdqw+pTUN0V
 9SRv+AK8c2d6EvTKUHo5Qi7BoD+NibYKmCF5DGvrbXL7aHe9KeL9Kd+vS6qWgfJRXp29
 KbMt9x8eWLyi1t4lp/9NlZm1Oqipvndm7lLRxgMPKL+CtyuY6iFgspNvy77JQbfacSro
 ZnJA==
X-Gm-Message-State: APjAAAVvL0FnJY0reW2fHmZTH8MonMoO27Tse83j/w7n0aw5f4ejeTle
 FZ2p48AZ6ALwuad/ok0Ea8hOFzCeA6m8si/8dgIyFhai6ArbFWY2O6G1yK1JyjcmsSPrJngPjyM
 EUhJ7OIqSAggJdC8=
X-Received: by 2002:aed:31e2:: with SMTP id 89mr55522344qth.35.1582655950438; 
 Tue, 25 Feb 2020 10:39:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqyROUZH9Hw5bWOXmOxM3wmsUFq0oZZX3hdy9fqWxfDWp/BiPvSwl/ZrB2RwmubfLiOGOt6hJQ==
X-Received: by 2002:aed:31e2:: with SMTP id 89mr55522324qth.35.1582655950157; 
 Tue, 25 Feb 2020 10:39:10 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 g6sm7668813qki.100.2020.02.25.10.39.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 10:39:09 -0800 (PST)
Date: Tue, 25 Feb 2020 13:39:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/32] virtio, pc: fixes, features
Message-ID: <20200225133855-mutt-send-email-mst@kernel.org>
References: <20200225151210.647797-1-mst@redhat.com>
 <CAFEAcA-eDYoyD-Hs6i7b3J+nt92DNUpFo9J+UZJtoxQ49R3i1w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-eDYoyD-Hs6i7b3J+nt92DNUpFo9J+UZJtoxQ49R3i1w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 25, 2020 at 04:47:31PM +0000, Peter Maydell wrote:
> On Tue, 25 Feb 2020 at 15:12, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > The following changes since commit 9a8abceb5f01d1066d3a1ac5a33aabcbaeec=
1860:
> >
> >   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-docs-2020022=
5' into staging (2020-02-25 11:03:47 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to afc37debf27ecf34d6bc1d4b52fa0918d0bd3f3c=
:
> >
> >   Fixed assert in vhost_user_set_mem_table_postcopy (2020-02-25 08:47:4=
7 -0500)
> >
> > ----------------------------------------------------------------
> > virtio, pc: fixes, features
> >
> > New virtio iommu.
> > Unrealize memory leaks.
> > In-band kick/call support.
> > Bugfixes, documentation all over the place.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> Hi; this fails to build on OSX:
>=20
>   CC      contrib/libvhost-user/libvhost-user.o
> /Users/pm215/src/qemu-for-merges/contrib/libvhost-user/libvhost-user.c:27=
:10:
> fatal error: 'sys/eventfd.h' file not found
> #include <sys/eventfd.h>
>          ^~~~~~~~~~~~~~~
> In file included from

weird this is not new.

> /Users/pm215/src/qemu-for-merges/contrib/vhost-user-bridge/main.c:37:
> /Users/pm215/src/qemu-for-merges/contrib/libvhost-user/libvhost-user.h:21=
:10:
> fatal error: 'linux/vhost.h' file not found
> #include <linux/vhost.h>
>          ^~~~~~~~~~~~~~~
> 1 error generated.
>=20
> thanks
> -- PMM


