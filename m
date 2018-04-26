Received: from eggs.gnu.org ([2001:4830:134:3::10]:41813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fBb2E-0006yi-2Q
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 03:09:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fBb2A-0000nG-6k
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 03:09:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59754 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fBb2A-0000n2-0v
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 03:09:38 -0400
Date: Thu, 26 Apr 2018 08:09:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180426070925.GA26812@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <AFF77CBF-01EC-494F-AA9C-9820F368EA32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AFF77CBF-01EC-494F-AA9C-9820F368EA32@gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Large patch set advice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org

On Wed, Apr 25, 2018 at 01:57:01PM -0600, Warner Losh wrote:
> Every Open Source project has its own quirks. Nobody wants the 520 comm=
its
> on the branch that I started with (too many merged rather than rebases =
in
> the last 5 years). The 320 real commits are a mess. I=E2=80=99ve been p=
reening them
> to get rid of the silly stuff like (back this out, put it back, all the
> =E2=80=98spelling/typo/white space=E2=80=99 fixes). At the end of the r=
ebase, I still
> wasn=E2=80=99t to =E2=80=98the same=E2=80=99 so I had a bunch of =E2=80=
=98true up=E2=80=99 commits to make it the
> same...

> My first question seems almost rhetorical: that=E2=80=99s not an accept=
able state
> of affairs, and curation is needed to upstream. Right?

Yeah, no one is going to want to review 300 patches !

> (4) Deal with the cases where multiple people have worked on a patch by
> putting SoBs for all of them (or reworking them if I can=E2=80=99t get =
a hold
> of the original authors) on the commits that are merged. I didn=E2=80=99=
t see
> a specific policy for this, but this seems sane. The alternative seems
> worse (having elements that don=E2=80=99t compile)

The signed off by line is attesting that you agree to this:

   http://developercertificate.org/

IIUC nothing there requires you to add a SoB line for each author,
but you have to be confident that you can agree to terms a) & b),
given the the work you are building on top of.


> (5) Send them in small batches. I=E2=80=99d go insane trying to manage
> 200 concurrent code reviews, and I can=E2=80=99t image that I=E2=80=99m=
 unique
> in this. I also image that fixes in the early part of the series
> may have ripples to the later parts if my past experience with
> these things has any relevance.

Can't  disagree with that !

> Thanks for any help you can give me.

IIUC, the current bsd-user code in GIT is completely broken & unusable.
After all 500 patches have been applied, I'm wondering how much of
the original code is actually left ? If it is a very small percentage,
an alternative strategy might be to send a patch deleting everything
in tree, and then treat your code as if you were adding bsd-user as a
brand new feature. This could potentially let you merge & restructure
the patches into a smaller more easily reviewable set of work.=20


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
