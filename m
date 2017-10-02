Received: from eggs.gnu.org ([2001:4830:134:3::10]:53464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dz88y-0003lI-FK
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 17:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dz88x-0007yH-Ii
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 17:20:52 -0400
References: <20170913160333.23622-1-eblake@redhat.com>
	<20170913160333.23622-23-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <49cb6caa-a0ec-e0fb-a53c-8de170d2bdc6@redhat.com>
Date: Mon, 2 Oct 2017 17:20:40 -0400
MIME-Version: 1.0
In-Reply-To: <20170913160333.23622-23-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 22/23] block: Relax
 bdrv_aligned_preadv() assertion
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <qemu-devel.nongnu.org>



On 09/13/2017 12:03 PM, Eric Blake wrote:
> Now that bdrv_is_allocated accepts non-aligned inputs, we can
> remove the TODO added in commit d6a644bb.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>
