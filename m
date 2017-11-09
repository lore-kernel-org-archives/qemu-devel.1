Received: from eggs.gnu.org ([2001:4830:134:3::10]:36777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCoPo-0004fg-Dl
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 10:06:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eCoPi-0006wQ-IN
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 10:06:48 -0500
Date: Thu, 9 Nov 2017 15:06:38 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171109150638.GH18164@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171109121903.24510-1-googuy@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171109121903.24510-1-googuy@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] Add missing parameters to mon option
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vicente Jimenez Aguilar <googuy@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Thu, Nov 09, 2017 at 01:19:03PM +0100, Vicente Jimenez Aguilar wrote:
> Documentation missed 'mon' option's 'pretty' and 'default' parameters
> 
> Signed-off-by: Vicente Jimenez Aguilar <googuy@gmail.com>
> ---
>  qemu-options.hx | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 3728e9b4dd..72cf48a8e5 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3477,9 +3477,9 @@ Like -qmp but uses pretty JSON formatting.
>  ETEXI
>  
>  DEF("mon", HAS_ARG, QEMU_OPTION_mon, \
> -    "-mon [chardev=]name[,mode=readline|control]\n", QEMU_ARCH_ALL)
> +    "-mon [chardev=]name[,mode=readline|control][,pretty[=on|off]][,default[=on|off]]\n", QEMU_ARCH_ALL)
>  STEXI
> -@item -mon [chardev=]name[,mode=readline|control]
> +@item -mon [chardev=]name[,mode=readline|control][,pretty[=on|off]][,default[=on|off]]

The 'default' option is deprecated and unused, so intentionally not
documented

https://qemu.weilnetz.de/doc/qemu-doc.html#g_t_002dmon-default_003don-_0028since-2_002e4_002e0_0029


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
