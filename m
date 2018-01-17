Received: from eggs.gnu.org ([2001:4830:134:3::10]:45262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ebeVK-000652-5g
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 22:35:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ebeVH-0003F1-2E
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 22:35:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ebeVG-0003EU-Rv
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 22:35:06 -0500
References: <20180116231824.27114-1-shaun.reitan@ndchost.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <78acb30d-ac20-4a59-50dc-9a247e190314@redhat.com>
Date: Wed, 17 Jan 2018 11:35:00 +0800
MIME-Version: 1.0
In-Reply-To: <20180116231824.27114-1-shaun.reitan@ndchost.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Add ability to provide ifname when using
 netdev bridge or tap helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shaun Reitan <shaun.reitan@ndchost.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>



On 2018=E5=B9=B401=E6=9C=8817=E6=97=A5 07:18, Shaun Reitan wrote:
> This patch replaces the patch I sent yesturday. This one fixes
> a bug in my original code as well as corrects a few styling
> issues. Hopfully this one comes out correct!  Sorry for the
> inconvienece.
>  =20
> When currently using -netdev bridge or -netdev tap with a helper
> you are unable to set an ifname. This patch adds that ability so
> that you can now specify an ifname.
>
> Signed-off-by: Shaun Reitan <shaun.reitan@ndchost.com>
> ---
>   net/tap.c            | 33 ++++++++++++++++++++++++---------
>   qapi/net.json        |  1 +
>   qemu-bridge-helper.c | 11 +++++++++--
>   qemu-options.hx      |  2 +-
>   4 files changed, 35 insertions(+), 12 deletions(-)
>

Applied.

Thanks
