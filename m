Received: from eggs.gnu.org ([2001:4830:134:3::10]:54896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fB09k-0008N7-Ew
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:47:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fB09e-0002nH-MO
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:47:00 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58181)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fB09e-0002n7-FW
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:46:54 -0400
Date: Tue, 24 Apr 2018 11:46:52 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180424154652.GA22209@flamenco>
References: <20180424045112.12963-1-peterx@redhat.com>
	<20180424045112.12963-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424045112.12963-3-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/4] qemu-thread: introduce
 qemu-thread-common.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Apr 24, 2018 at 12:51:10 +0800, Peter Xu wrote:
> Introduce some hooks for the shared part of qemu thread between POSIX
> and Windows implementations.  Note that in qemu_mutex_unlock_impl() we
> moved the call before unlock operation which should make more sense.
> And we don't need qemu_mutex_post_unlock() hook.
> 
> Currently the hooks only calls the tracepoints.

This line is obsolete -- in _init we set ->initialized.

> Put all these shared hooks into the header files.  It should be internal
> to qemu-thread but not for qemu-thread users, hence put into util/
> directory.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
(snip)
> +++ b/util/qemu-thread-common.h
(snip)
> +#ifndef __QEMU_THREAD_COMMON_H__
> +#define __QEMU_THREAD_COMMON_H__

Please change to QEMU_THREAD_COMMON_H, without the double underscore.
(_* and __* identifiers are reserved for the C library)

Otherwise:

Reviewed-by: Emilio G. Cota <cota@braap.org>

Thanks,

		Emilio
