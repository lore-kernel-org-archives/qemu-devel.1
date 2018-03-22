Received: from eggs.gnu.org ([2001:4830:134:3::10]:37325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eyqrL-0003zp-Rd
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 23:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eyqrK-0003Wt-UZ
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 23:25:47 -0400
Date: Thu, 22 Mar 2018 11:25:19 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180322032519.GC32362@xz-mi>
References: <a80175c7-0d54-dc0b-5dbe-8bb05f51913b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a80175c7-0d54-dc0b-5dbe-8bb05f51913b@redhat.com>
Subject: Re: [Qemu-devel] raw iotest regressions in 2.12.0-rc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>

On Wed, Mar 21, 2018 at 05:58:48PM -0400, John Snow wrote:
> ./check -v -raw
> Failures: 109 132 136 148 152 183
> 
> 3fd2457d18edf5736f713dfe1ada9c87a9badab1 is the first bad commit
> commit 3fd2457d18edf5736f713dfe1ada9c87a9badab1
> Author: Peter Xu <peterx@redhat.com>
> Date:   Fri Mar 9 17:00:03 2018 +0800
> 
>     monitor: enable IO thread for (qmp & !mux) typed
> 
>     Start to use dedicate IO thread for QMP monitors that are not using
>     MUXed chardev.
> 
>     Reviewed-by: Fam Zheng <famz@redhat.com>
>     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>     Signed-off-by: Peter Xu <peterx@redhat.com>
>     Message-Id: <20180309090006.10018-21-peterx@redhat.com>
>     Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> 
> The symptom appears to be extra "RESUME" events in the stream that
> weren't expected by the original output for tests 109 and 183; the rest
> are python and I didn't dig yet.
> 
> ./check -v raw
> Failures: 055
> Failed 5 of 5 tests
> 
> 91ad45061af0fe44ac5dadb5bedaf4d7a08077c8 is the first bad commit
> commit 91ad45061af0fe44ac5dadb5bedaf4d7a08077c8
> Author: Peter Xu <peterx@redhat.com>
> Date:   Fri Mar 9 17:00:05 2018 +0800
> 
>     tests: qmp-test: verify command batching
> 
>     OOB introduced DROP event for flow control.  This should not affect old
>     QMP clients.  Add a command batching check to make sure of it.
> 
>     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>     Signed-off-by: Peter Xu <peterx@redhat.com>
>     Message-Id: <20180309090006.10018-23-peterx@redhat.com>
>     Reviewed-by: Eric Blake <eblake@redhat.com>
>     Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> 
> 
> Maybe these are known, but I wanted to consolidate them for rc0 for
> something easy to search for. There are others for qcow2 which I'll post
> in a bit...!

I'll have a look on this today and see whether this is the same
problem as reported by Max.  Sorry for that, and thanks for reporting!

-- 
Peter Xu
