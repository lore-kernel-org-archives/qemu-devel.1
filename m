Received: from eggs.gnu.org ([2001:4830:134:3::10]:37248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dOKEU-0005y6-JM
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 04:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dOKEP-0007Tg-Op
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 04:46:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dOKEP-0007TN-Ir
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 04:46:21 -0400
References: <20170622124204.19407-1-marcandre.lureau@redhat.com>
	<20170622124204.19407-32-marcandre.lureau@redhat.com>
	<4c3acdae-a0b6-38a3-ee74-e774ea94c56a@weilnetz.de>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d4c9c6b7-8652-22a8-41b6-b53cacdc2b75@redhat.com>
Date: Fri, 23 Jun 2017 16:46:14 +0800
MIME-Version: 1.0
In-Reply-To: <4c3acdae-a0b6-38a3-ee74-e774ea94c56a@weilnetz.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 31/31] eepro100: replace
 g_malloc()+memcpy() with g_memdup()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org



On 2017=E5=B9=B406=E6=9C=8822=E6=97=A5 21:09, Stefan Weil wrote:
> Am 22.06.2017 um 14:42 schrieb Marc-Andr=C3=A9 Lureau:
>> I found these pattern via grepping the source tree. I don't have a
>> coccinelle script for it!
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>   hw/net/eepro100.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
>> index 4bf71f2d85..7d3b2e52c7 100644
>> --- a/hw/net/eepro100.c
>> +++ b/hw/net/eepro100.c
>> @@ -1894,8 +1894,7 @@ static void e100_nic_realize(PCIDevice *pci_dev,=
 Error **errp)
>>  =20
>>       qemu_register_reset(nic_reset, s);
>>  =20
>> -    s->vmstate =3D g_malloc(sizeof(vmstate_eepro100));
>> -    memcpy(s->vmstate, &vmstate_eepro100, sizeof(vmstate_eepro100));
>> +    s->vmstate =3D g_memdup(&vmstate_eepro100, sizeof(vmstate_eepro10=
0));
>>       s->vmstate->name =3D qemu_get_queue(s->nic)->model;
>>       vmstate_register(&pci_dev->qdev, -1, s->vmstate, s);
>>   }
>>
> Reviewed-by: Stefan Weil <sw@weilnetz.de>
>

Reviewed-by: Jason Wang <jasowang@redhat.com>
