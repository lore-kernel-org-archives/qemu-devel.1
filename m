Received: from eggs.gnu.org ([2001:4830:134:3::10]:36563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dtspa-0005P8-EO
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dtspZ-0003KS-N5
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:59:10 -0400
Date: Mon, 18 Sep 2017 11:58:56 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170918095856.GF31915@localhost.localdomain>
References: <20170913082817.24731-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913082817.24731-1-berto@igalia.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] throttle: Assert that
 bkt->max is valid in throttle_compute_wait()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

Am 13.09.2017 um 10:28 hat Alberto Garcia geschrieben:
> If bkt->max == 0 and bkt->burst_length > 1 then we could have a
> division by 0 in throttle_do_compute_wait(). That configuration is
> however not permitted and is already detected by throttle_is_valid(),
> but let's assert it in throttle_compute_wait() to make it explicit.
> 
> Found by Coverity (CID: 1381016).
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Thanks, applied to the block branch.

Kevin
