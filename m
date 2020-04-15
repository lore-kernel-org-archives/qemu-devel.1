Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C1EC2BB55
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 12:44:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75987206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 12:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W4IJCZoC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75987206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOhP7-0006wJ-K7
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 08:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jOhNT-0005U3-RV
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jOhNS-00043F-L1
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:42:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42591
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jOhNS-00042n-Gu
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 08:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586954569;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pDg5qi4xsryBk4w02BFiq4x1Ldryzh5UYOH/kWiPtkE=;
 b=W4IJCZoCqzkfvyv1X4fXAmvf0QEBcxIQ0f3B44YeRh2HNfFrvpH5Y90wDboA4G79y/qljv
 RjKYOMfLOhUjXmxms38WNgv3dQxfDV1c59o1h2rfY8m+S8zqBWitjG5wVR1Bq0uzYxGJdE
 4JioYdKK6Ejlyr1WELriqZKmxKsrm3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-pTUhGiO2N7iWVEoJH3_vGg-1; Wed, 15 Apr 2020 08:42:42 -0400
X-MC-Unique: pTUhGiO2N7iWVEoJH3_vGg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3D801005510;
 Wed, 15 Apr 2020 12:42:40 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA93A19C70;
 Wed, 15 Apr 2020 12:42:39 +0000 (UTC)
Date: Wed, 15 Apr 2020 13:42:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [for-5.0] Deprecate KVM support for AArch32
Message-ID: <20200415124236.GG1344391@redhat.com>
References: <20200414120935.12719-1-peter.maydell@linaro.org>
 <20200415123310.GC1344391@redhat.com>
 <CAFEAcA80g-Zohi0t7u51aNs58i8_zPCOcRob6zx6DYdTjYfXWQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA80g-Zohi0t7u51aNs58i8_zPCOcRob6zx6DYdTjYfXWQ@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 15, 2020 at 01:41:05PM +0100, Peter Maydell wrote:
> On Wed, 15 Apr 2020 at 13:33, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
> >
> > On Tue, Apr 14, 2020 at 01:09:35PM +0100, Peter Maydell wrote:
> > > The Linux kernel has dropped support for allowing 32-bit Arm systems
> > > to host KVM guests (kernel commit 541ad0150ca4aa663a2, which just
> > > landed upstream in the 5.7 merge window).  Mark QEMU's support for
> > > this configuration as deprecated, so that we can delete that support
> > > code in 5.2.
> > >
> > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > > ---
> > > I was reading the 5.7 merge window writeup on LWN this weekend
> > > and saw that the dropping of 32-bit support had gone in; just
> > > enough time to squeeze our deprecation warning into 5.0 so we
> > > can drop the code in 5.2 rather than 6.0...
> > >
> > >  docs/system/deprecated.rst | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> >
> > The docs are sufficient to start the deprecation process, but
> > we might consider also having a warning from configure, or a
> > message on stderr at runtime to make it more visible to users.
>=20
> Mmm. I didn't feel entirely comfortable making code changes to
> print messages at this point in the 5.0 release cycle, though.

Sure, that's understandable.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


