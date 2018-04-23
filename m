Received: from eggs.gnu.org ([2001:4830:134:3::10]:57859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fAYOt-00073U-Q6
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 06:08:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fAYOo-0002pE-Tb
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 06:08:47 -0400
Date: Mon, 23 Apr 2018 12:08:31 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180423120831.11cc785f.cohuck@redhat.com>
In-Reply-To: <1523864720-4680-1-git-send-email-thuth@redhat.com>
References: <1523864720-4680-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.13] pc-bios/s390-ccw: size_t
 should be unsigned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>

On Mon, 16 Apr 2018 09:45:20 +0200
Thomas Huth <thuth@redhat.com> wrote:

> "size_t" should be an unsigned type according to the C standard.
> Thus we should also use this convention in the s390-ccw firmware to avoid
> confusion. I checked the sources, and apart from one spot in libc.c, the
> code should all be fine with this change.
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1753437
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Use long instead of ssize_t in uitoa()
> 
>  pc-bios/s390-ccw/libc.c | 2 +-
>  pc-bios/s390-ccw/libc.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

I assume you'll queue this one yourself?
