Received: from eggs.gnu.org ([209.51.188.92]:34452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmPfr-0001CS-02
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmPfp-0001Pp-LN
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:03:02 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:35492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gmPfp-0000bM-F5
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:03:01 -0500
Received: by mail-wr1-f41.google.com with SMTP id 96so4153096wrb.2
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 13:02:23 -0800 (PST)
References: <20190123183352.11025-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c3a5202c-850e-a0b0-42d0-bd74428b25f2@redhat.com>
Date: Wed, 23 Jan 2019 22:02:20 +0100
MIME-Version: 1.0
In-Reply-To: <20190123183352.11025-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] MAINTAINERS: update microbit ARM board
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim@groklearning.com, contrib@steffen-goertz.de, Thomas Huth <thuth@redhat.com>, joel@jms.id.au, jusual@mail.ru

On 1/23/19 7:33 PM, Stefan Hajnoczi wrote:
> New source files were added without corresponding ./MAINTAINERS file
> entries.  Let's get things up to date.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> v2:
>  * Simplify using wildcard patterns [Thomas]
> ---
>  MAINTAINERS | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index af339b86db..72460f938f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -831,9 +831,11 @@ M: Joel Stanley <joel@jms.id.au>
>  M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
>  S: Maintained
> -F: hw/arm/nrf51_soc.c
> -F: hw/arm/microbit.c
> -F: include/hw/arm/nrf51_soc.h
> +F: hw/*/nrf51*.c
> +F: hw/*/microbit*.c
> +F: include/hw/*/nrf51*.h
> +F: include/hw/*/microbit*.h
> +F: tests/microbit-test.c
>  
>  CRIS Machines
>  -------------
> 
