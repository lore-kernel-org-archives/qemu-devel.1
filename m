Received: from eggs.gnu.org ([2001:4830:134:3::10]:37857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gPHJh-0003zj-Po
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 20:28:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gPHJe-0004yz-Mv
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 20:28:33 -0500
References: <20181119101921.31949-1-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <362e12d5-bc66-a0ce-9d00-ecc56d49932b@redhat.com>
Date: Tue, 20 Nov 2018 20:23:23 -0500
MIME-Version: 1.0
In-Reply-To: <20181119101921.31949-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-next? 0/2] qemu-img: Minor
 fixes to an amend error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org, qemu-devel@nongnu.org



On 11/19/18 5:19 AM, Max Reitz wrote:
> One of the amend error paths has two issues that are fixed by this
> series.  Since they are relatively minor and have been present in 3.0
> already, I think there is no need to get them into 3.1.  OTOH they are
> bug fixes, so they could go into 3.1 if you, dear reader, insist.

I enjoy your use of "dear reader" in cover letters.

Not related to the above:

Reviewed-by: John Snow <jsnow@redhat.com>

> 
> 
> Max Reitz (2):
>   qemu-img: Fix typo
>   qemu-img: Fix leak
> 
>  qemu-img.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
