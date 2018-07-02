Received: from eggs.gnu.org ([2001:4830:134:3::10]:47534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa1qQ-0008G9-4C
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa1qL-0004wZ-8d
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:38:30 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa1qL-0004wT-3x
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:38:25 -0400
Received: by mail-qk0-x244.google.com with SMTP id c131-v6so8971936qkb.0
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 09:38:25 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180702145513.11481-1-kraxel@redhat.com>
	<20180702145513.11481-2-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <759f935b-9160-a5e1-0485-c992121abd1b@amsat.org>
Date: Mon, 2 Jul 2018 13:38:21 -0300
MIME-Version: 1.0
In-Reply-To: <20180702145513.11481-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/3] audio/hda: fix CID 1393631
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 07/02/2018 11:55 AM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/audio/hda-codec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
> index 9f630fa37f..2b58c3505b 100644
> --- a/hw/audio/hda-codec.c
> +++ b/hw/audio/hda-codec.c
> @@ -189,7 +189,7 @@ struct HDAAudioState {
>  
>  static inline int64_t hda_bytes_per_second(HDAAudioStream *st)
>  {
> -    return 2 * st->as.nchannels * st->as.freq;
> +    return 2LL * st->as.nchannels * st->as.freq;
>  }
>  
>  static inline void hda_timer_sync_adjust(HDAAudioStream *st, int64_t target_pos)
> 
