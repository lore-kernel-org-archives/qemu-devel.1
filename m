Received: from eggs.gnu.org ([2001:4830:134:3::10]:33222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhdEl-0003BF-N8
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhdEh-0001yw-O6
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:54:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dhdEh-0001yg-Hl
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:54:27 -0400
Date: Tue, 15 Aug 2017 16:54:10 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170815165410.066c4c4d.cohuck@redhat.com>
In-Reply-To: <1502431076-22849-2-git-send-email-thuth@redhat.com>
References: <1502431076-22849-1-git-send-email-thuth@redhat.com>
	<1502431076-22849-2-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11 1/2] tests/boot-sector: Do not
 overwrite the x86 buffer on other architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Victor Kaplansky <victork@redhat.com>

On Fri, 11 Aug 2017 07:57:55 +0200
Thomas Huth <thuth@redhat.com> wrote:

> Re-using the boot_sector code buffer from x86 for other architectures
> is not very nice, especially if we add more architectures later. It's
> also ugly that the test uses a huge pre-initialized array at all - the
> size of the executable is very huge due to this array. So let's use a
> separate buffer for each architecture instead, allocated from the heap,
> so that we really just use the memory that we need.
> 
> Suggested-by: Michael Tsirkin <mst@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/boot-sector.c | 41 ++++++++++++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 15 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
