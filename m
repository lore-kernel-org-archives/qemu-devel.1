Received: from eggs.gnu.org ([2001:4830:134:3::10]:40344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eNTh2-0007Sy-5q
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 20:12:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eNTgy-00062z-6N
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 20:12:40 -0500
References: <20171123020832.8165-1-mreitz@redhat.com>
	<20171123020832.8165-16-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <80cdc5e8-923f-acfe-08ad-e9731aae114d@redhat.com>
Date: Fri, 8 Dec 2017 20:12:30 -0500
MIME-Version: 1.0
In-Reply-To: <20171123020832.8165-16-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 15/17] iotests: Make 184 image-less
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
> 184 does not need an image, so don't use one.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Seems sane.

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  tests/qemu-iotests/184     | 25 ++++--------------
>  tests/qemu-iotests/184.out | 63 +++++++---------------------------------------
>  2 files changed, 14 insertions(+), 74 deletions(-)
> 
