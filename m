Received: from eggs.gnu.org ([209.51.188.92]:38050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <puwen@hygon.cn>) id 1hGI2X-0006Tc-2V
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 02:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <puwen@hygon.cn>) id 1hGI2U-0006GM-9a
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 02:57:56 -0400
Received: from [110.188.70.11] (port=25496 helo=spam2.hygon.cn)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <puwen@hygon.cn>) id 1hGI2Q-00066z-GP
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 02:57:52 -0400
References: <1555124080-27089-1-git-send-email-puwen@hygon.cn>
	<20190415092500.GD5718@redhat.com>
From: Pu Wen <puwen@hygon.cn>
Message-ID: <aa92336f-681e-30d9-2670-7d0093d9912a@hygon.cn>
Date: Tue, 16 Apr 2019 14:56:12 +0800
MIME-Version: 1.0
In-Reply-To: <20190415092500.GD5718@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] i386: Add new Hygon 'Dhyana' CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>

On 2019/4/15 17:25, Daniel P. Berrang=C3=A9 wrote:
> On Sat, Apr 13, 2019 at 10:54:40AM +0800, Pu Wen wrote:
...
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index f2c15bf..551bec9 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -128,6 +128,8 @@ GlobalProperty pc_compat_3_1[] =3D {
>>       { "EPYC" "-" TYPE_X86_CPU, "nrip-save", "off" },
>>       { "EPYC-IBPB" "-" TYPE_X86_CPU, "npt", "off" },
>>       { "EPYC-IBPB" "-" TYPE_X86_CPU, "nrip-save", "off" },
>> +    { "Dhyana" "-" TYPE_X86_CPU, "npt", "off" },
>> +    { "Dhyana" "-" TYPE_X86_CPU, "nrip-save", "off" },
>>       { "Skylake-Client" "-" TYPE_X86_CPU,      "mpx", "on" },
>>       { "Skylake-Client-IBRS" "-" TYPE_X86_CPU, "mpx", "on" },
>>       { "Skylake-Server" "-" TYPE_X86_CPU,      "mpx", "on" },
>> @@ -152,6 +154,7 @@ GlobalProperty pc_compat_2_12[] =3D {
>>       { TYPE_X86_CPU, "topoext", "off" },
>>       { "EPYC-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
>>       { "EPYC-IBPB-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
>> +    { "Dhyana-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
>>   };
>>   const size_t pc_compat_2_12_len =3D G_N_ELEMENTS(pc_compat_2_12);
>=20
> You can drop the changes in this file. This CPU model didn't exist
> in any older QEMU releases, so there's no machine type backcompat
> required, at least from upstream QEMU POV.

Then how about running QEMU with the parameter like "-M pc-i440fx-2.12"?=20
Although the default machine is newer than that.

--=20
Regards,
Pu Wen
