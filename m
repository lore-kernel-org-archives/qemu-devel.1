Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417F0C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 11:09:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D5802080C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 11:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQ7LgQ07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5802080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j16wJ-0007OH-7P
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 06:09:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j16vf-0006pw-Dg
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:08:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j16ve-0004nd-6v
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:08:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45944
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j16ve-0004nN-3B
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:08:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581332917;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xIb2kGGeRaHTC95b0eLfQB7HWNahXRCA/gEMap+k1Jk=;
 b=IQ7LgQ074SgMIv3QJxa8QLHvpUCPzYaQnkxghxEZCqCk5hcJR0jacQWtAHOE3Vg9kCGhG0
 xxyXL4ftdd8jnpUDc5ZmrDQ/j3akFSPHSDQXGx6uJYzCtOW6fWKacgKvDy79kUXJGBn0lI
 xHmfvHTZKVkrCIVnl/1zqWuEONz0zaY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-jSwBx0IaP46F6gg866wynA-1; Mon, 10 Feb 2020 06:08:26 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED91818CA240;
 Mon, 10 Feb 2020 11:08:23 +0000 (UTC)
Received: from redhat.com (ovpn-112-55.ams2.redhat.com [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 57EAB26FD6;
 Mon, 10 Feb 2020 11:08:15 +0000 (UTC)
Date: Mon, 10 Feb 2020 11:08:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Summary of Re: Making QEMU easier for management tools and
 applications
Message-ID: <20200210110812.GB3269@redhat.com>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <875zgm2vqv.fsf@dusky.pond.sub.org>
 <CAJSP0QWCn_vv2Vs-UWc9nPHjdBQq9KMkiQ7D91+RwHM_okTzZw@mail.gmail.com>
 <CAFEAcA9NfGivg0C_enAT_8+_mmbQSi6H=7G+4w7RdJwXP7yUtA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9NfGivg0C_enAT_8+_mmbQSi6H=7G+4w7RdJwXP7yUtA@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: jSwBx0IaP46F6gg866wynA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 10, 2020 at 11:01:48AM +0000, Peter Maydell wrote:
> On Mon, 10 Feb 2020 at 10:57, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > I'm in favor of simplifying QEMU at the expense of an incompatible CLI
> > change in QEMU 6.0.
>=20
> If we want to do wholesale incompatible changes to the CLI
> I think we definitely need some kind of tool where a user
> can say "here's my old command line, what's the new style
> equivalent?". Otherwise we're going to have a deluge of
> user issues where their old working setups broke and
> QEMU didn't give them any useful hints about why.

There is a risk that if we promise to have a fully automated conversion
that it will be alot of work, and could force us to introduce hacks into
the new impl just to satisfy conversion.  IMHO we shouldn't be afraid of
declaring that some parts of the old syntax can NOT be directly transformed
into new syntax, simply for the sake of making a new impl more practical
to move forward with.

An alternative approach to mitigate the disruption is to *not* make any
incompatible changes to qemu-system-XXXX. Instead introduce new binaries
with the new syntax and any other architectural  changes we wish to make.
The old binaries can be deprecated but remain around for an extended
period of time, to give people and apps time to migrate. We can provide
rough guidance and perhaps partially automated conversion to help people
move, but not aim for a 100% automated conversion.=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


