Received: from eggs.gnu.org ([2001:4830:134:3::10]:45648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTf3R-0003fi-EJ
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 23:05:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTf3M-0007ar-Gc
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 23:05:37 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTf3M-0007aa-9r
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 23:05:32 -0400
Received: by mail-qt0-x241.google.com with SMTP id d3-v6so7892185qto.1
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 20:05:32 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180614132242.12970-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5c4071e8-7913-aeac-86ab-f624df15db09@amsat.org>
Date: Fri, 15 Jun 2018 00:05:26 -0300
MIME-Version: 1.0
In-Reply-To: <20180614132242.12970-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] coverity-model: Fix indentation messed up
 in commit 04a0afe5285
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 06/14/2018 10:22 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  scripts/coverity-model.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/scripts/coverity-model.c b/scripts/coverity-model.c
> index 48b112393b..2ec753db05 100644
> --- a/scripts/coverity-model.c
> +++ b/scripts/coverity-model.c
> @@ -106,12 +106,12 @@ static int get_keysym(const name2keysym_t *table,
>  /* Replay data is considered trusted.  */
>  uint8_t replay_get_byte(void)
>  {
> -     uint8_t byte = 0;
> -     if (replay_file) {
> -         uint8_t c;
> -         byte = c;
> -     }
> -     return byte;
> +    uint8_t byte = 0;
> +    if (replay_file) {
> +        uint8_t c;
> +        byte = c;
> +    }
> +    return byte;
>  }
>  
>  
> 
