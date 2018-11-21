Received: from eggs.gnu.org ([2001:4830:134:3::10]:56596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gPXx0-0002Uo-Eb
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 14:14:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gPXwv-0003bo-LX
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 14:14:14 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:54654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gPXwp-0003Gx-NY
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 14:14:03 -0500
Received: by mail-wm1-f54.google.com with SMTP id r63-v6so6664680wma.4
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 11:13:56 -0800 (PST)
References: <1542276385-7638-1-git-send-email-liq3ea@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e929f930-2a0b-28ee-fab9-234c99da1d3a@redhat.com>
Date: Wed, 21 Nov 2018 20:13:52 +0100
MIME-Version: 1.0
In-Reply-To: <1542276385-7638-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] vl.c: remove outdated comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, laurent@vivier.eu
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 15/11/18 11:06, Li Qiang wrote:
> Cc: qemu-trivial@nongnu.org
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  vl.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index fa25d1ae2d..ae63018a1d 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1522,9 +1522,6 @@ static int machine_help_func(QemuOpts *opts, MachineState *machine)
>      return 1;
>  }
>  
> -/***********************************************************/
> -/* main execution loop */
> -
>  struct vm_change_state_entry {
>      VMChangeStateHandler *cb;
>      void *opaque;
> 

Queued, thanks.

Paolo
