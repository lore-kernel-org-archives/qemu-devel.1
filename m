Received: from eggs.gnu.org ([2001:4830:134:3::10]:49249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fIYCT-0000l7-NL
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:33:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fIYCI-0002Nt-0R
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:33:01 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:55799)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fIYCH-0002LM-4M
	for qemu-devel@nongnu.org; Tue, 15 May 2018 07:32:49 -0400
References: <1526383058-49501-1-git-send-email-imammedo@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <7dd6b2d6-73f8-706e-9083-884ce478d784@vivier.eu>
Date: Tue, 15 May 2018 13:32:33 +0200
MIME-Version: 1.0
In-Reply-To: <1526383058-49501-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: update comments to point to
 cpu_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi

Le 15/05/2018 à 13:17, Igor Mammedov a écrit :
> cpu_init() was replaced by cpu_create() since 2.12 but comments
> weren't updated. So update stale comments now.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  bsd-user/main.c   | 2 +-
>  linux-user/main.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index 283dc6f..a6ef4a7 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -917,7 +917,7 @@ int main(int argc, char **argv)
>      envlist_free(envlist);
>  
>      /*
> -     * Now that page sizes are configured in cpu_init() we can do
> +     * Now that page sizes are configured in cpu_create() we can do
>       * proper page alignment for guest_base.
>       */
>      guest_base = HOST_PAGE_ALIGN(guest_base);
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 3234754..27d0b37 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -693,7 +693,7 @@ int main(int argc, char **argv, char **envp)
>      envlist_free(envlist);
>  
>      /*
> -     * Now that page sizes are configured in cpu_init() we can do
> +     * Now that page sizes are configured in cpu_create() we can do
>       * proper page alignment for guest_base.
>       */
>      guest_base = HOST_PAGE_ALIGN(guest_base);
> 

I think page size is now configured in tcg_exec_init() since:

  commit 26a5f13b8eb1281d0552fe323e869806f3cefbfb
  Author: bellard <bellard@c046a42c-6fe2-441c-8c8c-71466251a162>
  Date:   Wed May 28 12:30:31 2008 +0000

      variable dynamic translation buffer size

Strangely comment has been added after this change by:

  commit 379f6698d73f476de38682b3ff96ecb226728c43
  Author: Paul Brook <paul@codesourcery.com>
  Date:   Fri Jul 17 12:48:08 2009 +0100

    Userspace guest address offsetting


Thanks,
Laurent
