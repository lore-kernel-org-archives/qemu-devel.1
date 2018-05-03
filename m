Received: from eggs.gnu.org ([2001:4830:134:3::10]:43541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEKZg-0004Cj-Vf
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEKZd-0004Dr-JQ
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:11:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42848 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fEKZd-0004DL-Ew
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:11:29 -0400
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-40-git-send-email-mst@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4a2fe843-7773-3c5a-a2dd-443225c054e1@redhat.com>
Date: Thu, 3 May 2018 15:11:26 -0500
MIME-Version: 1.0
In-Reply-To: <1525376963-79623-40-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 39/67] target: replace command line flags
 with preprocessor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org

On 05/03/2018 02:51 PM, Michael S. Tsirkin wrote:
> Each target is currently built with a different set of include
> directories, this is what makes it possible to pull in a separate copy
> of header files depending on the target.
> 
> Replace with per-target ifdefs which are easier to understand.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   include/target-dir.h | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 63 insertions(+)
>   create mode 100644 include/target-dir.h

Ah, now we get to the file mentioned in a couple of previous patches.

> +#ifndef QEMU_TARGET_DIR_H
> +#define QEMU_TARGET_DIR_H
> +
> +#if defined(TARGET_ALPHA)
> +#define TARGET_DIR_PREFIX ../target/alpha
> +#elif defined(TARGET_ARM)
> +#define TARGET_DIR_PREFIX ../target/arm

> +#elif defined(TARGET_XTENSA)
> +#define TARGET_DIR_PREFIX ../target/xtensa
> +#else
> +#error "Target-specific directory include missing"
> +#endif
> +
> +#define TARGET_DIR_HASH(file) #file
> +#define TARGET_DIR_STRING(file) TARGET_DIR_HASH(file)
> +#define TARGET_DIR(file) TARGET_DIR_STRING(TARGET_DIR_PREFIX/file)

Cool trick!  It seems pretty reasonable to me.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
