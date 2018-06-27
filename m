Received: from eggs.gnu.org ([2001:4830:134:3::10]:58982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYC2j-00005j-2r
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 11:07:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYC2g-000692-Dt
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 11:07:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39298 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fYC2g-00068n-7o
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 11:07:34 -0400
References: <20180627144834.GA20218@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ee18a045-4fd1-4088-44e7-3a97fc759aa3@redhat.com>
Date: Wed, 27 Jun 2018 17:07:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180627144834.GA20218@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] MSRC001_102C on EPYC (was Re: [PATCH v3]
 target-i386/cpu: Add new EPYC CPU model)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Babu Moger <babu.moger@amd.com>
Cc: qemu-devel@nongnu.org, Tom Lendacky <Thomas.Lendacky@amd.com>, Richard Henderson <rth@twiddle.net>, "Daniel P. Berrange" <berrange@redhat.com>, Jon Masters <jcm@redhat.com>

On 27/06/2018 16:48, Eduardo Habkost wrote:
> Hi,
>=20
> On Tue, Aug 15, 2017 at 12:00:51PM -0500, Brijesh Singh wrote:
>> Add a new base CPU model called 'EPYC' to model processors from AMD EP=
YC
>> family (which includes EPYC 76xx,75xx,74xx, 73xx and 72xx).
>>
>> The following features bits have been added/removed compare to Opteron=
_G5
>>
>> Added: monitor, movbe, rdrand, mmxext, ffxsr, rdtscp, cr8legacy, osvw,
>>        fsgsbase, bmi1, avx2, smep, bmi2, rdseed, adx, smap, clfshopt, =
sha
>>        xsaveopt, xsavec, xgetbv1, arat
>>
>> Removed: xop, fma4, tbm
>>
> [...]
>> +    {
>> +        .name =3D "EPYC",
>> +        .level =3D 0xd,
>> +        .vendor =3D CPUID_VENDOR_AMD,
>> +        .family =3D 23,
>> +        .model =3D 1,
>> +        .stepping =3D 2,
>=20
> These f/m/s values trigger model-specific code in Windows 10
> guests[1], and I couldn't find any public information that allow
> us to fix the problem.

At least family 17h should be set for EPYC processors.

> Windows 10 tries to set bit 15 of MSRC001_102C, in code that
> looks like workarounds for CPU Erratas.
>=20
> I found a Revision Guide for family 17h[2], but it has no mention
> of MSRC001_102C at all.

I also found a "Processor Programming Reference"
(https://support.amd.com/TechDocs/54945_PPR_Family_17h_Models_00h-0Fh.pdf=
)
but it's not there either.

It's okay I think if KVM is modified to either return zero and ignore
writes, or return 0x8000, but I'd like confirmation from AMD too.

Paolo
