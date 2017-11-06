Received: from eggs.gnu.org ([2001:4830:134:3::10]:44734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eBg8m-0001U9-8R
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:04:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eBg8l-0006P2-CS
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:04:32 -0500
Received: from mail-ua0-x242.google.com ([2607:f8b0:400c:c08::242]:48892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eBg8l-0006OU-7s
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:04:31 -0500
Received: by mail-ua0-x242.google.com with SMTP id z4so6222815uaz.5
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 04:04:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b691e0e4-0131-202a-feb2-97659816477b@redhat.com>
References: <20171106115347.19873-1-marcandre.lureau@redhat.com>
	<b691e0e4-0131-202a-feb2-97659816477b@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 6 Nov 2017 13:04:29 +0100
Message-ID: <CAJ+F1CLFf94Rr5GewfOxh=yVonK9V5XG9fWU6h4dWySZJQj4Hw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] build-sys: restrict vmcoreinfo to
 fw_cfg+dma capable targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>

Hi

On Mon, Nov 6, 2017 at 12:58 PM, Thomas Huth <thuth@redhat.com> wrote:
> On 06.11.2017 12:53, Marc-Andr=C3=A9 Lureau wrote:
>> vmcoreinfo is built for all targets. However, it requires fw_cfg with
>> DMA operations support (write operation). Restrict vmcoreinfo exposure
>> to architectures that are supporting FW_CFG_DMA, that is arm-virt and
>> x86 only atm.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  default-configs/arm-softmmu.mak    | 2 ++
>>  default-configs/i386-softmmu.mak   | 1 +
>>  default-configs/x86_64-softmmu.mak | 1 +
>>  hw/misc/Makefile.objs              | 2 +-
>>  4 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softm=
mu.mak
>> index 5059d134c8..d37edc4312 100644
>> --- a/default-configs/arm-softmmu.mak
>> +++ b/default-configs/arm-softmmu.mak
>> @@ -130,3 +130,5 @@ CONFIG_SMBIOS=3Dy
>>  CONFIG_ASPEED_SOC=3Dy
>>  CONFIG_GPIO_KEY=3Dy
>>  CONFIG_MSF2=3Dy
>> +
>> +CONFIG_FW_CFG_DMA=3Dy
>
> Maybe remove the empty line?
>

This file seems to be organized somehow, although it's hard to figure
out how for me at first glance ;) commenting sections would help.

> Apart from that, patch looks good to me, so:
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>

thanks


--=20
Marc-Andr=C3=A9 Lureau
