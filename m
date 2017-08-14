Received: from eggs.gnu.org ([2001:4830:134:3::10]:33009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dh5i7-000264-Ix
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 23:06:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dh5i4-0003q3-E7
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 23:06:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dh5i4-0003pr-8O
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 23:06:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 94FF3C04F2A6
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 02:57:25 +0000 (UTC)
References: <1502351323-15186-1-git-send-email-thuth@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <17d55442-f976-70ad-a4a5-2a22ab73ff6c@redhat.com>
Date: Mon, 14 Aug 2017 10:57:13 +0800
MIME-Version: 1.0
In-Reply-To: <1502351323-15186-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.10] qemu-doc: Mention
 host_net_add/-remove in the deprecation chapter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>



On 2017=E5=B9=B408=E6=9C=8810=E6=97=A5 15:48, Thomas Huth wrote:
> The two HMP commands host_net_add and -remove have recently been
> marked as deprecated, too, so we should now mention them in the
> chapter of deprecated features.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   qemu-doc.texi | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index aeb7bc5..7b62fdf 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -3283,6 +3283,14 @@ by the ``convert -l snapshot_param'' argument in=
stead.
>  =20
>   @section System emulator human monitor commands
>  =20
> +@subsection host_net_add (since 2.10.0)
> +
> +The ``host_net_add'' command is replaced by the ``netdev_add'' command=
.
> +
> +@subsection host_net_remove (since 2.10.0)
> +
> +The ``host_net_remove'' command is replaced by the ``host_net_remove''=
 command.
> +
>   @subsection usb_add (since 2.10.0)
>  =20
>   The ``usb_add'' command is replaced by the ``device_add'' command.

Applied, thanks.
