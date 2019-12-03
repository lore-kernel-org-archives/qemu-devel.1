Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E075C432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:37:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4833820674
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IWW6+mcB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4833820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic6UH-000727-83
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 06:37:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ic6E0-0007LH-Pj
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:20:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ic6Dz-0005tH-7B
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:20:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41408
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ic6Dz-0005qP-0y
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:20:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575372010;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8WlKTX7HByTCVFdutJqJSja/SDlqc6DQa+QYnLLKo0s=;
 b=IWW6+mcBmIuWfZC3QyNIdK9gZGaEDZZQNw6b3yFudcHEEusgEybiypuzntQRESEP7+v77M
 msdXUPMSwQzTRCnroIRQ/J3V2CZ5ofrsqnGYpcPxJdJN0WwWHEQYZHTkNdnez69dyvhFTJ
 YOxfDzcedht7zfRqm7jkExcKUBRPFNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-w3ZPQUHAPuOKnX-xZnJEEg-1; Tue, 03 Dec 2019 06:20:04 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F700801E7A;
 Tue,  3 Dec 2019 11:20:03 +0000 (UTC)
Received: from redhat.com (ovpn-112-52.ams2.redhat.com [10.36.112.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E2F155C1B5;
 Tue,  3 Dec 2019 11:19:51 +0000 (UTC)
Date: Tue, 3 Dec 2019 11:19:49 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: virtiofsd: Where should it live?
Message-ID: <20191203111949.GB267814@redhat.com>
References: <20191125185021.GB3767@work-vm>
 <20191126102600.GG556568@redhat.com>
 <20191126121416.GE2928@work-vm>
 <CAFEAcA9Ln2uwg4f4s8oS6VeQk83W3BErmH9cHeyDJy7v-4gNxw@mail.gmail.com>
 <87k17ekhs9.fsf@dusky.pond.sub.org>
 <fef0eaaf-149a-f8a8-02c5-821d2d42becd@redhat.com>
 <20191203105341.GB3078@work-vm>
 <CAFEAcA8bjGAs7JSTNYYYwCH1yF06i0v0r9wjKXqZGZg_Sqy0VA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8bjGAs7JSTNYYYwCH1yF06i0v0r9wjKXqZGZg_Sqy0VA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: w3ZPQUHAPuOKnX-xZnJEEg-1
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
Cc: mszeredi@redhat.com, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Dec 03, 2019 at 11:06:44AM +0000, Peter Maydell wrote:
> On Tue, 3 Dec 2019 at 10:53, Dr. David Alan Gilbert <dgilbert@redhat.com>=
 wrote:
> >
> > We seem to be coming to the conclusion something that:
> >
> >   a) It should live in the qemu tree
> >   b) It shouldn't live under contrib
> >   c) We'll create a new top level, i.e. 'daemons'
> >   d) virtiofsd will be daemons/virtiofsd
> >
> > Now, somethings I'm less clear on:
> >   e) What else would move into daemons?  It was suggested
> >     that if we've got virtiofsd in there, then we should move
> >     libvhost-user - which I understand, but then it's not a
> >     'daemons'.
> >     Are there any otehr daemons that should move?
>=20
> I like the idea of a new top level directory, but I think
> 'daemons' is a bit too specific -- for instance it seems to
> me that qemu-img would be sensible to move out of the root,
> and that's not a daemon.

Do we really need an extra directory level ?

IIUC, the main point against having $GIT_ROOT/virtiofsd is that
the root of our repo is quite cluttered already.

Rather than trying to create a multi-level hierarchy which adds
a debate around naming, why not address the clutter by moving
*ALL* the .c/.h files out of the root so that we have a flatter
tree:

  $GITROOT
    +- qemu-system
    |   +- vl.c
    |   +- ...most other files...
    +- qemu-img
    |   +- qemu-img.c
    +- qemu-nbd
    |   +- qemu-nbd.c
    +- qemu-io
    |   +- qemu-io.c
    |   +- qemu-io-cmds.c
    +- qemu-bridge-helper
    |   ...
    +- qemu-edid
    +- qemu-keymap
    +- qga  (already exists)

Then we can add virtiofsd and other programs at the root with no big
issue.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


