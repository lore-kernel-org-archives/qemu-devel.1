Received: from eggs.gnu.org ([2001:4830:134:3::10]:55735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etWWs-0007ju-Lb
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:42:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1etWWp-0007T9-Gx
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:42:38 -0500
Date: Wed, 7 Mar 2018 11:42:32 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180307114232.78f5aed1.cohuck@redhat.com>
In-Reply-To: <1520317081-5341-1-git-send-email-thuth@redhat.com>
References: <1520317081-5341-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] pc-bios/s390-ccw: Move string arrays
 from bootmap header to .c file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org

On Tue,  6 Mar 2018 07:18:01 +0100
Thomas Huth <thuth@redhat.com> wrote:

> bootmap.h can currently only be included once - otherwise the linker
> complains about multiple definitions of the "magic" strings. It's a
> bad style to define string arrays in header files, so let's better
> move these to the bootmap.c file instead where they are used.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2:
>  - Removed duplicated vol_desc_magic (copy-n-paste error)
> 
>  pc-bios/s390-ccw/bootmap.c | 20 ++++++++++++++++++++
>  pc-bios/s390-ccw/bootmap.h | 19 -------------------
>  2 files changed, 20 insertions(+), 19 deletions(-)

Thanks, applied (without rebuild as this is no functional change).
