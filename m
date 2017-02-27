Received: from eggs.gnu.org ([2001:4830:134:3::10]:47755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ciHZ3-0001wT-FE
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 04:25:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ciHYz-0004y0-SC
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 04:25:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ciHYz-0004xl-MG
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 04:25:49 -0500
Date: Mon, 27 Feb 2017 09:25:42 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170227092542.GB18219@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170224172714.26026-1-berrange@redhat.com>
	<148795758490.177.4813793419465218571@0e2666bad730>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <148795758490.177.4813793419465218571@0e2666bad730>
Subject: Re: [Qemu-devel] [PATCH] os: don't corrupt pre-existing
 memory-backend data with prealloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, jitendra.kolhe@hpe.com, mprivozn@redhat.com, stefanha@redhat.com, pbonzini@redhat.com

On Fri, Feb 24, 2017 at 09:33:05AM -0800, no-reply@patchew.org wrote:
> === OUTPUT BEGIN ===
> Checking PATCH 1/1: os: don't corrupt pre-existing memory-backend data with prealloc...
> ERROR: Use of volatile is usually wrong: see Documentation/volatile-considered-harmful.txt

ERROR: checkpatch.pl is usually wrong ;-P

Heh, it is refering to a doc in the kernel source tree, which does not even
exist at that path location anymore :-)


> #42: FILE: util/oslib-posix.c:370:
> +            volatile char val = *(area + (hpagesize * i));
> 
> total: 1 errors, 0 warnings, 21 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> === OUTPUT END ===

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
