Received: from eggs.gnu.org ([2001:4830:134:3::10]:50815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fTUMm-0005Bn-Ne
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fTUMh-00013N-PB
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:40:52 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:34260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fTUMh-000134-HJ
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:40:47 -0400
Received: by mail-wr0-x243.google.com with SMTP id a12-v6so6953592wro.1
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 08:40:47 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180612184616.90838-1-mst@redhat.com>
	<20180614081800.GH6355@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2219a7fd-b496-6653-b79a-c20136727f98@redhat.com>
Date: Thu, 14 Jun 2018 17:40:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180614081800.GH6355@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/2] kvm: x86 CPU power management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On 14/06/2018 10:18, Daniel P. Berrangé wrote:
> I don't think
> the -realtime flag should ever have been introduced, and we certainly
> shouldn't add more stuff under it.
> 
> "-realtime" is referring to a very specific use case, while the
> properties listed under it are all general purpose features. Real
> time guests just happen to be one possible use case, but it is
> valid to use them for non-real time guests.
> 
> IOW, I think we should just have this as an option under -cpu or
> some other *functionally* named option, not a option named after
> a specific usage scenario.

"-cpu" is certainly wrong for KVM_CAP_X86_DISABLE_EXITS. "-cpu" is a
device option, while this is about host behavior.  "-realtime"'s name is
awful, but I still think it's the best place for this option.  Maybe we
could call it "-realtime power-mgmt={host|guest}".

A separate issue is whether the same flag should control both
KVM_CAP_X86_DISABLE_EXITS and the monitor/mwait CPUID leaf.  Eduardo,
what do you think?

Paolo
