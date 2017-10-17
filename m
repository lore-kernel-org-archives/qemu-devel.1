Received: from eggs.gnu.org ([2001:4830:134:3::10]:40878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1e4IFo-0000ap-2w
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 23:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1e4IFk-000787-FH
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 23:09:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1e4IFk-00076l-3c
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 23:09:12 -0400
References: <20171013063209.15617-1-maozy.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9c2233a7-c834-4463-3082-43555a2f1d1b@redhat.com>
Date: Tue, 17 Oct 2017 11:09:01 +0800
MIME-Version: 1.0
In-Reply-To: <20171013063209.15617-1-maozy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] Optimize COLO-compare performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>



On 2017=E5=B9=B410=E6=9C=8813=E6=97=A5 14:32, Mao Zhongyi wrote:
> In this series, adjust the way that the packet are queued and compared
> to improve the colo net performence.
>
> Cc: Zhang Chen <zhangckid@gmail.com>
> Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
> Cc: Jason Wang <jasowang@redhat.com>
>
> Mao Zhongyi (4):
>    colo-compare: Insert packet into the suitable position of packet que=
ue
>      directly
>    colo-compare: compare the packet in a specified Connection
>    colo-compare: Fix comments
>    colo: Consolidate the duplicate code chunk into a routine
>
>   net/colo-compare.c | 61 +++++++++++++++++++++++++++++++--------------=
---------
>   net/colo.c         | 18 +++++++++-------
>   net/colo.h         |  1 +
>   3 files changed, 46 insertions(+), 34 deletions(-)
>

Applied.

Thanks
