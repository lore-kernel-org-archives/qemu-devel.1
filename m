Received: from eggs.gnu.org ([2001:4830:134:3::10]:38923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gAlfv-00081C-1s
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:51:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gAlfl-0005oM-8G
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:51:30 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gAlfk-0005nS-Gw
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:51:21 -0400
Received: by mail-oi1-x244.google.com with SMTP id y81-v6so8608760oia.6
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 17:51:19 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
References: <20181012002217.2864-1-philmd@redhat.com>
	<20181012002217.2864-2-philmd@redhat.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <623d9f61-bbff-2656-3663-c4c414d107da@acm.org>
Date: Thu, 11 Oct 2018 19:51:15 -0500
MIME-Version: 1.0
In-Reply-To: <20181012002217.2864-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH v2 01/11] hw/ipmi: Remove unnecessary
 declarations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Prasad J Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org

On 10/11/2018 07:22 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>   hw/ipmi/ipmi_bmc_extern.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
> index bf0b7ee0f5..8c78b9804b 100644
> --- a/hw/ipmi/ipmi_bmc_extern.c
> +++ b/hw/ipmi/ipmi_bmc_extern.c
> @@ -85,10 +85,6 @@ typedef struct IPMIBmcExtern {
>       bool send_reset;
>   } IPMIBmcExtern;
>   
> -static int can_receive(void *opaque);
> -static void receive(void *opaque, const uint8_t *buf, int size);
> -static void chr_event(void *opaque, int event);
> -
>   static unsigned char
>   ipmb_checksum(const unsigned char *data, int size, unsigned char start)
>   {

Looks good to me.  Thanks.

Acked-by: Corey Minyard <cminyard@mvista.com>
