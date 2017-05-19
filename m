Received: from eggs.gnu.org ([2001:4830:134:3::10]:55345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBd02-0008Cq-SC
	for qemu-devel@nongnu.org; Fri, 19 May 2017 04:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBd01-0006MB-Ry
	for qemu-devel@nongnu.org; Fri, 19 May 2017 04:11:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dBd01-0006M6-LH
	for qemu-devel@nongnu.org; Fri, 19 May 2017 04:11:01 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AD1FB3DE3D
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 08:11:00 +0000 (UTC)
References: <1495175803-12830-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2616084a-1c7b-4082-d491-b1aa3018b6fc@redhat.com>
Date: Fri, 19 May 2017 10:10:57 +0200
MIME-Version: 1.0
In-Reply-To: <1495175803-12830-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] usb: Deprecate HMP commands usb_add and
 usb_del
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: Dr David Alan Gilbert <dgilbert@redhat.com>



On 19/05/2017 08:36, Thomas Huth wrote:
> The commands 'device_add' and 'device_del' should be used
> nowadays instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hmp-commands.hx | 6 ++++--
>  vl.c            | 6 ++++++
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index baeac47..e763606 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -676,7 +676,8 @@ ETEXI
>  STEXI
>  @item usb_add @var{devname}
>  @findex usb_add
> -Add the USB device @var{devname}.  For details of available devices see
> +Add the USB device @var{devname}. This command is deprecated, please
> +use @code{device_add} instead. For details of available devices see
>  @ref{usb_devices}
>  ETEXI
>  
> @@ -693,7 +694,8 @@ STEXI
>  @findex usb_del
>  Remove the USB device @var{devname} from the QEMU virtual USB
>  hub. @var{devname} has the syntax @code{bus.addr}. Use the monitor
> -command @code{info usb} to see the devices you can remove.
> +command @code{info usb} to see the devices you can remove. This
> +command is deprecated, please use @code{device_del} instead.
>  ETEXI
>  
>      {
> diff --git a/vl.c b/vl.c
> index 3ca6bd3..268a8d8 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1435,6 +1435,9 @@ static int usb_parse(const char *cmdline)
>  void hmp_usb_add(Monitor *mon, const QDict *qdict)
>  {
>      const char *devname = qdict_get_str(qdict, "devname");
> +
> +    error_report("usb_add is deprecated, please use device_add instead");
> +
>      if (usb_device_add(devname) < 0) {
>          error_report("could not add USB device '%s'", devname);
>      }
> @@ -1443,6 +1446,9 @@ void hmp_usb_add(Monitor *mon, const QDict *qdict)
>  void hmp_usb_del(Monitor *mon, const QDict *qdict)
>  {
>      const char *devname = qdict_get_str(qdict, "devname");
> +
> +    error_report("usb_del is deprecated, please use device_del instead");
> +
>      if (usb_device_del(devname) < 0) {
>          error_report("could not delete USB device '%s'", devname);
>      }
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
