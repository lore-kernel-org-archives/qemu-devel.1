Received: from eggs.gnu.org ([2001:4830:134:3::10]:33613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZxbB-0002iQ-KO
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:38:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZxb6-0002II-13
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:38:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZxb5-0002Ha-OK
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 07:38:39 -0500
References: <1545227081-213696-1-git-send-email-robert.hu@linux.intel.com>
	<1545227081-213696-2-git-send-email-robert.hu@linux.intel.com>
	<20181219140136.GJ20465@redhat.com>
	<1545265096.44118.3.camel@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e1b012da-7aac-1063-35ae-0ab3c4c5eb4b@redhat.com>
Date: Thu, 20 Dec 2018 13:38:31 +0100
MIME-Version: 1.0
In-Reply-To: <1545265096.44118.3.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] i386: remove the new CPUID 'PCONFIG'
 from Icelake-Server CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Robert Hoo <robert.hu@linux.intel.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: robert.hu@intel.com, rth@twiddle.net, ehabkost@redhat.com, thomas.lendacky@amd.com, qemu-devel@nongnu.org

On 20/12/18 01:18, Robert Hoo wrote:
> On Wed, 2018-12-19 at 14:01 +0000, Daniel P. Berrang=C3=A9 wrote:
>> On Wed, Dec 19, 2018 at 09:44:40PM +0800, Robert Hoo wrote:
>>> Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
>>> ---
>>> =C2=A0target/i386/cpu.c | 3 +--
>>> =C2=A01 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index 677a3bd..b6113d0 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -2613,8 +2613,7 @@ static X86CPUDefinition builtin_x86_defs[] =3D
>>> {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0CPUID_7_0_ECX_AVX512VNNI | CPUID_7_0_ECX_AVX512BITALG
>>> |
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0CPUID_7_0_ECX_AVX512_VPOPCNTDQ | CPUID_7_0_ECX_LA57,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.features[FEAT_=
7_0_EDX] =3D
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0CPUID_7_0_EDX_PCONFIG | CPUID_7_0_EDX_SPEC_CTRL |
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0CPUID_7_0_EDX_SPEC_CTRL_SSBD,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0CPUID_7_0_EDX_SPEC_CTRL |
>>> CPUID_7_0_EDX_SPEC_CTRL_SSBD,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Missing: XSA=
VES (not supported by some Linux versions,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* including v4.1 to v4.12).
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* KVM doesn't yet expose any XSAVES stat=
e save
>>> component,
>>
>> This was shipped in QEMU 3.1.0, so I don't think we can
>> unconditionally
>> remove it like this without breaking CPU model migration compat.=C2=A0
>>
> I think the sooner, the better. Take the time window that Icelake CPU
> model has just shipped with QEMU 3.1.0 and is not publicly/widely used
> yet.

We should still leave it in the 3.1 machine types.  I've just sent a
patch to do the same with MPX.

Paolo
