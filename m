Received: from eggs.gnu.org ([2001:4830:134:3::10]:53242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0o7S-00073D-Bj
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 08:54:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0o7P-0005TL-Be
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 08:54:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47226 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f0o7P-0005Sy-6p
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 08:54:27 -0400
Date: Tue, 27 Mar 2018 20:54:15 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180327125415.GQ17789@xz-mi>
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
	<20180313075739.11194-8-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180313075739.11194-8-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH 7/8] migration: introduce save_normal_page()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org

On Tue, Mar 13, 2018 at 03:57:38PM +0800, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> It directly sends the page to the stream neither checking zero nor
> using xbzrle or compression
> 
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
