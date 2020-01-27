Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D15C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 10:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CE9B207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 10:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ix1ObsLj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE9B207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw1Hl-0003Gr-Av
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 05:06:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iw1HB-0002mR-Rc
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:05:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iw1HA-0006N2-GL
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:05:49 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32971
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iw1HA-0006M1-CD
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:05:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580119547;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H3TqPhZ16UZUqUA2Pg37ZKUGYyQK+qhho2K2NTXToQ0=;
 b=ix1ObsLjvaa/Zy5+oZ/YMG02zoMcKrbmWXn1wdm9Qe69tcywvs5+R1IjIKK8+BhV8S+/fj
 VQOTCWzsCrRSwWeNeNs3lvDNjwR4Z5wGoXxO+qlEDdv4iEbwwaEKNwVeSmcRaIwLreKms/
 Bp4Bd6NSRUw/J6PDSYmUQG69rRekUJo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-IX38TYZzNDqcM_AC1Td-MQ-1; Mon, 27 Jan 2020 05:05:43 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52A7C90A062;
 Mon, 27 Jan 2020 10:05:42 +0000 (UTC)
Received: from redhat.com (ovpn-112-52.ams2.redhat.com [10.36.112.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B59B108BD09;
 Mon, 27 Jan 2020 10:05:30 +0000 (UTC)
Date: Mon, 27 Jan 2020 10:05:27 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200127100527.GC837450@redhat.com>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <87h81unja8.fsf@dusky.pond.sub.org>
 <20191224134139.GD2710539@redhat.com>
 <30664f6e-81da-a6e6-9b20-037fc91290fb@redhat.com>
 <878slyej29.fsf@dusky.pond.sub.org>
 <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
 <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <20200124095027.GA824327@redhat.com>
 <47e06198-34cb-a0af-1086-4b72c88c5dc1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <47e06198-34cb-a0af-1086-4b72c88c5dc1@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: IX38TYZzNDqcM_AC1Td-MQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jan 25, 2020 at 12:52:30PM +0100, Paolo Bonzini wrote:
> On 24/01/20 10:50, Daniel P. Berrang=C3=A9 wrote:
> >   * qemu-launcher-$TARGET
> >=20
> >     A binary that is able to launch qemu-runtime-$TARGET
> >     with jailers active.
> >=20
> >     This has no command line arguments except for a pair
> >     of UNIX socket paths. One is a QMP server, the other
> >     is the path for the QMP of qemu-runtime-$TARGET.
> >=20
> >     Commands it processes will be in automatically proxied
> >     through to the qemu-runtime-$TARGET QMP, with appropriate
> >     jailer updates being done in between.
> >=20
>=20
> What would be the advantage of this over the Libvirt embedded driver?
> Especially if you include in the picture something like libvirt-go-xml
> (or libvirt-GObject, does it still exist?) that hides the XML from the
> code that uses it.

Yes, libvirt-gobject still exists & is used by GNOME Boxes.

> The main complication in the launcher is hotplug, which means that a
> simple "do a couple bind mounts, unshare, drop privileges and forget
> about it" approach doesn't work.  Proxying QMP commands doesn't seem
> that easy, and I don't see much code being shared between the launcher
> and QEMU; if the existing QEMU code is not suitable for Libvirt, it
> wouldn't be suitable for a qemu.git launcher either.

Mostly this suggestion is a response to discussions elsewhere in this
thread expressing a desire for a way to do QEMU jailing natively. In
this proposal I'm describing an approach that might satisfy that desire,
while ignoring whatever exists in the current ecosystem including
libvirt.

So yes, there is clearly overlap here with libvirt, and this tool is
not an easy thing to build to a level which is feature comparable
with what libvirt offers. For this launcher to be credible I think
it would have to be something libvirt were capable of using itself
and that's a challenge. So quite possibly the libvirt embedded driver
is indeed a better bet. =20


> Also, as you mentioned earlier, QEMU wants to keep its vocabulary
> lower-level, and therefore the launcher's vocabulary would end up
> diverging from QEMU.  Some example:
>=20
> - QEMU wants a qemu-pr-helper socket path, the launcher would take care
> of launching qemu-pr-helper itself
>=20
> - QEMU wants the complete configuration on the migration destination,
> the launcher might take care of sending it from the source?
>=20
> At this point, you get something that looks very much like Libvirt and,
> especially if you include live migration, it has to take into account
> the same compatibility considerations as Libvirt.

Yes indeed.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


