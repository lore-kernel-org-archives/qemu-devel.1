Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74A2C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 10:19:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B203020661
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 10:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDWuThcd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B203020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw1UE-0006C4-Or
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 05:19:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iw1TY-0005kq-TU
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:18:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iw1TX-0004ze-0R
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:18:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42652
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iw1TW-0004zA-TZ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580120314;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7dY2dr80K2QrKye3Sl+XOMrvIm2z2Bgr5HdW9O9waFA=;
 b=KDWuThcdhmzGdnq7XXVx3bSg3jcjWONXS5ppHbmBOBJRRN887+E8UNp10ZcNl3LqRrGhV3
 WZ2vr8fhf0YhXk8yc8dn+x7oF0xu7u8n/8qp+JGi774ooSXQsoTqz/bh6t7c/iZwHXFLb0
 hFyYrT90lZJkaUKZdFUSnM9y3T912D8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-GXg7TWpiO5qhgnF1KH1Jjw-1; Mon, 27 Jan 2020 05:18:32 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18DEA800D48;
 Mon, 27 Jan 2020 10:18:31 +0000 (UTC)
Received: from redhat.com (ovpn-112-52.ams2.redhat.com [10.36.112.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B67C619C58;
 Mon, 27 Jan 2020 10:18:19 +0000 (UTC)
Date: Mon, 27 Jan 2020 10:18:16 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200127101816.GD837450@redhat.com>
References: <20191224134139.GD2710539@redhat.com>
 <30664f6e-81da-a6e6-9b20-037fc91290fb@redhat.com>
 <878slyej29.fsf@dusky.pond.sub.org>
 <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
 <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <871rrp474i.fsf@dusky.pond.sub.org>
 <20200124102743.GB824327@redhat.com>
 <20200124143841.GG4732@dhcp-200-226.str.redhat.com>
 <87sgk3x2im.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87sgk3x2im.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: GXg7TWpiO5qhgnF1KH1Jjw-1
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
 Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jan 25, 2020 at 11:18:41AM +0100, Markus Armbruster wrote:
> Kevin Wolf <kwolf@redhat.com> writes:
>=20
> > Am 24.01.2020 um 11:27 hat Daniel P. Berrang=C3=A9 geschrieben:
> >> So if we allowed YAML instead of JSON, now we get...
> >>=20
> >>   $ cat qemu.yaml
> >>   ---
> >>   arguments:
> >>   - arg: object
> >>     data:
> >>       type: secret
> >>       id: libvirt-5-storage-secret0
> >>       data: 9eao5F8qtkGt+seB1HYivWIxbtwUu6MQtg1zpj/oDtUsPr1q8wBYM91uEH=
Cn6j/1
> >>       keyid: masterKey0
> >>       iv: AAECAwQFBgcICQoLDA0ODw=3D=3D
> >>       format: base64
> >>   - arg: object
> >>     data:
> >>       type: secret
> >>       id: libvirt-5-format-luks-secret0
> >>       data: 9eao5F8qtkGt+seB1HYivWIxbtwUu6MQtg1zpj/oDtUsPr1q8wBYM91uEH=
Cn6j/1
> >>       keyid: masterKey0
> >>       iv: AAECAwQFBgcICQoLDA0ODw=3D=3D
> >>       format: base64
> >>   - arg: blockdev
> >>     data:
> >>       node-name: libvirt-5-format
> >>       read-only: false
> >>       driver: qcow2
> >>       encrypt:
> >>         format: luks
> >>         key-secret: libvirt-5-format-luks-secret0
> >>       file:
> >>         driver: iscsi
> >>         portal: example.org:6000
> >>         target: iqn.1992-01.com.example:storage
> >>         lun: 1
> >>         transport: tcp
> >>         user: myname
> >>         password-secret: libvirt-5-storage-secret0
> >>         node-name: libvirt-5-storage
> >>         auto-read-only: true
> >>         discard: unmap
> >>   $ qemu-system-x86_64 -f qemu.yaml
> >>=20
> >> This is finally something I'd consider to be on a par with the
> >> original QEMU syntax, before we added hierarchical data. You
> >> have the minimal possible amount of syntax here. No commas,
> >> no quotes, no curly brackets, etc.
> >
> > This seems to have the same problems as the QEMU command line (how do
> > you distinguish strings from ints, from bools, from null?).
>=20
> True: YAML provides only string scalars.

Actually, YAML provides  strings, integers, booleans & nulls, the same
level of typing at JSON, but with added benefit of supporting comments
officially:

  https://rollout.io/blog/yaml-tutorial-everything-you-need-get-started/

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


