Received: from eggs.gnu.org ([2001:4830:134:3::10]:43642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cP8hU-0006xh-RR
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 09:07:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cP8hS-0000RX-0l
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 09:07:28 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cP8hR-0000QS-RY
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 09:07:25 -0500
Received: by mail-wm0-x243.google.com with SMTP id l2so71262403wml.2
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 06:07:24 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170105135957.12003-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c425d3c5-aaaf-646d-4222-f3ff276fbd19@redhat.com>
Date: Thu, 5 Jan 2017 15:07:22 +0100
MIME-Version: 1.0
In-Reply-To: <20170105135957.12003-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] error: report hints on stderr when no
 monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com



On 05/01/2017 14:59, Marc-André Lureau wrote:
> Report the error hint when running from the command line and reaching an
> error, ex:
> 
> $ qemu-system-x86_64 -m 1Z
> qemu-system-x86_64: -m 1Z: Parameter 'size' expects a size
> You may use k, M, G or T suffixes for kilobytes, megabytes, gigabytes and terabytes.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  monitor.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/monitor.c b/monitor.c
> index a82f547488..e5cc11b5a5 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -3973,6 +3973,8 @@ void error_vprintf_unless_qmp(const char *fmt, va_list ap)
>  {
>      if (cur_mon && !monitor_cur_is_qmp()) {
>          monitor_vprintf(cur_mon, fmt, ap);
> +    } else if (!cur_mon) {
> +        vfprintf(stderr, fmt, ap);
>      }
>  }
>  
> 

Good idea!

Paolo
