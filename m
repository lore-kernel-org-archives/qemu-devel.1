Received: from eggs.gnu.org ([2001:4830:134:3::10]:43208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fJjap-0003fb-Oh
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:55:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fJjak-0007Mu-Ti
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:55:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fJjak-0007LI-NK
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:54:58 -0400
Date: Fri, 18 May 2018 14:54:51 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180518175451.GD25013@localhost.localdomain>
References: <1526568841-35372-1-git-send-email-mst@redhat.com>
	<20180517184658.GA1543@localhost.localdomain>
	<20180517225316-mutt-send-email-mst@kernel.org>
	<20180518160431.GX25013@localhost.localdomain>
	<20180518195139-mutt-send-email-mst@kernel.org>
	<20180518171311.GB25013@localhost.localdomain>
	<0764c230-3f84-36a5-ad89-fc8dd318d1e4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0764c230-3f84-36a5-ad89-fc8dd318d1e4@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, qemu-devel@nongnu.org

On Fri, May 18, 2018 at 07:18:57PM +0200, Paolo Bonzini wrote:
> On 18/05/2018 19:13, Eduardo Habkost wrote:
> >> As much as we'd like to be helpful and validate input, you need a real
> >> time host too. I'm not sure how we'd find out - I suggest we do not
> >> bother for now.
> > I'm worried that people will start enabling the flag in all kinds
> > of scenarios where the guarantees can't be kept, and make the
> > meaning of the flag in practice completely different from its
> > documented meaning.
> 
> I don't think we should try to detect anything.  As far as QEMU is
> concerned, it's mostly garbage in, garbage out when it comes to invalid
> configurations.  It's just a bit, and using it in invalid configurations
> is okay if you're doing it (for example) for debugging.

In this case, I'd like the requirements and recommendations to be
included in QEMU documentation.  Especially to point out the most
obvious and more likely mistakes (like not ensuring memory is
pinned at all, or letting the vCPU threads be interrupted).

So, is there a known list of steps required to configure a host
to enable kvm-hints-realtime safely, already?  I'd like the
documentation to be better than "you should fiddle with the CPU
affinity on your system and also ensure memory will be pinned;
good luck".

-- 
Eduardo
