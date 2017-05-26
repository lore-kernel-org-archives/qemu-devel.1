Received: from eggs.gnu.org ([2001:4830:134:3::10]:49068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dEBfj-0002nd-2e
	for qemu-devel@nongnu.org; Fri, 26 May 2017 05:36:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dEBfi-00029h-3l
	for qemu-devel@nongnu.org; Fri, 26 May 2017 05:36:39 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:41588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dEBfh-00029Z-TP
	for qemu-devel@nongnu.org; Fri, 26 May 2017 05:36:38 -0400
Date: Fri, 26 May 2017 11:36:33 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170526093633.7jtkyxovg4fsoece@aurel32.net>
References: <1495704132-5675-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1495704132-5675-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] target/s390x/cpu_models: Allow some
 additional feature bits for the "qemu" CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

On 2017-05-25 11:22, Thomas Huth wrote:
> Currently we only present the plain z900 feature bits to the guest,
> but QEMU already emulates some additional features (but not all of
> the next CPU generation, so we can not use the next CPU level as
> default yet). Since newer Linux kernels are checking the feature bits
> and refuse to work if a required feature is missing, it would be nice
> to have a way to present more of the supported features when we are
> running with the "qemu" CPU.
> This patch now adds the supported features to the "full_feat" bitmap,
> so that additional features can be enabled on the command line now,
> for example with:
> 
>  qemu-system-s390x -cpu qemu,stfle=true,ldisp=true,eimm=true,stckf=true
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Mark feats array with "static const"
> 
>  target/s390x/cpu_models.c | 34 +++++++++++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
