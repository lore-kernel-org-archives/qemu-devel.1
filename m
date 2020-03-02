Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E148CC3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 10:29:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC6BC2146E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 10:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnnrgAhN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC6BC2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8iKN-0006HL-Na
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 05:29:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j8iJg-0005mv-BK
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 05:28:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j8iJe-0001q4-Nn
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 05:28:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58009
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j8iJe-0001pp-Il
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 05:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583144929;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2rJ3Hbstcly6jnfx3MQNuubZFyVik0lsuanJCvKZ5s0=;
 b=fnnrgAhNY9BdUvcGzBNp5U3FBbax8+1XY3gtOVbbY/gEsclasGfoxxQO63F/FbFosMlIIa
 XTKkme6MhEpgEBrVpRY0HzXu4GpsJZgN2N/DQPGNT9rK9MFDFHp54191EhjCOb3nKlEMAu
 GELoNV3o2iZd833fRZHSHYgujOuJr6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-pVZfS5GUOqG2cTueJ8JdQw-1; Mon, 02 Mar 2020 05:28:47 -0500
X-MC-Unique: pVZfS5GUOqG2cTueJ8JdQw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B532C19057D7;
 Mon,  2 Mar 2020 10:28:45 +0000 (UTC)
Received: from redhat.com (ovpn-112-55.ams2.redhat.com [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B789A60BF7;
 Mon,  2 Mar 2020 10:28:44 +0000 (UTC)
Date: Mon, 2 Mar 2020 10:28:41 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thorsten Glaser <t.glaser@tarent.de>
Subject: Re: qemu-system-x86_64: warning: Unknown X11 keycode mapping '<null>'.
Message-ID: <20200302102841.GD1679990@redhat.com>
References: <alpine.DEB.2.22.394.2003020002570.23029@tglase.lan.tarent.de>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2003020002570.23029@tglase.lan.tarent.de>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 02, 2020 at 12:04:46AM +0100, Thorsten Glaser wrote:
> I got this while running qemu under VNC, and was told to report it.
>=20
> including the following information:
>=20
>   - Operating system
> =09Debian GNU/Linux sid/x32
>   - X11 Server
> =09x11vnc  0.9.16-3

Can you tell me a bit more detail about how you launch this all.

"x11vnc" suggests you had a regular X11 desktop session, and are
exporting it via VNC ?

But later...

>   - xdpyinfo
> =09name of display:    :2
> =09version number:    11.0
> =09vendor string:    AT&T Laboratories Cambridge

...this suggests your running a VNC server, with embedded X11 server


>   - xprop -root

...there's no _XKB_RULES_NAMES(STRING) property listed, which is the key
thing we'd expect to see for a modern X server. eg

  _XKB_RULES_NAMES(STRING) =3D "evdev", "pc105", "us", "", ""

is what most X servers on Linux will report.

Can you also say what QEMU version ?

QEMU since 2.12.0 or later has a second way to detect the keymap, by
querying the scancode mapping for certain keys.

So either your QEMU is fairly old, or you are using a keycode mapping
that QEMU has no understanding of (we support evdev, or the classic
xfree86 'kbd' mapping). It would be highly unusual not to use one of
those two, but none the less, that appears to be the case here ?


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


