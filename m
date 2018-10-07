Received: from eggs.gnu.org ([2001:4830:134:3::10]:51954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g9DAg-0004vh-Ez
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 13:48:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g9DAd-0008KR-6q
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 13:48:50 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g9DAc-0008KJ-Ur
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 13:48:47 -0400
Received: by mail-wm1-x341.google.com with SMTP id z204-v6so6163695wmc.5
	for <qemu-devel@nongnu.org>; Sun, 07 Oct 2018 10:48:46 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20181007043335.23631-1-liq3ea@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <be443eb3-742d-08c6-492c-058331ec14b0@amsat.org>
Date: Sun, 7 Oct 2018 19:48:44 +0200
MIME-Version: 1.0
In-Reply-To: <20181007043335.23631-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] vl.c: print error message if load fw_cfg
 file failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org

On 10/7/18 6:33 AM, Li Qiang wrote:
> It makes sense to print the error message while reading
> file failed.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  vl.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index cc55fe04a2..3db410e771 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2207,8 +2207,9 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
>          size = strlen(str); /* NUL terminator NOT included in fw_cfg blob */
>          buf = g_memdup(str, size);
>      } else {
> -        if (!g_file_get_contents(file, &buf, &size, NULL)) {
> -            error_report("can't load %s", file);
> +        GError *error = NULL;
> +        if (!g_file_get_contents(file, &buf, &size, &error)) {
> +            error_report("can't load %s, %s", file, error->message);

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>              return -1;
>          }
>      }
>
