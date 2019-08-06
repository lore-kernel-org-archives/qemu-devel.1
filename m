Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8A1C433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 15:28:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70DE12070D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 15:28:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70DE12070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv1ON-0006PE-Oa
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 11:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52556)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hv1H9-0001qN-7W
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 11:21:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hv1H8-0000Vl-6p
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 11:21:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51356)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1hv1H7-0000VH-U9
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 11:21:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A373476A00;
 Tue,  6 Aug 2019 15:21:20 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-113.ams2.redhat.com
 [10.36.117.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08DCA60C83;
 Tue,  6 Aug 2019 15:21:13 +0000 (UTC)
Date: Tue, 6 Aug 2019 17:21:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <20190806152112.GC5849@localhost.localdomain>
References: <20190628194512.21311-1-danielhb413@gmail.com>
 <20190628194512.21311-2-danielhb413@gmail.com>
 <20190802160731.GF6379@localhost.localdomain>
 <92e47934-88e0-5734-fa35-56ecd700e1d7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92e47934-88e0-5734-fa35-56ecd700e1d7@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 06 Aug 2019 15:21:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 1/4] block: introducing
 'bdrv_co_delete_file' interface
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
Cc: jsnow@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 06.08.2019 um 15:27 hat Daniel Henrique Barboza geschrieben:
> > > diff --git a/block.c b/block.c
> > > index c139540f2b..6e2b0f528d 100644
> > > --- a/block.c
> > > +++ b/block.c
> > > @@ -621,6 +621,17 @@ int get_tmp_filename(char *filename, int size)
> > >   #endif
> > >   }
> > > +/**
> > > + * Helper that checks if a given string represents a regular
> > > + * local file.
> > > + */
> > > +bool bdrv_path_is_regular_file(const char *path)
> > > +{
> > > +    struct stat st;
> > > +
> > > +    return (stat(path, &st) == 0) && S_ISREG(st.st_mode);
> > > +}
> > > +
> > >   /*
> > >    * Detect host devices. By convention, /dev/cdrom[N] is always
> > >    * recognized as a host CDROM.
> > This hunk isn't generic, it belong in file-posix.c
> 
> Patch 3 uses this function as part of the core logic of this fix (do not
> delete the file if the file already existed) inside block/cryptoc. This
> is the reason it is exposed here. I assumed that we do not want a
> public function inside file-posix.c (since there is none - everything
> is done using the BD interfaces).

Hm... This doesn't feel right. crypto can't assume that it's working on
a local file. It's working on some lower level BlockDriverState,
whatever that may be. Remember that you could pass all kind of URLs e.g.
for network protocols like NBD or gluster. You don't want to check
whether a local filename exists then.

In fact, I'm not sure if having a special case for an already existing
file is even worth it: By the time we fail, we'll already have truncated
the file, so the old data is lost anyway. Deleting that empty or
half-initialised file doesn't seem much worse than leaving a broken file
behind.

Kevin

