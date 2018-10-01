Received: from eggs.gnu.org ([2001:4830:134:3::10]:46113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g731b-0006B4-Ry
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 14:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g731X-0004zx-St
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 14:34:31 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39461)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g731X-0004zH-LF
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 14:34:27 -0400
Date: Mon, 1 Oct 2018 14:34:23 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181001183423.GA27555@flamenco>
References: <20180919175423.GA25553@flamenco>
 <87va71uijc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87va71uijc.fsf@linaro.org>
Subject: Re: [Qemu-devel] ideas for improving TLB performance (help with TCG
 backend wanted)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Pranith Kumar <bobby.prani@gmail.com>, Richard Henderson <richard.henderson@linaro.org>

On Thu, Sep 20, 2018 at 01:19:51 +0100, Alex Bennée wrote:
> If we are going to have an indirection then we can also drop the
> requirement to scale the TLB according to the number of MMU indexes we
> have to support. It's fairly wasteful when a bunch of them are almost
> never used unless you are running stuff that uses them.

So with dynamic TLB sizing, what you're suggesting here is to resize
each MMU array independently (depending on their use rate) instead
of using a single "TLB size" for all MMU indexes. Am I understanding
your point correctly?

Thanks,

		E.
