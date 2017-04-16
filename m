Received: from eggs.gnu.org ([2001:4830:134:3::10]:51956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1czoup-0000wT-Sl
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 14:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1czouo-0000w3-CB
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 14:28:51 -0400
Date: Sun, 16 Apr 2017 14:28:43 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170416182843.GA30160@flamenco>
References: <1491959850-30756-1-git-send-email-cota@braap.org>
	<1491959850-30756-6-git-send-email-cota@braap.org>
	<73257eb8-edfd-ae0b-a5fa-b1194de568d8@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73257eb8-edfd-ae0b-a5fa-b1194de568d8@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 05/10] tcg: add jr opcode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Stefan Weil <sw@weilnetz.de>, Alexander Graf <agraf@suse.de>, alex.bennee@linaro.org, qemu-arm@nongnu.org, Pranith Kumar <bobby.prani+qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On Sat, Apr 15, 2017 at 04:40:35 -0700, Richard Henderson wrote:
> On 04/11/2017 06:17 PM, Emilio G. Cota wrote:
> >This will be used by TCG targets to implement a fast path
> >for indirect branches.
> >
> >I only have implemented and tested this on an i386 host, so
> >make this opcode optional and mark it as not implemented by
> >other TCG backends.
> 
> I don't think this is quite the right abstraction.  In particular, if we can
> always return a valid address from the helper, we can eliminate a
> conditional branch.
> 
> I think this should work as follows:
(snip)

Yes that's much better. In fact in the cover letter I forgot to
mention that the code by the paper authors does something similar
to avoid the branch.

I went with the design with a branch because (1) I wasn't sure that
exporting tb_ret_addr would get your approval and (2) my knowledge
of TCG backend code is shamefully poor.

Will work on a v2. Thanks for the feedback!

		Emilio
