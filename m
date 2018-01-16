Received: from eggs.gnu.org ([2001:4830:134:3::10]:60801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebNu4-0005nk-Ib
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 04:51:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ebNu1-0005Ac-Fl
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 04:51:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ebNu1-0005AD-9B
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 04:51:33 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1940276532
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 09:51:32 +0000 (UTC)
Date: Tue, 16 Jan 2018 09:51:23 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180116095123.GE1521@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20180115114841.GH8218@redhat.com>
	<20180115132636.33905fde.cohuck@redhat.com>
	<CAK1Eb9=c08yNKiNysQp6nprcMKDhRF2FH-pCe278gJEQSzP-KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK1Eb9=c08yNKiNysQp6nprcMKDhRF2FH-pCe278gJEQSzP-KQ@mail.gmail.com>
Subject: Re: [Qemu-devel] RFE for patchew docker result reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <fzheng@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, famz@redhat.com

On Tue, Jan 16, 2018 at 10:16:28AM +0800, Fam Zheng wrote:
> On Mon, Jan 15, 2018 at 8:26 PM, Cornelia Huck <cohuck@redhat.com> wrote:
> > On Mon, 15 Jan 2018 11:48:41 +0000
> > "Daniel P. Berrange" <berrange@redhat.com> wrote:
> >
> >> Currently if I look at the patchew website for build logs, the 'docker'
> >> job results are listed as a single expandable item.
> >>
> >> Patchew runs 3 separate docker builds, however, and there's a tonne of
> >> output to scroll through to find which one actually failed.
> >>
> >> Thus, my RFE is to split the build log up so that instead of a single
> >> "docker" result, it shows  "docker quick", "docker biuld" and
> >> "docker mingw" as separate build logs / results. This would make it
> >> easier to see at a glance which scenario failed.
> >
> > +1. Splitting the output into smaller units makes sense to me.
> 
> Made the proposed change on patchew.org. Thanks.

That's great, thanks for figuring this out so quickly !

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
