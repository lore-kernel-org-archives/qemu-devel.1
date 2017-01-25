Received: from eggs.gnu.org ([2001:4830:134:3::10]:52901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cWWyS-0008O6-AB
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 18:27:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cWWyR-0004mk-LO
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 18:27:32 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:33436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1cWWyR-0004lf-Gd
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 18:27:31 -0500
Received: by mail-oi0-x242.google.com with SMTP id j15so16845857oih.0
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 15:27:29 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <f60c6090-0ca8-8ce9-8015-4e8e34123a5a@vivier.eu>
References: <1485377117-18105-1-git-send-email-thuth@redhat.com>
	<f60c6090-0ca8-8ce9-8015-4e8e34123a5a@vivier.eu>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 25 Jan 2017 15:26:58 -0800
Message-ID: <CAKmqyKMyzquxEGTF4Un_1WvwBNXOoJU1g67_9fFarVy-yeff+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/core/generic-loader: Fix crash when
 running without CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>

On Wed, Jan 25, 2017 at 12:52 PM, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 25/01/2017 =C3=A0 21:45, Thomas Huth a =C3=A9crit :
>> When running QEMU with "-M none -device loader,file=3Dkernel.elf", it
>> currently crashes with a segmentation fault, because the "none"-machine
>> does not have any CPU by default and the generic loader code tries
>> to dereference s->cpu. Fix it by adding an appropriate check for a
>> NULL pointer.
>>
>> Reported-by: Laurent Vivier <laurent@vivier.eu>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  hw/core/generic-loader.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
>> index 58f1f02..4601267 100644
>> --- a/hw/core/generic-loader.c
>> +++ b/hw/core/generic-loader.c
>> @@ -137,20 +137,21 @@ static void generic_loader_realize(DeviceState *de=
v, Error **errp)
>>  #endif
>>
>>      if (s->file) {
>> +        AddressSpace *as =3D s->cpu ? s->cpu->as :  NULL;
>
> Should we just abort if s->cpu is NULL?

I agree, what is the use case where you are loading images without a CPU?

If there is a use case (maybe some KVM thing?) then this patch looks fine t=
o me.

Thanks,

Alistair

>
> Laurent
>
>
