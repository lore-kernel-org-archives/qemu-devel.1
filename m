Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F69EC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 10:18:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E85102064C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 10:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gPsY8T39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E85102064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwkQY-0007KI-4Y
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 05:18:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iwkPF-0006IE-48
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:17:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iwkPE-0004Ew-0A
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:17:09 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21328
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iwkPD-0004Ef-TX
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:17:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580293027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bPElJzPM8itb1dJ/hLOna8wKQ9oX9pCBOWfXiVBKFpE=;
 b=gPsY8T39wksxRaWWgmxEINfSJ3yTZIDsBdSfsZZz2ohkQD6uXnXnZB04PuHD3AAsrypKTK
 DZU/0A1gDGtgVuIrDLKZDDgzCEbaZjsuV3x+40qyolp9gKXebpVJTpzPBis49Ta0cROmGe
 nQs3UwN1ZNBXoAmyDU0kGpaWxgJfKhI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-zyH9OAPsOEyZyCKvZMgeGA-1; Wed, 29 Jan 2020 05:17:03 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E9381005510;
 Wed, 29 Jan 2020 10:17:02 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-205.ams2.redhat.com [10.36.116.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B829A8E9FA;
 Wed, 29 Jan 2020 10:17:01 +0000 (UTC)
Date: Wed, 29 Jan 2020 11:17:00 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 2/4] qapi: Create module 'control'
Message-ID: <20200129101700.GB5690@linux.fritz.box>
References: <20200128175211.30007-1-kwolf@redhat.com>
 <20200128175211.30007-3-kwolf@redhat.com>
 <8736by4q3m.fsf@dusky.pond.sub.org>
 <20200129090953.GA5690@linux.fritz.box>
 <87sgjy1txs.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87sgjy1txs.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: zyH9OAPsOEyZyCKvZMgeGA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 29.01.2020 um 10:41 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
>=20
> > Am 29.01.2020 um 09:35 hat Markus Armbruster geschrieben:
> >> Kevin Wolf <kwolf@redhat.com> writes:
> >>=20
> >> > misc.json contains definitions that are related to the system emulat=
or,
> >> > so it can't be used for other tools like the storage daemon. This pa=
tch
> >> > moves basic functionality that is shared between all tools (and most=
ly
> >> > related to the monitor itself) into a new control.json, which could =
be
> >> > used in tools as well.
> >> >
> >> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >> > ---
> >> >  qapi/control.json          | 218 ++++++++++++++++++++++++++++++++++=
+++
> >> >  qapi/misc.json             | 212 ----------------------------------=
--
> >> >  qapi/qapi-schema.json      |   1 +
> >> >  monitor/monitor-internal.h |   1 +
> >> >  monitor/hmp-cmds.c         |   1 +
> >> >  monitor/misc.c             |   1 +
> >> >  monitor/qmp-cmds.c         |   1 +
> >> >  monitor/qmp.c              |   2 +-
> >> >  tests/qtest/qmp-test.c     |   2 +-
> >> >  ui/gtk.c                   |   1 +
> >> >  qapi/Makefile.objs         |   6 +-
> >> >  11 files changed, 229 insertions(+), 217 deletions(-)
> >> >  create mode 100644 qapi/control.json
> >> >
> >> > diff --git a/qapi/control.json b/qapi/control.json
> >> > new file mode 100644
> >> > index 0000000000..a82a18da1a
> >> > --- /dev/null
> >> > +++ b/qapi/control.json
> >> > @@ -0,0 +1,218 @@
> >> > +# -*- Mode: Python -*-
> >> > +#
> >> > +
> >>=20
> >> Let's add a copyright notice:
> >>=20
> >>    # Copyright (C) 2011-2020 Red Hat, Inc.
> >>    #
> >>    # This work is licensed under the terms of the GNU GPL, version 2 o=
r later.
> >>    # See the COPYING file in the top-level directory.
> >
> > I'm not adding anything new, but just moving code from a file that
> > doesn't have a copyright notice. In fact, almost none of the schema
> > files have a copyright notice. I'm not comfortable adding legal
> > assertions without verifying that they are correct, and certainly not a=
s
> > a side-effect of a code movement patch. This would be an unrelated
> > change.
> >
> > I suggest that we leave this patch as is, and if you think copyright
> > notices should be added, the correct information can be tracked down
> > and added consistently for all schema files in a separate series.
>=20
> There is nothing to be tracked down.  Anything that lacks an explicit
> copyright notice is under GPLv2+, as per LICENSE.

The copyright holders should be tracked down rather than just putting
"Red Hat" there, which is most likely wrong. Not that copyright notices
anywhere else are much more complete, but they tend to be correct at
least when they are added (i.e. usually when the file is created), so
not updating them is the fault of the copyright holders that are
missing in the notice.

But anyway, it's unrelated to this patch in either case.

Kevin


