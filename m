Received: from eggs.gnu.org ([2001:4830:134:3::10]:55190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIbUD-0005eW-TV
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIbU6-0004bX-Aj
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:03:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36166 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fIbU6-0004b4-6q
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:03:26 -0400
References: <20180512014801.17566-1-richard.henderson@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cb920ac0-36d2-09c4-e3dc-197f73710868@redhat.com>
Date: Tue, 15 May 2018 10:03:22 -0500
MIME-Version: 1.0
In-Reply-To: <20180512014801.17566-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/virtio: Fix brace Werror with clang
 6.0.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>

On 05/11/2018 08:48 PM, Richard Henderson wrote:
> The warning is
> 
> hw/virtio/vhost-user.c:1319:26: error: suggest braces
>        around initialization of subobject [-Werror,-Wmissing-braces]
>      VhostUserMsg msg = { 0 };
>                           ^
>                           {}
> 
> While the original code is correct, and technically exactly correct
> as per ISO C89, both GCC and Clang support plain empty set of braces

s/C89/C99/ (the guarantee of a universal {0} initializer was only added 
in C99, if I recall correctly)

> as an extension.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/virtio/vhost-user.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

It's annoying that we have to work around clang's bogus warning by 
resorting to an extension.  But such is life.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
