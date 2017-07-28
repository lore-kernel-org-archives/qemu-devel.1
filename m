Received: from eggs.gnu.org ([2001:4830:134:3::10]:33405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1davyQ-00054L-DO
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 23:29:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1davyL-0006yj-SZ
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 23:29:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1davyL-0006wy-Lz
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 23:29:53 -0400
References: <cover.1501052660.git.maozy.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <99e3f246-46c9-f440-9767-b0578995b190@redhat.com>
Date: Fri, 28 Jul 2017 11:29:33 +0800
MIME-Version: 1.0
In-Reply-To: <cover.1501052660.git.maozy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 0/4] Remove dead error handling and
 convert to realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: jiri@resnulli.us, armbru@redhat.com, f4bug@amsat.org



On 2017=E5=B9=B407=E6=9C=8826=E6=97=A5 16:13, Mao Zhongyi wrote:
> This series mainly implements the conversion of rocker to realize,
> also remove the dead error handling and rename the unusual macro
> name.
>
> v6:
>
> I posted another patch(commit 4cee3cf3) after patch1 of this series but
> before patch1 be merged, they changed the same function caused this
> series not to be applied cleanly on HEAD. so resend v6 to fix it.
>
> Because there is no change on the patch content, so still add the R-B.
>
> Cc: jasowang@redhat.com
> Cc: jiri@resnulli.us
> Cc: armbru@redhat.com
> Cc: f4bug@amsat.org
>
> Mao Zhongyi (4):
>    net/rocker: Remove the dead error handling
>    net/rocker: Plug memory leak in pci_rocker_init()
>    net/rocker: Convert to realize()
>    net/rocker: Fix the unusual macro name
>
>   hw/net/rocker/rocker.c        | 94 +++++++++++-----------------------=
---------
>   hw/net/rocker/rocker_desc.c   | 10 -----
>   hw/net/rocker/rocker_fp.c     |  4 --
>   hw/net/rocker/rocker_of_dpa.c | 20 ---------
>   hw/net/rocker/rocker_world.c  | 12 +++---
>   5 files changed, 28 insertions(+), 112 deletions(-)
>

Applied.

Thanks
