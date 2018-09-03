Received: from eggs.gnu.org ([2001:4830:134:3::10]:37437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fwseb-00084s-40
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 13:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fwseY-00032z-1l
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 13:28:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43516 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fwseX-00032m-Th
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 13:28:41 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180903092644.25812-5-xiaoguangrong@tencent.com> (guangrong
	xiao's message of "Mon, 3 Sep 2018 17:26:44 +0800")
References: <20180903092644.25812-1-xiaoguangrong@tencent.com>
	<20180903092644.25812-5-xiaoguangrong@tencent.com>
Reply-To: quintela@redhat.com
Date: Mon, 03 Sep 2018 19:28:34 +0200
Message-ID: <87wos21oe5.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 4/4] migration: handle the error
 condition properly
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
> ram_find_and_save_block() can return negative if any error hanppens,
> however, it is completely ignored in current code
>
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Good catch.
