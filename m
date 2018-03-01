Received: from eggs.gnu.org ([2001:4830:134:3::10]:60958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1erMFr-0001Ry-G0
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:20:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1erMFm-0006Id-IZ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:20:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46696 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1erMFm-0006IU-D3
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:20:02 -0500
References: <1519888086-4207-1-git-send-email-jusual@mail.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <63219f38-05e9-5154-81a8-034d0994761d@redhat.com>
Date: Thu, 1 Mar 2018 12:19:58 +0100
MIME-Version: 1.0
In-Reply-To: <1519888086-4207-1-git-send-email-jusual@mail.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] use g_path_get_basename instead of basename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Jim Mussared <jim@groklearning.com>, Joel Stanley <joel@jms.id.au>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>

On 01/03/2018 08:08, Julia Suvorova wrote:
> +static void free_progname(void)
> +{
> +    g_free(progname);
> +}
> +
>  static void GCC_FMT_ATTR(2, 3) readline_printf_func(void *opaque,
>                                                      const char *fmt, ...)
>  {
> @@ -504,7 +509,8 @@ int main(int argc, char **argv)
>  #endif
>  
>      module_call_init(MODULE_INIT_TRACE);
> -    progname = basename(argv[0]);
> +    progname = g_path_get_basename(argv[0]);
> +    atexit(free_progname);

This atexit is not needed; memory is always freed on exit.  But, it's
good that you thought about it!

I can queue this patch for merging once I get an ack from Alex
Williamson (VFIO).

Thanks,

Paolo
