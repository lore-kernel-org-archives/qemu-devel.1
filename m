Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF09BC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 10:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 861072051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 10:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZVWrUvh9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861072051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDnMj-0004R0-4T
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 06:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58845)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jDn4C-0006Xb-L5
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:33:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jDn4B-0002wO-C9
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:33:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37738
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jDn4B-0002ox-4b
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584354830;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CcoKouWrdavudzQUoPtXVTWmOEtozE9L6emHp/iK5kk=;
 b=ZVWrUvh9Lsd1wPd0TcCk8GHCKdDfvUHF8RybzyudHR+oiWIvRdhATtuUOfX3sR6g/SZJiD
 pKLVsMjJeP3anxIH1ixR977l5n2xeHg6EX30ilhT+eiODVfXLqYoTuPfwG9jCnhZRYGXso
 1NIsUFgekoHmr5C2KyNvsgMz10JnqiI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-2VEUg5zYOmiLrHgcG5tleA-1; Mon, 16 Mar 2020 06:33:40 -0400
X-MC-Unique: 2VEUg5zYOmiLrHgcG5tleA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6180C63AD0;
 Mon, 16 Mar 2020 10:33:39 +0000 (UTC)
Received: from redhat.com (unknown [10.36.112.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D278E46;
 Mon, 16 Mar 2020 10:33:34 +0000 (UTC)
Date: Mon, 16 Mar 2020 10:33:31 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH] tools/virtiofsd: add support for --socket-group
Message-ID: <20200316103331.GC1528804@redhat.com>
References: <20200312104142.21259-1-alex.bennee@linaro.org>
 <20200312104913.GB4089516@redhat.com>
 <CAJ+F1CJWy2gEHHjzqyqnvHFf6EP4mEGABLt4aA7xptkXDwPGiw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJWy2gEHHjzqyqnvHFf6EP4mEGABLt4aA7xptkXDwPGiw@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Mar 14, 2020 at 02:33:25PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Thu, Mar 12, 2020 at 11:49 AM Daniel P. Berrang=C3=A9 <berrange@redhat=
.com> wrote:
> >
> > On Thu, Mar 12, 2020 at 10:41:42AM +0000, Alex Benn=C3=A9e wrote:
> > > If you like running QEMU as a normal user (very common for TCG runs)
> > > but you have to run virtiofsd as a root user you run into connection
> > > problems. Adding support for an optional --socket-group allows the
> > > users to keep using the command line.
> >
> > If we're going to support this, then I think we need to put it in
> > the vhost-user.rst specification so we standardize across backends.
> >
> >
>=20
> Perhaps. Otoh, I wonder if the backend spec should be more limited to
> arguments/introspection that are used by programs.
>=20
> In this case, I even consider --socket-path to be unnecessary, as a
> management layer can/should provide a preopened & setup fd directly.
>=20
> What do you think?

I think there's value in standardization even if it is an option targetted
at human admins, rather than machine usage. You are right though that
something like libvirt would never use --socket-group, or --socket-path.
Even admins would benefit if all programs followed the same naming for
these.  We could document such options as "SHOULD" rather than "MUST"
IOW, we don't mandate --socket-group, but if you're going to provide a
way to control socket group, this option should be used.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


