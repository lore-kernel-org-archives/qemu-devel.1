Received: from eggs.gnu.org ([2001:4830:134:3::10]:50295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cZLDN-00079u-AK
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 12:30:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cZLDK-0008IW-8X
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 12:30:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cZLDK-0008I1-2H
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 12:30:30 -0500
Date: Thu, 2 Feb 2017 17:30:23 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170202173023.GX2915@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170202171625.28502-1-rjones@redhat.com>
	<20170202171625.28502-2-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170202171625.28502-2-rjones@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] qemu-nbd: Implement socket activation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, den@openvz.org, rkagan@virtuozzo.com, dplotnikov@virtuozzo.com, stefanha@gmail.com

On Thu, Feb 02, 2017 at 05:16:25PM +0000, Richard W.M. Jones wrote:
> Socket activation (sometimes known as systemd socket activation)
> allows an Internet superserver to pass a pre-opened listening socket
> to the process, instead of having qemu-nbd open a socket itself.  This
> is done via the LISTEN_FDS and LISTEN_PID environment variables, and a
> standard file descriptor range.
> 
> This change partially implements socket activation for qemu-nbd.  If
> the environment variables are set correctly, then socket activation
> will happen automatically, otherwise everything works as before.  The
> limitation is that LISTEN_FDS must be 1.
> 
> Signed-off-by: Richard W.M. Jones.
> ---
>  qemu-nbd.c | 172 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 163 insertions(+), 9 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
