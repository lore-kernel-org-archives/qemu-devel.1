Received: from eggs.gnu.org ([2001:4830:134:3::10]:52838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1e8KMh-0002hr-Df
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 02:13:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1e8KMg-0004zK-Cz
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 02:13:03 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:56722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1e8KMg-0004yE-44
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 02:13:02 -0400
Received: by mail-wr0-x241.google.com with SMTP id r79so7857894wrb.13
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 23:13:02 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <cb2390f6-61e7-7f9b-0e94-a0f2abf88af3@amsat.org>
References: <382833937419ccd4de5de9b65f74ca561cfa328d.1509114880.git.alistair.francis@xilinx.com>
	<cb2390f6-61e7-7f9b-0e94-a0f2abf88af3@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Sat, 28 Oct 2017 08:12:30 +0200
Message-ID: <CAKmqyKNbq7dYR8iaBVbbG=Nvp=iYdqdH9O=uHR8RHV+m3ovJJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/1] xlnx-zcu102: Specify the number of
 max CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Edgar Iglesias <edgar.iglesias@gmail.com>

On Fri, Oct 27, 2017 at 8:22 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> Hi Alistair,
>
> On 10/27/2017 11:35 AM, Alistair Francis wrote:
>> Specify the number of CPUs that can run on ZynqMP.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>>
>>  hw/arm/xlnx-zcu102.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
>> index 519a16ed98..b86c048bb3 100644
>> --- a/hw/arm/xlnx-zcu102.c
>> +++ b/hw/arm/xlnx-zcu102.c
>> @@ -240,6 +240,7 @@ static void xlnx_zcu102_machine_class_init(ObjectCla=
ss *oc, void *data)
>>      mc->block_default_type =3D IF_IDE;
>>      mc->units_per_default_bus =3D 1;
>>      mc->ignore_memory_transaction_failures =3D true;
>> +    mc->max_cpus =3D 6;
>
> This can be self-explanatory:
>
>     mc->max_cpus =3D XLNX_ZYNQMP_NUM_APU_CPUS + XLNX_ZYNQMP_NUM_RPU_CPUS;

Ah good point.

I won't be able to update that until I'm back from holidays.

>
> Then:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Thanks!
Alistair

>
>>  }
>>
>>  static const TypeInfo xlnx_zcu102_machine_init_typeinfo =3D {
>>
