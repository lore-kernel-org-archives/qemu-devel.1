Received: from eggs.gnu.org ([2001:4830:134:3::10]:35584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzmMQ-00061Z-NO
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 13:21:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzmMN-0006aQ-S2
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 13:21:58 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59977)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzmMN-0006Z0-IQ
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 13:21:55 -0400
Date: Tue, 11 Sep 2018 13:21:49 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180911172149.GA20075@flamenco>
References: <20180903171831.15446-1-cota@braap.org>
	<20180903171831.15446-6-cota@braap.org> <87d0tld83i.fsf@linaro.org>
	<20180910123020.GA19941@flamenco>
	<606947f7-ee92-ec98-90f5-d41ebe6a64be@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <606947f7-ee92-ec98-90f5-d41ebe6a64be@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/6] target/i386/translate: use
 thread-local storage in !user-mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Tue, Sep 11, 2018 at 13:24:03 +0200, Paolo Bonzini wrote:
> On 10/09/2018 14:30, Emilio G. Cota wrote:
> >> I'm confused - as we can have multi-threaded user space don't the same
> >> requirements apply?
> > In user-mode, code generation is serialized by mmap_lock.
> > Making these per-thread would just waste TLS space.
> 
> It's stupid question time!  How can the TLS work?  tcg_x86_init is only
> called once, the first time cpu_exec_realizefn is called.
>
> Either they can be kept in non-TLS, or you should move them to DisasContext.

Yes, the latter is the Right Thing (tm), as both you and Richard
pointed out. I should have done that in the first place.

Will send a v3 with just this change + the configure patch.

Thanks,

		Emilio
