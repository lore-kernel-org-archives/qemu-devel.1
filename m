Received: from eggs.gnu.org ([209.51.188.92]:43489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h14G7-00033O-TX
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:13:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h14G7-0000lz-7h
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 02:13:03 -0500
From: Thomas Huth <thuth@redhat.com>
References: <1551769785-17717-1-git-send-email-thuth@redhat.com>
Message-ID: <a1d91dfd-a6dc-d06c-332c-1865cbc3c08a@redhat.com>
Date: Tue, 5 Mar 2019 08:12:55 +0100
MIME-Version: 1.0
In-Reply-To: <1551769785-17717-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] target/s390x: Remove
 non-architected entries from struct LowCore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>

On 05/03/2019 08.09, Thomas Huth wrote:
> There are some fields in our struct LowCore which apparently have
> been copied from a very old version of the Linux kernel. These
> fields are not architected in the "Principles of Operation", and
> only used on these memory locations in Linux kernels older than
> 2.6.29. Newer Linux kernels moved the entries to different locations
> or are not using them at all anymore. Thus we should never access
> these fields from the QEMU side, so they should be removed.
> 
> While we're at it, also add a QEMU_BUILD_BUG_MSG() statement to
> assert that struct LowCore has the right size.

Uh, sorry, wrong version of the patch, please ignore, I did not add the
QEMU_BUILD_BUG_MSG() here yet. I'll send a v2 in a minute...

 Thomas
