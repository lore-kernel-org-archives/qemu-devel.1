Received: from eggs.gnu.org ([2001:4830:134:3::10]:59048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Thomas.Lendacky@amd.com>) id 1fROqP-0008O9-Fk
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 17:22:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Thomas.Lendacky@amd.com>) id 1fROqM-0003lh-AW
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 17:22:49 -0400
Received: from mail-co1nam03on0042.outbound.protection.outlook.com
	([104.47.40.42]:36476
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Thomas.Lendacky@amd.com>)
	id 1fROqL-0003kt-U2
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 17:22:46 -0400
References: <20180601145921.9500-1-konrad.wilk@oracle.com>
	<20180601153809.15259-1-konrad.wilk@oracle.com>
	<20180601153809.15259-2-konrad.wilk@oracle.com>
	<20180604200701.GB3184@localhost.localdomain>
	<caa3376a-252b-0a85-1a63-d2a6a911739c@amd.com>
	<20180606142052.GG3064@redhat.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <a4305137-99eb-98b9-4063-b63b06825b2a@amd.com>
Date: Fri, 8 Jun 2018 16:22:32 -0500
MIME-Version: 1.0
In-Reply-To: <20180606142052.GG3064@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] i386: define the AMD 'amd-ssbd' CPUID
 feature bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, pbonzini@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, rth@twiddle.net

On 6/6/2018 9:20 AM, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Jun 05, 2018 at 08:31:41AM -0500, Tom Lendacky wrote:
>> On 6/4/2018 3:07 PM, Eduardo Habkost wrote:
>>> On Fri, Jun 01, 2018 at 11:38:08AM -0400, Konrad Rzeszutek Wilk wrote:
>>>> AMD future CPUs expose _two_ ways to utilize the Intel equivalant
>>>> of the Speculative Store Bypass Disable. The first is via
>>>> the virtualized VIRT_SPEC CTRL MSR (0xC001_011f) and the second
>>>> is via the SPEC_CTRL MSR (0x48). The document titled:
>>>> 124441_AMD64_SpeculativeStoreBypassDisable_Whitepaper_final.pdf
>>>>
>>>> gives priority of SPEC CTRL MSR over the VIRT SPEC CTRL MSR.
>>>>
>>>> A copy of this document is available at
>>>>       https://bugzilla.kernel.org/show_bug.cgi?id=3D199889
>>>>
>>>> Anyhow, this means that on future AMD CPUs there will be  _two_ ways t=
o
>>>> deal with SSBD.
>>>
>>> Does anybody know if there are AMD CPUs where virt-ssbd won't
>>> work and would require amd-ssbd to mitigate vulnerabilities?
>>
>> The idea behind virt-ssbd was to provide an architectural method for
>> a guest to do SSBD when amd-ssbd isn't present.  The amd-ssbd feature
>> will use SPEC_CTRL which is intended to not be intercepted and
>> will be fast.  The use of virt-ssbd will always be intercepted and
>> therefore will not be as fast.  So a guest should be presented with
>> amd-ssbd, if available, in preference to virt-ssbd.
>=20
> Can you clarify whether 'amd-ssbd' is also an architectural method

Yes, amd-ssbd is architectural - it is a defined CPUID bit.

Thanks,
Tom

> or not ?  ie is it safe to use 'amd-ssbd' in a guest which can be
> live migrated between different generations/families of AMD CPU,
> or must be use virt-ssbd in that case ?
>=20
>=20
> Regards,
> Daniel
>=20
