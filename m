Received: from eggs.gnu.org ([2001:4830:134:3::10]:39814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAHqA-00038e-5g
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 13:00:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAHq6-0004dO-Vv
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 13:00:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAHq6-0004cB-PK
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 13:00:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so6265406wma.4
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 10:00:02 -0700 (PDT)
References: <20181009130442.26296-1-berrange@redhat.com>
	<20181009130442.26296-4-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8bffa81f-e9d8-0806-95a4-7ea13594348d@redhat.com>
Date: Wed, 10 Oct 2018 19:00:00 +0200
MIME-Version: 1.0
In-Reply-To: <20181009130442.26296-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 03/11] hw/usb: don't set IN_ISDIR for
 inotify watch in MTP driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 09/10/2018 15:04, Daniel P. Berrangé wrote:
> IN_ISDIR is not a bit that one can request when registering a
> watch with inotify_add_watch. Rather it is a bit that is set
> automatically when reading events from the kernel.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/usb/dev-mtp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index 00a3691bae..f026419e47 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -642,8 +642,7 @@ static void usb_mtp_inotify_cleanup(MTPState *s)
>  
>  static int usb_mtp_add_watch(int inotifyfd, char *path)
>  {
> -    uint32_t mask = IN_CREATE | IN_DELETE | IN_MODIFY |
> -        IN_ISDIR;
> +    uint32_t mask = IN_CREATE | IN_DELETE | IN_MODIFY;
>  
>      return inotify_add_watch(inotifyfd, path, mask);
>  }
> 
