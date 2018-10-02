Received: from eggs.gnu.org ([2001:4830:134:3::10]:56184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g7R1J-0006PG-P6
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 16:11:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g7R1E-0006MW-1g
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 16:11:47 -0400
References: <20181001132036.7919-1-peter.maydell@linaro.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <c1365d28-d78b-40d3-95dc-a1f507c46948@redhat.com>
Date: Tue, 2 Oct 2018 16:11:31 -0400
MIME-Version: 1.0
In-Reply-To: <20181001132036.7919-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] tests: Disable
 test-bdrv-drain and test-replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, patches@linaro.org, Wen Congyang <wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>, Max Reitz <mreitz@redhat.com>



On 10/01/2018 09:20 AM, Peter Maydell wrote:
> The test-bdrv-drain and test-replication tests have
> intermittent errors which make my build testing process
> fail way too often. Disable them both for the moment.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I'm having trouble making forward progress with applying
> merges because of these flaky tests :-(
> 
>  tests/Makefile.include | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index d0c0a92e67d..1cb1e1a1da7 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -91,7 +91,7 @@ gcov-files-test-thread-pool-y = thread-pool.c
>  gcov-files-test-hbitmap-y = util/hbitmap.c
>  check-unit-y += tests/test-hbitmap$(EXESUF)
>  gcov-files-test-hbitmap-y = blockjob.c
> -check-unit-y += tests/test-bdrv-drain$(EXESUF)
> +#check-unit-y += tests/test-bdrv-drain$(EXESUF)
>  check-unit-y += tests/test-blockjob$(EXESUF)
>  check-unit-y += tests/test-blockjob-txn$(EXESUF)
>  check-unit-y += tests/test-block-backend$(EXESUF)
> @@ -167,7 +167,7 @@ check-unit-y += tests/test-crypto-xts$(EXESUF)
>  check-unit-y += tests/test-crypto-block$(EXESUF)
>  check-unit-y += tests/test-logging$(EXESUF)
>  gcov-files-test-logging-y = util/log.c
> -check-unit-$(CONFIG_REPLICATION) += tests/test-replication$(EXESUF)
> +#check-unit-$(CONFIG_REPLICATION) += tests/test-replication$(EXESUF)
>  check-unit-y += tests/test-bufferiszero$(EXESUF)
>  gcov-files-check-bufferiszero-y = util/bufferiszero.c
>  check-unit-y += tests/test-uuid$(EXESUF)
> 

Should we leave some kind of breadcrumb to remind ourselves to fix or
re-enable these for the 3.1 RC window?

--js
