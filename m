Received: from eggs.gnu.org ([2001:4830:134:3::10]:39917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhEGK-0006ND-Sw
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 08:14:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhEGI-0003vX-8E
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 08:14:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dhEGI-0003v3-1n
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 08:14:26 -0400
Date: Mon, 14 Aug 2017 14:14:20 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170814141420.5bd6a701.cohuck@redhat.com>
In-Reply-To: <1502712555-4587-2-git-send-email-jasowang@redhat.com>
References: <1502712555-4587-1-git-send-email-jasowang@redhat.com>
	<1502712555-4587-2-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL V2] qemu-doc: Mention host_net_add/-remove
 in the deprecation chapter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>

On Mon, 14 Aug 2017 20:09:15 +0800
Jason Wang <jasowang@redhat.com> wrote:

> From: Thomas Huth <thuth@redhat.com>
> 
> The two HMP commands host_net_add and -remove have recently been
> marked as deprecated, too, so we should now mention them in the
> chapter of deprecated features.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  qemu-doc.texi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index aeb7bc5..7b62fdf 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -3283,6 +3283,14 @@ by the ``convert -l snapshot_param'' argument instead.
>  
>  @section System emulator human monitor commands
>  
> +@subsection host_net_add (since 2.10.0)
> +
> +The ``host_net_add'' command is replaced by the ``netdev_add'' command.
> +
> +@subsection host_net_remove (since 2.10.0)
> +
> +The ``host_net_remove'' command is replaced by the ``host_net_remove'' command.

Err.. that does not look right...

> +
>  @subsection usb_add (since 2.10.0)
>  
>  The ``usb_add'' command is replaced by the ``device_add'' command.
