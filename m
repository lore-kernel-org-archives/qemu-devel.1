Received: from eggs.gnu.org ([2001:4830:134:3::10]:55168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ePP2L-0004Gp-Pu
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 03:38:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ePP2J-0000ra-94
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 03:38:37 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20171214005953.8898-1-jsnow@redhat.com>
	<20171214005953.8898-2-jsnow@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fad7ac35-e2be-a7b0-078c-4aa4c3dd2905@redhat.com>
Date: Thu, 14 Dec 2017 09:38:26 +0100
MIME-Version: 1.0
In-Reply-To: <20171214005953.8898-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/7] blockjob: record time of last yield
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com

On 14/12/2017 01:59, John Snow wrote:
>      qemu_coroutine_yield();
> +    job->last_yield_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);

This is not the time the job has yielded control, but the time the job
has gotten it back.  Is it intended?

Thanks,

Paolo
