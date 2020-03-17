Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C95AC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:16:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19DE820714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J0P+WENz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19DE820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEDwl-0000Y8-67
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jEDsm-0005p4-H6
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:11:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jEDsk-0001og-Ry
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:11:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:45541)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jEDsk-0001jJ-3I
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584457909;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LkX81IMsUQ+DjurR7kOZbluED1mNhs0b7Sq9o8OmHg4=;
 b=J0P+WENzQkCsYbmoliqsmiav2pDueimx3//l8C2tEe19xMt69cWAoyL8q1LyU8OTSrmi4F
 AmrJu0dkTl/Y+3Fu7Omr7ITcJnBPBDQqPVUcQb5b17rZkwLSdgeDhwTf/Cz9srHA8zOC9Z
 8KntN/lQm88wJohzL6Mx7/UTrFiMLzw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-utVJ8v8KO7OqMUuY_QdTHg-1; Tue, 17 Mar 2020 11:11:45 -0400
X-MC-Unique: utVJ8v8KO7OqMUuY_QdTHg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BCB71034B20;
 Tue, 17 Mar 2020 15:11:44 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 419A25D9E5;
 Tue, 17 Mar 2020 15:11:35 +0000 (UTC)
Date: Tue, 17 Mar 2020 15:11:31 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/10] Bitmaps patches
Message-ID: <20200317151131.GL2041016@redhat.com>
References: <20200317043819.20197-1-jsnow@redhat.com>
 <CAFEAcA_=DHpNZ+b9Hrim39R74Jik8MKqu8MPJm80wMsQS0FADQ@mail.gmail.com>
 <5805273e-0a2f-850a-a07a-97dac0d7211e@redhat.com>
 <20200317145703.GH2041016@redhat.com>
 <CAFEAcA9-YLNcZPPsHsdLB0O2Ac4WKPspMe=Re2S7tyTZu=kwFA@mail.gmail.com>
 <20200317150528.GK2041016@redhat.com>
 <CAFEAcA_pLvupGhgeuevVBxhNz-NVkKWOUrr=nJaPAEKquHaqxw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_pLvupGhgeuevVBxhNz-NVkKWOUrr=nJaPAEKquHaqxw@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 17, 2020 at 03:07:34PM +0000, Peter Maydell wrote:
> On Tue, 17 Mar 2020 at 15:05, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
> >
> > On Tue, Mar 17, 2020 at 03:00:48PM +0000, Peter Maydell wrote:
> > > On Tue, 17 Mar 2020 at 14:57, Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> > > > I don't feel like -Wno-unused-function looses anything significant,=
 as
> > > > the GCC builds will still be reporting unused functions which will
> > > > catch majority of cases.
> > >
> > > The most interesting difference is that clang will catch unused
> > > static inline functions which gcc does not.
> >
> > That's mostly just about dead code cruft detection IIUC. That code won'=
t
> > make it into the binary if it isn't used.
>=20
> Indeed, but it's nice to have the dead code cruft detection. You
> can always mark the function as __attribute__((unused)) if you really
> mean that it might be present but not used.

The *BSDs  seem to track latest glib pretty quickly. So if we got the
unused attribute into upstream glib, we would probably have about
6-9 months before we get a build platform with the fixed glib included
where we can conditionally re-enable the unused-function warning.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


