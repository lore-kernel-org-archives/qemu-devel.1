Received: from eggs.gnu.org ([2001:4830:134:3::10]:45998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dsSGQ-00086t-5o
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dsSGN-0002fz-0W
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:24:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1dsSGM-0002bc-RE
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:24:54 -0400
Date: Thu, 14 Sep 2017 13:24:43 +0200
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20170914112443.GC24545@vader>
References: <1505385363-27717-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1505385363-27717-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] configure: Allow --enable-seccomp on s390x, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Christian Ehrhardt <christian.ehrhardt@canonical.com>

On Thu, Sep 14, 2017 at 12:36:03PM +0200, Thomas Huth wrote:
> libseccomp supports s390x since version 2.3.0, and I was able to start
> a VM with "-sandbox on" without any obvious problems by using this patch,
> so it should be safe to allow --enable-seccomp on s390x nowadays, too.
> 

I don't have a s390x hardware to test so I'll have to trust you.
Anyone from IBM interested in testing this patch as well?

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index fd7e3a5..83ba64e 100755
> --- a/configure
> +++ b/configure
> @@ -2032,7 +2032,7 @@ if test "$seccomp" != "no" ; then
>      arm|aarch64)
>          libseccomp_minver="2.2.3"
>          ;;
> -    ppc|ppc64)
> +    ppc|ppc64|s390x)
>          libseccomp_minver="2.3.0"
>          ;;
>      *)
> -- 
> 1.8.3.1
> 

-- 
Eduardo Otubo
Senior Software Engineer @ RedHat
