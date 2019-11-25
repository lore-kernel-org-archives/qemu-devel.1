Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A2CC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:50:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 707D620674
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vnv1TkWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707D620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZGch-0000Kp-T1
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 10:49:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iZGTp-0000U2-8f
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:40:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iZGTo-00031R-37
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:40:49 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41614
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iZGTn-00030p-V6
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574696447;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UpOn6Na2p1Jiw8koUNq+IGodiPP9AnTwGCaopCORq/k=;
 b=Vnv1TkWsvclPgAmEg+/wZ5TH1v4H2TMluLAvob4E/3xDEuwoODSQuXCBLDOPuQ2h5+s+Gx
 ELdHU3KiqEz0aM7zlc52tWstsEAUycvqbkp5IlUfO1b7utLZI826lQzyXY5tUf9AOPtCxJ
 lNuyzeoNAW9LVtx8Dl+bBx/HMM5zUs4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-lt4pjHqWOCqoGXdOgGQ1Yw-1; Mon, 25 Nov 2019 10:40:41 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2506E881D30;
 Mon, 25 Nov 2019 15:40:40 +0000 (UTC)
Received: from redhat.com (ovpn-112-59.ams2.redhat.com [10.36.112.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B1125C290;
 Mon, 25 Nov 2019 15:40:24 +0000 (UTC)
Date: Mon, 25 Nov 2019 15:40:21 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: Re: [libvirt] [PATCH-for-4.2] hw/mips: Deprecate the r4k machine
Message-ID: <20191125154021.GI4157473@redhat.com>
References: <20191125104103.28962-1-philmd@redhat.com>
 <CAL1e-=hktyuAzESyZMz3P4a9aq17dsrrzWpyXYfFYn=cWP3e4A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAL1e-=hktyuAzESyZMz3P4a9aq17dsrrzWpyXYfFYn=cWP3e4A@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: lt4pjHqWOCqoGXdOgGQ1Yw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Thomas Huth <thuth@redhat.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 25, 2019 at 03:45:35PM +0100, Aleksandar Markovic wrote:
> On Monday, November 25, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
> wrote:
>=20
> > The r4k machine was introduced in 2005 (6af0bf9c7) and its last
> > logical change was in 2005 (9542611a6). After we can count 164
> > maintenance commits (QEMU API changes) with the exception of
> > 1 fix in 2015 (memory leak, commit 3ad9fd5a).
> >
> >
> Please don't start any deprecation process. This requires certain
> consultation within my company. Rest assured that everyone's opinion will
> be taken into account while doing consiltation.

The idea of having a deprecation process is precisely to
allow time for people like to provide feedback before any
deletion takes place. So this is not a reason to delay
starting of deprecation.

The process lasts for 2 releases before we delete anything:

  https://qemu.weilnetz.de/doc/qemu-doc.html#Deprecated-features

When we start the clock now, it is deprecated when 5.0 releases
in April 2020, and still deprecated with 5.1 in August 2020.

The code won't be deleted until Sep 2020 when 5.2 dev cycle opens,
and there's still time to undelete it right up until the 5.2 feature
freeze in late Oct 2020. That's 11 months away, which is plenty of
time for feedback IMHO.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


