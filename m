Received: from eggs.gnu.org ([2001:4830:134:3::10]:43558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gHpBr-0003Ig-4o
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gHpBl-0003kp-Ec
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:01:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gHpBj-0003iK-FL
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 08:01:31 -0400
Date: Wed, 31 Oct 2018 12:00:49 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181031120049.GH9625@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <BN6PR2201MB1251EA1F1F5E486A889A827CC6CC0@BN6PR2201MB1251.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR2201MB1251EA1F1F5E486A889A827CC6CC0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Subject: Re: [Qemu-devel] Question: Perfecting checkpatch.pl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "stefanha@redhat.com" <stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>

On Tue, Oct 30, 2018 at 12:35:15PM +0000, Aleksandar Markovic wrote:
> Perhaps checkpatch.pl should make sure the commit messages do not contain "address@hidden" and "Reviewed-off-by"?
> 
> $ git log | grep address@hidden
>     Signed-off-by: Michael S. Tsirkin <address@hidden>
>     Signed-off-by: Ronald Hecht <address@hidden>
>     Signed-off-by: Justin Chevrier <address@hidden>
>     Signed-off-by: Justin Chevrier <address@hidden>
>     Signed-off-by: Justin Chevrier <address@hidden>

This makes sense...

> 
> $ git log | grep Reviewed-off-by
>     Reviewed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>     Reviewed-off-by: Anthony Liguori <aliguori@us.ibm.com>

but I'm not convinced it is worth doing this, because the set of
mistakes people have made is enourmous, so it turns into a game
of whack-a-mole.

 git log | grep -- '-by:' | sed -e 's/-by:.*/-by/' | sed -e 's/ //g' | sort | uniq -c
   3127 Acked-by
      1 ACKed-by
      1 Acked-off-by
      5 Analyzed-by
      3 Approximately-suggested-by
      3 Co-authored-by
      1 Edited-by
      2 eviewed-by
      1 Fine-with-me'd-by
      1 Fix-suggested-by
      3 Found-by
      1 Inspired-by
      1 Introduced-by
      1 Original-patch-by
      1 Problem-spotted-by
      2 Proposed-by
      2 Rebased-by
      1 Release-acked-by
      1 Reported-and-analyzed-by
      2 Reported-and-tested-by
      1 Reported-and-Tested-by
   1834 Reported-by
      1 Reportyed-by
      7 Requested-by
      2 Reveiwed-by
      1 Revieed-by
      2 Revieved-by
      4 Reviewd-by
  30991 Reviewed-by
      2 Reviewed-off-by
      3 Reviwed-by
      1 Rported-by
      1 Sgined-off-by
      1 Sigend-off-by
      1 Signed-by
      1 Signed-of-by
  97837 Signed-off-by
      1 Signer-off-by
      4 Singed-off-by
      1 Spotted-by
    660 Suggested-by
   1951 Tested-by
      1 Tested-off-by
      1 xSigned-off-by


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
