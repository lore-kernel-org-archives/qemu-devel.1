Received: from eggs.gnu.org ([2001:4830:134:3::10]:44187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e4Boa-0004EA-EJ
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e4BoW-0008Q2-44
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:16:44 -0400
References: <20170929120339.14197-1-otubo@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <a58fe8e6-65ef-a8e0-19ff-6234c65f32a7@msgid.tls.msk.ru>
Date: Mon, 16 Oct 2017 23:16:34 +0300
MIME-Version: 1.0
In-Reply-To: <20170929120339.14197-1-otubo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv2] filter-mirror: segfault when specifying
 non existent device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, lizhijian@cn.fujitsu.com, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

29.09.2017 15:03, Eduardo Otubo wrote:
> v2:
>     Removed "err:" label from the end of the function and replaced by
>     two separate error messages. One when outdev is not specified and
>     one when outdev does not exist.
> 
>     Fixed the error message that was referencing nf->netdev_id and not
>     s->outdev.
> 
> When using filter-mirror like the example below where the interface
> 'ndev0' does not exist on the host, QEMU crashes into segmentation
> fault.
> 
>  $ qemu-system-x86_64 -S -machine pc -netdev user,id=ndev0 -object filter-mirror,id=test-object,netdev=ndev0
> 
> This happens because the function filter_mirror_setup() does not checks
> if the device actually exists and still keep on processing calling
> qemu_chr_find(). This patch fixes this issue.

Applied to -trivial, with a tiny fix in the commit message (checkS).

Thanks!

/mjt
