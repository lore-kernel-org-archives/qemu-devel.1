Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C943C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 10:02:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48365207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 10:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Medj6Aa8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48365207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw1Dp-0001bE-Ff
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 05:02:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iw1CY-0000SH-Ff
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:01:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iw1CX-0002Nf-6b
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:01:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45157
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iw1CX-0002M1-1e
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:01:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580119259;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=no7o3lAGOXMTvoS+/m456Hzi5XDSiGZpyt/Dhg8pojg=;
 b=Medj6Aa8Py88vvBRsi+fOAekhzqwZIbIdh0kLuJDxNUIScQNC+5+zq3iefxkOt2SnuYOlW
 cJ+hAm/FdYIs5PKAJP3VU23XSb8FO3UW8XyH8gb5FfDCi0uS5Fy7vjf/ZdZmA+sjyjfauz
 GQGdGdFjsx/k7BQNpucIBRRad/ykZvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-Gd0Ladq9Nh6wSp1nwzG_PA-1; Mon, 27 Jan 2020 05:00:56 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8964F800D41;
 Mon, 27 Jan 2020 10:00:54 +0000 (UTC)
Received: from redhat.com (ovpn-112-52.ams2.redhat.com [10.36.112.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6707D1001B08;
 Mon, 27 Jan 2020 10:00:43 +0000 (UTC)
Date: Mon, 27 Jan 2020 10:00:40 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200127100040.GB837450@redhat.com>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <87h81unja8.fsf@dusky.pond.sub.org>
 <20191224134139.GD2710539@redhat.com>
 <30664f6e-81da-a6e6-9b20-037fc91290fb@redhat.com>
 <878slyej29.fsf@dusky.pond.sub.org>
 <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
 <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <20200124095027.GA824327@redhat.com>
 <87a769s1y2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87a769s1y2.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Gd0Ladq9Nh6wSp1nwzG_PA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 27, 2020 at 10:06:45AM +0100, Markus Armbruster wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> >   * qemu-system-$TARGET
> >
> >     The current binaries that exist today.
> >
> >     qemu-system-$TARGET should not be part of our formal
> >     stability promise. We won't gratuitously / knowingly
> >     break without good reason, but we will accept that
> >     breakage can happen. Stability is only offered by
> >     the qemu-{runtime,launcher}-$TARGET.
> >
> >     Several choices for their future in long term:
> >
> >       - Leave them as-is and basically ignore them
> >         whereever practical going forward, so we
> > =09minimally worry about backcompat breakage
> >
> >       - Plan to re-write them so that they are simply
> >         a shim the forks+execs qemu-runtime-$TARGET
> > =09and does syntax translation from CLI/HMP/QMP.
> >
> >       - Deprecate them with a view to deletion entirely
> >         in $NNN years. For some large-ish value of NNN,
> > =09given how well known they are
>=20
> How do the other complex executables like qemu-img, qemu-nbd fit into
> this picture?
>=20
> Do they become redundant somehow for non-human users?
>=20
> If not, will they get a QMP-only sibling, like qemu-system-$TARGET gets
> qemu-runtime-$TARGET?

I've not really thought about the other tools when writing this.

In libvirt we do see much of the same pain points in dealing with
these tools, as we do with QEMU emulator targets though. eg need
to probe features, the complexity of specifying block devices.
So there's clearly some conceptual overlap here to consider.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


