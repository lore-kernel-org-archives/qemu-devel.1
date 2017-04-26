Received: from eggs.gnu.org ([2001:4830:134:3::10]:37464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d3JCQ-0002bJ-CL
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 05:25:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d3JCL-0002fW-CQ
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 05:25:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d3JCL-0002fH-3E
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 05:25:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 367CD8004A
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 09:25:19 +0000 (UTC)
References: <1493106644-6049-1-git-send-email-thuth@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cee42ea6-5b1c-ebc3-089a-24b49ef76d82@redhat.com>
Date: Wed, 26 Apr 2017 17:25:12 +0800
MIME-Version: 1.0
In-Reply-To: <1493106644-6049-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net/dump: Issue a warning for the
 deprecated "-net dump"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org



On 2017=E5=B9=B404=E6=9C=8825=E6=97=A5 15:50, Thomas Huth wrote:
> Network dumping should be done with "-object filter-dump" nowadays.
> Using "-net dump" via the VLAN mechanism is considered as deprecated
> and might be removed in a future release. So warn the users now
> to inform them to user the filter-dump method instead.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   net/dump.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/net/dump.c b/net/dump.c
> index 89a149b..442eb53 100644
> --- a/net/dump.c
> +++ b/net/dump.c
> @@ -194,6 +194,9 @@ int net_init_dump(const Netdev *netdev, const char =
*name,
>  =20
>       assert(peer);
>  =20
> +    error_report("'-net dump' is deprecated. "
> +                 "Please use '-object filter-dump' instead.");
> +
>       if (dump->has_file) {
>           file =3D dump->file;
>       } else {

Applied.

Thanks
