Received: from eggs.gnu.org ([2001:4830:134:3::10]:60152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dSN8k-0003pY-15
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:41:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dSN8h-0003Xd-0M
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:41:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dSN8g-0003WC-QV
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 08:41:10 -0400
Date: Tue, 4 Jul 2017 13:41:04 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170704124104.GN3135@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1499166735-39360-1-git-send-email-pbonzini@redhat.com>
	<1499166735-39360-3-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1499166735-39360-3-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/22] configure: early test for supported
 targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, thuth@redhat.com, anthony.xu@intel.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

On Tue, Jul 04, 2017 at 01:11:55PM +0200, Paolo Bonzini wrote:
> Check for unsupported targets in target_list, and print an
> error early in the configuration process.
> 
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> 	v2: place ;; on a separate line [Daniel]
> 
>  configure | 70 +++++++++++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 48 insertions(+), 22 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
