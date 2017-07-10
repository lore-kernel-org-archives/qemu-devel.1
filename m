Received: from eggs.gnu.org ([2001:4830:134:3::10]:60369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dUhZU-000753-OV
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 18:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dUhZU-00072u-0r
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 18:54:28 -0400
References: <20170703151051.31327-1-eblake@redhat.com>
	<20170703151051.31327-8-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <32753e56-1c92-c949-9148-925e4c0acc89@redhat.com>
Date: Mon, 10 Jul 2017 18:54:20 -0400
MIME-Version: 1.0
In-Reply-To: <20170703151051.31327-8-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 07/17] qcow2: Switch
 sectors_covered_by_bitmap_cluster() to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 07/03/2017 11:10 AM, Eric Blake wrote:
> We are gradually converting to byte-based interfaces, as they are
> easier to reason about than sector-based.  Change the qcow2 bitmap
> helper function sectors_covered_by_bitmap_cluster(), renaming it
> in the process.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 

It really will be nice to not have multiple layers of scaling for 
bitmaps anymore.

Reviewed-by: John Snow <jsnow@redhat.com>
