Received: from eggs.gnu.org ([2001:4830:134:3::10]:47486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@weiser.dinsnail.net>) id 1eWS2U-0005Z4-Ho
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 14:15:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@weiser.dinsnail.net>) id 1eWS2T-00041s-SI
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 14:15:54 -0500
Date: Tue, 2 Jan 2018 20:02:42 +0100
From: Michael Weiser <michael.weiser@gmx.de>
Message-ID: <20180102190242.GC31343@weiser.dinsnail.net>
References: <20171230225622.97409-1-michael.weiser@gmx.de>
	<19080078-e96a-cc33-bb02-97f9b726d080@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19080078-e96a-cc33-bb02-97f9b726d080@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2] target/arm: Fix stlxp for aarch64_be
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

Hi Richard,

On Mon, Jan 01, 2018 at 03:06:21PM -0800, Richard Henderson wrote:

> > v2:
> > - make it work for MTTCG as well by catering to the 128bit expectation
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> > +     * 128bit store but two doulbewords stored consecutively */
>                                ^^ typo

Fixed for v3. Thanks!
-- 
Michael
