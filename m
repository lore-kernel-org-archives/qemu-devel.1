Received: from eggs.gnu.org ([2001:4830:134:3::10]:53020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ds2gF-0007XT-Qt
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 04:05:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ds2gC-0006wE-D7
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 04:05:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ds2gC-0006vU-32
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 04:05:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0844F356CD
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 08:05:51 +0000 (UTC)
Date: Wed, 13 Sep 2017 09:05:47 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170913080547.GA3067@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170912165139.16212-1-berrange@redhat.com>
	<1a39aeeb-1362-4fdb-4bee-b11a258954f5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1a39aeeb-1362-4fdb-4bee-b11a258954f5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] scripts: let checkpatch.pl process an
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

On Tue, Sep 12, 2017 at 07:11:34PM +0200, Paolo Bonzini wrote:
> On 12/09/2017 18:51, Daniel P. Berrange wrote:
> > Currently before submitting a series, devs should run checkpatch.pl
> > across each patch to be submitted. This can be automated using a
> > command such as:
> > 
> >   git rebase -i master -x 'git show | ./scripts/checkpatch.pl -'
> > 
> > This is rather long winded to type, so this patch introduces a way
> > to tell checkpatch.pl to validate a series of GIT revisions.
> > 
> > If checkpatch.pl is given a single argument that contains a literal
> > '..', this is interpreted as a GIT revision list.
> > 
> > For example:
> > 
> >     $ ./scripts/checkpatch.pl master..
> >     total: 0 errors, 0 warnings, 297 lines checked
> > 
> >     b886d352a2bf58f0996471fb3991a138373a2957 has no obvious style problems and is ready for submission.
> >     total: 0 errors, 0 warnings, 182 lines checked
> > 
> >     2a731f9a9ce145e0e0df6d42dd2a3ce4dfc543fa has no obvious style problems and is ready for submission.
> >     total: 0 errors, 0 warnings, 102 lines checked
> > 
> >     11844169bcc0c8ed4449eb3744a69877ed329dd7 has no obvious style problems and is ready for submission.
> > 
> > If a genuine patch filename contains the characters '..' it is
> > possible to force interpretation of the arg as a patch
> > 
> >   $ ./scripts/checkpatch.pl --patch master..
> > 
> > will force it to load a patch file called "master.."
> 
> Looks good, but why no --branch anymore? :)  (I can also try adding it
> back on top).

It felt redundant to me. I guess it could be used to force interpretation
of the arg as a git revlist, even if it lacks '..' ?


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
