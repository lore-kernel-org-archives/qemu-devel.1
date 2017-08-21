Received: from eggs.gnu.org ([2001:4830:134:3::10]:47954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1djlGF-0005M0-Fc
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 07:52:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1djlGA-00049q-K0
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 07:52:50 -0400
Received: from mail-by2nam01on0068.outbound.protection.outlook.com
	([104.47.34.68]:28128
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1djlGA-00049L-4t
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 07:52:46 -0400
References: <20170815170051.127257-1-brijesh.singh@amd.com>
	<276d5c64-7ef3-127b-b2f4-e5f7b3a5aab4@redhat.com>
	<2f426b2d-cea3-bed4-1966-6868d6e3bbfe@amd.com>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <bc615022-ef99-026a-742d-c53c2a4297ed@amd.com>
Date: Mon, 21 Aug 2017 06:52:37 -0500
MIME-Version: 1.0
In-Reply-To: <2f426b2d-cea3-bed4-1966-6868d6e3bbfe@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3] target-i386/cpu: Add new EPYC CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: brijesh.singh@amd.com, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Tom Lendacky <Thomas.Lendacky@amd.com>

Hi Paolo,


On 8/17/17 1:37 PM, Brijesh Singh wrote:
> On 08/17/2017 11:45 AM, Paolo Bonzini wrote:
>> On 15/08/2017 19:00, Brijesh Singh wrote:
>>>
>>> The following features bits have been added/removed compare to
>>> Opteron_G5
>>>
>>> Added: monitor, movbe, rdrand, mmxext, ffxsr, rdtscp, cr8legacy, osvw,
>>>         fsgsbase, bmi1, avx2, smep, bmi2, rdseed, adx, smap,
>>> clfshopt, sha
>>>         xsaveopt, xsavec, xgetbv1, arat
>>>
>>> Removed: xop, fma4, tbm
>>
>> Interesting, why were these removed?
>>
>
> I don't know exact reason why these were removed - I am going with
> whatever is
> listed as supported feature bit in PPR [1], but I will ask around and
> let you
> know. I believe some of these instruction are superseded with newer
> instructions
> (e.g fma4->fma)
>
> [1]
> http://support.amd.com/TechDocs/54945_PPR_Family_17h_Models_00h-0Fh.pdf
>
>

I checked with CPU team, it seems those instruction sets were never
really used, I believe AMD came up with them but they were superseded by
SSE4/AVX extensions.

-Brijesh
