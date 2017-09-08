Received: from eggs.gnu.org ([2001:4830:134:3::10]:59672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqFdG-0001XR-68
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqFdB-0004bD-Ft
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:31:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dqFdB-0004aj-A9
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:31:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3392E80F79
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 09:31:20 +0000 (UTC)
Date: Fri, 8 Sep 2017 10:31:14 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170908093114.GC3609@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170908091027.9104-1-otubo@redhat.com>
	<20170908091027.9104-2-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170908091027.9104-2-otubo@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv5 1/5] seccomp: changing from whitelist to
 blacklist
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com

On Fri, Sep 08, 2017 at 11:10:23AM +0200, Eduardo Otubo wrote:
> This patch changes the default behavior of the seccomp filter from
> whitelist to blacklist. By default now all system calls are allowed and
> a small black list of definitely forbidden ones was created.
> 
> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> ---
>  include/sysemu/seccomp.h |   2 +
>  qemu-seccomp.c           | 264 ++++++-----------------------------------------
>  vl.c                     |   1 -
>  3 files changed, 35 insertions(+), 232 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
