Received: from eggs.gnu.org ([2001:4830:134:3::10]:60002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dA6Sl-0004Zy-PI
	for qemu-devel@nongnu.org; Sun, 14 May 2017 23:14:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dA6Si-0002WP-Jw
	for qemu-devel@nongnu.org; Sun, 14 May 2017 23:14:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dA6Si-0002Uw-Dq
	for qemu-devel@nongnu.org; Sun, 14 May 2017 23:14:20 -0400
References: <1494552955-30529-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fc95d874-9492-68ec-f613-59940d1f4a94@redhat.com>
Date: Mon, 15 May 2017 11:14:11 +0800
MIME-Version: 1.0
In-Reply-To: <1494552955-30529-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] Optimize filter-mirror and
 filter-rewriter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>



On 2017=E5=B9=B405=E6=9C=8812=E6=97=A5 09:35, Zhang Chen wrote:
> Fix some duplicate codes and remove unused codes.
>
> Zhang Chen (3):
>    net/filter-mirror.c: Remove duplicate check code.
>    net/filter-mirror.c: Rename filter_mirror_send() and fix codestyle
>    net/filter-rewriter: Remove unused option in filter-rewirter
>
>   net/filter-mirror.c | 35 ++++++++++++++++-------------------
>   qemu-options.hx     |  3 ++-
>   2 files changed, 18 insertions(+), 20 deletions(-)
>

Looks good to me, just need to address Eric's comment on patch 3.

Thanks
