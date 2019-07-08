Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4216C606C1
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 16:10:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF97220693
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 16:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF97220693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkWDJ-00013z-1h
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 12:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43718)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hkWC1-0000Bl-IP
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 12:08:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hkWC0-000311-DD
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 12:08:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44432)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hkWC0-00030Q-5U
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 12:08:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6F82FC004BA8
 for <qemu-devel@nongnu.org>; Mon,  8 Jul 2019 16:08:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E87C55D9E5;
 Mon,  8 Jul 2019 16:08:35 +0000 (UTC)
Date: Mon, 8 Jul 2019 17:08:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190708160833.GM3082@redhat.com>
References: <20190708072437.3339-1-marcandre.lureau@redhat.com>
 <20190708154406.GL2746@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190708154406.GL2746@work-vm>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Mon, 08 Jul 2019 16:08:39 +0000 (UTC)
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
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 08, 2019 at 04:44:06PM +0100, Dr. David Alan Gilbert wrote:
> * Marc-Andr=C3=A9 Lureau (marcandre.lureau@redhat.com) wrote:
> > Hi,
> >=20
> > With external processes or helpers participating to the VM support, i=
t
> > becomes necessary to handle their migration. Various options exist to
> > transfer their state:
> > 1) as the VM memory, RAM or devices (we could say that's how
> >    vhost-user devices can be handled today, they are expected to
> >    restore from ring state)
> > 2) other "vmstate" (as with TPM emulator state blobs)
> > 3) left to be handled by management layer
> >=20
> > 1) is not practical, since an external processes may legitimatelly
> > need arbitrary state date to back a device or a service, or may not
> > even have an associated device.
> >=20
> > 2) needs ad-hoc code for each helper, but is simple and working
> >=20
> > 3) is complicated for management layer, QEMU has the migration timing
> >=20
> > The proposed "dbus-vmstate" object will connect to a given D-Bus
> > address, and save/load from org.qemu.VMState1 owners on migration.
>=20
> Some very high level questions:
>   a) If I've got two QEMU's running, how do the right devices
>    end up migrating to the right qemu?

This isn't using the normal DBus instance. It needs a new isntance of
dbus-daemon to be spawned for each VM IIUC.

>   b) Why use dbus for the comms? Don't all of the daemons have some
>    protocol'd socket between QEMU and the daemon? If so they could
>    send up a separate FD for migration data

There's two distinct aspects here

 - Whether to use a bus vs peer-to-peer
 - What protocol to run over the wire

DBus defines a low level wire protocol. It just happens that it is
commonly used in bus topology, but it is fine being used peer-to-peer
instead.

IOW, we could use Dbus as the wire encoding, and still have a direct
FD betwwen QEMU & the helper program, without needign dbus-daemon
present.

>   c) Your 1MB limit is pretty aribtary - it's nice to have a limit
>     but it's hard to justify why it's that one.

IIRC, that's the default DBus message size limit. You can choose to
raise that in the client & server impl if desired, or alternatively
just pass back a memfd() handle with the DBus relpy, over which to
access the bulk data out of band.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

