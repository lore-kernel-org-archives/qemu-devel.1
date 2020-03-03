Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FE0C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:45:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C6B320836
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ExCo3jdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6B320836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j953V-0008SG-5y
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:45:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j952a-0007uc-9c
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:44:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j952Z-0001xM-1b
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:44:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35449
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j952Y-0001xD-U7
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583232281;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GC8qPuMVPmMIY+4ImhSWmzcFZJSYl4iR6BIPqfZZ1qI=;
 b=ExCo3jdquqjvNyPy/cwZiJ3NKZ63MRmm/M21O61go820zyJ1oE6aXjp122/ST4rV/B6kyP
 ZeQthfhuY6cev8W9c7Vn2bYNyd1HHSJkVcoYS7TJwjAsl7cHyjqTJWWN/aLd5CXHPdE+f0
 NZSiyC+11q1tCxjg9/Ndztn6zrg3/4I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-IpyWGi8gOHSTUNkB18Mp3Q-1; Tue, 03 Mar 2020 05:44:37 -0500
X-MC-Unique: IpyWGi8gOHSTUNkB18Mp3Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B824800D50;
 Tue,  3 Mar 2020 10:44:35 +0000 (UTC)
Received: from redhat.com (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 93B9573860;
 Tue,  3 Mar 2020 10:44:34 +0000 (UTC)
Date: Tue, 3 Mar 2020 10:44:31 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thorsten Glaser <t.glaser@tarent.de>
Subject: Re: qemu-system-x86_64: warning: Unknown X11 keycode mapping '<null>'.
Message-ID: <20200303104431.GB1773352@redhat.com>
References: <alpine.DEB.2.22.394.2003020002570.23029@tglase.lan.tarent.de>
 <20200302102841.GD1679990@redhat.com>
 <alpine.DEB.2.22.394.2003021336010.14371@tglase.lan.tarent.de>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2003021336010.14371@tglase.lan.tarent.de>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 02, 2020 at 01:43:12PM +0100, Thorsten Glaser wrote:
> On Mon, 2 Mar 2020, Daniel P. Berrang=C3=A9 wrote:
>=20
> > "x11vnc" suggests you had a regular X11 desktop session, and are
> > exporting it via VNC ?
>=20
> No, x11vnc is a standalone VNC server.

AFAICT, this is not the case. On both my Fedora & Debian installs,
x11vnc is just a binary that attaches to an existing X11 server
and exports it - it doesn't provide an X11 itself, like tigervnc
or tightvnc do.

> > Can you tell me a bit more detail about how you launch this all.
>=20
> Sure:
>=20
> $ vncserver -geometry 1000x768 -name nowm :2
> $ (export DISPLAY=3D:2; exec </dev/null >>.xsession-errors; exec 2>&1; ic=
ewm-session &)

Can you tell me output of

  $ ls -al /usr/bin/vncserver

On Debian this is normally a symlink to alternatives. If so,
also tell me what this reports:

  $ ls -al /etc/alternatives/vncserver


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


