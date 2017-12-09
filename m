Received: from eggs.gnu.org ([2001:4830:134:3::10]:47200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eNU12-0005eM-6x
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 20:33:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eNU11-0001MI-A9
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 20:33:20 -0500
References: <20171123020832.8165-1-mreitz@redhat.com>
	<20171123020832.8165-18-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <27cf970f-dd54-970a-6b4a-0a0d39dde39b@redhat.com>
Date: Fri, 8 Dec 2017 20:33:10 -0500
MIME-Version: 1.0
In-Reply-To: <20171123020832.8165-18-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 17/17] iotests: Filter compat-dependent
 info in 198
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org



On 11/22/2017 09:08 PM, Max Reitz wrote:
> There is a bit of image-specific information which depends on the qcow2
> compat level.  Filter it so that 198 works with compat=0.10 (and any
> refcount_bits value).
> 
> Note that we cannot simply drop the --format-specific switch because we
> do need the "encrypt" information.
> 

I imagine it's not worth your time to factor this out.
That makes sense to me.

> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>
