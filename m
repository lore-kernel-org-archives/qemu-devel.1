Received: from eggs.gnu.org ([2001:4830:134:3::10]:41598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cnqg6-0004ED-5I
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cnqg1-0006va-Fy
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:56:10 -0400
Received: from smtp2-g21.free.fr ([2a01:e0c:1:1599::11]:43890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1cnqg1-0006uW-9U
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:56:05 -0400
References: <1489511503-13334-1-git-send-email-yongbok.kim@imgtec.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <d89215ef-4c61-8341-165a-0a8b7792c1d8@reactos.org>
Date: Tue, 14 Mar 2017 18:55:57 +0100
MIME-Version: 1.0
In-Reply-To: <1489511503-13334-1-git-send-email-yongbok.kim@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] dma/rc4030: fix a mixed declarations and
 code warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>, QEMU Developers <qemu-devel@nongnu.org>

Le 14/03/2017 =E0 18:11, Yongbok Kim a =E9crit :
> Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>

Reviewed-by: Herv=E9 Poussineau <hpoussin@reactos.org>

> ---
>  hw/dma/rc4030.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
> index 8ad97f1..4dbb4fd 100644
> --- a/hw/dma/rc4030.c
> +++ b/hw/dma/rc4030.c
> @@ -99,8 +99,8 @@ typedef struct rc4030State
>
>  static void set_next_tick(rc4030State *s)
>  {
> -    qemu_irq_lower(s->timer_irq);
>      uint32_t tm_hz;
> +    qemu_irq_lower(s->timer_irq);
>
>      tm_hz =3D 1000 / (s->itr + 1);
>
>
