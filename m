Received: from eggs.gnu.org ([2001:4830:134:3::10]:43474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgDUC-00042K-DP
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:40:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgDU9-0005Ah-Ap
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:40:20 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgDU9-0005A5-7Q
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:40:17 -0500
Received: by mail-qk0-x244.google.com with SMTP id s186so13014335qkb.1
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 08:40:15 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
	<20170221141451.28305-2-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d57e99a9-2662-7cc3-15bf-f838eea19d95@amsat.org>
Date: Tue, 21 Feb 2017 13:40:12 -0300
MIME-Version: 1.0
In-Reply-To: <20170221141451.28305-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 01/30] qtest: fix a memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On 02/21/2017 11:14 AM, Marc-André Lureau wrote:
> Spotted by ASAN.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  qtest.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/qtest.c b/qtest.c
> index 1446719e8d..6f4d26832a 100644
> --- a/qtest.c
> +++ b/qtest.c
> @@ -240,6 +240,7 @@ static void GCC_FMT_ATTR(2, 3) qtest_sendf(CharBackend *chr,
>      va_start(ap, fmt);
>      buffer = g_strdup_vprintf(fmt, ap);
>      qtest_send(chr, buffer);
> +    g_free(buffer);
>      va_end(ap);
>  }
>
>
