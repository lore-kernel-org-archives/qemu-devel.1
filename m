Received: from eggs.gnu.org ([2001:4830:134:3::10]:51226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ePEh4-0000Yg-4q
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:35:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ePEh3-0001dH-Bl
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:35:58 -0500
References: <20171213154432.18097-1-berto@igalia.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <ecd7d06e-c399-270f-bf0c-87ad6d50e18b@redhat.com>
Date: Wed, 13 Dec 2017 16:35:50 -0500
MIME-Version: 1.0
In-Reply-To: <20171213154432.18097-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] iotests: Tweak 030 in order to trigger
 a race condition with parallel jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org



On 12/13/2017 10:44 AM, Alberto Garcia wrote:
> This patch tweaks TestParallelOps in iotest 030 so it allocates data
> in smaller regions (256KB/512KB instead of 512KB/1MB) and the
> block-stream job in test_stream_commit() only needs to copy data that
> is at the very end of the image.
> 
> This way when the block-stream job is awakend it will finish right
> away without any chance of being stopped by block_job_sleep_ns(). This
> triggers the bug that was fixed by 3d5d319e1221082974711af1d09d82f07
> and is therefore a more useful test case for parallel block jobs.
> 
> After this patch the aforementiond bug can also be reproduced with the
> test_stream_parallel() test case.
> 
> Since with this change the stream job in test_stream_commit() finishes
> early, this patch introduces a similar test case where both jobs are
> slowed down so they can actually run in parallel.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Reviewed-by: John Snow <jsnow@redhat.com>
