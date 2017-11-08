Received: from eggs.gnu.org ([2001:4830:134:3::10]:45544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eCNOW-0008J5-0J
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:15:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eCNOR-000566-Tt
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:15:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eCNOR-00054m-O0
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:15:35 -0500
References: <20171108022828.7242-1-f4bug@amsat.org>
	<20171108022828.7242-6-f4bug@amsat.org>
	<20171108091628.GI12670@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <68054d7f-85e2-62e0-bb24-701be23b45ee@redhat.com>
Date: Wed, 8 Nov 2017 11:15:26 +0100
MIME-Version: 1.0
In-Reply-To: <20171108091628.GI12670@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 5/6] hw/i386: deprecate the pc-0.10 and
 pc-0.11 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

On 08.11.2017 10:16, Daniel P. Berrange wrote:
> On Tue, Nov 07, 2017 at 11:28:27PM -0300, Philippe Mathieu-Daud=C3=A9 w=
rote:
>> Both are deprecated since 2.9.0
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>  hw/i386/pc_piix.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> index f79d5cb694..c462b702ff 100644
>> --- a/hw/i386/pc_piix.c
>> +++ b/hw/i386/pc_piix.c
>> @@ -941,6 +941,7 @@ static void pc_i440fx_0_11_machine_options(Machine=
Class *m)
>>      pc_i440fx_0_12_machine_options(m);
>>      m->hw_version =3D "0.11";
>>      SET_MACHINE_COMPAT(m, PC_COMPAT_0_11);
>> +    m->deprecated_reason =3D "Too old";
>>  }
>> =20
>>  DEFINE_I440FX_MACHINE(v0_11, "pc-0.11", pc_compat_0_13,
>> @@ -976,6 +977,7 @@ static void pc_i440fx_0_10_machine_options(Machine=
Class *m)
>>      pc_i440fx_0_11_machine_options(m);
>>      m->hw_version =3D "0.10";
>>      SET_MACHINE_COMPAT(m, PC_COMPAT_0_10);
>> +    m->deprecated_reason =3D "Too old";
>>  }
>=20
> Any deprecation message should give users useful information about what
> they should do instead to avoid the problem.

+1

> More generally though, what would removing these two machines types all=
ow
> us to actually achieve ? Seems quite arbitrary to pick 0.10 and 0.11 bu=
t
> leave the other 20+ machine types.

We've discussed this a couple of months ago on the mailing list: The
basic idea is that the oldest machine type that is still in use is 0.12
(as a base for the RHEL 6 machines), so we should avoid to get rid of
that code yet. But 0.10 and 0.11 very likely do not have any users
anymore, so it should be OK to deprecate them.

 Thomas
