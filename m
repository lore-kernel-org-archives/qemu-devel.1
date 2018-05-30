Received: from eggs.gnu.org ([2001:4830:134:3::10]:46561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fNvpw-0004iR-Mj
	for qemu-devel@nongnu.org; Wed, 30 May 2018 03:48:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fNvps-0008Mm-Ox
	for qemu-devel@nongnu.org; Wed, 30 May 2018 03:48:00 -0400
Date: Wed, 30 May 2018 09:47:52 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180530094752.0ffd5310.cohuck@redhat.com>
In-Reply-To: <1527568809-5640-1-git-send-email-walling@linux.ibm.com>
References: <1527568809-5640-1-git-send-email-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pc-bios/s390-ccw: define loadparm length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, lersek@redhat.com

On Tue, 29 May 2018 00:40:09 -0400
Collin Walling <walling@linux.ibm.com> wrote:

> Loadparm is defined by the s390 architecture to be 8 bytes
> in length. Let's define this size in the s390-ccw bios.
> 
> Suggested-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/iplb.h | 4 +++-
>  pc-bios/s390-ccw/main.c | 8 ++++----
>  pc-bios/s390-ccw/sclp.c | 2 +-
>  pc-bios/s390-ccw/sclp.h | 2 +-
>  4 files changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Thomas, I assume this will go via your tree?
