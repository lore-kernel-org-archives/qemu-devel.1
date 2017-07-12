Received: from eggs.gnu.org ([2001:4830:134:3::10]:45945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dVPmC-0006a6-Nn
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 18:06:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dVPm8-0000JF-OE
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 18:06:32 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60211)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dVPm8-0000Io-C6
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 18:06:28 -0400
Date: Wed, 12 Jul 2017 18:06:27 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170712220627.GA31168@flamenco>
References: <149942760788.8972.474351671751194003.stgit@frigg.lan>
	<149942810176.8972.2271168155656858925.stgit@frigg.lan>
	<87d196ai8j.fsf@linaro.org> <87eftmgi5q.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87eftmgi5q.fsf@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v12 02/27] cpu-exec: Avoid global variables
 in icount-related functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Wed, Jul 12, 2017 at 11:42:57 +0300, Lluís Vilanova wrote:
> Alex Bennée writes:
> 
> > Lluís Vilanova <vilanova@ac.upc.edu> writes:
> 
> >> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> 
> > I guess. I assume this is also something Emilio is targeting with his
> > multi-threaded translation work.
> 
> Yes, Emilio suggested to format this patch in a way that won't conflict with his
> changes.

53f6672bcf57d8 is already in master so you should drop this patch for
your next respin.

BTW the problem for the multi-threaded translation work is the global
"static TCGLabel *exitreq_label."

		Emilio
