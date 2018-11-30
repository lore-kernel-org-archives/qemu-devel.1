Received: from eggs.gnu.org ([2001:4830:134:3::10]:58239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gSejo-00036N-Ss
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:05:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gSejl-00052M-7i
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:05:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gSeji-0004tn-Vl
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:05:23 -0500
References: <154356772378.66975.13711686652368325931.stgit@bahia.lan>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f814fd63-64a2-a464-7022-2c8f5bac4af6@redhat.com>
Date: Fri, 30 Nov 2018 10:05:07 +0100
MIME-Version: 1.0
In-Reply-To: <154356772378.66975.13711686652368325931.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0] 9p: remove support for the
 "handle" backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org

On 2018-11-30 09:49, Greg Kurz wrote:
> The "handle" fsdev backend was deprecated in QEMU 2.12.0 with:
> 
> commit db3b3c7281ca82e2647e072a1f97db111313dd73
> Author: Greg Kurz <groug@kaod.org>
> Date:   Mon Jan 8 11:18:23 2018 +0100
> 
>     9pfs: deprecate handle backend
> 
>     This backend raise some concerns:
> 
>     - doesn't support symlinks
>     - fails +100 tests in the PJD POSIX file system test suite [1]
>     - requires the QEMU process to run with the CAP_DAC_READ_SEARCH
>       capability, which isn't recommended for security reasons
> 
>     This backend should not be used and wil be removed. The 'local'
>     backend is the recommended alternative.
> 
>     [1] https://www.tuxera.com/community/posix-test-suite/
> 
>     Signed-off-by: Greg Kurz <groug@kaod.org>
>     Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
>     Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> 
> It has passed the two release cooling period without any complaint.
> 
> Remove it now.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> 
> It could have been removed for 3.1.0, but I woke up too late, so moving
> this to 4.0.
> 
> ---
>  fsdev/qemu-fsdev.c    |    3 
>  hw/9pfs/9p-handle.c   |  710 -------------------------------------------------
>  hw/9pfs/Makefile.objs |    1 
>  qemu-deprecated.texi  |    8 -
>  qemu-options.hx       |    8 -
>  5 files changed, 4 insertions(+), 726 deletions(-)
>  delete mode 100644 hw/9pfs/9p-handle.c

Reviewed-by: Thomas Huth <thuth@redhat.com>
