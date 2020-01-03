Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22BCC2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 12:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82D872085B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 12:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFmH1pSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D872085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inM9P-00044f-LP
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 07:33:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1inM8l-0003dE-3H
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 07:33:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1inM8i-0001dQ-SS
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 07:33:18 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46109
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1inM8i-0001YC-N9
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 07:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578054795;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=weGexod5tBMg0CDwzyojDlqkirYzOv55fsNqEq0GBTk=;
 b=SFmH1pSp9ohdltTQXYbDvKuXX8zHlK6Y0x94k2j+8NiHDiYfOnj/QUD5FjhhPCwXOjwpVi
 QawpWbFKXLIl+0Uxrz0qHKYZNzT9KAAIN3F84N6yGR3gKOKPwFfekeh4HKS8KmLH0BVNqi
 KUVpVK1ZVtpS+9b8GiyqqR1hseijZVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-xPa4XVp3ObafoVd54yl1qg-1; Fri, 03 Jan 2020 07:33:11 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A360A800D41
 for <qemu-devel@nongnu.org>; Fri,  3 Jan 2020 12:33:10 +0000 (UTC)
Received: from redhat.com (ovpn-112-41.ams2.redhat.com [10.36.112.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69D44385;
 Fri,  3 Jan 2020 12:33:06 +0000 (UTC)
Date: Fri, 3 Jan 2020 12:33:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 005/104] virtiofsd: Add passthrough_ll
Message-ID: <20200103123303.GS2753983@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-6-dgilbert@redhat.com>
 <20200103120109.GK2753983@redhat.com>
 <20200103121535.GE3804@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200103121535.GE3804@work-vm>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: xPa4XVp3ObafoVd54yl1qg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 03, 2020 at 12:15:35PM +0000, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> > On Thu, Dec 12, 2019 at 04:37:25PM +0000, Dr. David Alan Gilbert (git) =
wrote:
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > >=20
> > > passthrough_ll is one of the examples in the upstream fuse project
> > > and is the main part of our daemon here.  It passes through requests
> > > from fuse to the underlying filesystem, using syscalls as directly
> > > as possible.
> > >=20
> > > From libfuse fuse-3.8.0
> > >=20
> > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > ---
> > >  tools/virtiofsd/passthrough_ll.c | 1338 ++++++++++++++++++++++++++++=
++
> > >  1 file changed, 1338 insertions(+)
> > >  create mode 100644 tools/virtiofsd/passthrough_ll.c
> > >=20
> > > diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passt=
hrough_ll.c
> > > new file mode 100644
> > > index 0000000000..5372d02934
> > > --- /dev/null
> > > +++ b/tools/virtiofsd/passthrough_ll.c
> > > @@ -0,0 +1,1338 @@
> > > +/*
> > > +  FUSE: Filesystem in Userspace
> > > +  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
> > > +
> > > +  This program can be distributed under the terms of the GNU GPL.
> >=20
> > I presume this mistake exists in upstream fuse GIT - missing GPL versio=
n
> > number info here.
>=20
> Yes it is, see:
> https://github.com/libfuse/libfuse/blob/d735af94fa54a5555ce725f1d4e6b97b8=
12b6603/example/passthrough_ll.c
>=20
> And at the time that was added their COPYING file was GPL v2.
>=20
> although they've since renamed COPYING to GPL2.txt but not updated
> the comments; but they added a LICENSE file.
> https://github.com/libfuse/libfuse/commit/e8bcd8461ce7dfdc7366f44bad8d855=
696e73c3b
>=20
> > This is important to correct since we're moving code
> > from another repo and thus the COPYING file it is referring to on the
> > next line is ambiguous to the casual reader.
> >=20
> > > +  See the file COPYING.
> > > +*/
> >=20
> > With the GPL version info added:
>=20
> So just change 'GNU GPL' to 'GNU GPL version 2' during the import?

Yes, or just  "GPLv2" is fine too. Ideally submit a patch to libfuse
upstream & then just copy the result.

>=20
> >   Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


