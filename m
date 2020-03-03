Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB933C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 13:15:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A143D20842
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 13:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TfETJPez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A143D20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j97O9-0004vc-Ml
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 08:15:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j97NM-0004Wj-Qt
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 08:14:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j97NL-00026A-1X
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 08:14:20 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60003
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j97NK-00025M-TI
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 08:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583241257;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sGX5weHl/srTQUTGPbW8ZIx0c6Lwp81l2kllP3d9uAY=;
 b=TfETJPezw9nqla7IQX/GpXZbEyvJ4eOn2AhcplHGLgHcxNt4RG51svz3mOrPS3SJBX2au+
 o2lY6lE4NqfvioPhWXI08U/UwlnPERuhMIQzFQJhft2T8c+73DYCwNliP4tkp2xpzRFwne
 M9W7spx1zTLAgDAxmqCtDTTW7rNG9O4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-bsA30IFjNEGy_L7vbyPs2Q-1; Tue, 03 Mar 2020 08:14:12 -0500
X-MC-Unique: bsA30IFjNEGy_L7vbyPs2Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E53761005512;
 Tue,  3 Mar 2020 13:14:10 +0000 (UTC)
Received: from redhat.com (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2ECDD73869;
 Tue,  3 Mar 2020 13:14:10 +0000 (UTC)
Date: Tue, 3 Mar 2020 13:14:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thorsten Glaser <t.glaser@tarent.de>
Subject: Re: qemu-system-x86_64: warning: Unknown X11 keycode mapping '<null>'.
Message-ID: <20200303131407.GF1773352@redhat.com>
References: <alpine.DEB.2.22.394.2003020002570.23029@tglase.lan.tarent.de>
 <20200302102841.GD1679990@redhat.com>
 <alpine.DEB.2.22.394.2003021336010.14371@tglase.lan.tarent.de>
 <20200303104431.GB1773352@redhat.com>
 <alpine.DEB.2.22.394.2003031410520.18659@tglase.lan.tarent.de>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2003031410520.18659@tglase.lan.tarent.de>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On Tue, Mar 03, 2020 at 02:12:04PM +0100, Thorsten Glaser wrote:
> On Tue, 3 Mar 2020, Daniel P. Berrang=C3=A9 wrote:
>=20
> > AFAICT, this is not the case. On both my Fedora & Debian installs,
> > x11vnc is just a binary that attaches to an existing X11 server
>=20
> Huh, weird. Perhaps this changed over the years and distro releases.
>=20
> >   $ ls -al /usr/bin/vncserver
>=20
> $ realpath $(which vncserver)
> /usr/bin/tightvncserver
>=20
> This does surprise me, because I also have x11vnc installed and
> vaguely remember using it in standalone server mode for a while.
>=20
> But, yes, tightvncserver 1:1.3.9-9.1 is also installed, so I=E2=80=99m
> apparently using that.

Thanks, that gives me something to try to reproduce the problem now.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


