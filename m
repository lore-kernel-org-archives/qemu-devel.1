Received: from eggs.gnu.org ([2001:4830:134:3::10]:41959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYXmw-00030h-ET
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYXmr-0008O4-HO
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:20:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48994 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fYXmr-0008M8-Cm
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:20:41 -0400
References: <1530098844-236851-1-git-send-email-robert.hu@linux.intel.com>
	<1530098844-236851-2-git-send-email-robert.hu@linux.intel.com>
	<20180627170304.GD914@localhost.localdomain>
	<1530177956.22880.32.camel@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ce3282a7-310c-6c53-05b8-f00afb787279@redhat.com>
Date: Thu, 28 Jun 2018 16:20:37 +0200
MIME-Version: 1.0
In-Reply-To: <1530177956.22880.32.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/5] i386: Add support for IA32_PRED_CMD
 and IA32_ARCH_CAPABILITIES MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Robert Hoo <robert.hu@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, wei.w.wang@intel.com

On 28/06/2018 11:25, Robert Hoo wrote:
>>> +    uint64_t pred_cmd;
>>> +    uint64_t arch_capabilities;
>> What's the purpose of those CPUX86State fields, if the migration
>> sections were removed in v2?
>>
> Thanks Eduardo. Going to clean up in v3. Any more comments, regarding
> other patches?

Yes - something like arch_capabilities must stay, as it will be filled
in with "CPUID-like" feature bits that are actually visible to the guest
via the MSR.

However, I suggest adding it to the FeatureWord enum, since everything
that handles FeatureWord applies to this new kind of MSR as well.
Currently FeatureWord is only for CPUID leaves, but it doesn't have to
be like that.

Paolo
