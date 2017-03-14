Received: from eggs.gnu.org ([2001:4830:134:3::10]:54683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cnjch-0005XF-L2
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cnjcg-00075y-JO
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:24:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cnjcg-000743-DA
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:24:10 -0400
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A34DDC05AA4F
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 10:24:09 +0000 (UTC)
Date: Tue, 14 Mar 2017 10:24:05 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170314102405.GB2652@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1489480018-11443-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1489480018-11443-1-git-send-email-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] vnc: fix reverse mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, Mar 14, 2017 at 09:26:58AM +0100, Gerd Hoffmann wrote:
> vnc server in reverse mode (qemu -vnc localhost:$nr,reverse) interprets
> $nr as display number (i.e. with 5900 offset) in recent qemu versions.
> Historical and documented behavior is interpreting $nr as port number
> though. So we should bring code and documentation in line.
> 
> Given that default listening port for viewers is 5500 the 5900 offset is
> pretty inconvinient, because it is simply impossible to connect to port
> 5500.  So, lets fix the code not the docs.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  ui/vnc.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
