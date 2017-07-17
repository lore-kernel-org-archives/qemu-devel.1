Received: from eggs.gnu.org ([2001:4830:134:3::10]:51945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXAVK-0001aT-Fs
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:12:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXAVJ-00039Z-Kr
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:12:22 -0400
References: <20170717142310.17048-1-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <f6c0aba5-7406-5bd6-fd48-a0d09ebb050b@redhat.com>
Date: Mon, 17 Jul 2017 14:12:13 -0400
MIME-Version: 1.0
In-Reply-To: <20170717142310.17048-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] nbd: Fix iotests failure due
 to changed client error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, mreitz@redhat.com, Ishani <chugh.ishani@research.iiit.ac.in>



On 07/17/2017 10:23 AM, Eric Blake wrote:
> Commit 8ecaeae8 changed the way the client requests an NBD export,
> and in the process also changed the resulting error message when
> the export is not present, breaking a couple of iotests.  The error
> message is now directly given by the server (a failed NBD_OPT_GO)
> instead of implied by the client (after exhausting NBD_OPT_LIST),
> but looking at the testsuite changes, it proves worthwhile to
> reword the error message to be slightly less verbose (as this is
> one particular error message likely to be hit by a user).
> 
> Note that the error message is now sensitive to which binary is
> running the server as well as the client (since the expected
> output is replaying a message received from the server); in
> general iotests are run on client and server from the same source
> code base, but if it proves problematic in practice, we'll have
> to tweak or sanitize the output somehow.
> 
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Thanks, fixes it up for me.

Tested-by: John Snow <jsnow@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
