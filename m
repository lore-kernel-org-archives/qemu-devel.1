Received: from eggs.gnu.org ([2001:4830:134:3::10]:60895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gadLr-0007yf-IV
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:13:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gadLn-0005up-SY
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:13:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gadLl-0005qi-SV
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:13:38 -0500
Received: by mail-wr1-f68.google.com with SMTP id j2so7485486wrw.1
	for <qemu-devel@nongnu.org>; Sat, 22 Dec 2018 01:13:35 -0800 (PST)
References: <20181221063002.7570-1-pbonzini@redhat.com>
	<cb7a9fc9-cded-7ca5-dbb9-8ffde9670fa7@redhat.com>
	<faa89439-18ae-931b-54c7-212b7dea0e48@redhat.com>
	<1545440514.44118.11.camel@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <588440e5-7fb2-7404-935e-f61c22c83b16@redhat.com>
Date: Sat, 22 Dec 2018 10:13:33 +0100
MIME-Version: 1.0
In-Reply-To: <1545440514.44118.11.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Robert Hoo <robert.hu@linux.intel.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, luwei.kang@intel.com
Cc: robert.hu@intel.com, qemu-stable@nongnu.org

On 22/12/18 02:01, Robert Hoo wrote:
> On Fri, 2018-12-21 at 16:27 +0100, Paolo Bonzini wrote:
>> On 21/12/18 16:22, Philippe Mathieu-Daudé wrote:
>>> Hi Paolo,
>>>
>>> On 12/21/18 7:30 AM, Paolo Bonzini wrote:
>>>> From: Robert Hoo <robert.hu@linux.intel.com>
>>>>
>>>> Processor tracing is not yet implemented for KVM and it will be
>>>> an
>>>> opt in feature requiring a special module parameter.
>>>> Disable it, because it is wrong to enable it by default and
>>>> it is impossible that no one has ever used it.
>>>>
>>>> Cc: qemu-stable@nongnu.org
>>>
>>> Does this patch misses Robert S-o-b?
>>> Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> 
> Paolo's right. It didn't come from me.
>>
>> No, the author is wrong, it should be me.  "git commit -c" apparently
>> copies the author from the original commit.
>>
>> Paolo
> 
> Hi Paolo, would you hold on INTEL_PT removal for a moment? I think I
> need Luwei's double confirm.

I'm aware of Luwei's patches, they will be in 4.21.  As mentioned in the
commit message, they will be an opt-in feature, not enabled by default;
the default is system-wide tracing and no INTEL_PT CPUID bit available
in the guest.

Paolo
