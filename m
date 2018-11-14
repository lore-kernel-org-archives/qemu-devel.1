Received: from eggs.gnu.org ([2001:4830:134:3::10]:60314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gMynR-000104-KU
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:17:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gMynL-000261-UT
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:17:43 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:46327)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gMynK-0001zl-03
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:17:38 -0500
Date: Wed, 14 Nov 2018 12:17:27 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181114171727.GB960@flamenco>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-3-cota@braap.org> <875zwzerqg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875zwzerqg.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC 02/48] trace: expand mem_info:size_shift to 3
 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

On Wed, Nov 14, 2018 at 13:03:19 +0000, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > This will allow us to trace 16B-long memory accesses.
> >
> > While at it, add some defines for the mem_info bits and simplify
> > trace_mem_get_info by making it a wrapper around trace_mem_build_info.
> >
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> 
> Currently we ignore atomic operation but I assume we'll want to
> represent them at some point here.

We "ignore" them in that we just trace them without marking them
as atomic. We do trace them since d071f4cd55 ("trace: enable tracing
of TCG atomics", 2018-06-27), which BTW is a spin-off of early
iterations of this series.

> I don't know if memory barrier behaviour would also be worth exporting?

I don't see much value in that from a tracing viewpoint; if
users need such instruction-specific details they can just
use a plugin, where they can disassemble TB's.

Thanks,

		E.
