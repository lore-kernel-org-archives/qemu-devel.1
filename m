Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82612C606D7
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 09:03:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B8FD216FD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 09:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8FD216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkm1j-0001WM-HF
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 05:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39366)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hkm0k-00013n-74
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:02:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hkm0i-00051n-Lw
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:02:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51138)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hkm0g-00050E-Tx
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:02:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1CD77C05FBCB
 for <qemu-devel@nongnu.org>; Tue,  9 Jul 2019 09:02:01 +0000 (UTC)
Received: from redhat.com (ovpn-112-31.ams2.redhat.com [10.36.112.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A2E525DA62;
 Tue,  9 Jul 2019 09:01:56 +0000 (UTC)
Date: Tue, 9 Jul 2019 10:01:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190709090153.GD8664@redhat.com>
References: <20190708072437.3339-1-marcandre.lureau@redhat.com>
 <20190708160442.GL3082@redhat.com>
 <CAMxuvaxih_D9HLRnRxhNweux3LsOsxCxzYn6VY748sJx0w8KSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvaxih_D9HLRnRxhNweux3LsOsxCxzYn6VY748sJx0w8KSQ@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 09 Jul 2019 09:02:01 +0000 (UTC)
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
 Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 09, 2019 at 12:26:38PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Mon, Jul 8, 2019 at 8:04 PM Daniel P. Berrang=C3=A9 <berrange@redhat=
.com> wrote:
> > > The D-Bus protocol can be made to work peer-to-peer, but the most
> > > common and practical way is through a bus daemon. This also has the
> > > advantage of increased debuggability (you can eavesdrop on the bus =
and
> > > introspect it).
> >
> > The downside of using the bus daemon is that we have to spawn a new
> > instance of dbus-daemon for every QEMU VM that's running on the host,
> > which is yet more memory overhead for each VM & another process to
> > manage, and yet another thing to go wrong.
>=20
> dbus-daemon (or dbus-broker) has been optimized to fit on many devices
> and use cases, it doesn't take much memory (3mb for my session dbus
> right now).
>=20
> More processes to manage is inevitable. In a near future, we may have
> 5-10 processes running around qemu. I think dbus-daemon will be one of
> the easiest to deal with. (as can be seen in the dbus-vmstate test, it
> is very simple to start a private dbus-daemon)

The increase in processes per-QEMU is a significant concern I have
around complexity & manageability in general, hence a desire to avoid
requiring processes unless they have a compelling reason to exist.

> > QEMU already has a direct UNIX socket connection to the helper
> > processes in question. I'd much rather we just had another direct
> > UNIX socket  connection to that helper, using D-Bus peer-to-peer.
> > The benefit of debugging doesn't feel compelling enough to justify
> > running an extra daemon for each VM.
>=20
> I wouldn't minor the need for easier debugging. Debugging multiple
> processes talking to each other is really hard. Having a bus is
> awesome (if not required) in this case.
>=20
> There are other advantages of using a bus, those come to my mind:
>=20
> - less connections (bus topology)

That applies to general use of DBus, but doesn't really apply to
the proposed QEMU usage, as every single helper is talking to the
same QEMU endpoint. So if we have 10 helpers, in p2p mode, we
get 10 sockets open between the helper & QEMU. In bus mode, we
get 10 sockets open between the helper & dbus and another socket
open between dbus & QEMU. The bus is only a win in connections
if you have a mesh-like connection topology not hub & spoke.

> - configuring/enforcing policies & limits

I don't see that as an advantage. Rather it is addressing the
decreased security that the bus model exposes. In peer2peer
mode, the helpers can only talk to QEMU, so can't directly
interact with each other. In bus mode, the helpers have a
direct communications path to attack each other over, so we
absolutely need policy to mitigate this increased risk. It
would be better to remove that risk at any architectural
level by not having a bus at all.

> - on-demand service activation & discoverability

Again useful for dbus in general, but I don't see any clear scenario
in which this is relevant to QEMU's usage.

> I also think D-Bus is the IPC of choice for multi-process. It's easier
> to use than many other IPC due to the various tools and language
> bindings available. Having a common bus is a good incentive to use a
> common IPC, instead of a dozen of half-baked protocols.

As I said, I don't have any objection to DBus as a protocol. I think it
would serve our needs well, most especially because GIO has decent API
bindings to using it, so we avoid having to depend on another 3rd party
library for something else.

I think from QEMU's POV, the only real alternative to DBus would be to
build something on QMP. I prefer DBus, because JSON is a disaster for
integer type handling, and DBus is more accessible for the helper apps
which can easily use a DBus API of their choice.

> Nevertheless, I also think we could use D-Bus in peer-to-peer mode,
> and I did some investigation. The slirp-helper supports it. We could
> teach dbus-vmstate to eastablish peer-to-peer connections. Instead of
> receiving a bus address and list of Ids, it could have a list of dbus
> peer socket path. Both approaches are not incompatible, but I think
> the bus benefits outweigh the downside of running an extra process.

As above I'm not seeing the compelling benefits of using a bus, so
think we shoud stick to dbus in p2p mode.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

