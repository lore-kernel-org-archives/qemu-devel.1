Received: from eggs.gnu.org ([2001:4830:134:3::10]:34949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gFQKa-0008PN-Jb
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 17:04:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gFQKV-0004ZS-Sp
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 17:04:44 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:42131)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gFQKS-0004Ri-I9
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 17:04:37 -0400
References: <20181024201303.114-1-likan_999.student@sina.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <0ad53de4-6910-240a-4732-82bf2dc94aec@vivier.eu>
Date: Wed, 24 Oct 2018 22:03:47 +0100
MIME-Version: 1.0
In-Reply-To: <20181024201303.114-1-likan_999.student@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] Fix linux-user crashes in
 ioctl(SIOCGIFCONF) when ifc_buf is NULL.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kan Li <likan_999.student@sina.com>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

On 24/10/2018 21:13, Kan Li wrote:
> Summary:
> This is to fix bug https://bugs.launchpad.net/qemu/+bug/1796754.
> It is valid for ifc_buf to be NULL according to
> http://man7.org/linux/man-pages/man7/netdevice.7.html.
> 
> Signed-off-by: Kan Li <likan_999.student@sina.com>
> ---
>  linux-user/syscall.c | 55 ++++++++++++++++++++++++++++------------------------
>  1 file changed, 30 insertions(+), 25 deletions(-)
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
