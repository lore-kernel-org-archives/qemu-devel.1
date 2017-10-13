Received: from eggs.gnu.org ([2001:4830:134:3::10]:41863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1e310M-00071O-Fr
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 10:32:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1e310I-0002We-HQ
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 10:32:02 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:44397)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1e310I-0002Vy-Ci
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 10:31:58 -0400
Received: by mail-pf0-x242.google.com with SMTP id x7so10502114pfa.1
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 07:31:58 -0700 (PDT)
Date: Fri, 13 Oct 2017 23:31:54 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20171013143154.GF2958@lianli.shorne-pla.net>
References: <20171013134930.32547-1-shorne@gmail.com>
	<20171013134930.32547-3-shorne@gmail.com>
	<068db9d2-2805-2dac-4c19-efc6d187db44@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <068db9d2-2805-2dac-4c19-efc6d187db44@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] target/openrisc: Make coreid and
 numcores variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Development <qemu-devel@nongnu.org>, Openrisc <openrisc@lists.librecores.org>

On Fri, Oct 13, 2017 at 06:58:21AM -0700, Richard Henderson wrote:
> On 10/13/2017 06:49 AM, Stafford Horne wrote:
> > Previously coreid and numcores were hard coded as 0 and 1 respectively
> > as OpenRISC QEMU did not have multicore support.
> > 
> > Multicore support is now being added so these registers need to have
> > configured values.
> > 
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> >  target/openrisc/sys_helper.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~

Thank you for the review.

-Stafford
