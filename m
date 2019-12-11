Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EF9C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 13:26:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D970208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 13:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FhRumh8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D970208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if20O-0007aV-7u
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 08:26:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48415)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1if1zQ-0006wZ-8Z
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:25:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1if1zO-0002Gc-0b
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:25:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32532
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1if1zN-0002Fs-Rw
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 08:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576070713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eWLcZmzWP1thshO5+8HaCofQSktkf9qVOpCeFPvffbw=;
 b=FhRumh8w7CCrBxokrE/Kp3bxLtAR+PVtENRuyq5YOjAfgb9WTohvwqinYvHGMZ+M7+Oz4E
 FIkoYKXXICJC6Q3/wHSH4vyRriKbjcwggJs3zeGH8uFWGeYDJzZwMYNOh03IGLTgwTc3j0
 qLjrbHRiOK963O2v3rcOzHQj+iPsWGk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-spLs-IgbMKehH6FcwleFHg-1; Wed, 11 Dec 2019 07:24:20 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE286477;
 Wed, 11 Dec 2019 12:24:19 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96F1B5C1B5;
 Wed, 11 Dec 2019 12:24:18 +0000 (UTC)
Date: Wed, 11 Dec 2019 13:24:17 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Subject: Re: Insufficiently documented deprecated command arguments
Message-ID: <20191211122417.GB6505@linux.fritz.box>
References: <87tv67wa9y.fsf@dusky.pond.sub.org>
 <20191211093317.GB2441258@angien.pipo.sk>
 <20191211101439.GA6505@linux.fritz.box>
 <20191211105147.GC2441258@angien.pipo.sk>
MIME-Version: 1.0
In-Reply-To: <20191211105147.GC2441258@angien.pipo.sk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: spLs-IgbMKehH6FcwleFHg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 11.12.2019 um 11:51 hat Peter Krempa geschrieben:
> On Wed, Dec 11, 2019 at 11:14:39 +0100, Kevin Wolf wrote:
> > Am 11.12.2019 um 10:33 hat Peter Krempa geschrieben:
> > > On Wed, Dec 11, 2019 at 09:12:41 +0100, Markus Armbruster wrote:
> > > >     Commit 7a9877a026 "block: Accept device model name for
> > > >     block_set_io_throttle" (v2.8.0) deprecated block_set_io_throttl=
e
> > > >     argument @device.
> > >=20
> > > This one is more complex. The command is used both in 'blockdev' and =
in
> > > 'drive' mode:
> > >=20
> > > In 'drive' mode we pass the alias of the 'drive' as the @device
> > > argument.
> > >=20
> > > In 'blockdev' mode we pass the qom name as @id
> >=20
> > Any reason you couldn't use the QOM name even in 'drive' mode for any
> > QEMU version that has the @id option?
>=20
> Honestly, I didn't want to change the existing implementation at all.
>=20
> If it will help I can change that as it will be pretty easy to do.

You can keep it for until after the blockdev dust has settled. It would
"just" be to address the deprecation since QEMU 2.8, not because of any
functional change.

> >=20
> > > >     Commit c42e8742f5 "block: Use JSON null instead of "" to disabl=
e
> > > >     backing file" (v2.10.0) deprecated blockdev-add empty string
> > > >     argument @backing.
> > >=20
> > > This is used in 'blockdev' mode only and we always pass the JSON null=
 or
> > > a node name string.
> >=20
> > Here the thing to consider might be that JSON null isn't easy to use on
> > the command line for manual users.
> >=20
> > > >     These were missed in commit eb22aeca65 "docs: document deprecat=
ion
> > > >     policy & deprecated features in appendix" (v2.10.0).
> > > >=20
> > > >     Commit 3c605f4074 "commit: Add top-node/base-node options" (v3.=
1.0)
> > > >     deprecated block-commit arguments @base and @top.
> > >=20
> > > This command also has two modes:
> > >=20
> > > In 'drive' mode we pass in path strings as @base and @ top.
> > >=20
> > > In 'blockdev' mode we pass in nodenames as @base-node and @top-node.
> > >=20
> > > Starting from qemu-4.2 libvirt uses 'blockdev' mode for VMs unless an=
 SD
> > > card is configured as we didn't convert to the '-device' approach for
> > > those as AFAIK not everything is possible to be converted.
> >=20
> > Hm... I guess in 'drive' mode, you stil don't assign node names, so you
> > actually have to rely on paths?
>=20
> Well, in some specific cases we could detect the node names
> auto-assigned by qemu and use them instead of paths, but in my opinion
> it's not worth the effort and extra code.

Well, the question is what to do on the QEMU side then. Deprecation
should mean that we have a plan for removing the feature. If we're
planning to keep the feature indefinitely because libvirt needs it, we
might want to consider removing the deprecation notice.

(Though honestly, keeping this one indefinitely feels wrong because
using file names to identify nodes was really one of the worse ideas.)

Kevin


