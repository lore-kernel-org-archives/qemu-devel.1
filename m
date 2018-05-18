Received: from eggs.gnu.org ([2001:4830:134:3::10]:35705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fJj1y-0007Ss-NL
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:19:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fJj1x-00071T-Vd
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:19:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53286 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fJj1x-00071E-Q8
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:19:01 -0400
References: <1526568841-35372-1-git-send-email-mst@redhat.com>
	<20180517184658.GA1543@localhost.localdomain>
	<20180517225316-mutt-send-email-mst@kernel.org>
	<20180518160431.GX25013@localhost.localdomain>
	<20180518195139-mutt-send-email-mst@kernel.org>
	<20180518171311.GB25013@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0764c230-3f84-36a5-ad89-fc8dd318d1e4@redhat.com>
Date: Fri, 18 May 2018 19:18:57 +0200
MIME-Version: 1.0
In-Reply-To: <20180518171311.GB25013@localhost.localdomain>
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

On 18/05/2018 19:13, Eduardo Habkost wrote:
>> As much as we'd like to be helpful and validate input, you need a real
>> time host too. I'm not sure how we'd find out - I suggest we do not
>> bother for now.
> I'm worried that people will start enabling the flag in all kinds
> of scenarios where the guarantees can't be kept, and make the
> meaning of the flag in practice completely different from its
> documented meaning.

I don't think we should try to detect anything.  As far as QEMU is
concerned, it's mostly garbage in, garbage out when it comes to invalid
configurations.  It's just a bit, and using it in invalid configurations
is okay if you're doing it (for example) for debugging.

Paolo
