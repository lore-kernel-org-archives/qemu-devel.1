Received: from eggs.gnu.org ([2001:4830:134:3::10]:60385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0THT-0003Hq-C0
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 11:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0THS-0001lm-MH
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 11:11:43 -0400
References: <20180913125217.23173-1-kwolf@redhat.com>
	<20180913125217.23173-4-kwolf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0d3a1209-9770-bcf7-aa47-4baa95fd88e9@redhat.com>
Date: Thu, 13 Sep 2018 17:11:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180913125217.23173-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/17] aio-wait: Increase num_waiters
 even in home thread
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
> Even if AIO_WAIT_WHILE() is called in the home context of the
> AioContext, we still want to allow the condition to change depending on
> other threads as long as they kick the AioWait. Specfically block jobs
> can be running in an I/O thread and should then be able to kick a drain
> in the main loop context.

I don't understand the scenario very well.  Why hasn't the main loop's
drain incremented num_waiters?

Note I'm not against the patch---though I would hoist the
atomic_inc/atomic_dec outside the if, since it's done in both branches.

Paolo
