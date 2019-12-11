Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094B5C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 13:04:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C52A92077B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 13:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dhvtLA7v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52A92077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if1f2-0001Lj-Ox
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 08:04:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1if1dx-0000Bx-Fh
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:03:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1if1dv-0006wV-Vt
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:03:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28447
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1if1dv-0006tg-S3
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:03:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576069381;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pWPS/scdnjH3bZiyRlJV53iE6asMpkv3AjunRxlsBpY=;
 b=dhvtLA7v0zPgLbCs+7e/PBvKuhMqKGJuinEgibZVU5WRHGA6ZL1LjWfdVu0W9gc4B9Kygk
 xL4la2p1dnY8b1cyOhOv3+bAn55KUnXI8eMTBgG6TJxaQarSCNhHgBTgznjZydPr/K21HZ
 laAMuJC6GGD9GRn4scrZ1Mb0qGYrJ88=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-Em5WSsJONDi5upzBJTWisQ-1; Wed, 11 Dec 2019 07:32:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 377801010FC2;
 Wed, 11 Dec 2019 12:32:15 +0000 (UTC)
Received: from redhat.com (ovpn-112-62.ams2.redhat.com [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 886AB1001B07;
 Wed, 11 Dec 2019 12:32:13 +0000 (UTC)
Date: Wed, 11 Dec 2019 12:32:10 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: Insufficiently documented deprecated command arguments
Message-ID: <20191211123210.GH955178@redhat.com>
References: <87tv67wa9y.fsf@dusky.pond.sub.org>
 <20191211093317.GB2441258@angien.pipo.sk>
 <20191211101439.GA6505@linux.fritz.box>
 <20191211105147.GC2441258@angien.pipo.sk>
 <20191211122417.GB6505@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20191211122417.GB6505@linux.fritz.box>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Em5WSsJONDi5upzBJTWisQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Krempa <pkrempa@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 11, 2019 at 01:24:17PM +0100, Kevin Wolf wrote:
> Am 11.12.2019 um 11:51 hat Peter Krempa geschrieben:
> > On Wed, Dec 11, 2019 at 11:14:39 +0100, Kevin Wolf wrote:
> > > Am 11.12.2019 um 10:33 hat Peter Krempa geschrieben:
> > > > On Wed, Dec 11, 2019 at 09:12:41 +0100, Markus Armbruster wrote:
> > > > >     Commit 7a9877a026 "block: Accept device model name for
> > > > >     block_set_io_throttle" (v2.8.0) deprecated block_set_io_throt=
tle
> > > > >     argument @device.
> > > >=20
> > > > This one is more complex. The command is used both in 'blockdev' an=
d in
> > > > 'drive' mode:
> > > >=20
> > > > In 'drive' mode we pass the alias of the 'drive' as the @device
> > > > argument.
> > > >=20
> > > > In 'blockdev' mode we pass the qom name as @id
> > >=20
> > > Any reason you couldn't use the QOM name even in 'drive' mode for any
> > > QEMU version that has the @id option?
> >=20
> > Honestly, I didn't want to change the existing implementation at all.
> >=20
> > If it will help I can change that as it will be pretty easy to do.
>=20
> You can keep it for until after the blockdev dust has settled. It would
> "just" be to address the deprecation since QEMU 2.8, not because of any
> functional change.
>=20
> > >=20
> > > > >     Commit c42e8742f5 "block: Use JSON null instead of "" to disa=
ble
> > > > >     backing file" (v2.10.0) deprecated blockdev-add empty string
> > > > >     argument @backing.
> > > >=20
> > > > This is used in 'blockdev' mode only and we always pass the JSON nu=
ll or
> > > > a node name string.
> > >=20
> > > Here the thing to consider might be that JSON null isn't easy to use =
on
> > > the command line for manual users.
> > >=20
> > > > >     These were missed in commit eb22aeca65 "docs: document deprec=
ation
> > > > >     policy & deprecated features in appendix" (v2.10.0).
> > > > >=20
> > > > >     Commit 3c605f4074 "commit: Add top-node/base-node options" (v=
3.1.0)
> > > > >     deprecated block-commit arguments @base and @top.
> > > >=20
> > > > This command also has two modes:
> > > >=20
> > > > In 'drive' mode we pass in path strings as @base and @ top.
> > > >=20
> > > > In 'blockdev' mode we pass in nodenames as @base-node and @top-node=
.
> > > >=20
> > > > Starting from qemu-4.2 libvirt uses 'blockdev' mode for VMs unless =
an SD
> > > > card is configured as we didn't convert to the '-device' approach f=
or
> > > > those as AFAIK not everything is possible to be converted.
> > >=20
> > > Hm... I guess in 'drive' mode, you stil don't assign node names, so y=
ou
> > > actually have to rely on paths?
> >=20
> > Well, in some specific cases we could detect the node names
> > auto-assigned by qemu and use them instead of paths, but in my opinion
> > it's not worth the effort and extra code.
>=20
> Well, the question is what to do on the QEMU side then. Deprecation
> should mean that we have a plan for removing the feature. If we're
> planning to keep the feature indefinitely because libvirt needs it, we
> might want to consider removing the deprecation notice.

Ideally libvirt would stop using -drive entirely, as I hate the idea of
having to keep this around indefinitely in libvirt too. This needs QEMU
to close the last gaps wrt SD cards

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


