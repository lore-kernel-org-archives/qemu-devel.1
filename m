Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98C4C33CB6
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 11:05:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9C75206D9
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 11:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQGRgJzm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C75206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is2yC-0005B7-Te
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 06:05:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1is2x7-0004Qh-QL
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 06:04:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1is2x4-0003Ai-4F
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 06:04:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29575
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1is2x3-00039u-Vx
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 06:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579172677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zu0k2wUr5iJo7Zg/OFYLF+7gelRsZKASDYcLP1CgaTE=;
 b=KQGRgJzmopC4f8JJKces4Nfke3sdIXrnhnZ7fzX1mLhQs/XBFY/2vJUM+vwUVonES3kaZz
 HWD24Qd7MdolFd52RE8yezOhow0aTjTQJVtKnXdLPs2T/zmbzjsPZ8/4vlYp8fcfFIudLn
 +xa0uZdK28z54t8/BltNnhBBMIuftuM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-D0ht77__NAiwxpW6ZIVh4Q-1; Thu, 16 Jan 2020 06:03:26 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F14D718AAFAC;
 Thu, 16 Jan 2020 11:03:24 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-117-182.ams2.redhat.com
 [10.36.117.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 306D526FDB;
 Thu, 16 Jan 2020 11:03:17 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 230E63E0489; Thu, 16 Jan 2020 12:03:14 +0100 (CET)
Date: Thu, 16 Jan 2020 12:03:14 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200116110314.GA24159@paraplu>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <87h81unja8.fsf@dusky.pond.sub.org>
 <20200102144722.GL121208@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200102144722.GL121208@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: D0ht77__NAiwxpW6ZIVh4Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 02, 2020 at 02:47:22PM +0000, Stefan Hajnoczi wrote:
> On Sat, Dec 21, 2019 at 10:02:23AM +0100, Markus Armbruster wrote:
> > Stefan Hajnoczi <stefanha@gmail.com> writes:

[...]

> > > 2. scripts/qmp/ contains command-line tools for QMP communication.
> > > They could use some polish and then be shipped.
> >=20
> > MAINTAINERS blames them on me, but they're effectively unmaintained.
> > Prerequisite for shipping: having a maintainer who actually gives a
> > damn.
> ...
> > * scripts/qmp/qmp-shell
> >=20
> >   Half-hearted attempt at a human-friendly wrapper around the JSON
> >   syntax.  I have no use for this myself.
>=20
> I think this one is used by people.  John Snow comes to mind.

FWIW I too frequently use 'qmp-shell'.  And some of the examples in this
document[1] are demonstrated with it.

I'm reasonably happy with it (particularly the persistent history
captured in ~/.qmp-shell_history), and it has some "known issues" that
can trip up a new user.  The one that immediately jumps to mind:
asynchronous events won't be printed without a prompt from the user --
e.g. after a `blockdev-commit`, you won't see BLOCK_JOB_{READY,
COMPLETED} events printed unless you manually hit enter from the
'qmp-shell'.

(Not complaining; I have a long-standing TODO to make time to
investigate this.)

[1] https://qemu.readthedocs.io/en/latest/interop/live-block-operations.htm=
l

> > > 3. python/qemu/ contains Python modules for managing a QEMU process
> > > and QMP communication.  This should be packaged in distros and
> > > available on PyPI.
> >=20
> > Currently maintained by Eduardo and Cleber (cc'ed) under "Python
> > scripts".

Yeah, that'd certainly be useful.  I vaguely recall a discussion on this
topic here on the list (or probably some hallway discussion, can't
recall.)


[...]


--=20
/kashyap


