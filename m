Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BD9C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:27:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1343224673
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/l6jOUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1343224673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irKMY-0006mE-1I
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 06:27:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1irKLD-0005N1-I1
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:26:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1irKLA-0006QU-4c
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:26:35 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49707
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1irKL9-0006Q7-Vn
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579001191;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lzblGynO8njBoY9XqYLz5uI14FqX8lgrqCV7DzZofeY=;
 b=C/l6jOUplV56gEaIgf3p5WKqxIi6Xzr4f+Q7xnW4Jj0dXA9BaCrV9uK1Lhpd2XtEsehaXX
 MOxWFnEJ21beyBIaZNcdDIElb6mM/i4FBwlf7y9bv/2qUrL5nsHq1d1lO5ezvPOrge2Vrz
 1erqX4YdX7ppQJ+ZaEStG8pZ1bFVnf0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-93XbAf2FNtWL1Gj61S6BSQ-1; Tue, 14 Jan 2020 06:26:17 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3693C801E6C;
 Tue, 14 Jan 2020 11:26:15 +0000 (UTC)
Received: from redhat.com (ovpn-112-42.ams2.redhat.com [10.36.112.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DACED5DA32;
 Tue, 14 Jan 2020 11:26:05 +0000 (UTC)
Date: Tue, 14 Jan 2020 11:26:02 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PULL 00/29] Migration pull patches (second try)
Message-ID: <20200114112602.GJ4071034@redhat.com>
References: <20200114092606.1761-1-quintela@redhat.com>
 <CAFEAcA-7aLrp4n9gtD=0MzmMDpzNyJCUpOmY2XPxNOun5MKeGA@mail.gmail.com>
 <875zhewae5.fsf@secure.laptop>
MIME-Version: 1.0
In-Reply-To: <875zhewae5.fsf@secure.laptop>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 93XbAf2FNtWL1Gj61S6BSQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 14, 2020 at 12:22:10PM +0100, Juan Quintela wrote:
> Peter Maydell <peter.maydell@linaro.org> wrote:
> > On Tue, 14 Jan 2020 at 09:26, Juan Quintela <quintela@redhat.com> wrote=
:
> >>
> >> The following changes since commit 3c8a6575985b1652b45bfa670b5e1907d64=
2cfa0:
> >>
> >>   Merge remote-tracking branch
> >> 'remotes/kraxel/tags/usb-20200113-pull-request' into staging
> >> (2020-01-13 14:19:57 +0000)
> >>
> >> are available in the Git repository at:
> >>
> >>   https://github.com/juanquintela/qemu.git tags/migration-pull-pull-re=
quest
> >>
> >> for you to fetch changes up to 4eafab585c091050b5ae63130f46fe46ac919c3=
a:
> >>
> >>   migration: Support QLIST migration (2020-01-14 10:17:12 +0100)
> >>
> >> ----------------------------------------------------------------
> >> Migration pull request
> >> - updated QList patch
> >> - initialize local msg variable
> >>
> >> ----------------------------------------------------------------
> >
> > Still fails on hosts where ram_addr_t is 32 bits.
> > Looks like you still haven't got the fix for the problem
> > Dan pointed out where multifd_save_setup() is using the
> > wrong type when it calculates p->packetlen to allocate the
> > data structure.
>=20
> Ouch.  Then there is "yet" another different problem. I fixed the one
> that daniel pointed.

Err, no you only fixed one of the two bugs I pointed out (for a second
time)

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


