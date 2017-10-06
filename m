Received: from eggs.gnu.org ([2001:4830:134:3::10]:55476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e0W7U-0001UV-8j
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 13:09:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e0W7Q-0006iE-Vp
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 13:09:04 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53987)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e0W7Q-0006gR-Ow
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 13:09:00 -0400
Date: Fri, 6 Oct 2017 13:08:57 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171006170857.GA26136@flamenco>
References: <1502149958-23381-1-git-send-email-cota@braap.org>
	<20171005234831.GB23670@flamenco> <87a814y27e.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a814y27e.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 00/22] tcg: tb_lock removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Fri, Oct 06, 2017 at 11:56:21 +0100, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > On Mon, Aug 07, 2017 at 19:52:16 -0400, Emilio G. Cota wrote:
> >> This series applies on top of the "multiple TCG contexts" series, v4:
> >>   https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg06769.html
> > (snip)
> >> Please review!
> >
> > Turns out this patchset breaks icount, even after fixing the patchset
> > it is based on (see [1]).
> 
> Isn't icount only used in single-threaded mode though?

Yes, but it also hits some code paths that get executed very rarely
(or not at all) in !icount mode. And we still acquire locks in single-threaded
mode -- the breakage is most likely due to a missing page_unlock somewhere.

Cheers,

		Emilio
