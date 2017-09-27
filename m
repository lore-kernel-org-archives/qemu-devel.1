Received: from eggs.gnu.org ([2001:4830:134:3::10]:40440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dxJgo-0002lU-Hw
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 17:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dxJgn-0006gz-MT
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 17:16:18 -0400
References: <20170913160333.23622-1-eblake@redhat.com>
	<20170913160333.23622-16-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <88ce047a-c351-6b5b-4dac-3cc6fb07f02e@redhat.com>
Date: Wed, 27 Sep 2017 17:16:09 -0400
MIME-Version: 1.0
In-Reply-To: <20170913160333.23622-16-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 15/23] qemu-img: Add find_nonzero()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 09/13/2017 12:03 PM, Eric Blake wrote:
> During 'qemu-img compare', when we are checking that an allocated
> portion of one file is all zeros, we don't need to waste time
> computing how many additional sectors after the first non-zero
> byte are also non-zero.  Create a new helper find_nonzero() to do
> the check for a first non-zero sector, and rebase
> check_empty_sectors() to use it.
> 
> The new interface intentionally uses bytes in its interface, even
> though it still crawls the buffer a sector at a time; it is robust
> to a partial sector at the end of the buffer.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>
