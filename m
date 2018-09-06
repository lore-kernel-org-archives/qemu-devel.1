Received: from eggs.gnu.org ([2001:4830:134:3::10]:57837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fxqvg-0000je-IA
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 05:50:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fxqvd-0004Dw-Bd
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 05:50:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57722 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fxqvb-0003yM-8V
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 05:50:20 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180906070101.27280-4-xiaoguangrong@tencent.com> (guangrong
	xiao's message of "Thu, 6 Sep 2018 15:01:01 +0800")
References: <20180906070101.27280-1-xiaoguangrong@tencent.com>
	<20180906070101.27280-4-xiaoguangrong@tencent.com>
Reply-To: quintela@redhat.com
Date: Thu, 06 Sep 2018 11:49:53 +0200
Message-ID: <87o9db3qgu.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 3/3] migration: use
 save_page_use_compression in flush_compressed_data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>
> It avoids to touch compression locks if xbzrle and compression
> are both enabled
>
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
