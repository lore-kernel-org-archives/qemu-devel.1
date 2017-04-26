Received: from eggs.gnu.org ([2001:4830:134:3::10]:53381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d3C48-000295-TU
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 21:48:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d3C48-0001JU-46
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 21:48:24 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:36536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d3C47-0001Ij-Vi
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 21:48:24 -0400
Received: by mail-qk0-x241.google.com with SMTP id y63so19476446qkd.3
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 18:48:23 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170425223739.6703-1-quintela@redhat.com>
	<20170425223739.6703-26-quintela@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b64642f8-50c9-4829-7981-8f25e3cc5253@amsat.org>
Date: Tue, 25 Apr 2017 22:48:19 -0300
MIME-Version: 1.0
In-Reply-To: <20170425223739.6703-26-quintela@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 25/26] audio: un-export OPLResetChip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On 04/25/2017 07:37 PM, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/audio/fmopl.c | 2 +-
>  hw/audio/fmopl.h | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
> index 99d09c5..dc9043c 100644
> --- a/hw/audio/fmopl.c
> +++ b/hw/audio/fmopl.c
> @@ -1036,7 +1036,7 @@ void YM3812UpdateOne(FM_OPL *OPL, int16_t *buffer, int length)
>  }
>
>  /* ---------- reset one of chip ---------- */
> -void OPLResetChip(FM_OPL *OPL)
> +static void OPLResetChip(FM_OPL *OPL)
>  {
>  	int c,s;
>  	int i;
> diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
> index f89af08..fc9f16b 100644
> --- a/hw/audio/fmopl.h
> +++ b/hw/audio/fmopl.h
> @@ -95,7 +95,6 @@ FM_OPL *OPLCreate(int clock, int rate);
>  void OPLDestroy(FM_OPL *OPL);
>  void OPLSetTimerHandler(FM_OPL *OPL,OPL_TIMERHANDLER TimerHandler,int channelOffset);
>
> -void OPLResetChip(FM_OPL *OPL);
>  int OPLWrite(FM_OPL *OPL,int a,int v);
>  unsigned char OPLRead(FM_OPL *OPL,int a);
>  int OPLTimerOver(FM_OPL *OPL,int c);
>
