Received: from eggs.gnu.org ([2001:4830:134:3::10]:35517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fJj0s-0006sJ-NI
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:17:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fJj0o-0006Zr-OZ
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:17:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45122 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fJj0o-0006Zb-JX
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:17:50 -0400
References: <1526568841-35372-1-git-send-email-mst@redhat.com>
	<20180517184658.GA1543@localhost.localdomain>
	<20180517225316-mutt-send-email-mst@kernel.org>
	<20180518160431.GX25013@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9d528020-87f6-a600-9d08-02c88d20b18c@redhat.com>
Date: Fri, 18 May 2018 19:17:43 +0200
MIME-Version: 1.0
In-Reply-To: <20180518160431.GX25013@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] kvm: rename HINTS_DEDICATED to
 KVM_HINTS_REALTIME
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, qemu-devel@nongnu.org

On 18/05/2018 18:04, Eduardo Habkost wrote:
>> Without mlock you should always use pv spinlocks.
>>
>> Otherwise you risk blocking on a lock taken by
>> a VCPU that is in turn blocked on IO, where the IO
>> is not completing because CPU is being used up
>> spinning.
>
> So the stronger guarantee seems necessary.
> 
> Now what should host userspace do if the user is trying to run an
> existing configuration where the CPUID hint was set but memory is
> not pinned?

As mentioned elsewhere in the thread, there are many ways to pin memory,
and mlock is not always necessary.  However, I agree with Michael in
making the hint provide a stronger guarantee.

Paolo
