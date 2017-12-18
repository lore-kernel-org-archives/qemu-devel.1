Received: from eggs.gnu.org ([2001:4830:134:3::10]:51617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eQrn3-0006cy-6E
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:32:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eQrmz-000155-8O
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:32:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eQrmz-00014E-2K
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 04:32:49 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 68BC57F7B0
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:32:47 +0000 (UTC)
Date: Mon, 18 Dec 2017 09:32:41 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171218093241.GB13493@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171218085308.23241-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171218085308.23241-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] io: fix QIONetListener memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Dec 18, 2017 at 09:53:08AM +0100, Paolo Bonzini wrote:
> The sources array does not escape out of qio_net_listener_wait_client, so
> we have to free it.
> 
> Reported by Coverity.
> 
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  io/net-listener.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks, queued.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
