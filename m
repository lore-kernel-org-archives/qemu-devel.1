Received: from eggs.gnu.org ([2001:4830:134:3::10]:57329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ckl5d-00062r-PC
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:21:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ckl5a-00089D-Mv
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:21:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ckl5a-00088x-Gx
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 00:21:42 -0500
References: <1488448458-4976-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <058c8c25-ec73-542d-a3d5-c40f38ac0b33@redhat.com>
Date: Mon, 6 Mar 2017 13:21:36 +0800
MIME-Version: 1.0
In-Reply-To: <1488448458-4976-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V3 0/3] COLO-compare: Optimize the code and
 fix some bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, bian naimeng <biannm@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>



On 2017=E5=B9=B403=E6=9C=8802=E6=97=A5 17:54, Zhang Chen wrote:
> This series we will Optimize the code and fix some bug.
> Patch1: Rename colo_packet_compare() and remove duplicate check in comp=
are icmp.
> Patch2: Optimize compare_common and increase compare performance.
> Patch3: Fix debug info always print bug.
>
> Zhang Chen (3):
>    COLO-compare: Rename compare function and remove duplicate codes
>    COLO-compare: Optimize compare_common and compare_tcp
>    COLO-compare: Fix icmp and udp compare different packet always dump
>      bug
>
>   net/colo-compare.c | 74 ++++++++++++++++++++++++++++++++++++---------=
---------
>   1 file changed, 49 insertions(+), 25 deletions(-)
>

Applied, thanks.
