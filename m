Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FCCC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 22:10:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 109B7205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 22:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iG9sjHA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 109B7205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxvw-0006yp-9O
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 18:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jDxU1-0004O4-7w
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:41:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jDxTz-0007Rk-TL
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:41:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:55211)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jDxTz-0007GV-MV
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hsQsm5hV2ZBOmd7M3g/bskb7EbZv3u0Mh4NWEi7ju1A=;
 b=iG9sjHA5gCcWyWlLotf8wGMdW8+ujXNM6uX88604qId79t0GjzaWl27mTRUzFPuAdWSXBC
 xSEQwEr1jTDavfZl1Y8iMOP8W5qAM2CVambBLpJ1LtBbO9+FdFTvTcejbOBAQ7SY2z3MS9
 iECv2qFwkHy7Pe8PFdy3VU/pOTaA46M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-Vd2KuuqEM-as8mIgS-eg2g-1; Mon, 16 Mar 2020 17:41:08 -0400
X-MC-Unique: Vd2KuuqEM-as8mIgS-eg2g-1
Received: by mail-wr1-f69.google.com with SMTP id n11so9180957wrs.13
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 14:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=J5LDVR52MYacWg0sUWklIsoO9H9wE+Uh809qRKktBAw=;
 b=XQoo6RDW2HLko257VOQiGm3X+VbJuITqlmGK+RO9IeV4qPW8t7xTxCZ/8A8D18PUjT
 uZRD4ZazdX7PWLm7ileCE5jani0B9vVhNPFl4lvW/uzG/55kKky/pOhZix+K664fubNw
 lo7Xpg9GI6jpv+dwzYnRMsJhSvxUz2UVVGz8f2dK4uaG1Q1Hiad/Wg3NoddYwIFXo5qc
 t/bgAJgF/LWg++ee1nhLTwkH4Fl3ltbliwAUpgLJqLvEpZ62bENcBEvezKsoA+bvJONr
 5Nld0uSCTXQQ/qTAymkWRVOLLhTPPD9G4ZcSka1kxYBNmX86/1DquaQmSVMqJsL+zwib
 oNWQ==
X-Gm-Message-State: ANhLgQ1glylhWNB3uoDRaxYvIFLe599uEQmLLHStvI0ZDS85z8ytmEQS
 dyuud2e61uNRLDPsExyIJl9GnP1XWooa3hHs7Dza0deMhNJOAFXqSdWZ4VmwFLTGOrIVSZQKSMU
 glQ3Q1Yq1Cs22jpg=
X-Received: by 2002:a5d:458c:: with SMTP id p12mr1552754wrq.66.1584394867454; 
 Mon, 16 Mar 2020 14:41:07 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsAONPyo7pTDp5GVJZ7dU8vLVMhQHzpIo4UlZX2Va9FDeNzZKHFdnaQoa9DE40dXbc2k8DbMg==
X-Received: by 2002:a5d:458c:: with SMTP id p12mr1552736wrq.66.1584394867254; 
 Mon, 16 Mar 2020 14:41:07 -0700 (PDT)
Received: from redhat.com (bzq-79-180-7-202.red.bezeqint.net. [79.180.7.202])
 by smtp.gmail.com with ESMTPSA id
 9sm1191845wmx.32.2020.03.16.14.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 14:41:05 -0700 (PDT)
Date: Mon, 16 Mar 2020 17:41:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 2/2] mmap-alloc: Include osdep.h before checking
 CONFIG_LINUX
Message-ID: <20200316173626-mutt-send-email-mst@kernel.org>
References: <20200311232342.1614944-1-ehabkost@redhat.com>
 <20200311232342.1614944-3-ehabkost@redhat.com>
 <20200315154559.GW1187748@habkost.net>
 <20200315170229-mutt-send-email-mst@kernel.org>
 <20200316173039.GB1817047@habkost.net>
 <CAFEAcA9CYeTjmUSbMtGjDazrh1p=5vLAd3bq7JBtLd0RfnruDw@mail.gmail.com>
 <20200316184046.GD1817047@habkost.net>
 <CAFEAcA-i_S1TZWoDQ5L4J32t3N+aHWvm9dGqHxFHB7wuKpE0iA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-i_S1TZWoDQ5L4J32t3N+aHWvm9dGqHxFHB7wuKpE0iA@mail.gmail.com>
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
Cc: Jingqi Liu <jingqi.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 16, 2020 at 07:20:02PM +0000, Peter Maydell wrote:
> On Mon, 16 Mar 2020 at 18:40, Eduardo Habkost <ehabkost@redhat.com> wrote=
:
> >
> > On Mon, Mar 16, 2020 at 06:08:54PM +0000, Peter Maydell wrote:
> > > The usual approach is that if you don't have the Linux-specific
> > > feature available you quietly fall back to whatever the sensible
> > > behaviour is for when the feature isn't present. We definitely
> > > don't want to be printing warnings on non-Linux systems that
> > > are effectively just saying "you're not running Linux". Same goes
> > > for "host happens not to be running a bleeding-edge Linux kernel
> > > and this feature isn't available yet".
> >
> > I don't think using pmem=3Don without MAP_SYNC is expected to be a
> > supported use case, is it?  If a use case is not supported, the
> > sensible behavior is to tell the user it is not supported.
>=20
> Yeah, that's fair. But the code at the moment does a fallback
> to "proceed without SHARED_VALIDATE | SYNC", so I assumed it
> was supposed to work.
>=20
> thanks
> -- PMM

Oh I remember now. pmem=3Don was introduced without MAP_SYNC first.
So yes, it's ok to set it to 0 for mips.

--=20
MST


