Received: from eggs.gnu.org ([2001:4830:134:3::10]:44176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dIWeB-0003dh-Eg
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dIWe7-0005ZK-G0
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:48:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dIWe7-0005Yz-A7
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 04:48:55 -0400
References: <1496736776-19852-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1d4d9454-2005-ff6c-d3b2-88b3b9cb593a@redhat.com>
Date: Wed, 7 Jun 2017 16:48:42 +0800
MIME-Version: 1.0
In-Reply-To: <1496736776-19852-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V3 0/3] COLO-compare: Make COLO-compare
 support remote COLO-frame
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



On 2017=E5=B9=B406=E6=9C=8806=E6=97=A5 16:12, Zhang Chen wrote:
> This series focus on COLO-proxy remote colo-frame support.
> Xen COLO-frame is the first user. We add a new chardev socket
> in colo-compare as the way of communicate with remote COLO-frame.
> And remote COLO-frame notify colo-proxy part depend on this serise:
> https://lists.nongnu.org/archive/html/qemu-devel/2017-04/msg03904.html
>
> I will send another part of this series after depend patchset have
> been merged.
>
> V3:
>   - Fix codestyle.
>
> V2:
>   - Rename this series.
>   - Change communication way to remote colo-frame.
>   - Some bugfix.
>   - Split the main function, anther part wait depend patchset.
>
>
> Zhang Chen (3):
>    COLO-compare: Add new parameter for communicate with remote colo-fra=
me
>    COLO-compare: Add remote checkpoint notify chardev socket handler
>      frame
>    COLO-compare: Add remote initialization and checkpoint notification
>
>   net/colo-compare.c | 91 +++++++++++++++++++++++++++++++++++++++++++++=
+++++++--
>   qemu-options.hx    | 41 ++++++++++++++++++++----
>   2 files changed, 124 insertions(+), 8 deletions(-)
>

Thanks for the series.

To speed up things, I would like to see IOThread conversion first. Then=20
we can have this on top.
