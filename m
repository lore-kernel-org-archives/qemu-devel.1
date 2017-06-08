Received: from eggs.gnu.org ([2001:4830:134:3::10]:58114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dJ1Te-0005JF-Jr
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:44:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dJ1Ta-0005f2-BV
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:44:10 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54573)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dJ1TZ-0005df-Rv
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:44:06 -0400
Date: Thu, 8 Jun 2017 13:44:04 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170608174404.GA1767@flamenco>
References: <20170607155536.1193-1-rth@twiddle.net>
	<20170607233019.GA29137@flamenco>
	<d1c6bad4-12b4-b697-fca5-dae84864bba0@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1c6bad4-12b4-b697-fca5-dae84864bba0@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v4 0/7] tcg: allocate TB structs preceding
 translate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On Thu, Jun 08, 2017 at 09:44:11 -0700, Richard Henderson wrote:
> On 06/07/2017 04:30 PM, Emilio G. Cota wrote:
> >On Wed, Jun 07, 2017 at 08:55:29 -0700, Richard Henderson wrote:
> >>Then I've a few follow-up patches to take advantage of the new TB
> >>placement for arm platforms.  I've had a look at the asm output for
> >>ppc64 and s390x, and don't see anything obvious that can be improved.
> >
> >Nice! Just tested patches 3-7 with an arm guest image on
> >x86 and aarch64 hosts:
> >
> >   Tested-by: Emilio G. Cota <cota@braap.org>
> 
> So... you've tested patch 3 then?
> Patches 4-7 are for an arm host.

Ha! Yes, sorry for the confusion -- I blindly went by the patch titles'
"target/arm" prefix; shouldn't they be "tcg/arm"?

		E.
