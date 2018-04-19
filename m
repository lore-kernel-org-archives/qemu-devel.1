Received: from eggs.gnu.org ([2001:4830:134:3::10]:48398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9G7m-0005jC-4X
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 16:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9G7j-0001OR-Go
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 16:25:46 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:42090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9G7j-0001Lg-Br
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 16:25:43 -0400
Received: by mail-qk0-x244.google.com with SMTP id j10so6702693qke.9
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 13:25:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1524156319-11465-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524156319-11465-15-git-send-email-ian.jackson@eu.citrix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f594f663-d53c-690e-8797-48cbbe43f8fa@amsat.org>
Date: Thu, 19 Apr 2018 17:25:38 -0300
MIME-Version: 1.0
In-Reply-To: <1524156319-11465-15-git-send-email-ian.jackson@eu.citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 14/16] os-posix: cleanup: Replace fprintf
 with error_report in remaining call sites
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>, qemu-devel@nongnu.org
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>, Ross Lagerwall <ross.lagerwall@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org

Hi Ian,

On 04/19/2018 01:45 PM, Ian Jackson wrote:
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Daniel P. Berrange <berrange@redhat.com>
> CC: Michael Tokarev <mjt@tls.msk.ru>
> ---
> v7: New patch
> ---
>  os-posix.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/os-posix.c b/os-posix.c
> index 0f59566..d4cf466 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -129,7 +129,7 @@ void os_set_proc_name(const char *s)
>          exit(1);
>      }
>  #else
> -    fprintf(stderr, "Change of process name not supported by your OS\n");
> +    error_report("Change of process name not supported by your OS\n");

removing the trailing "\n":
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>      exit(1);
>  #endif
>  }
> @@ -243,7 +243,7 @@ static void change_root(void)
>  {
>      if (chroot_dir) {
>          if (chroot(chroot_dir) < 0) {
> -            fprintf(stderr, "chroot failed\n");
> +            error_report("chroot failed");
>              exit(1);
>          }
>          if (chdir("/")) {
> 
