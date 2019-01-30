Received: from eggs.gnu.org ([209.51.188.92]:38302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1goy6g-0000e0-5c
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 17:13:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1goy6f-00058U-1o
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 17:13:17 -0500
References: <20190102100113.24621-1-mahaocong_work@163.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <4ca4be78-22f9-53ed-2ca6-9592b77f46cb@redhat.com>
Date: Wed, 30 Jan 2019 17:12:47 -0500
MIME-Version: 1.0
In-Reply-To: <20190102100113.24621-1-mahaocong_work@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] add new function to copy dirty-bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mahaocong <mahaocong_work@163.com>, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, mahaocong <mahaocong@didichuxing.com>, qemu-devel@nongnu.org, mreitz@redhat.com



On 1/2/19 5:01 AM, mahaocong wrote:
> From: mahaocong <mahaocong@didichuxing.com>
> 
> This patch adds new function to copy the hbitmap from an exist dirty-bitmap to
> another. The destination bitmap should have the same size and granularity with
> the source bitmap, or the copy will fail.
> 
> Signed-off-by: mahaocong <mahaocong@didichuxing.com>

/technically/ we *can* do this already by creating a blank bitmap and
merging from one bitmap to the empty one.

Do you have a good argument for why copy is needed in addition?

--js
