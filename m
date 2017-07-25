Received: from eggs.gnu.org ([2001:4830:134:3::10]:55048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dZvKB-0007KE-Sd
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dZvK8-00035Z-Qf
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:36:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dZvK8-00034n-K6
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:36:12 -0400
Date: Tue, 25 Jul 2017 09:36:03 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170725083603.GC26394@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170724181544.20292-1-brandon.carpenter@cypherpath.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170724181544.20292-1-brandon.carpenter@cypherpath.com>
Subject: Re: [Qemu-devel] [PATCH] io: Always remove an old channel watch
 before adding a new one.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com

On Mon, Jul 24, 2017 at 11:15:44AM -0700, Brandon Carpenter wrote:
> Also set saved handle to zero when removing without adding a new watch.
> 
> Signed-off-by: Brandon Carpenter <brandon.carpenter@cypherpath.com>
> ---
>  ui/vnc-auth-vencrypt.c | 3 +++
>  ui/vnc-ws.c            | 6 ++++++
>  ui/vnc.c               | 4 ++++
>  3 files changed, 13 insertions(+)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
