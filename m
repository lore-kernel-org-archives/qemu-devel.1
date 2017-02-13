Received: from eggs.gnu.org ([2001:4830:134:3::10]:36342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cdKaE-0000gp-Ay
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:38:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cdKa9-0002LR-EG
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:38:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cdKa9-0002KS-7f
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:38:33 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9BCCD3B708
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 17:38:32 +0000 (UTC)
References: <1486747506-15876-1-git-send-email-abologna@redhat.com>
	<1486747506-15876-3-git-send-email-abologna@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <bfcec72c-4bc0-d1ce-d043-93f10c6e3aa7@redhat.com>
Date: Mon, 13 Feb 2017 18:38:29 +0100
MIME-Version: 1.0
In-Reply-To: <1486747506-15876-3-git-send-email-abologna@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 2/2] mach-virt: Provide sample
 configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org
Cc: marcel@redhat.com, drjones@redhat.com, kraxel@redhat.com

On 02/10/17 18:25, Andrea Bolognani wrote:
> These are very much like the sample configuration files
> for q35, and can be used both as documentation and as
> a starting point for creating your own guest.
> 
> Two sample configuration files are provided:
> 
>   * mach-virt-graphical.cfg can be used to start a
>     fully-featured (USB, graphical console, etc.)
>     guest that uses VirtIO devices;
> 
>   * mach-virt-serial.cfg is similar but has a minimal
>     set of devices and uses the serial console.
> 
> All configuration files are fully commented and neatly
> organized.
> ---
>  docs/mach-virt-graphical.cfg | 281 +++++++++++++++++++++++++++++++++++++++++++
>  docs/mach-virt-serial.cfg    | 243 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 524 insertions(+)
>  create mode 100644 docs/mach-virt-graphical.cfg
>  create mode 100644 docs/mach-virt-serial.cfg
> 

[snip]

> +[drive "optical-disk"]
> +  file = "install.iso"                          # CHANGE ME
> +  format = "raw"
> +  if = "none"

I usually add

  readonly = "on"

here -- more precisely, at the corresponding location on the command
line --, but I'm unsure if that justifies v8 :)

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks!
Laszlo
