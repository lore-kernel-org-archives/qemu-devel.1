Received: from eggs.gnu.org ([2001:4830:134:3::10]:52318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e1Ync-0005YB-KK
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:12:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e1Ynb-0000CN-Jh
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:12:52 -0400
Date: Mon, 9 Oct 2017 22:12:36 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171009141236.GC28199@lemon>
References: <20171009125940.24220-1-ashijeetacharya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171009125940.24220-1-ashijeetacharya@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v9 0/8] Optimize VMDK I/O by allocating
 multiple clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: kwolf@redhat.com, jsnow@redhat.com, mreitz@redhat.com, stefanha@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Mon, 10/09 18:29, Ashijeet Acharya wrote:
> Optimization test results:
> 
> This patch series improves 128 KB sequential write performance to an
> empty VMDK file by 54%
> 
> Benchmark command: ./qemu-img bench -w -c 1024 -s 128K -d 1 -t none -f
> vmdk test.vmdk
> 
> Changes in v9:
> - rebase the series

Thanks, looks good to me, applied:

https://github.com/famz/qemu/tree/staging

Fam
