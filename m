Received: from eggs.gnu.org ([2001:4830:134:3::10]:60939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dniG2-00074O-0O
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 05:29:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dniFx-0003De-3r
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 05:28:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dniFw-0003DN-Sy
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 05:28:53 -0400
Date: Fri, 1 Sep 2017 10:28:45 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170901092845.GF31680@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1504250391-6353-1-git-send-email-thuth@redhat.com>
	<150425055972.204.8095890686679875127@b5667b65043c>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <150425055972.204.8095890686679875127@b5667b65043c>
Subject: Re: [Qemu-devel] [qemu-web PATCH] Add a blog post about the release
 of version 2.10.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, pbonzini@redhat.com, famz@redhat.com, mdroth@linux.vnet.ibm.com

On Fri, Sep 01, 2017 at 12:22:41AM -0700, no-reply@patchew.org wrote:
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Message-id: 1504250391-6353-1-git-send-email-thuth@redhat.com
> Subject: [Qemu-devel] [qemu-web PATCH] Add a blog post about the release of version 2.10.0
> Type: series
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> 
> BASE=base
> n=1
> total=$(git log --oneline $BASE.. | wc -l)
> failed=0
> 
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> 
> commits="$(git log --format=%H --reverse $BASE..)"
> for c in $commits; do
>     echo "Checking PATCH $n/$total: $(git log -n 1 --format=%s $c)..."
>     if ! git show $c --format=email | ./scripts/checkpatch.pl --mailback -; then
>         failed=1
>         echo
>     fi
>     n=$((n+1))
> done
> 
> exit $failed
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  * [new tag]               patchew/1504250391-6353-1-git-send-email-thuth@redhat.com -> patchew/1504250391-6353-1-git-send-email-thuth@redhat.com
> Switched to a new branch 'test'
> b70b83ae5d Add a blog post about the release of version 2.10.0
> 
> === OUTPUT BEGIN ===
> Checking PATCH 1/1: Add a blog post about the release of version 2.10.0...
> ERROR: trailing whitespace
> #60: FILE: _posts/2017-09-01-qemu-2-10-0.md:43:
> + * s390: support for z14 CPU models and netboot/TFTP via CCW BIOS, $
> 
> total: 1 errors, 0 warnings, 56 lines checked


While it is nice that it identified the trailing whitespace in this
case, does it really make sense for the patchew to be running the
checkpatch.pl from qemu.git, against patches to qemu-web.git ?

Perhaps it should skip patches with 'web' or 'qemu-web' in the
[...]  part of the subject ?

And/or have a dedicated patch checker for the web contnt that
ran appropriate tests ?


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
