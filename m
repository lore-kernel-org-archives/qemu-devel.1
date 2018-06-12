Received: from eggs.gnu.org ([2001:4830:134:3::10]:33083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fSdDm-0003BZ-ET
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:56:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fSdDj-00010v-AI
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:56:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38804 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fSdDj-00010n-4G
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:55:59 -0400
References: <20180611203712.12086-1-ehabkost@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a8426bf6-7531-6306-d1c6-bb4c6c2099cd@redhat.com>
Date: Tue, 12 Jun 2018 08:55:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180611203712.12086-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] i386: Remove ospke CPUID flag name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

On 11/06/2018 22:37, Eduardo Habkost wrote:
> RFC NOTE: Paolo, Richard, as far as I can see, there's no point
> in enabling OSPKE in user-mode QEMU.  Do you confirm that?
> 
> OSPKE is not a static feature flag: it changes dynamically at
> runtime depending on CR4, and it was never configurable: KVM
> never returned OSPKE on GET_SUPPORTED_CPUID, and on TCG enables
> it automatically if CR4_PKE_MASK is set.
> 
> Remove OSPKE from the feature name array so users don't try to
> configure it manually.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Yes, it's the same as OSXSAVE.  Thanks!

Paolo
