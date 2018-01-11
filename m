Received: from eggs.gnu.org ([2001:4830:134:3::10]:59609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZdEp-0000WB-3t
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:49:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZdEm-00034Y-HW
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:49:47 -0500
References: <20180110091846.10699-1-famz@redhat.com>
	<20180110091846.10699-4-famz@redhat.com>
	<20180110183304.GE24212@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e0ad8125-e788-69c0-0711-0da0bbdb55f4@redhat.com>
Date: Thu, 11 Jan 2018 14:48:41 +0100
MIME-Version: 1.0
In-Reply-To: <20180110183304.GE24212@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 3/9] block: Add VFIO based NVMe driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Karl Rister <krister@redhat.com>

On 10/01/2018 19:33, Stefan Hajnoczi wrote:
>> +
>> +    /* Fields protected by @lock */
> Does this lock serve any purpose?  I didn't see a place where these
> fields is accessed from multiple threads.  Perhaps you're trying to
> prepare for multiqueue, but then other things like the
> BDRVNVMeState->inflight counter aren't protected so it doesn't make
> sense.
> 

Other drivers are already thread safe (e.g. block/vdi.c since commit
1e88663979, "vdi: make it thread-safe", 2017-07-17).  So I'd be in favor
of (fixing and) keeping the lock.

Paolo
