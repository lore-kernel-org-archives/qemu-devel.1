Received: from eggs.gnu.org ([2001:4830:134:3::10]:36519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSl5k-00065X-59
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:52:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSl5g-0005yM-Gc
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:52:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gSl5c-0005vf-Iu
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:52:26 -0500
References: <154356772378.66975.13711686652368325931.stgit@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cf3f805a-4991-04d6-2cbb-6c1cca8bd238@redhat.com>
Date: Fri, 30 Nov 2018 09:52:18 -0600
MIME-Version: 1.0
In-Reply-To: <154356772378.66975.13711686652368325931.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1?] 9p: remove support for the
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
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 11/30/18 2:49 AM, Greg Kurz wrote:
> The "handle" fsdev backend was deprecated in QEMU 2.12.0 with:
> 
> commit db3b3c7281ca82e2647e072a1f97db111313dd73
> Author: Greg Kurz <groug@kaod.org>
> Date:   Mon Jan 8 11:18:23 2018 +0100
> 
>      9pfs: deprecate handle backend

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
>   fsdev/qemu-fsdev.c    |    3
>   hw/9pfs/9p-handle.c   |  710 -------------------------------------------------
>   hw/9pfs/Makefile.objs |    1
>   qemu-deprecated.texi  |    8 -
>   qemu-options.hx       |    8 -
>   5 files changed, 4 insertions(+), 726 deletions(-)
>   delete mode 100644 hw/9pfs/9p-handle.c

Well, it certainly doesn't drive -rc4 on its own, but as we may have an 
-rc4 for other reasons, maybe it could still be argued that this is 3.1 
material on the grounds of removing questionable code for less attack 
exposure?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
