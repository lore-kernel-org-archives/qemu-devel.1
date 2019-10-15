Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6ECECE58F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 21:04:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C31B2083B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 21:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ARfnjfnG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C31B2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKTzu-0008WL-Kf
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 17:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iKTyj-0007Ua-3T
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 17:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iKTyg-0004Vr-KB
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 17:03:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44715
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iKTyg-0004Ug-9o
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 17:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571173412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0J9YiDjWgC5KXBkVTVYpAAbtmtsdgmWhH6B1ZMws+D8=;
 b=ARfnjfnGFYLAPLCaC5xLhkfusyn42DarrQ9z9HTdVITOLZoi8QN/NU4IWKE0L/VmAhcZqQ
 B/sAmg5wMiq5JPllpcznjBO99Nr7GYjkSoRnEpMy65k87kbUSbqqSL9vlMdI3J+L2vJmyJ
 BWUb+Vq8GGr8qJocAI7/0iVJPuDdSiI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-Cdf_IWfsMsyI166FGaqC_w-1; Tue, 15 Oct 2019 17:03:30 -0400
Received: by mail-wm1-f70.google.com with SMTP id l3so212440wmf.8
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 14:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=U+XpzMxKOL4mmsYnlHbFYn8lnj4PX+5aftBwbc/wAsI=;
 b=EDRdPctpQuOGua/F9dqd+G0KXI5HwOcp0H9bs+olDFfVNzFUOwn4M6HsqZhUR/yQdT
 gbiekoOjuZ5GhsT/B2tcAiZfup2exosW66+ClqI0+I0DNS1QRcBOrg7ygZAP8suzs+Eu
 9A+wTQ5IhuI1W8c4uU1kIkcJVclsb4X9fvljel+jPsi/QJDj+CH3eM3Lta4lbHCk61k2
 RGmoR9/PUImAeF7Q2UvvpkwCGtZZUVDv/Hhs/i49n2/Xq+GAXX8zo8b7toGqXi+ofnme
 P0grjG2qFgY4jKhbZO7XZJ45rbyyxOWyLdYg0PhHWG2c0yCPHvSIp1c9ENKxO/A+153G
 QVFA==
X-Gm-Message-State: APjAAAUFtlYvi/HwoVfg1KA2rTUSn+riz6x/8y+dEnE42pzhJhgiSGHS
 rQbDBdbwuCDDajFyIAHZ5iDg8sSqhVBr3EWtx+fqVR4U6eZ6s9B2UgyxI85itTF8HGn8Ry/chEY
 gsF5F6HwNULsVZKs=
X-Received: by 2002:a1c:ed0d:: with SMTP id l13mr409732wmh.76.1571173409228;
 Tue, 15 Oct 2019 14:03:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxHOGqf1ZoRZNI1Advj4Lksch+m7xYx8UAZ3A+9B/Ft2Uwq0+hInzWA7e0PMb60CBT4gEprEA==
X-Received: by 2002:a1c:ed0d:: with SMTP id l13mr409726wmh.76.1571173408980;
 Tue, 15 Oct 2019 14:03:28 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 n15sm20774486wrw.47.2019.10.15.14.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2019 14:03:28 -0700 (PDT)
Date: Tue, 15 Oct 2019 17:03:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/19] virtio, vhost, acpi: features, fixes, tests
Message-ID: <20191015165846-mutt-send-email-mst@kernel.org>
References: <20191005215508.28754-1-mst@redhat.com>
 <CAFEAcA96HPyqqCr5C4Ymtoji8srsaC0W=8t+Q-Xf=XGwt5mW=A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA96HPyqqCr5C4Ymtoji8srsaC0W=8t+Q-Xf=XGwt5mW=A@mail.gmail.com>
X-MC-Unique: Cdf_IWfsMsyI166FGaqC_w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 07, 2019 at 05:31:32PM +0100, Peter Maydell wrote:
> On Sat, 5 Oct 2019 at 22:58, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > A couple of tweaks to the bios table test weren't
> > reviewed yet but as they are really helpful to
> > the arm tests I'm pushing, and affecting only the
> > test so fairly benign (dropped assert + a comment),
> > I cut a corner and pushed them straight away.
> > Will be easy to tweak with a patch on top or revert.
> >
> > The following changes since commit 4f59102571fce49af180cfc6d4cdd2b5df7b=
db14:
> >
> >   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-oct-0=
1-2019' into staging (2019-10-01 16:21:42 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to 9d59bed1da5e5815987879346cf708344060ea63=
:
> >
> >   virtio: add vhost-user-fs-pci device (2019-10-05 17:43:55 -0400)
> >
> > ----------------------------------------------------------------
> > virtio, vhost, acpi: features, fixes, tests
> >
> > Tests for arm/virt ACPI tables.
> > Virtio fs support (no migration).
> > A vhost-user reconnect bugfix.
>=20
> Hi -- this summary of the changes just says it has
> updates to the test code, but the patches include:
>=20
> > Shameer Kolothum (8):
> >       hw/arm/virt: Enable device memory cold/hot plug with ACPI boot
>=20
> which is to say actually enabling the hotplug memory feature,
> not just tweaking tests. Did you mean to put the whole feature
> in this pullreq? (If you did, that's fine, it just doesn't
> match up with the cover letter so maybe it was an accident?)
>=20
> thanks
> -- PMM

Yes this was intentional. I meant I was asked to merge it because of
the tests. But tests wouldn't pass without the feature :)
I've updated the description. Pls pull.

--=20
MST


