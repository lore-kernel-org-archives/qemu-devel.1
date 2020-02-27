Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B41FC4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:40:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9AFC24690
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQQvi8W2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9AFC24690
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7HWS-0004n6-Vo
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 06:40:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43765)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j7HV0-0003UO-AV
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:38:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j7HUw-0008AU-QX
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:38:36 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57970
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j7HUw-00086B-Jz
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:38:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582803513;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M8TyWRDiZfwO4iR/rU1PuO7ZYtPvtyt775EDLXpXcW4=;
 b=aQQvi8W2HTPVPZ+uuQqQlKmQFKKpWQfwYLGlUfqkNmnjomsVz1eXbyMa2Lio0uLnkFg0Vb
 PXltPhx9sYecObHZ+joFSe8QrR+WMOFuU2LSg6KkFZ/bTGGiVMznQKqI2/vgJ0d9eVrnEV
 C7KqPkDtbfdohXRE8Dgs0e+dBsqW43k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-g064SZGmPCuzuerejsL_tA-1; Thu, 27 Feb 2020 06:38:25 -0500
X-MC-Unique: g064SZGmPCuzuerejsL_tA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51F7C800D54;
 Thu, 27 Feb 2020 11:38:24 +0000 (UTC)
Received: from redhat.com (ovpn-112-43.ams2.redhat.com [10.36.112.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7230B1BC6D;
 Thu, 27 Feb 2020 11:38:17 +0000 (UTC)
Date: Thu, 27 Feb 2020 11:38:14 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v4 0/5] vhost-user block device backend implementation
Message-ID: <20200227113814.GI1645630@redhat.com>
References: <20200218050711.8133-1-coiby.xu@gmail.com>
 <20200219163815.GD1085125@stefanha-x1.localdomain>
 <CAJAkqrXaqmT2pR4K1x06AeQZHvUWp-fcqnbKZq_45czO96v5PA@mail.gmail.com>
 <20200227074114.GB83512@stefanha-x1.localdomain>
 <CAJAkqrWUJWLdT+6b_XmHFwnzhhbYei2SakCKVW0Rf92HJgoZDw@mail.gmail.com>
 <20200227100206.GA7493@linux.fritz.box>
 <CAJAkqrW_Euur3HjWaK6E-TAjT1dmjA1fz1oPwKSt7_pOC3=S+w@mail.gmail.com>
 <20200227105528.GC7493@linux.fritz.box>
 <CAMxuvay1vLosHTpXP7b3pXQvfRPOMp0z3ML66khLSrK-iLf7aQ@mail.gmail.com>
 <20200227111958.GD7493@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200227111958.GD7493@linux.fritz.box>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: bharatlkmlkvm@gmail.com,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Coiby Xu <coiby.xu@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 27, 2020 at 12:19:58PM +0100, Kevin Wolf wrote:
> Am 27.02.2020 um 12:07 hat Marc-Andr=C3=A9 Lureau geschrieben:
> > On Thu, Feb 27, 2020 at 11:55 AM Kevin Wolf <kwolf@redhat.com> wrote:
> > > Am 27.02.2020 um 11:28 hat Coiby Xu geschrieben:
> > > > > > we still need customized vu_message_read because libvhost-user =
assumes
> > > > > > we will always get a full-size VhostUserMsg and hasn't taken ca=
re of
> > > > > > this short read case. I will improve libvhost-user's vu_message=
_read
> > > > > > by making it keep reading from socket util getting enough bytes=
. I
> > > > > > assume short read is a rare case thus introduced performance pe=
nalty
> > > > > > would be negligible.
> > > >
> > > > > In any case, please make sure that we use the QIOChannel function=
s
> > > > > called from a coroutine in QEMU so that it will never block, but =
the
> > > > > coroutine can just yield while it's waiting for more bytes.
> > > >
> > > > But if I am not wrong, libvhost-user is supposed to be indepdent fr=
om
> > > > the main QEMU code. So it can't use the QIOChannel functions if we
> > > > simply modify exiting vu_message_read to address the short read iss=
ue.
> > > > In v3 & v4, I extended libvhost-user to allow vu_message_read to be
> > > > replaced by one which will depend on the main QEMU code. I'm not su=
re
> > > > which way is better.
> > >
> > > The way your latest patches have it, with a separate read function,
> > > works for me.
> >=20
> > Done right, I am not against it, fwiw
> >=20
> > > You could probably change libvhost-user to reimplement the same
> > > functionality, and it might be an improvement for other users of the
> > > library, but it's also code duplication and doesn't provide more valu=
e
> > > in the context of the vhost-user export in QEMU.
> > >
> > > The point that's really important to me is just that we never block w=
hen
> > > we run inside QEMU because that would actually stall the guest. This
> > > means busy waiting in a tight loop until read() returns enough bytes =
is
> > > not acceptable in QEMU.
> >=20
> > In the context of vhost-user, local unix sockets with short messages
> > (do we have >1k messages?), I am not sure if this is really a problem.
>=20
> I'm not sure how much of a problem it is in practice, and whether we
> can consider the vhost-user client trusted. But using QIOChannel from
> within a coroutine just avoids the problem completely, so it feels like
> a natural choice to just do that.

It isn't clear to me that we have a consitent plan for how we intend
libvhost-user to develop & what it is permitted to use.  What information
I see in the source code and in this thread are contradictory.

For example, in the text quoted above:

  "libvhost-user is supposed to be indepdent from the main QEMU code."

which did match my overall understanding too. At the top of libvhost-user.c
there is a comment

   /* this code avoids GLib dependency */

but a few lines later it does

  #include "qemu/atomic.h"
  #include "qemu/osdep.h"
  #include "qemu/memfd.h"

and in the Makefile we link it to much of QEMU util code:

  libvhost-user.a: $(libvhost-user-obj-y) $(util-obj-y) $(stub-obj-y)

this in turn pulls in GLib code, and looking at symbols we can see
over 100 GLib functions used:

  $ nm ./libvhost-user.a | grep 'U g_' | sort | uniq | wc -l
  128

And over 200 QEMU source object files included:

  $ nm ./libvhost-user.a | grep '.o:' | sort | wc -l
  224

So unless I'm missing something, we have lost any independance from
both QEMU and GLib code that we might have had in the past.

Note this also has licensing implications, as I expect this means that
via the QEMU source objects it pulls in, libvhost-user.a has become
a GPLv2-only combined work, not a GPLv2-or-later combined work.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


