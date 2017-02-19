Received: from eggs.gnu.org ([2001:4830:134:3::10]:56586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfJ0a-00057n-Bb
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 23:22:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfJ0X-0003DS-7Y
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 23:22:00 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36133)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cfJ0X-0003DG-3l
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 23:21:57 -0500
Received: by mail-qk0-x243.google.com with SMTP id p22so11588728qka.3
	for <qemu-devel@nongnu.org>; Sat, 18 Feb 2017 20:21:57 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-18-git-send-email-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ddab08e5-7f6b-5b59-75e4-8b59fb7891f2@amsat.org>
Date: Sun, 19 Feb 2017 01:21:53 -0300
MIME-Version: 1.0
In-Reply-To: <1487067971-10443-18-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 17/24] util/cutils: Drop
 QEMU_STRTOSZ_DEFSUFFIX_* macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org


On 02/14/2017 07:26 AM, Markus Armbruster wrote:
> Writing QEMU_STRTOSZ_DEFSUFFIX_* instead of '*' gains nothing.  Get
> rid of these eyesores.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  util/cutils.c | 28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)
>
> diff --git a/util/cutils.c b/util/cutils.c
> index ef658bb..4a290ea 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -178,30 +178,22 @@ int fcntl_setfl(int fd, int flag)
>  }
>  #endif
>
> -#define QEMU_STRTOSZ_DEFSUFFIX_EB 'E'
> -#define QEMU_STRTOSZ_DEFSUFFIX_PB 'P'
> -#define QEMU_STRTOSZ_DEFSUFFIX_TB 'T'
> -#define QEMU_STRTOSZ_DEFSUFFIX_GB 'G'
> -#define QEMU_STRTOSZ_DEFSUFFIX_MB 'M'
> -#define QEMU_STRTOSZ_DEFSUFFIX_KB 'K'
> -#define QEMU_STRTOSZ_DEFSUFFIX_B 'B'
> -
>  static int64_t suffix_mul(char suffix, int64_t unit)
>  {
>      switch (qemu_toupper(suffix)) {
> -    case QEMU_STRTOSZ_DEFSUFFIX_B:
> +    case 'B':
>          return 1;
> -    case QEMU_STRTOSZ_DEFSUFFIX_KB:
> +    case 'K':
>          return unit;
> -    case QEMU_STRTOSZ_DEFSUFFIX_MB:
> +    case 'M':
>          return unit * unit;
> -    case QEMU_STRTOSZ_DEFSUFFIX_GB:
> +    case 'G':
>          return unit * unit * unit;
> -    case QEMU_STRTOSZ_DEFSUFFIX_TB:
> +    case 'T':
>          return unit * unit * unit * unit;
> -    case QEMU_STRTOSZ_DEFSUFFIX_PB:
> +    case 'P':
>          return unit * unit * unit * unit * unit;
> -    case QEMU_STRTOSZ_DEFSUFFIX_EB:
> +    case 'E':
>          return unit * unit * unit * unit * unit * unit;
>      }
>      return -1;
> @@ -258,17 +250,17 @@ fail:
>
>  int64_t qemu_strtosz(const char *nptr, char **end)
>  {
> -    return do_strtosz(nptr, end, QEMU_STRTOSZ_DEFSUFFIX_B, 1024);
> +    return do_strtosz(nptr, end, 'B', 1024);
>  }
>
>  int64_t qemu_strtosz_mebi(const char *nptr, char **end)
>  {
> -    return do_strtosz(nptr, end, QEMU_STRTOSZ_DEFSUFFIX_MB, 1024);
> +    return do_strtosz(nptr, end, 'M', 1024);
>  }
>
>  int64_t qemu_strtosz_metric(const char *nptr, char **end)
>  {
> -    return do_strtosz(nptr, end, QEMU_STRTOSZ_DEFSUFFIX_B, 1000);
> +    return do_strtosz(nptr, end, 'B', 1000);
>  }
>
>  /**
>
