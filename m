Received: from eggs.gnu.org ([2001:4830:134:3::10]:56157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1gLaR2-00053I-Vp
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 16:04:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1gLaGD-0002z7-30
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 15:53:42 -0500
References: <20181021190721.2148-1-hpoussin@reactos.org>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <0b492470-2146-c75a-6be6-0a2c5d0ebf5c@reactos.org>
Date: Sat, 10 Nov 2018 21:53:18 +0100
MIME-Version: 1.0
In-Reply-To: <20181021190721.2148-1-hpoussin@reactos.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] ps2kbd: default to scan enabled after reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Geoffrey McRae <geoff@hostfission.com>, qemu-ppc@nongnu.org

Ping.

Le 21/10/2018 à 21:07, Hervé Poussineau a écrit :
> A check for scan_enabled has been added to ps2_keyboard_event in commit
> 143c04c7e0639e53086519592ead15d2556bfbf2 to prevent stream corruption.
> This works well as long as operating system is resetting keyboard, or enabling it.
> 
> This fixes IBM 40p firmware, which doesn't bother sending KBD_CMD_RESET,
> KBD_CMD_ENABLE or KBD_CMD_RESET_ENABLE before trying to use the keyboard.
> 
> Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
> ---
>   hw/input/ps2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/input/ps2.c b/hw/input/ps2.c
> index fdfcadf9a1..eded4f0f8d 100644
> --- a/hw/input/ps2.c
> +++ b/hw/input/ps2.c
> @@ -938,7 +938,7 @@ static void ps2_kbd_reset(void *opaque)
>   
>       trace_ps2_kbd_reset(opaque);
>       ps2_common_reset(&s->common);
> -    s->scan_enabled = 0;
> +    s->scan_enabled = 1;
>       s->translate = 0;
>       s->scancode_set = 2;
>       s->modifiers = 0;
> 
