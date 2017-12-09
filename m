Received: from eggs.gnu.org ([2001:4830:134:3::10]:51557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eNUE0-0000vB-Eg
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 20:46:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eNUDz-0001qf-Ou
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 20:46:44 -0500
References: <20171123020832.8165-1-mreitz@redhat.com>
	<20171123020832.8165-10-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <cda61c2a-1bfc-563a-2646-215da99df17f@redhat.com>
Date: Fri, 8 Dec 2017 20:46:32 -0500
MIME-Version: 1.0
In-Reply-To: <20171123020832.8165-10-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/17] iotests: Disable some tests for
 compat=0.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>



On 11/22/2017 09:08 PM, Max Reitz wrote:
> Tests 080, 130, 137, and 176 simply do not work with compat=0.10 for the
> reasons stated there.
> 
> 177 is a bit more interesting:  Originally, it was actually very much
> intended to work with compat=0.10 (it even had a special case for that).
> However, it now prints the test image's map twice, and short of just not
> doing that, there is no solution I can imagine that is both simple and
> would leave compat=0.10 support intact.
> 

So we lost that support in
f0a9c18f9e7
and
81c219ac6ce

Eric, any input before we downscope your test?

> Signed-off-by: Max Reitz <mreitz@redhat.com>

Without agonizing over it, I don't see an easy win either, so:

Reviewed-by: John Snow <jsnow@redhat.com>

(but it is a shame to lose the ability to test it.)
