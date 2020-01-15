Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D616C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 12:21:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A08C3207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 12:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qm5iZjQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A08C3207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irhfU-0005Il-QI
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 07:21:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1irhei-0004iM-5S
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:20:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1irhee-0008Sy-C6
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:20:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40413
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1irhee-0008Sd-7g
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 07:20:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579090811;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yEN8dSEuhiZ8ohF4PsSGipeAt7RCTuACNkUFg8l8jdA=;
 b=Qm5iZjQ0GUIPXy9Y2N4ddnOXArW7xgBLJzvglv2himaRt6KzcBnaJk8RGcN8/0Lhkxf83o
 tmYZeJKC1jLB21Ij9h2aSaTnctTqCjH8fmPHU1e5GRA+buoSjmQ6n8OQeWm9k0vRjm+6B8
 N9uHH3eu3wF3B9ysRfEzOE9Q6ZA8cPw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-BhYNqpzlNiOIqbQKbzsipQ-1; Wed, 15 Jan 2020 07:20:08 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF7CD1081FD7;
 Wed, 15 Jan 2020 12:20:06 +0000 (UTC)
Received: from redhat.com (ovpn-112-60.ams2.redhat.com [10.36.112.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C9FD19757;
 Wed, 15 Jan 2020 12:19:55 +0000 (UTC)
Date: Wed, 15 Jan 2020 12:19:53 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200115121953.GJ93923@redhat.com>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <1EFEF446-AFEA-429F-B6BA-3206A7C41836@redhat.com>
 <20200108104306.GC5057@dhcp-200-226.str.redhat.com>
 <97F153BD-FB8A-46C7-90D0-9E894B9E0292@redhat.com>
 <20200108133842.GE5057@dhcp-200-226.str.redhat.com>
 <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87r200zzje.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: BhYNqpzlNiOIqbQKbzsipQ-1
X-Mimecast-Spam-Score: 0
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 15, 2020 at 01:15:17PM +0100, Markus Armbruster wrote:
> Christophe de Dinechin <dinechin@redhat.com> writes:
>=20
> > Thanks a bunch. This clarifies a number of my misconceptions about
> > how this is currently used. Most notably this one:
> >
> >> On 15 Jan 2020, at 10:20, Markus Armbruster <armbru@redhat.com> wrote:
> >>=20
> >>> We don=E2=80=99t want the QAPI to let arbitrary fields of a QOM objec=
t
> >>> be modified, do we?
> >>=20
> >> We already do: QMP command qom-set.  If it breaks your guest, you get =
to
> >> keep the pieces.
> >
> > Ouch. I certainly did not expect that.
> >
> > "It is not what you don=E2=80=99t know that kills you, it is what you k=
now that ain=E2=80=99t so".
>=20
> Do we have a legitimate use for qom-set right now?  Hmm, let's check
> libvirt... aha:
>=20
> * qemuMonitorJSONSetMemoryStatsPeriod() uses it to control
>   virtio-balloon's guest-stats-polling-interval property, in accordance
>   with docs/virtio-balloon-stats.txt.
>=20
> * qemuMonitorJSONSetIOThread() uses it to control iothread's properties
>   poll-max-ns, poll-grow, poll-shrink.  Their use with -object is
>   documented (in qemu-options.hx), their use with qom-set is not.
>=20
> Oh well.

Libvirt is of course happy to switch to something else instead of
qom-set for these features if QEMU wants to provide a safer
alternative.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


