Received: from eggs.gnu.org ([2001:4830:134:3::10]:38851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dSJGv-00054W-S6
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:33:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dSJGr-0005C3-Uj
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:33:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dSJGr-0005Ak-Pi
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:33:21 -0400
Date: Tue, 4 Jul 2017 09:33:16 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170704083316.GC3135@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-4-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1499099693-22903-4-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/22] configure: add --disable-tcg
 configure option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, thuth@redhat.com, anthony.xu@intel.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com, Anthony Liguori <aliguori@us.ibm.com>

On Mon, Jul 03, 2017 at 06:34:34PM +0200, Paolo Bonzini wrote:
> This lets you build without TCG (hardware accelerationor qtest only).  When
> this flag is passed to configure, it will automatically filter out the target
> list to only those that support KVM or Xen or HAX.
> 
> Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
