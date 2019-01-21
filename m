Received: from eggs.gnu.org ([209.51.188.92]:42544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1glbHC-0003Ic-SZ
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 10:14:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1glbHB-00081R-8d
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 10:14:13 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:39828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1glbHB-000816-1x
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 10:14:13 -0500
Received: by mail-wr1-f42.google.com with SMTP id t27so23783911wra.6
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 07:14:12 -0800 (PST)
Date: Mon, 21 Jan 2019 16:14:08 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190121151408.3paksvv6vytjf7k7@steredhat>
References: <20190118223152.24183-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190118223152.24183-1-lersek@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] fw_cfg: fix the life cycle and the name of
 "qemu_extra_params_fw"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Fri, Jan 18, 2019 at 11:31:52PM +0100, Laszlo Ersek wrote:
> Commit 19bcc4bc3213 ("fw_cfg: Make qemu_extra_params_fw locally",
> 2019-01-04) changed the storage duration of the "qemu_extra_params_fw"
> array from static to automatic. This broke the interface contract on the
> fw_cfg_add_file() function, which is documented as follows, in
> "include/hw/nvram/fw_cfg.h":
> 
> > [...] The data referenced by the starting pointer is only linked, NOT
> > copied, into the data structure of the fw_cfg device. [...]
> 
> As a result, when guest firmware fetches the "etc/boot-menu-wait" fw_cfg
> file, it now sees garbage. Fix the regression by changing the storage
> duration to allocated. (The call is reached at most once, on the realize
> path of the board-specific fw_cfg sysbus device.)
> 
> While at it, clean up the name and the assignment of the object as well.
> 
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
> Fixes: 19bcc4bc3213e78c303ad480a7a578f62258252d
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  hw/nvram/fw_cfg.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
