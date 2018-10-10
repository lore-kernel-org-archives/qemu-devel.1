Received: from eggs.gnu.org ([2001:4830:134:3::10]:36577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAGAB-0002EW-Al
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 11:12:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAGA8-0006nN-7d
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 11:12:39 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:35968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAGA7-0006jA-BZ
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 11:12:36 -0400
Received: by mail-wr1-f52.google.com with SMTP id y16so6176816wrw.3
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 08:12:22 -0700 (PDT)
References: <20181009130442.26296-1-berrange@redhat.com>
	<20181009130442.26296-5-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7966f435-e277-e89b-d9ad-e122ad3a2fcf@redhat.com>
Date: Wed, 10 Oct 2018 17:12:20 +0200
MIME-Version: 1.0
In-Reply-To: <20181009130442.26296-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 04/11] hw/usb: fix const-ness for string
 params in MTP driver
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
> Various functions accepting 'char *' string parameters were missing
> 'const' qualifiers.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/usb/dev-mtp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index f026419e47..ccbe25820b 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -372,7 +372,7 @@ static const USBDesc desc = {
>  /* ----------------------------------------------------------------------- */
>  
>  static MTPObject *usb_mtp_object_alloc(MTPState *s, uint32_t handle,
> -                                       MTPObject *parent, char *name)
> +                                       MTPObject *parent, const char *name)
>  {
>      MTPObject *o = g_new0(MTPObject, 1);
>  
> @@ -454,7 +454,7 @@ static MTPObject *usb_mtp_object_lookup(MTPState *s, uint32_t handle)
>  }
>  
>  static MTPObject *usb_mtp_add_child(MTPState *s, MTPObject *o,
> -                                    char *name)
> +                                    const char *name)
>  {
>      MTPObject *child =
>          usb_mtp_object_alloc(s, s->next_handle++, o, name);
> @@ -473,7 +473,7 @@ static MTPObject *usb_mtp_add_child(MTPState *s, MTPObject *o,
>  }
>  
>  static MTPObject *usb_mtp_object_lookup_name(MTPObject *parent,
> -                                             char *name, int len)
> +                                             const char *name, int len)
>  {
>      MTPObject *iter;
>  
> @@ -640,7 +640,7 @@ static void usb_mtp_inotify_cleanup(MTPState *s)
>      }
>  }
>  
> -static int usb_mtp_add_watch(int inotifyfd, char *path)
> +static int usb_mtp_add_watch(int inotifyfd, const char *path)
>  {
>      uint32_t mask = IN_CREATE | IN_DELETE | IN_MODIFY;
>  
> 
