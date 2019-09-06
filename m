Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817A3C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 11:49:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A0A5206BB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 11:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A0A5206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6CkJ-0005z9-DD
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 07:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i6CjY-0005WQ-Nc
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 07:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i6CjW-00028M-Td
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 07:48:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58628)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i6CjW-00027M-Lo
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 07:48:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3DCFD6412E;
 Fri,  6 Sep 2019 11:48:53 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FBBC5D9CA;
 Fri,  6 Sep 2019 11:48:40 +0000 (UTC)
Date: Fri, 6 Sep 2019 12:48:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190906114838.GX5119@redhat.com>
References: <20190905152136.30637-1-stefanha@redhat.com>
 <20190905152136.30637-3-stefanha@redhat.com>
 <20190905172732.GQ2700@work-vm>
 <20190906102328.GE5900@stefanha-x1.localdomain>
 <20190906104953.GV5119@redhat.com> <20190906111223.GD2699@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190906111223.GD2699@work-vm>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 06 Sep 2019 11:48:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC 2/3] virtiofsd: add DBus server to handle log
 level changes
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
Cc: virtio-fs@redhat.com,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Eryu Guan <eguan@linux.alibaba.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 06, 2019 at 12:12:23PM +0100, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> > On Fri, Sep 06, 2019 at 11:23:28AM +0100, Stefan Hajnoczi wrote:
> > > On Thu, Sep 05, 2019 at 06:27:32PM +0100, Dr. David Alan Gilbert wr=
ote:
> > > > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > > > Introduce a DBus server thread that runs alongside the other vi=
rtiofsd
> > > > > threads.  It processes changes to the /org/qemu/virtiofsd objec=
t which
> > > > > can be accessed at the org.qemu.virtiofsd location on the bus.
> > > > >=20
> > > > > This code does not use locking because we are the only writer t=
o the
> > > > > int current_log_level variable.  More advanced management comma=
nds would
> > > > > require locking to prevent race conditions with the other threa=
ds.
> > > > >=20
> > > > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > >=20
> > > > OK, that is less complex than I'd feared.
> > > > I guess there's something probably nice to do with name/integer m=
apping
> > > > for warning levels that we could use from one of the libraries.
> > >=20
> > > I used a free-form string because it's what systemd's LogLevel prop=
erty
> > > also does.  But I can investigate the cleanest approach for limitin=
g it
> > > to a set of string constants.
> >=20
> > There's no concept of "enums" at the DBus protocol level. Sending enu=
ms
> > in string form is the normal practice - avoiding integer values means
> > you are not vulnerable to enum values changing if someone inserts a n=
ew
> > constant in the middlle of the enum. This same reason is why QAPI use=
s
> > strings for enums instead of ints.
>=20
> Oh, I wasn't talking aobut changing protocol; I just meant there was
> probably a neater way of doing the string look up than the opencoded wa=
y
> it was done.

Oh sure, you can declare the enum in a header, and then run glib-mkenums
with that header file and it will spit out the code neccessary to
register a GEnum class. This gives you ability to do int/string conversio=
ns
with a simple api

  https://developer.gnome.org/gobject/stable/gobject-Enumeration-and-Flag=
-Types.html
  https://developer.gnome.org/gobject/stable/glib-mkenums.html

It makes sense to use this, since virtiofsd is already using GObject
via GDbus.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

