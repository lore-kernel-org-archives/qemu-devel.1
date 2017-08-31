Received: from eggs.gnu.org ([2001:4830:134:3::10]:35205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dnO46-0000Yl-2i
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:55:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dnO42-0000jA-Ui
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:55:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dnO42-0000ir-Nt
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:55:14 -0400
Date: Thu, 31 Aug 2017 11:13:22 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170831101322.GL13619@stefanha-x1.localdomain>
References: <1503991359-3353-1-git-send-email-wang.yong155@zte.com.cn>
	<1503991359-3353-2-git-send-email-wang.yong155@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1503991359-3353-2-git-send-email-wang.yong155@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCHv5 01/03] qemu-iothread: IOThread supports
 the GMainContext event loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wang yong <wang.yong155@zte.com.cn>
Cc: pbonzini@redhat.com, famz@redhat.com, jasowang@redhat.com, zhangchen.fnst@cn.fujitsu.com, zhang.zhanghailiang@huawei.com, wang.guang55@zte.com.cn, lizhijian@cn.fujitsu.com, qemu-devel@nongnu.org

On Tue, Aug 29, 2017 at 03:22:37PM +0800, Wang yong wrote:
> From: Wang Yong <wang.yong155@zte.com.cn>
> 
> IOThread uses AioContext event loop and does not run a GMainContext.
> Therefore,chardev cannot work in IOThread,such as the chardev is
> used for colo-compare packets reception.
> 
> This patch makes the IOThread run the GMainContext event loop,
> chardev and IOThread can work together.
> 
> Signed-off-by: Wang Yong <wang.yong155@zte.com.cn>
> Signed-off-by: Wang Guang <wang.guang55@zte.com.cn>
> ---
>  include/sysemu/iothread.h |  4 ++++
>  iothread.c                | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
