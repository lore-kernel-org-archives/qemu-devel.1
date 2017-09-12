Received: from eggs.gnu.org ([2001:4830:134:3::10]:36388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drnxE-0007fC-P3
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drnxD-0005Si-Ls
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:22:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1drnxD-0005SF-FJ
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:22:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8B203C0587D9
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 16:22:26 +0000 (UTC)
Date: Tue, 12 Sep 2017 17:22:23 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170912162223.GN17633@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170912104626.8386-1-berrange@redhat.com>
	<810971dc-0a17-cf41-c11a-db991a17317a@redhat.com>
	<20170912161252.GM17633@redhat.com>
	<5994d2c2-77b3-6698-c9e0-c737c84caf68@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5994d2c2-77b3-6698-c9e0-c737c84caf68@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scripts: let checkpatch.pl process an
 entire GIT branch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Tue, Sep 12, 2017 at 06:14:57PM +0200, Paolo Bonzini wrote:
> On 12/09/2017 18:12, Daniel P. Berrange wrote:
> > On Tue, Sep 12, 2017 at 05:52:18PM +0200, Paolo Bonzini wrote:
> >> On 12/09/2017 12:46, Daniel P. Berrange wrote:
> >>> Currently before submitting a series, devs should run checkpatch.pl
> >>> across each patch to be submitted. This can be automated using a
> >>> command such as:
> >>>
> >>>   git rebase -i master -x 'git show | ./scripts/checkpatch.pl -'
> >>>
> >>> This is rather long winded to type, so this patch introduces a new
> >>> flag '--branch' to checkpatch.pl which instructs it to check every
> >>> patch on the current GIT branch.
> >>
> >> Great idea, though I'm not sure about having a default.  And to keep it
> >> easy to invoke, having a sole argument that ends with ".." might DWIM
> >> and enable --branch too...
> > 
> > I think it is beneficial to have a default, as I figure the majority
> > of contributors are working on a branch that's rebased against master..
> > Half as many characters to type in the common case :-)
> 
> With the DWIM option "--branch" and "master.." are exactly the same
> length. :)

Oh hang on. I think I misunderstood what you suggested. I thought you
meant  'checkpatch.pl --branch master..', but IIUC you actually mean
'checkpatch.pl master..' with no flag. That would work with me.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
