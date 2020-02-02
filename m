Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88906C35240
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 09:34:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 540B520842
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 09:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6zz8ej2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 540B520842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyBeT-0002SD-HR
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 04:34:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iyBdY-0001yq-AH
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 04:33:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iyBdW-0007mp-Kw
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 04:33:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50689
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iyBdW-0007ke-Gs
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 04:33:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580636029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SgdDnj3NSKmyD6qv87mWW3MTjQuVwZhG9QjWjY4Pajw=;
 b=J6zz8ej2zulzQdYkGfet3ykjopjpdMlyaAxSRtN3HrevlR+VVuFZp6hasCrfFvOJ5nBif8
 XfVBK3A5jKUDK93MYDMO+noCVNCF+1opSjjS6NS4/iw7cmtywSkBOKGl1OsRqQvlcLN8nS
 j9J0PdfDeosIiFdeFSDd70Wfj5HwNT4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-iqdcBHyFMRCRqP5qSyKtxA-1; Sun, 02 Feb 2020 04:33:43 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC85E8010E7;
 Sun,  2 Feb 2020 09:33:41 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-29.ams2.redhat.com
 [10.36.116.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F3EA460BE0;
 Sun,  2 Feb 2020 09:33:37 +0000 (UTC)
Date: Sun, 2 Feb 2020 10:33:36 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v2 3/5] a standone-alone tool to directly share disk
 image file via vhost-user protocol
Message-ID: <20200202093336.GB3456@localhost.localdomain>
References: <20200114140620.10385-1-coiby.xu@gmail.com>
 <20200114140620.10385-4-coiby.xu@gmail.com>
 <20200116140429.GJ163546@stefanha-x1.localdomain>
 <CAJAkqrVhvi-8MZ-mPjZ67yfjOaick5Gu_g3GxYAeYvH3Cp6QVw@mail.gmail.com>
 <20200117101158.GC7394@dhcp-200-226.str.redhat.com>
 <CAJAkqrUYp7uCH80Ui0S4GXnAaKasNGPAYM5oJEjC2LuJ02cfPg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJAkqrUYp7uCH80Ui0S4GXnAaKasNGPAYM5oJEjC2LuJ02cfPg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: iqdcBHyFMRCRqP5qSyKtxA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 31.01.2020 um 17:42 hat Coiby Xu geschrieben:
> > Yes, I think at least for the moment it should work fine this way.
> > Eventually, I'd like to integrate it with --export (and associated QMP
> > commands, which are still to be created), too. Maybe at that point we
> > want to make the QOM object not user creatable any more.
>=20
> Does it mean TYPE_USER_CREATABLE interface in QOM will become
> deprecated in the future? I'm curious what are the reasons for making
> QOM object no user creatable? Because we may still need to start
> vhost-user block device backend through HMP or QMP instead of stating
> it as a standalone-alone daemon.

Not in general, but if we have something like a block-export-add QMP
command, the QOM interface would be redundant. We could still leave it
there and have both a low-level and a high-level interface, but whether
we would want to is something we still have to decide.

> > As for test cases, do you think it would be hard to just modify the
> > tests to send an explicit 'quit' command to the daemon?
>=20
> Accroding to https://patchew.org/QEMU/20191017130204.16131-1-kwolf@redhat=
.com/20191017130204.16131-10-kwolf@redhat.com/,
>=20
> > +static bool exit_requested =3D false;
> > +
> > +void qemu_system_killed(int signal, pid_t pid)
> > +{
> > +    exit_requested =3D true;
> > +}
>=20
> if exit_requested =3D true, qemu-storage-daemon will exit the main loop
> and then quit. So is calling qemu_system_killed by what you means "to
> send an explicit 'quit' command to the daemon"?

qemu_system_killed() is call in the signal handlers for, amongst others,
SIGTERM and SIGINT. This is one way to stop the storage daemon (for
manual use, sending SIGINT with Ctrl-C is probably the easiest way).

What I actually meant is the 'quit' QMP command which will cause
qmp_quit() to be run, which contains the same code. But if sending a
signal is more convenient, that's just as good.

Kevin

> On Fri, Jan 17, 2020 at 6:12 PM Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > Am 17.01.2020 um 09:12 hat Coiby Xu geschrieben:
> > > Excellent! I will add an option (or object property) for
> > > vhost-user-blk server oject which will tell the daemon process to exi=
t
> > > when the client disconnects, thus "make check-qtest" will not get hel=
d
> > > by this daemon process. After that since Kevin's qemu-storage-daemon
> > > support "-object" option
> > > (https://patchew.org/QEMU/20191017130204.16131-1-kwolf@redhat.com/201=
91017130204.16131-3-kwolf@redhat.com/)
> > > and vhost-user-server is a user-creatable QOM object, it will work ou=
t
> > > of the box.
> >
> > Yes, I think at least for the moment it should work fine this way.
> > Eventually, I'd like to integrate it with --export (and associated QMP
> > commands, which are still to be created), too. Maybe at that point we
> > want to make the QOM object not user creatable any more.
> >
> > Would it make sense to prefix the object type name with "x-" so we can
> > later retire it from the external user interface without a deprecation
> > period?
> >
> > As for test cases, do you think it would be hard to just modify the
> > tests to send an explicit 'quit' command to the daemon?
> >
> > > I'm curious when will be formal version of qemu-storage-daemon
> > > finished so I can take advantage of it? Or should I apply the RFC
> > > PATCHes to my working branch directly and submit them together with
> > > the patches on vhost-user-blk server feature when posting v3?
> >
> > It's the next thing I'm planning to work on after completing the
> > coroutine-base QMP handlers (which I hope to get finished very soon).
> >
> > For the time being I would suggest that you put any patches that depend
> > on qemu-storage-daemon (if you do need it) at the end of your series so
> > that we could apply the first part even if the storage daemon isn't in
> > yet.
> >
> > The latest version of my patches is at:
> >
> >     git://repo.or.cz/qemu/kevin.git storage-daemon
> >
> > But if you just need something for testing your code, I think it would
> > even make sense if you kept your standalone tool around (even though
> > we'll never merge it) and we'll deal with integration in the storage
> > daemon once both parts are ready.
> >
> > Kevin
> >
>=20
>=20
> --=20
> Best regards,
> Coiby
>=20


