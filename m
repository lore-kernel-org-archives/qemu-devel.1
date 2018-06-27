Received: from eggs.gnu.org ([2001:4830:134:3::10]:59673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1fYC52-0001ct-5f
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 11:10:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1fYC4z-0007fv-8R
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 11:10:00 -0400
Received: from mail-bn3nam01on0070.outbound.protection.outlook.com
	([104.47.33.70]:31104
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1fYC4z-0007eK-2T
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 11:09:57 -0400
References: <20180627144834.GA20218@localhost.localdomain>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <6350d004-b652-2265-65a0-d22b9de59902@amd.com>
Date: Wed, 27 Jun 2018 10:09:47 -0500
MIME-Version: 1.0
In-Reply-To: <20180627144834.GA20218@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Eduardo Habkost <ehabkost@redhat.com>, Babu Moger <babu.moger@amd.com>
Cc: brijesh.singh@amd.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Richard Henderson <rth@twiddle.net>, "Daniel P. Berrange" <berrange@redhat.com>, Jon Masters <jcm@redhat.com>

Hi Eduardo,


On 06/27/2018 09:48 AM, Eduardo Habkost wrote:
> Hi,
> 
> On Tue, Aug 15, 2017 at 12:00:51PM -0500, Brijesh Singh wrote:
>> Add a new base CPU model called 'EPYC' to model processors from AMD EPYC
>> family (which includes EPYC 76xx,75xx,74xx, 73xx and 72xx).
>>
>> The following features bits have been added/removed compare to Opteron_G5
>>
>> Added: monitor, movbe, rdrand, mmxext, ffxsr, rdtscp, cr8legacy, osvw,
>>         fsgsbase, bmi1, avx2, smep, bmi2, rdseed, adx, smap, clfshopt, sha
>>         xsaveopt, xsavec, xgetbv1, arat
>>
>> Removed: xop, fma4, tbm
>>
> [...]
>> +    {
>> +        .name = "EPYC",
>> +        .level = 0xd,
>> +        .vendor = CPUID_VENDOR_AMD,
>> +        .family = 23,
>> +        .model = 1,
>> +        .stepping = 2,
> 
> These f/m/s values trigger model-specific code in Windows 10
> guests[1], and I couldn't find any public information that allow
> us to fix the problem.
>  > Windows 10 tries to set bit 15 of MSRC001_102C, in code that
> looks like workarounds for CPU Erratas.
> 
> I found a Revision Guide for family 17h[2], but it has no mention
> of MSRC001_102C at all.
> 
> Can AMD help us fix this?
> 


IIRC, someone at AMD was looking into this. I will ask around and
update you.


> If we are unable to fix it, I plan to work around it by changing
> EPYC's family/model/stepping to the values in Opteron_G5 on QEMU
> 3.0.


I hope we find the correct definition of MSR and update the
document so that we don't need to workaround it in KVM/Qemu.


> 
> [1] Details can be seen at:
>      https://bugzilla.redhat.com/show_bug.cgi?id=1592276
>      https://bugzilla.redhat.com/show_bug.cgi?id=1593190#c12
> [2] https://developer.amd.com/wp-content/resources/55449_1.12.pdf
> 
