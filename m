Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CF1C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 10:05:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C05124686
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 10:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZsZa/zlU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C05124686
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwNk0-0003Fn-Ou
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 05:05:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iwNjF-0002kf-G7
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:04:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iwNjC-0005SW-MD
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:04:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25452
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iwNjC-0005R1-Av
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 05:04:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580205853;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ggMU2O5FuN/w4Jfpv2Ow5aDB3X7xp32MfNIxAT+Jiws=;
 b=ZsZa/zlUCGX43sTi3bGqK2g62Yi9wUzpTCFHe2AiFVSxYMLdcIBxkfTpd4LnLgBfL+xWth
 WgkD045yIZerr/U4qVwtvGtv/BAn6L/3mHgR3lMqBkWdwGbQKYYffjuZ2FKZeIKN3+w3oU
 3runMwestigXaTQX8xmR2kwBYz//wVg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-FnXxB2jcMZyOlNow_MnHSA-1; Tue, 28 Jan 2020 05:04:10 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B15B8010C9;
 Tue, 28 Jan 2020 10:04:09 +0000 (UTC)
Received: from redhat.com (ovpn-112-34.ams2.redhat.com [10.36.112.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EED315D9C9;
 Tue, 28 Jan 2020 10:04:00 +0000 (UTC)
Date: Tue, 28 Jan 2020 10:03:56 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: Integrating QOM into QAPI
Message-ID: <20200128100356.GF1446339@redhat.com>
References: <871rrtmkko.fsf@dusky.pond.sub.org>
 <20200121113224.GD630615@stefanha-x1.localdomain>
 <CAJ+F1C+anMuBE6pOu8JNOoaNnDw8a47Dc1f6MhnxH=rRNqMF=Q@mail.gmail.com>
 <87wo9lc4oe.fsf_-_@dusky.pond.sub.org>
 <20200121143658.GB597037@redhat.com>
 <871rrs97ld.fsf@dusky.pond.sub.org>
 <CAJ+F1CJ68_QM7zhqoL-bom3vFSNprN3zOV5FUBtrJWg4nAai5g@mail.gmail.com>
 <C4AB0E62-765F-45BC-A442-99C643CFFCCD@redhat.com>
 <CAFEAcA9xtwNzZQS7biDy=LtZEiLDis3iQztOcP2+2NnCj80c0Q@mail.gmail.com>
 <B442E0A6-E0C5-426A-8234-EE6491AE4BB0@redhat.com>
MIME-Version: 1.0
In-Reply-To: <B442E0A6-E0C5-426A-8234-EE6491AE4BB0@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: FnXxB2jcMZyOlNow_MnHSA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 27, 2020 at 08:05:36PM +0100, Christophe de Dinechin wrote:
>=20
>=20
> > On 26 Jan 2020, at 16:04, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
> >=20
> > On Sun, 26 Jan 2020 at 08:10, Christophe de Dinechin
> > <dinechin@redhat.com> wrote:
> >> I=E2=80=99m still puzzled as to why anybody would switch to something =
like
> >> GObject when there is C++.
> >=20
> > I'm fairly strongly against using C++.
>=20
> Just to be clear, so am I ;-)
>=20
> > C++'s language design
> > is an "everything including the kitchen sink, lots of "this
> > is here for back compat but it's a bear trap", lots of new
> > stuff arriving all the time.
>=20
> Actually, the new stuff is not that bad, overall.
>=20
> I do agree C++ is an overly complicated language, and that in
> practice, there is zero chance of qemu moving to it. But that does
> not invalidate my point that creating a class in C++ is easier
> than creating a class in any C-based macro-heavy reinvention
> of basic OO concepts.
>=20
> (I write this after having read Paolo=E2=80=99s response, which points
> out IMO better reasons for GObject, which I will discuss there).
>=20
> > It's just too big to keep in
> > your head all at once. C has its faults, absolutely, but at
> > least it tries to be a reasonably sized vaguely coherent
> > language.
> >=20
> > You'd have more luck persuading me we should move to Rust:
> > at least then we'd get some clear benefits (no more buffer
> > overrun security bugs) for the upheaval :-)
>=20
> This is largely a myth as soon as you need to do =E2=80=9Cyour own stuff=
=E2=80=9D.
> Example: CVE-2019-18960, https://seclists.org/oss-sec/2019/q4/141.

Calling it a "myth" from from that one data point is not really credible.

No language is perfect & such that it can eliminate all possible CVEs.
Rust *can*, however, eliminate a very large set of bugs which lead to=20
memory corruption in unchecked languages like C/C++.  You'll still have
CVEs to deal with, but they'll be different classes of bugs, or rare
edge cases like the one you show above.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


