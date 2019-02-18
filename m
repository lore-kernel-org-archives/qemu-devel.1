Received: from eggs.gnu.org ([209.51.188.92]:44196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <remi.denis.courmont@huawei.com>) id 1gviSx-0007mz-7w
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:56:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <remi.denis.courmont@huawei.com>) id 1gviSw-0000Pf-CE
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:56:11 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:45343 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <remi.denis.courmont@huawei.com>)
	id 1gviSw-0000Mp-66
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:56:10 -0500
From: Remi Denis Courmont <remi.denis.courmont@huawei.com>
Date: Mon, 18 Feb 2019 12:56:01 +0000
Message-ID: <C029431E20CCA74C901B75816C3A8BB108B79605@lhreml501-mbx>
References: <20190208173520.15007-1-remi@remlab.net>
	<b7f75e48-e710-46fc-a420-8cba0d663542@vivier.eu>,
	<ddd021dc-7760-6d38-729e-d7ae534549d3@vivier.eu>
In-Reply-To: <ddd021dc-7760-6d38-729e-d7ae534549d3@vivier.eu>
Content-Language: fr-FR
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] linux-user: check valid address in
 access_ok()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, =?iso-8859-1?Q?R=E9mi_Denis-Courmont?= <remi@remlab.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi,=0A=
=0A=
I don't think that len =3D=3D 0 is a sufficient condition to eliminate inte=
ger overflow. It only ensures that size - 1 is a positive quantity.=0A=
=0A=
________________________________________=0A=
De : Laurent Vivier [laurent@vivier.eu]=0A=
Envoy=E9 : jeudi 14 f=E9vrier 2019 11:22=0A=
=C0 : R=E9mi Denis-Courmont; qemu-devel@nongnu.org=0A=
Cc : Remi Denis Courmont=0A=
Objet : Re: [Qemu-devel] [PATCH] linux-user: check valid address in access_=
ok()=0A=
=0A=
On 08/02/2019 19:33, Laurent Vivier wrote:=0A=
> On 08/02/2019 18:35, R=E9mi Denis-Courmont wrote:=0A=
>> This works around the LTP crash, but there are problably better ways to=
=0A=
>> go about it.=0A=
>>=0A=
>> Signed-off-by: R=E9mi Denis-Courmont <remi@remlab.net>=0A=
>> Cc: <lvivier@redhat.com>=0A=
>> ---=0A=
>>  linux-user/qemu.h | 3 ++-=0A=
>>  1 file changed, 2 insertions(+), 1 deletion(-)=0A=
>>=0A=
>> diff --git a/linux-user/qemu.h b/linux-user/qemu.h=0A=
>> index ef400cb78a..1d222a0cce 100644=0A=
>> --- a/linux-user/qemu.h=0A=
>> +++ b/linux-user/qemu.h=0A=
>> @@ -457,7 +457,8 @@ extern unsigned long guest_stack_size;=0A=
>>=0A=
>>  static inline int access_ok(int type, abi_ulong addr, abi_ulong size)=
=0A=
>>  {=0A=
>> -    return page_check_range((target_ulong)addr, size,=0A=
>> +    return guest_addr_valid(addr) && guest_addr_valid(addr + size) &&=
=0A=
>=0A=
> I think it should be guest_addr_valid(addr + size - 1).=0A=
=0A=
In fact (len =3D=3D 0 || guest_addr_valid(addr + size - 1)).=0A=
=0A=
Could you send a new version of your patch?=0A=
=0A=
I've received several mail delivery system errors regarding your email=0A=
address remi@remlab.net.=0A=
=0A=
Thanks,=0A=
Laurent=0A=
=0A=
