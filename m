Received: from eggs.gnu.org ([2001:4830:134:3::10]:34150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gB2e2-0000h3-MR
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:58:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gB2dy-0003ky-78
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:58:42 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:48815)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gB2dx-0003gG-82
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 14:58:38 -0400
References: <20181009074559.1041-1-likan_999.student@sina.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <948862dc-f261-b51b-9ffb-1afb3f95f0f9@vivier.eu>
Date: Fri, 12 Oct 2018 20:58:27 +0200
MIME-Version: 1.0
In-Reply-To: <20181009074559.1041-1-likan_999.student@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Fix crashes in
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

On 09/10/2018 09:45, Kan Li wrote:
> Summary:
> This is to fix bug https://bugs.launchpad.net/qemu/+bug/1796754.
> It is valid for ifc_buf to be NULL according to
> http://man7.org/linux/man-pages/man7/netdevice.7.html.
> 
> Signed-off-by: Kan Li <likan_999.student@sina.com>
> ---
>  linux-user/syscall.c | 56 ++++++++++++++++++++++++--------------------
>  1 file changed, 31 insertions(+), 25 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
