Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2273C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:11:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4972120EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGCX43tJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4972120EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHr4Z-0006Ov-6U
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 12:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kHqTK-0005E9-9S
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:32:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37067)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kHqTH-0004B0-AI
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600097564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YYnbWipXS1RKN/T1O5cmbU6o10USV8OxJxrlQknDX6c=;
 b=GGCX43tJo0eHpNY28/5uXF2yh9wkRLcJwLGIX8S/IjUi6kuf4gJZl6ym5rpCQDh1YyQyqW
 F7w6ZGu2dsNhrLjKB4i5JfZ0gPoKDNCRY3PdSfMc/IrxcP+dShdGFoXU/ZovvtEG95dKAA
 ix35eh7u2mbbsfNKFwqAJwmefrew3Gw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-rqWPbzavN8ePzk16_kmX1A-1; Mon, 14 Sep 2020 11:32:41 -0400
X-MC-Unique: rqWPbzavN8ePzk16_kmX1A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5262C1005E5D;
 Mon, 14 Sep 2020 15:32:40 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EA9750B44;
 Mon, 14 Sep 2020 15:32:35 +0000 (UTC)
Date: Mon, 14 Sep 2020 09:32:35 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add Stefan Hajnoczi as block/nvme.c
 maintainer
Message-ID: <20200914093235.3777f39b@x1.home>
In-Reply-To: <20200914103703.GH579094@stefanha-x1.localdomain>
References: <20200907111632.90499-1-stefanha@redhat.com>
 <20491ab5-7d5d-9360-7215-a1a56dbf5ed0@redhat.com>
 <20200914103703.GH579094@stefanha-x1.localdomain>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:55:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Sep 2020 11:37:03 +0100
Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Wed, Sep 09, 2020 at 02:51:50PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > On 9/7/20 1:16 PM, Stefan Hajnoczi wrote: =20
> > > Development of the userspace NVMe block driver picked up again recent=
ly.
> > > After talking with Fam I am stepping up as block/nvme.c maintainer.
> > > Patches will be merged through my 'block' tree.
> > >=20
> > > Cc: Kevin Wolf <kwolf@redhat.com>
> > > Cc: Klaus Jensen <k.jensen@samsung.com>
> > > Cc: Fam Zheng <fam@euphon.net>
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >  MAINTAINERS | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index b233da2a73..a143941551 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -2895,10 +2895,12 @@ S: Supported
> > >  F: block/null.c
> > > =20
> > >  NVMe Block Driver
> > > -M: Fam Zheng <fam@euphon.net>
> > > +M: Stefan Hajnoczi <stefanha@redhat.com>
> > > +R: Fam Zheng <fam@euphon.net>
> > >  L: qemu-block@nongnu.org
> > >  S: Supported
> > >  F: block/nvme*
> > > +T: git https://github.com/stefanha/qemu.git block =20
> >=20
> > As this driver is the only consumer of the 'VFIO helpers',
> > maybe we can:
> >=20
> > - maintains them in the same bucket
> > - add another entry (eventually with R: tag for Alex)
> >=20
> > The 'VFIO helpers' files are:
> > - util/vfio-helpers.c
> > - include/qemu/vfio-helpers.h
> >=20
> > What do you think? =20
>=20
> I'm happy to include vfio-helpers with the goal of eventually switching
> to vfio-common.
>=20
> Alex: does this sound good?

Yep, ok by me.  Thanks,

Alex


