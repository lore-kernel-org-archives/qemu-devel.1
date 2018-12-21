Received: from eggs.gnu.org ([2001:4830:134:3::10]:42154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gaMi9-0000BN-Qe
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 10:27:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gaMi9-0001Qd-77
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 10:27:37 -0500
References: <20181221063002.7570-1-pbonzini@redhat.com>
	<cb7a9fc9-cded-7ca5-dbb9-8ffde9670fa7@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <faa89439-18ae-931b-54c7-212b7dea0e48@redhat.com>
Date: Fri, 21 Dec 2018 16:27:29 +0100
MIME-Version: 1.0
In-Reply-To: <cb7a9fc9-cded-7ca5-dbb9-8ffde9670fa7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] i386: remove the 'INTEL_PT' CPUID bit from
 named CPU models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: robert.hu@intel.com, qemu-stable@nongnu.org, Robert Hoo <robert.hu@linux.intel.com>

On 21/12/18 16:22, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Paolo,
>=20
> On 12/21/18 7:30 AM, Paolo Bonzini wrote:
>> From: Robert Hoo <robert.hu@linux.intel.com>
>>
>> Processor tracing is not yet implemented for KVM and it will be an
>> opt in feature requiring a special module parameter.
>> Disable it, because it is wrong to enable it by default and
>> it is impossible that no one has ever used it.
>>
>> Cc: qemu-stable@nongnu.org
>=20
> Does this patch misses Robert S-o-b?
> Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>

No, the author is wrong, it should be me.  "git commit -c" apparently
copies the author from the original commit.

Paolo

>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  target/i386/cpu.c | 8 +++-----
>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index dae46f0319..9c54c41e7a 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -2493,8 +2493,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>>              CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLWB |
>>              CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
>>              CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
>> -            CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT |
>> -            CPUID_7_0_EBX_INTEL_PT,
>> +            CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT,
>>          .features[FEAT_7_0_ECX] =3D
>>              CPUID_7_0_ECX_PKU | CPUID_7_0_ECX_OSPKE |
>>              CPUID_7_0_ECX_AVX512VNNI,
>> @@ -2546,7 +2545,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>>              CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_SM=
EP |
>>              CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_I=
NVPCID |
>>              CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_=
ADX |
>> -            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_INTEL_PT,
>> +            CPUID_7_0_EBX_SMAP,
>>          .features[FEAT_7_0_ECX] =3D
>>              CPUID_7_0_ECX_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_P=
KU |
>>              CPUID_7_0_ECX_OSPKE | CPUID_7_0_ECX_VBMI2 | CPUID_7_0_ECX=
_GFNI |
>> @@ -2604,8 +2603,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D {
>>              CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_CLWB |
>>              CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
>>              CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512CD |
>> -            CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT |
>> -            CPUID_7_0_EBX_INTEL_PT,
>> +            CPUID_7_0_EBX_AVX512VL | CPUID_7_0_EBX_CLFLUSHOPT,
>>          .features[FEAT_7_0_ECX] =3D
>>              CPUID_7_0_ECX_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_P=
KU |
>>              CPUID_7_0_ECX_OSPKE | CPUID_7_0_ECX_VBMI2 | CPUID_7_0_ECX=
_GFNI |
>>
