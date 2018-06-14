Received: from eggs.gnu.org ([2001:4830:134:3::10]:54533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fTYud-0007pF-Dz
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:32:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fTYua-0006UR-8W
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:32:07 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36815)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fTYua-0006SE-1O
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:32:04 -0400
Received: by mail-wm0-x241.google.com with SMTP id v131-v6so133865wma.1
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 13:32:03 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180612184616.90838-1-mst@redhat.com>
	<20180614081800.GH6355@redhat.com>
	<2219a7fd-b496-6653-b79a-c20136727f98@redhat.com>
	<20180614154441.GC18967@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <14e39e34-6314-05f1-2b90-42bea564efaa@redhat.com>
Date: Thu, 14 Jun 2018 22:32:00 +0200
MIME-Version: 1.0
In-Reply-To: <20180614154441.GC18967@redhat.com>
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
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On 14/06/2018 17:44, Daniel P. Berrangé wrote:
>> "-cpu" is certainly wrong for KVM_CAP_X86_DISABLE_EXITS. "-cpu" is a
>> device option, while this is about host behavior.  "-realtime"'s name is
>> awful, but I still think it's the best place for this option.  Maybe we
>> could call it "-realtime power-mgmt={host|guest}".
> If none of the existing ones are a suitable fit, then we should just
> introduce a new CLI arg instead stuffing it into somewhere odd.

It is related to mlock in my opinion.  Both options are about applying
settings that reduce latency but may not be applicable in general.
Maybe "-realtime" could be renamed to "-perftune" or something like
that, but I'd like to keep the grouping.

Paolo

> IOW, why not just "--power-mgmt host|guest"
