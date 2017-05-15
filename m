Received: from eggs.gnu.org ([2001:4830:134:3::10]:40790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dA7NT-0000wS-1I
	for qemu-devel@nongnu.org; Mon, 15 May 2017 00:12:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dA7NP-0006y8-U6
	for qemu-devel@nongnu.org; Mon, 15 May 2017 00:12:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dA7NP-0006xA-Nl
	for qemu-devel@nongnu.org; Mon, 15 May 2017 00:12:55 -0400
References: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1494553288-30764-12-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <037d77db-9ba1-bd06-8789-9759400ae57b@redhat.com>
Date: Mon, 15 May 2017 12:12:49 +0800
MIME-Version: 1.0
In-Reply-To: <1494553288-30764-12-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V4 11/12] net/filter-rewriter.c: Add new
 option to enable vnet support for filter-rewriter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, weifuqiang <weifuqiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>



On 2017=E5=B9=B405=E6=9C=8812=E6=97=A5 09:41, Zhang Chen wrote:
> We add the vnet_hdr option for filter-rewriter, default is disable.
> If you use virtio-net-pci net driver, please enable it.
> You can use it for example:
> -object filter-rewriter,id=3Drew0,netdev=3Dhn0,queue=3Dall,vnet_hdr=3Do=
n
>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

As has been pointed out, let's squash this into patch 12.

Thanks
