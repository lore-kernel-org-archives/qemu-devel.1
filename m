Received: from eggs.gnu.org ([2001:4830:134:3::10]:47356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fJKnf-00089f-8n
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:26:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fJKnZ-0001wt-SI
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:26:39 -0400
Date: Thu, 17 May 2018 17:26:28 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180517172628.61cf46ba.cohuck@redhat.com>
In-Reply-To: <20180516132757.68558-1-pasic@linux.ibm.com>
References: <20180516132757.68558-1-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] virtio-ccw: clean up notify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Dong Jia Shi <bjsdjshi@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Wed, 16 May 2018 15:27:57 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> Coverity recently started complaining about virtio_ccw_notify().  Turns
> out, there is a couple of things that can be cleaned up.  Let's clean!

Changes look good to me.

I wanted to come up with a better patch description, but failed (well,
I did not try much.) So I'm inclined to merge this as-is.

> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: CID 1390619
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  hw/s390x/virtio-ccw.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
