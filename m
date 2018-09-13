Received: from eggs.gnu.org ([2001:4830:134:3::10]:33608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0TLT-0005dO-Nd
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 11:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0TLT-0004GE-6L
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 11:15:51 -0400
References: <20180913125217.23173-1-kwolf@redhat.com>
	<20180913125217.23173-7-kwolf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <387dce30-0a62-ad0a-e955-56ca714323b4@redhat.com>
Date: Thu, 13 Sep 2018 17:15:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180913125217.23173-7-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 06/17] job: Use AIO_WAIT_WHILE() in
 job_finish_sync()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, famz@redhat.com, slp@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org

On 13/09/2018 14:52, Kevin Wolf wrote:
> Also, job_drain() without aio_poll() isn't necessarily enough to make
> progress on a job, it could depend on bottom halves to be executed.

This is not changed by the patch though; AIO_WAIT_WHILE does not do the
bottom halves part anymore, bdrv_drain_poll_top_level does it instead.

What is it that needs bottom halves to be executed?  Could it delay
switching the job state until after that?

Thanks,

Paolo
