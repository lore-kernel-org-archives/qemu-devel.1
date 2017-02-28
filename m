Received: from eggs.gnu.org ([2001:4830:134:3::10]:54522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ciZxB-0003eW-Gs
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 00:04:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ciZx6-00071R-KM
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 00:04:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ciZx6-000714-FK
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 00:03:56 -0500
References: <1488254059-22716-1-git-send-email-zhang.zhanghailiang@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <39fc4efe-08c4-efff-38ca-56f8ba9106b8@redhat.com>
Date: Tue, 28 Feb 2017 13:03:49 +0800
MIME-Version: 1.0
In-Reply-To: <1488254059-22716-1-git-send-email-zhang.zhanghailiang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/2] filter-rewriter: fix one bug and
 one improvement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>, zhangchen.fnst@cn.fujitsu.com
Cc: qemu-devel@nongnu.org



On 2017=E5=B9=B402=E6=9C=8828=E6=97=A5 11:54, zhanghailiang wrote:
> Hi,
>
> Patch 1 fixes a double free bug.
> Patch 2 is an optimization for filter-rewriter.
>
> Please review, thanks.
>
>
> zhanghailiang (2):
>    net/colo: fix memory double free error
>    filter-rewriter: skip net_checksum_calculate() while offset =3D 0
>
>   net/colo.c            |  4 ++--
>   net/filter-rewriter.c | 17 +++++++++++------
>   2 files changed, 13 insertions(+), 8 deletions(-)
>

Applied, thanks.
