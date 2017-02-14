Received: from eggs.gnu.org ([2001:4830:134:3::10]:36492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cdcBV-0008Vw-Hm
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 07:26:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cdcBR-0001sp-I5
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 07:26:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cdcBR-0001rc-Cc
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 07:26:13 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 81D743E9
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 12:26:13 +0000 (UTC)
Date: Tue, 14 Feb 2017 12:26:07 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170214122607.GD467@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170213135235.12274-1-pbonzini@redhat.com>
	<20170213135235.12274-2-pbonzini@redhat.com>
	<20170214074831.GE6428@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170214074831.GE6428@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH 01/18] block: move AioContext, QEMUTimer,
 main-loop to libqemuutil
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com

On Tue, Feb 14, 2017 at 03:48:31PM +0800, Fam Zheng wrote:
> On Mon, 02/13 14:52, Paolo Bonzini wrote:
> > --- /dev/null
> > +++ b/util/aiocb.c
> > @@ -0,0 +1,55 @@
> > +/*
> > + * BlockAIOCB allocation
> > + *
> > + * Copyright (c) 2003-2017 Fabrice Bellard and the QEMU team
> 
> Hmm, I'm not lawyer, just wondering if the QEMU team is a legal entity that can
> hold copyright? :)

Reword it to say

  "Copyright (c) 2003-2017 Fabrice Bellard and other QEMU contributors"

so it is referring to individual contributors as distinct copyright
holders, as opposed to a single entity called "QEMU team"

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
