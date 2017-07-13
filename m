Received: from eggs.gnu.org ([2001:4830:134:3::10]:50750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dViwT-0000cT-SG
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 14:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dViwT-0002IV-6e
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 14:34:25 -0400
References: <20170713010555.6769-1-eblake@redhat.com>
	<20170713010555.6769-14-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <9d96ebeb-5dfa-daf4-ecca-64166050bb82@redhat.com>
Date: Thu, 13 Jul 2017 14:34:17 -0400
MIME-Version: 1.0
In-Reply-To: <20170713010555.6769-14-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 13/18] mirror: Switch
 mirror_dirty_init() to byte-based iteration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>



On 07/12/2017 09:05 PM, Eric Blake wrote:
> Now that we have adjusted the majority of the calls this function
> makes to be byte-based, it is easier to read the code if it makes
> passes over the image using bytes rather than sectors.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 

Looks like we just pick up a touch more cleanup here.

Reviewed-by: John Snow <jsnow@redhat.com>
