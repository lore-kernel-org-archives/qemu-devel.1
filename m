Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E199BC282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:20:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB9292077C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVMdbMNE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9292077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipw5A-0000sG-Ti
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 10:20:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ipw3J-0006m5-IA
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:18:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ipw3I-0003xv-4V
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:18:21 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52441
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ipw3G-0003rw-Uq
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:18:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578669498;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R8COT8qa76Y4CXxhQhfrxopi6wrBWQ/T8rSjVi7aOWw=;
 b=cVMdbMNExsrs1KdTANr9At0gd5W66zVC0QzrPlILUcp3qeUIbq3wRbgbvT9z/J0qEFSfmh
 IgWvz/jYa3nstB5qdo6G9+/Niwp444klgtlAWO3Y+mZS5W5YhwiYUs60tojxXVo5QVybgL
 uVbP4mhiceztWjYZNQ312FvQ6+xiPHs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-sDfICJn6P12arHpOyxUcVQ-1; Fri, 10 Jan 2020 10:18:17 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E15F800D48
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 15:18:16 +0000 (UTC)
Received: from redhat.com (ovpn-112-65.ams2.redhat.com [10.36.112.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 51C101001938;
 Fri, 10 Jan 2020 15:18:12 +0000 (UTC)
Date: Fri, 10 Jan 2020 15:18:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH 068/104] virtiofsd: passthrough_ll: control readdirplus
Message-ID: <20200110151808.GT3423494@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-69-dgilbert@redhat.com>
 <20200107112316.GL3368802@redhat.com>
 <20200110150447.GH3901@work-vm>
 <CAOssrKdRn9NGV9TuvCkRRXEwZep6B-R2598iYLY4-9d6zkPUXg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOssrKdRn9NGV9TuvCkRRXEwZep6B-R2598iYLY4-9d6zkPUXg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: sDfICJn6P12arHpOyxUcVQ-1
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
Cc: Vivek Goyal <vgoyal@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 10, 2020 at 04:13:08PM +0100, Miklos Szeredi wrote:
> On Fri, Jan 10, 2020 at 4:04 PM Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> >
> > * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> > > On Thu, Dec 12, 2019 at 04:38:28PM +0000, Dr. David Alan Gilbert (git=
) wrote:
> > > > From: Miklos Szeredi <mszeredi@redhat.com>
> > > >
> > >
> > > What is readdirplus and what do we need a command line option to
> > > control it ? What's the user benefit of changing the setting ?
> >
> > cc'ing Miklos who understands this better than me.
> >
> > My understanding is that readdirplus is a heuristic inherited from NFS
> > where when you iterate over the directory you also pick up stat() data
> > for each entry in the directory.  You then cache that stat data
> > somewhere.
> > The Plus-ness is that a lot of directory operations involve you stating
> > each entry (e.g. to figure out if you can access it etc) so rolling it
> > into one op avoids the separate stat.  The unplus-ness is that it's an
> > overhead and I think changes some of the caching behaviour.
>=20
> Yeah, so either may give better performance and it's hard to pick a
> clear winner.  NFS also has an option to control this.

IIUC from the man page, the NFS option for controlling this is a client
side mount option. This makes sense as only the client really has knowledge
of whether its workload will benefit.

With this in mind, should the readdirplus control for virtio-fs also be a
guest mount option instead of a host virtiofsd CLI option ? The guest admin
seems best placed to know whether their workload will benefit or not.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


