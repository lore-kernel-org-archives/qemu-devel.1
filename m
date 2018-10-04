Received: from eggs.gnu.org ([2001:4830:134:3::10]:33294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g7urg-0006we-12
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 00:03:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g7urb-0007sm-Vy
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 00:03:51 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58911)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g7urY-0007nd-3r
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 00:03:46 -0400
Date: Thu, 4 Oct 2018 00:03:40 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181004040340.GA24908@flamenco>
References: <20181003200454.18384-1-cota@braap.org>
	<20181003200454.18384-5-cota@braap.org>
	<20181004040147.GA22844@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004040147.GA22844@flamenco>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] cputlb: read CPUTLBEntry.addr_write
 atomically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Thu, Oct 04, 2018 at 00:01:47 -0400, Emilio G. Cota wrote:
>                                 Speedup over master
(snip)
> That is, a 5% average slowdown, with a max slowdown of ~14% for
> mcf :-(

png chart:
  https://imgur.com/a/5Jghi6Q

		E.
