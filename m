Received: from eggs.gnu.org ([2001:4830:134:3::10]:58821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dfiMv-00061H-Cv
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 03:59:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dfiMr-0007GS-Jc
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 03:59:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dfiMr-0007Ft-Cs
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 03:58:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 30A35400F8
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 07:58:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
References: <1502351323-15186-1-git-send-email-thuth@redhat.com>
Message-ID: <a96c990a-da40-7e2c-60a4-6868db1aa538@redhat.com>
Date: Thu, 10 Aug 2017 09:58:53 +0200
MIME-Version: 1.0
In-Reply-To: <1502351323-15186-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>

On 10.08.2017 09:48, Thomas Huth wrote:
> The two HMP commands host_net_add and -remove have recently been
> marked as deprecated, too, so we should now mention them in the
> chapter of deprecated features.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
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

D'oh, stupid copy-n-paste bug ... that should be replaced by
"netdev_del" of course instead. I'll send a v2...

 Thomas
