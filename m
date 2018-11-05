Received: from eggs.gnu.org ([2001:4830:134:3::10]:40662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gJhao-0003Ql-9T
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:19:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gJhNE-0008MG-JH
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:05:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gJhNA-00085t-JV
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:05:06 -0500
References: <20181105135538.28025-1-peter.maydell@linaro.org>
	<20181105135538.28025-2-peter.maydell@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2660bcda-2812-fea4-4f5c-3d096d8fe686@redhat.com>
Date: Mon, 5 Nov 2018 10:04:57 -0600
MIME-Version: 1.0
In-Reply-To: <20181105135538.28025-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1 1/2] include/qemu/thread.h:
 Document qemu_thread_atexit* API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, patches@linaro.org

On 11/5/18 7:55 AM, Peter Maydell wrote:
> Add documentation for the qemu_thread_atexit_add() and
> qemu_thread_atexit_remove() functions.
> 
> We include a (previously undocumented) constraint that notifiers
> may not be called if a thread is exiting because the entire
> process is exiting. This is fine for our current use because
> the callers use it only for cleaning up resources which go away
> on process exit (memory, Win32 fibers), and we will need the
> flexibility for the new posix implementation.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/qemu/thread.h | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
