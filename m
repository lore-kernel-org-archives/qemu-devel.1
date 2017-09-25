Received: from eggs.gnu.org ([2001:4830:134:3::10]:45312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dwbBB-0003EE-FS
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 17:44:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dwbBA-0000Ep-Rh
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 17:44:41 -0400
References: <20170922093926.9723-1-pbutsykin@virtuozzo.com>
	<20170922093926.9723-3-pbutsykin@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <824a08a4-a8cd-8f5c-18b6-2f3c44eca124@redhat.com>
Date: Mon, 25 Sep 2017 17:44:33 -0400
MIME-Version: 1.0
In-Reply-To: <20170922093926.9723-3-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] qcow2: truncate the tail of the
 image file after shrinking the image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, den@openvz.org



On 09/22/2017 05:39 AM, Pavel Butsykin wrote:
> Now after shrinking the image, at the end of the image file, there might be a
> tail that probably will never be used. So we can find the last used cluster and
> cut the tail.
> 
> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>


Reviewed-by: John Snow <jsnow@redhat.com>
