Received: from eggs.gnu.org ([2001:4830:134:3::10]:36968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eb19H-0001Ha-11
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:33:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eb19C-0005a4-Uw
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:33:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:2800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eb19C-0005Zr-Ng
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 04:33:42 -0500
References: <1515443797-10837-1-git-send-email-luwei.kang@intel.com>
	<20180112142252.GG6646@localhost.localdomain>
	<82D7661F83C1A047AF7DC287873BF1E167E7630B@SHSMSX101.ccr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <97bf8d29-4009-6f61-f4bb-d128da5a4c9f@redhat.com>
Date: Mon, 15 Jan 2018 10:33:35 +0100
MIME-Version: 1.0
In-Reply-To: <82D7661F83C1A047AF7DC287873BF1E167E7630B@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RESEND v1 1/2] i386: Add Intel Processor
 Trace feature support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Kang, Luwei" <luwei.kang@intel.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "rth@twiddle.net" <rth@twiddle.net>, "mtosatti@redhat.com" <mtosatti@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>

On 15/01/2018 08:19, Kang, Luwei wrote:
>> If you are forwarding host info directly to the guest, the feature
>> is not migration-safe.  The new feature needs to be added to 
>> feature_word_info[FEAT_7_0_EBX].unmigratable_flags.
>> 
> Hi, Thanks for you review. I want to support Intel PT live migration
> and patch [2/2] to do this. I don't understand  why need to add this
> feature in feature_word_info[FEAT_7_0_EBX].unmigratable_flags first
> to disable live migration.

Hi Luwei,

the issue is that different hosts can have different CPUID flags.  You
don't have a way to set the CPUID flags from the "-cpu" command line,
and it's not clear what values will be there in the various Ice Lake SKUs.

I am not sure if there is a mechanism to allow live migration only for
"-cpu host", but it cannot be supported for any other "-cpu" model.

Paolo
