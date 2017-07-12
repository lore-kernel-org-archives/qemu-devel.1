Received: from eggs.gnu.org ([2001:4830:134:3::10]:52486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dVO3E-0004hI-9H
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 16:16:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dVO3D-00029A-J0
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 16:16:00 -0400
References: <20170703151051.31327-1-eblake@redhat.com>
	<20170703151051.31327-15-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <7ad4bd44-8136-f2f8-1471-0daaa70a4f91@redhat.com>
Date: Wed, 12 Jul 2017 16:15:51 -0400
MIME-Version: 1.0
In-Reply-To: <20170703151051.31327-15-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 14/17] qcow2: Switch load_bitmap_data()
 to byte-based iteration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



On 07/03/2017 11:10 AM, Eric Blake wrote:
> Now that we have adjusted the majority of the calls this function
> makes to be byte-based, it is easier to read the code if it makes
> passes over the image using bytes rather than sectors.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 

Reviewed-by: John Snow <jsnow@redhat.com>

Vladimir, look good to you?

--js
