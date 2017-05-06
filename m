Received: from eggs.gnu.org ([2001:4830:134:3::10]:44341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d72JH-0000XP-VU
	for qemu-devel@nongnu.org; Sat, 06 May 2017 12:11:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d72JH-00046L-5l
	for qemu-devel@nongnu.org; Sat, 06 May 2017 12:11:55 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170506124314.23354-1-aurelien@aurel32.net>
	<20170506124314.23354-3-aurelien@aurel32.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4468d0ab-cf0b-bb36-833f-88b53592ec63@amsat.org>
Date: Sat, 6 May 2017 13:11:35 -0300
MIME-Version: 1.0
In-Reply-To: <20170506124314.23354-3-aurelien@aurel32.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/3] ide: export rotational qdev property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

On 05/06/2017 09:43 AM, Aurelien Jarno wrote:
> Export the rotational qdev property in the IDENTIFY request.
>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/ide/core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 0b48b64d3a..1aa76b0d90 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -191,6 +191,9 @@ static void ide_identify(IDEState *s)
>      if (dev && dev->conf.discard_granularity) {
>          put_le16(p + 169, 1); /* TRIM support */
>      }
> +    if (dev && !dev->conf.rotational) {
> +        put_le16(p + 217, 1); /* non-rotating device */
> +    }
>
>      ide_identify_size(s);
>      s->identify_set = 1;
>
