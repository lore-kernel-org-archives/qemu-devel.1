Received: from eggs.gnu.org ([209.51.188.92]:38412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDbnM-0007DI-23
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 17:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDbnK-0006zC-SD
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 17:27:11 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:45400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDbnK-0006wf-IR
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 17:27:10 -0400
Received: by mail-wr1-f47.google.com with SMTP id s15so18074940wra.12
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 14:27:10 -0700 (PDT)
References: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d35048f6-44e7-46a0-3d70-51123896f1ef@redhat.com>
Date: Mon, 8 Apr 2019 23:27:07 +0200
MIME-Version: 1.0
In-Reply-To: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] sd: Fix out-of-bounds assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lidong Chen <lidong.chen@oracle.com>, qemu-devel@nongnu.org
Cc: darren.kenny@oracle.com, f4bug@amsat.org

Hi Lidong

On 4/8/19 9:04 PM, Lidong Chen wrote:
> Due to an off-by-one error, the assert statements allow an
> out-of-bounds array access.

... which can't happen. Thus harmless for 4.0.

I suppose this is a static analysis warning and you didn't triggered it
while tracing.

Thanks for cleaning this :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Signed-off-by: Lidong Chen <lidong.chen@oracle.com>
> ---
>  hw/sd/sd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index aaab15f..818f86c 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -144,7 +144,7 @@ static const char *sd_state_name(enum SDCardStates state)
>      if (state == sd_inactive_state) {
>          return "inactive";
>      }
> -    assert(state <= ARRAY_SIZE(state_name));
> +    assert(state < ARRAY_SIZE(state_name));
>      return state_name[state];
>  }
>  
> @@ -165,7 +165,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
>      if (rsp == sd_r1b) {
>          rsp = sd_r1;
>      }
> -    assert(rsp <= ARRAY_SIZE(response_name));
> +    assert(rsp < ARRAY_SIZE(response_name));
>      return response_name[rsp];
>  }
>  
> 
