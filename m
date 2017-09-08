Received: from eggs.gnu.org ([2001:4830:134:3::10]:33554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqFfv-0003vm-Ox
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqFfm-0007EU-H4
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:34:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dqFfm-0007E0-A5
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:34:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 60A335AFC8
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 09:34:01 +0000 (UTC)
Date: Fri, 8 Sep 2017 10:33:56 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170908093356.GG3609@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170908091027.9104-1-otubo@redhat.com>
	<20170908091027.9104-6-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170908091027.9104-6-otubo@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv5 5/5] seccomp: add resourcecontrol
 argument to command line
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

On Fri, Sep 08, 2017 at 11:10:27AM +0200, Eduardo Otubo wrote:
> This patch adds [,resourcecontrol=deny] to `-sandbox on' option. It
> blacklists all process affinity and scheduler priority system calls to
> avoid any bigger of the process.
> 
> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> ---
>  include/sysemu/seccomp.h |  1 +
>  qemu-options.hx          |  9 ++++++---
>  qemu-seccomp.c           | 19 +++++++++++++++++++
>  vl.c                     | 16 ++++++++++++++++
>  4 files changed, 42 insertions(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
