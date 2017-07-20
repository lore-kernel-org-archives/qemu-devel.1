Received: from eggs.gnu.org ([2001:4830:134:3::10]:53459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dYGpF-000628-ED
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1dYGpA-0005sL-CN
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:09:29 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1dYGpA-0005qx-51
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:09:24 -0400
Received: by mail-wm0-f49.google.com with SMTP id w191so35101799wmw.1
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 12:09:19 -0700 (PDT)
Date: Thu, 20 Jul 2017 21:09:15 +0200
From: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Message-ID: <20170720210915.54fa7659@fiorina>
In-Reply-To: <1500452149-9520-1-git-send-email-lu.zhipeng@zte.com.cn>
References: <1500452149-9520-1-git-send-email-lu.zhipeng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qga: Add support network interface
 statistics in guest-network-get-interfaces command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
Cc: mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org

On Wed, 19 Jul 2017 16:15:49 +0800
ZhiPeng Lu <lu.zhipeng@zte.com.cn> wrote:

> we can get the network interface statistics inside a virtual machine by
> guest-network-get-interfaces command. it is very useful for us to monitor
> and analyze network traffic.
> 
> Signed-off-by: ZhiPeng Lu <lu.zhipeng@zte.com.cn>
> ---
>  qga/commands-posix.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++-

It seems we should be able to get some (if not all) the stats also for
Windows with GetIfTable2() or GetIfEntry2() functions. Do you think you
would be able to include also the Windows alternative?

Thanks,

    Tomas

>  qga/qapi-schema.json | 38 ++++++++++++++++++++++++++-
>  2 files changed, 108 insertions(+), 2 deletions(-)
> 
