Received: from eggs.gnu.org ([2001:4830:134:3::10]:38679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXTlJ-0002Cu-2K
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:46:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXTlF-0002OI-9k
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:46:09 -0400
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-16-f4bug@amsat.org>
	<CAJ+F1CJh-pX4rvuZKCzYiDE+8Spruan-w73qZk+=BWsLFG5OAg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bdc516ce-f893-1b93-d01a-b648fedd704d@redhat.com>
Date: Tue, 18 Jul 2017 16:46:01 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJh-pX4rvuZKCzYiDE+8Spruan-w73qZk+=BWsLFG5OAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 15/29] microblaze: use QEMU_IS_ALIGNED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu trival <qemu-trivial@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU <qemu-devel@nongnu.org>

On 18.07.2017 13:08, Marc-Andr=C3=A9 Lureau wrote:
> On Mon, Jul 17, 2017 at 11:09 PM, Philippe Mathieu-Daud=C3=A9
> <f4bug@amsat.org> wrote:
>> Applied using the Coccinelle semantic patch scripts/coccinelle/use_osd=
ep.cocci
>> (also added braces to satisfy checkpatch)
[...]
>> diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_help=
er.c
>> index 1e07e21c1c..41ab52fb7a 100644
>> --- a/target/microblaze/op_helper.c
>> +++ b/target/microblaze/op_helper.c
>> @@ -108,8 +108,9 @@ void helper_debug(CPUMBState *env)
>>               (env->sregs[SR_MSR] & MSR_IE));
>>      for (i =3D 0; i < 32; i++) {
>>          qemu_log("r%2.2d=3D%8.8x ", i, env->regs[i]);
>> -        if ((i + 1) % 4 =3D=3D 0)
>> +        if (QEMU_IS_ALIGNED(i + 1, 4)) {
>>              qemu_log("\n");
>> +        }
>>      }
>>      qemu_log("\n\n");
>>  }
>> diff --git a/target/microblaze/translate.c b/target/microblaze/transla=
te.c
>> index cb65d1e129..ae7b3c71b0 100644
>> --- a/target/microblaze/translate.c
>> +++ b/target/microblaze/translate.c
>> @@ -1839,9 +1839,10 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, f=
printf_function cpu_fprintf,
>>
>>      for (i =3D 0; i < 32; i++) {
>>          cpu_fprintf(f, "r%2.2d=3D%8.8x ", i, env->regs[i]);
>> -        if ((i + 1) % 4 =3D=3D 0)
>> +        if (QEMU_IS_ALIGNED(i + 1, 4)) {
>>              cpu_fprintf(f, "\n");
>>          }
>> +    }
>>      cpu_fprintf(f, "\n\n");
>>  }

I'd also vote to keep the original code here ... it's about pretty
printing, not about checking the alignment of addresses.

 Thomas
