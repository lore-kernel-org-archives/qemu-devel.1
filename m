Received: from eggs.gnu.org ([2001:4830:134:3::10]:56483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cageC-0006ak-IZ
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:35:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cage8-0000bR-QG
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:35:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cage8-0000b1-Kw
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 05:35:44 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BDAACC0567A1
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 10:35:44 +0000 (UTC)
Date: Mon, 6 Feb 2017 10:35:39 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170206103538.GE3029@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170204143245.15974-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170204143245.15974-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Makefile: Make "install" depend on
 "trace-events-all"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

On Sat, Feb 04, 2017 at 10:32:45PM +0800, Fam Zheng wrote:
> We install this file to data dir but since 0ab8ed18 it's no longer
> required by any objects during "make". List it explicitly as a depended
> target of install and fix the broken "make install" command.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
