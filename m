Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0442C73C7C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 09:11:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FEBD20665
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 09:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FEBD20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl8dU-00042J-JZ
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 05:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42782)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hl8cW-0003bU-UC
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hl8cU-0002If-Uk
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:10:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48210)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hl8cO-0001t0-K6
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:10:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 68E5C30917AB;
 Wed, 10 Jul 2019 09:10:24 +0000 (UTC)
Received: from redhat.com (ovpn-112-53.ams2.redhat.com [10.36.112.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 07EAF5D9CC;
 Wed, 10 Jul 2019 09:10:18 +0000 (UTC)
Date: Wed, 10 Jul 2019 10:10:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Message-ID: <20190710091013.GD30831@redhat.com>
References: <20190708072437.3339-1-marcandre.lureau@redhat.com>
 <20190708160442.GL3082@redhat.com>
 <CAMxuvaxih_D9HLRnRxhNweux3LsOsxCxzYn6VY748sJx0w8KSQ@mail.gmail.com>
 <20190709090153.GD8664@redhat.com>
 <CAJ+F1CK3=LvyVgv0S4kihWRJXfuj==LvpZyzi3NtFDSzZQsmyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CK3=LvyVgv0S4kihWRJXfuj==LvpZyzi3NtFDSzZQsmyw@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 10 Jul 2019 09:10:24 +0000 (UTC)
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

On Tue, Jul 09, 2019 at 02:47:32PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, Jul 9, 2019 at 1:02 PM Daniel P. Berrang=C3=A9 <berrange@redhat=
.com> wrote:
> >
> > On Tue, Jul 09, 2019 at 12:26:38PM +0400, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > Hi
> > >
> > > On Mon, Jul 8, 2019 at 8:04 PM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
> > > > QEMU already has a direct UNIX socket connection to the helper
> > > > processes in question. I'd much rather we just had another direct
> > > > UNIX socket  connection to that helper, using D-Bus peer-to-peer.
> > > > The benefit of debugging doesn't feel compelling enough to justif=
y
> > > > running an extra daemon for each VM.
> > >
> > > I wouldn't minor the need for easier debugging. Debugging multiple
> > > processes talking to each other is really hard. Having a bus is
> > > awesome (if not required) in this case.
> > >
> > > There are other advantages of using a bus, those come to my mind:
> > >
> > > - less connections (bus topology)
> >
> > That applies to general use of DBus, but doesn't really apply to
> > the proposed QEMU usage, as every single helper is talking to the
> > same QEMU endpoint. So if we have 10 helpers, in p2p mode, we
> > get 10 sockets open between the helper & QEMU. In bus mode, we
> > get 10 sockets open between the helper & dbus and another socket
> > open between dbus & QEMU. The bus is only a win in connections
> > if you have a mesh-like connection topology not hub & spoke.
>=20
> The mesh already exist, as it's not just QEMU that want to talk to the
> helpers, but the management layer, and 3rd parties (debug tools,
> audit, other management tools etc). There are also cases where helpers
> may want to talk to each other. Taking networking as an example, 2
> slirp interfaces may want to share the same DHCP, bootp/TFTP,
> filter/service provider. Redirection/forwarding may be provided on
> demand (chardev-like services). The same is probably true for block
> layers, security, GPU/display etc. In this case, the bus topology
> makes more sense than hiding it under.

These are alot of scenarios / use cases not described in the
cover letter for this series.

I'm reviewing this series from the POV of the need to transfer
vmstate from a helper back to QEMU, which was the scenario in
the cover letter. From this I see no need for a bus.

If you think there's a more general use cases involving QEMU
backends that will need the bus, then I think the bigger picture
needs to be described when proposing the use of the bus, instead
of only describing the very simple vmstate use case as the
motivation.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

