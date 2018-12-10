Received: from eggs.gnu.org ([2001:4830:134:3::10]:46826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWPS2-0000K5-EX
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:34:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWPRz-0004kr-8R
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:34:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gWPRw-0004fX-8x
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:34:33 -0500
Date: Mon, 10 Dec 2018 15:34:27 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181210173427.GG4669@habkost.net>
References: <20181207204107.GH7395@habkost.net>
	<20181209222738.GA9292@flamenco>
	<20181210163601.GA4669@habkost.net>
	<20181210170720.GA21344@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210170720.GA21344@flamenco>
Subject: Re: [Qemu-devel] Help needed: test-qht-par hangs on Travis
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org

On Mon, Dec 10, 2018 at 12:07:20PM -0500, Emilio G. Cota wrote:
> On Mon, Dec 10, 2018 at 14:36:01 -0200, Eduardo Habkost wrote:
> > On Sun, Dec 09, 2018 at 05:27:38PM -0500, Emilio G. Cota wrote:
> > > Can you try re-running the test, after applying the appended patch?
> > > (It disables the "resize" thread.)
> > 
> > It is running right now, here:
> > https://travis-ci.org/ehabkost/qemu-hacks/jobs/466074591
> > 
> > > 
> > > Also, does it reliably hang on Travis, or are these hangs
> > > intermittent?
> > 
> > It can be reproduced reliably.  qemu.git builds are failing since
> > Thursday:
> > https://travis-ci.org/qemu/qemu/builds
> 
> I see the build you launched timed out. Can you try the following
> patch (after discarding the previous one)? Let's see if just by
> disabling the second test we can get the build to move ahead.

I will try it.  I'm not sure yet if it's the first or the second
test case timing out.  Maybe the "OK\n" we see in the log file is
from another process running in parallel.


> 
> Thanks,
> 
> 		E.
> ---
> diff --git a/tests/test-qht-par.c b/tests/test-qht-par.c
> index d8a83caf5c..a916c91ccb 100644
> --- a/tests/test-qht-par.c
> +++ b/tests/test-qht-par.c
> @@ -46,7 +46,6 @@ int main(int argc, char *argv[])
> 
>      if (g_test_quick()) {
>          g_test_add_func("/qht/parallel/2threads-0%updates-1s", test_2th0u1s);
> -        g_test_add_func("/qht/parallel/2threads-20%updates-1s", test_2th20u1s);
>      } else {
>          g_test_add_func("/qht/parallel/2threads-0%updates-5s", test_2th0u5s);
>          g_test_add_func("/qht/parallel/2threads-20%updates-5s", test_2th20u5s);

-- 
Eduardo
