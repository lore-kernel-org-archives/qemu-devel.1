Received: from eggs.gnu.org ([209.51.188.92]:43457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hF0rh-00068f-Bj
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:25:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hF0rd-0005G3-GX
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:25:27 -0400
References: <20190412152619.23542-1-thuth@redhat.com>
	<2c7385cf-78ba-3331-53f0-1973408f0e4d@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b0f8958c-0266-e478-29de-93f60a8edda8@redhat.com>
Date: Fri, 12 Apr 2019 20:25:03 +0200
MIME-Version: 1.0
In-Reply-To: <2c7385cf-78ba-3331-53f0-1973408f0e4d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.1] hw/arm/nseries: Deprecate the n800
 and n810 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 12/04/2019 18.21, Philippe Mathieu-Daud=C3=A9 wrote:
> On 4/12/19 5:26 PM, Thomas Huth wrote:
>> These machines depend on the deprecated bluetooth subsystem. In case w=
e
>> finally decide to remove the bluetooth subsystem, we likely need to
>> remove the n800 and n810 machines, too, so mark them now as deprecated=
.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  hw/arm/nseries.c     | 3 +++
>>  qemu-deprecated.texi | 6 ++++++
>>  2 files changed, 9 insertions(+)
>>
>> diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
>> index 906b7ca22d..66e50b850c 100644
>> --- a/hw/arm/nseries.c
>> +++ b/hw/arm/nseries.c
>> @@ -1309,6 +1309,9 @@ static void n8x0_init(MachineState *machine,
>>      struct n800_s *s =3D (struct n800_s *) g_malloc0(sizeof(*s));
>>      int sdram_size =3D binfo->ram_size;
>> =20
>> +    warn_report("The n800 and n810 machines are deprecated. Please us=
e a "
>> +                "different Arm machine instead.");
>> +
>=20
> Unrelated to this patch, but can you add a similar warning in
> uart_hci_init() to make obvious that the bluetooth subsystem is now
> deprecated?

It's already there, in vl.c, case QEMU_OPTION_bt.

 Thomas
