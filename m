Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D37AC73C7C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 09:05:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 099C920693
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 09:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 099C920693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl8Xp-0001Is-8o
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 05:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40213)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hl8WQ-0000lD-Em
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hl8WO-0007w6-Q5
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:04:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58384)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hl8WN-0007On-1m
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:04:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 95D1730C0DD9
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 09:03:58 +0000 (UTC)
Received: from redhat.com (ovpn-112-53.ams2.redhat.com [10.36.112.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED5EB96F81;
 Wed, 10 Jul 2019 09:03:53 +0000 (UTC)
Date: Wed, 10 Jul 2019 10:03:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190710090350.GC30831@redhat.com>
References: <20190708072437.3339-1-marcandre.lureau@redhat.com>
 <20190708160442.GL3082@redhat.com>
 <8914dc43-0b99-ff83-7ff9-8f7b8f256909@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8914dc43-0b99-ff83-7ff9-8f7b8f256909@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 10 Jul 2019 09:03:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/3] Add dbus-vmstate
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 10, 2019 at 10:53:10AM +0200, Paolo Bonzini wrote:
> On 08/07/19 18:04, Daniel P. Berrang=C3=A9 wrote:
> > The downside of using the bus daemon is that we have to spawn a new
> > instance of dbus-daemon for every QEMU VM that's running on the host,
> > which is yet more memory overhead for each VM & another process to
> > manage, and yet another thing to go wrong.
> >=20
> > QEMU already has a direct UNIX socket connection to the helper
> > processes in question. I'd much rather we just had another direct
> > UNIX socket  connection to that helper, using D-Bus peer-to-peer.
> > The benefit of debugging doesn't feel compelling enough to justify
> > running an extra daemon for each VM.
>=20
> Would it be possible to make QEMU the broker?  That is, how hard would =
it
> be to embed a minimal DBus broker (which only takes care of connecting =
servers
> and clients---stuff like launching servers would be completely out of s=
cope)?

What would be the benefit of embedding it in QEMU ? I see significant
security downside to that which would mean its not something I'd want
to support.

If we accept the need for a bus then this implies there's a need for
service <-> service messages, where neither service is QEMU. This in
turn requires enforcement of security policies for the separation of
services. It is highly desirable, if not mandatory, to have such
security enforcement outside the QEMU address space, given that QEMU
is an untrustworthy component.


> Would it for example make sense to split the bus handling part of dbus-=
broker
> into a library that QEMU could reuse?  (And if we plan to do this, shou=
ld QEMU
> use sd-bus instead of gdbus?)
>=20
> In QOM that would be something like
>=20
>   -object dbus-connection,id=3Dclient1,chardev=3D...,addr=3Dfoo       #=
 p2p
>   -object dbus-vmstate,connection=3Dclient1                       # the=
 interface
>=20
>   -object dbus-connection,id=3Dclient1,addr=3Dfoo                   # v=
ia external daemon
>   -object dbus-vmstate,client=3Dclient1                           # the=
 interface
>=20
>   -object dbus-session,id=3Dsession1,chardev=3D...
>   -object dbus-connection,id=3Dclient1,session=3Dsession1,addr=3Dfoo  #=
 via internal daemon
>   -object dbus-vmstate,client=3Dclient1                           # the=
 interface

From my POV I only see two viable options. Either p2p with no bus & QEMU
being one endpoint so there's no requirement for security policies, or
bus based mesh with an external process to enforce security policy.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

