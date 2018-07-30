Received: from eggs.gnu.org ([2001:4830:134:3::10]:52415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fkAHw-0001Ng-BW
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:40:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fkAHv-00069F-FF
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:40:48 -0400
References: <20180729212744.23709-1-lbloch@janustech.com>
	<20180729212744.23709-2-lbloch@janustech.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ceb7a6e9-1dc2-b5f5-c81e-ba08841c8ba9@redhat.com>
Date: Mon, 30 Jul 2018 10:40:41 -0500
MIME-Version: 1.0
In-Reply-To: <20180729212744.23709-2-lbloch@janustech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/6 for-3.0] Update .gitignore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 07/29/2018 04:27 PM, Leonid Bloch wrote:
> Adds /roms/vgabios to .gitignore - this directory appears after the
> build, and was not ignored by Git so far.
> 

Actually, that's the directories for one of the submodules. It seems 
fishy to have a directory listed in both .gitignore and .gitmodules at 
the same time, so I'm inclined to NACK this patch, and instead figure 
out what in the build is dirtying the directory when the submodule is 
not checked out.

> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
> ---
>   .gitignore | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/.gitignore b/.gitignore
> index 5668d02782..2b3b30ae9f 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -212,3 +212,4 @@ trace-dtrace-root.dtrace
>   trace-ust-all.h
>   trace-ust-all.c
>   /target/arm/decode-sve.inc.c
> +/roms/vgabios
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
