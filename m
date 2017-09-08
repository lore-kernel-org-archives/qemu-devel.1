Received: from eggs.gnu.org ([2001:4830:134:3::10]:33223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqFfJ-0003Oa-Ln
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqFfD-0006do-O3
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:33:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dqFfD-0006cp-IG
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:33:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 997EA85545
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 09:33:26 +0000 (UTC)
Date: Fri, 8 Sep 2017 10:33:21 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170908093321.GF3609@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170908091027.9104-1-otubo@redhat.com>
	<20170908091027.9104-5-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170908091027.9104-5-otubo@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv5 4/5] seccomp: add spawn argument to
 command line
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

On Fri, Sep 08, 2017 at 11:10:26AM +0200, Eduardo Otubo wrote:
> This patch adds [,spawn=deny] argument to `-sandbox on' option. It
> blacklists fork and execve system calls, avoiding Qemu to spawn new
> threads or processes.
> 
> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> ---
>  include/sysemu/seccomp.h |  1 +
>  qemu-options.hx          |  9 +++++++--
>  qemu-seccomp.c           | 12 ++++++++++++
>  vl.c                     | 16 ++++++++++++++++
>  4 files changed, 36 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
