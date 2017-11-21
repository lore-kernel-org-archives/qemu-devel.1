Received: from eggs.gnu.org ([2001:4830:134:3::10]:32837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eHA22-0002pS-O2
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:00:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eHA1x-00081m-8x
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:00:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:63209)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1eHA1x-00081S-3D
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:00:09 -0500
Date: Tue, 21 Nov 2017 16:00:00 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20171121150000.nrofdu3arv2tcwta@eukaryote>
References: <20171121142538.22072-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171121142538.22072-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] build: disarm the TCG unit test trap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On Tue, Nov 21, 2017 at 02:25:38PM +0000, Daniel P. Berrange wrote:
> Developers sometimes mistakenly run 'make test' instead of 'make check'.
> 'make test' triggers the ancient, unmaintained tcg unit tests in
> tests/tcg/Makefile which have long since ceased compiling.
> 
> Even if someone fixes the TCG tests, it makes little sense to put
> them in a 'make test' target, rather they should be 'make check-tcg',
> possibly wired up as a dependency of 'make check'.
> 
> In the meantime, this patch disarms the 'make test' trap by simply
> deleting it so users get an immediate error. This should be enough
> for them to remember to type 'make check' instead (or 'make help'
> to learn). It also deletes 'make speed' which is another route
> into the tcg tests.

Thanks; I mistakenly fell for this trap.

> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
> 
> Changed in v2:
> 
>  - Remove 'test' & 'speed' targets, instead of making 'test'
>    a synonym for 'check'
> 
>  Makefile | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>

[...]

-- 
/kashyap
