Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4B7C606C1
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 16:07:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46807204EC
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 16:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46807204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkWB4-0006zo-IU
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 12:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42719)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hkW8N-0005uh-Iy
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 12:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hkW8L-0006bZ-M3
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 12:04:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48010)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hkW8L-0006T7-FM
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 12:04:53 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 48FF883F51
 for <qemu-devel@nongnu.org>; Mon,  8 Jul 2019 16:04:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 154691001B19;
 Mon,  8 Jul 2019 16:04:44 +0000 (UTC)
Date: Mon, 8 Jul 2019 17:04:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190708160442.GL3082@redhat.com>
References: <20190708072437.3339-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190708072437.3339-1-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 08 Jul 2019 16:04:48 +0000 (UTC)
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
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 08, 2019 at 11:24:34AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi,
>=20
> With external processes or helpers participating to the VM support, it
> becomes necessary to handle their migration. Various options exist to
> transfer their state:
> 1) as the VM memory, RAM or devices (we could say that's how
>    vhost-user devices can be handled today, they are expected to
>    restore from ring state)
> 2) other "vmstate" (as with TPM emulator state blobs)
> 3) left to be handled by management layer
>=20
> 1) is not practical, since an external processes may legitimatelly
> need arbitrary state date to back a device or a service, or may not
> even have an associated device.
>=20
> 2) needs ad-hoc code for each helper, but is simple and working
>=20
> 3) is complicated for management layer, QEMU has the migration timing
>=20
> The proposed "dbus-vmstate" object will connect to a given D-Bus
> address, and save/load from org.qemu.VMState1 owners on migration.
>=20
> Thus helpers can easily have their state migrated with QEMU, without
> implementing ad-hoc support (such as done for TPM emulation)
>=20
> I chose D-Bus as it is ubiquitous on Linux (it is systemd IPC), and
> can be made to work on various other OSes. There are several
> implementations and good bindings for various languages.
> (the tests/dbus-vmstate-test.c is a good example of how simple
> the implementation of services can be, even in C)
>=20
> The D-Bus protocol can be made to work peer-to-peer, but the most
> common and practical way is through a bus daemon. This also has the
> advantage of increased debuggability (you can eavesdrop on the bus and
> introspect it).

The downside of using the bus daemon is that we have to spawn a new
instance of dbus-daemon for every QEMU VM that's running on the host,
which is yet more memory overhead for each VM & another process to
manage, and yet another thing to go wrong.

QEMU already has a direct UNIX socket connection to the helper
processes in question. I'd much rather we just had another direct
UNIX socket  connection to that helper, using D-Bus peer-to-peer.
The benefit of debugging doesn't feel compelling enough to justify
running an extra daemon for each VM.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

