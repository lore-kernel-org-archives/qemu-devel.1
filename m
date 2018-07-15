Received: from eggs.gnu.org ([2001:4830:134:3::10]:53731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fepQ1-0001ND-CM
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 18:23:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fepPz-000821-Np
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 18:23:05 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:40140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fepPz-00081f-Ho
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 18:23:03 -0400
Received: by mail-qt0-x241.google.com with SMTP id h4-v6so31445184qtj.7
	for <qemu-devel@nongnu.org>; Sun, 15 Jul 2018 15:23:03 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180715162156.12394-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <43785d76-a05b-873c-fbfa-bb057fe37ff6@amsat.org>
Date: Sun, 15 Jul 2018 19:22:59 -0300
MIME-Version: 1.0
In-Reply-To: <20180715162156.12394-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.0] qga: fix file descriptor leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>

On 07/15/2018 01:21 PM, Paolo Bonzini wrote:
> The file descriptor for /sys/power/state was never closed.  Reported
> by Coverity.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  qga/commands-posix.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 233f78a406..4160aceaed 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1651,6 +1651,7 @@ static bool linux_sys_state_supports_mode(SuspendMode mode, Error **errp)
>      }
>  
>      ret = read(fd, buf, sizeof(buf) - 1);
> +    close(fd);
>      if (ret <= 0) {
>          return false;
>      }
> 
