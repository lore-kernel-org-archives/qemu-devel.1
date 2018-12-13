Received: from eggs.gnu.org ([2001:4830:134:3::10]:36855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gXSPm-0005fl-Ua
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:56:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gXSPm-0001Dk-47
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:56:38 -0500
Date: Thu, 13 Dec 2018 15:56:27 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181213155627.778fd434.cohuck@redhat.com>
In-Reply-To: <20181213120252.21697-1-peter.maydell@linaro.org>
References: <20181213120252.21697-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/s390/ccw.c: Don't take address of
 packed members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, Farhan Ali <alifm@linux.ibm.com>

On Thu, 13 Dec 2018 12:02:52 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> Taking the address of a field in a packed struct is a bad idea, because
> it might not be actually aligned enough for that pointer type (and
> thus cause a crash on dereference on some host architectures). Newer
> versions of clang warn about this.
> 
> Avoid the problem by using local copies of the PMCW and SCSW
> struct fields in copy_schib_from_guest() and copy_schib_to_guest().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v1->v2 changes:
>  * add comment about why we're using locals
>  * name locals with underscores, as QEMU's naming conventions recommend
> 
> 
>  hw/s390x/css.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)

Thanks, applied.
