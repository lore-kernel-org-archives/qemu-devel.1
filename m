Received: from eggs.gnu.org ([2001:4830:134:3::10]:33351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e5U0m-0003D7-Rc
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 05:54:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e5U0i-0006Wd-U6
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 05:54:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e5U0i-0006WI-NH
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 05:54:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B6AB680F6D
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 09:54:35 +0000 (UTC)
Date: Fri, 20 Oct 2017 10:54:31 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171020095431.GG21172@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171020092844.13880-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171020092844.13880-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] sockets: avoid leak of listen file
 descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

On Fri, Oct 20, 2017 at 10:28:44AM +0100, Daniel P. Berrange wrote:
> If we iterate over the full port range without successfully binding+listening
> on the socket, we'll try the next address, whereupon we overwrite the slisten
> file descriptor variable without closing it.
> 
> Rather than having two places where we open + close socket FDs on different
> iterations of nested for loops, re-arrange the code to always open+close
> within the same loop iteration.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  util/qemu-sockets.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)

Self-NACK this has a bug too


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
