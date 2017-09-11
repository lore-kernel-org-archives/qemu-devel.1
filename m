Received: from eggs.gnu.org ([2001:4830:134:3::10]:48365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1drMly-0000w5-K9
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:21:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1drMls-0004xP-SB
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:21:02 -0400
References: <20170911110037.6567-1-lvivier@redhat.com>
	<20170911110615.GK21444@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <d205d21c-0db2-c4b7-aeab-e9f4dac8ff6b@redhat.com>
Date: Mon, 11 Sep 2017 13:20:53 +0200
MIME-Version: 1.0
In-Reply-To: <20170911110615.GK21444@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hmp: fix "dump-quest-memory" segfault (ppc)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 11/09/2017 13:06, Daniel P. Berrange wrote:
> On Mon, Sep 11, 2017 at 01:00:37PM +0200, Laurent Vivier wrote:
>> Commit fd5d23babf (hmp: fix "dump-quest-memory" segfault)
>> fixes the problem for i386, do the same for ppc.
> 
> What about all the other targets QEMU supports ?  Have you checked if they
> are similarly affected, as we don't want to wait another 6 months to get a
> bug report that s390 or aarch64 crash in exactly the same way too.

s390 works fine, but aarch64 needs the same kind of fix.

Thanks,
Laurent
