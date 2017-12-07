Received: from eggs.gnu.org ([2001:4830:134:3::10]:53663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eMvCX-0001Ca-2d
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 07:22:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eMvCT-0006W4-Ro
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 07:22:53 -0500
Date: Thu, 7 Dec 2017 13:22:43 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171207132243.2664b6b4.cohuck@redhat.com>
In-Reply-To: <20171206144438.28908-1-pasic@linux.vnet.ibm.com>
References: <20171206144438.28908-1-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/2] unrestrict cssids related patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Wed,  6 Dec 2017 15:44:36 +0100
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> See the commit messages and cover letters of the individual
> patches for more details.
> 
> v1 -> v2:
> * Squashed advertising via property into #1 
> * Fixed commit message for #1 
> * Dropped machine name in the doc and changed
>   how the 'deprecated' warning works
> * Added acks and r-b's when appropriate
> 
> Halil Pasic (2):
>   s390x/css: unrestrict cssids
>   s390x: deprecate s390-squash-mcss machine prop
> 
>  hw/s390x/3270-ccw.c        |  2 +-
>  hw/s390x/css-bridge.c      | 11 +++++++++++
>  hw/s390x/css.c             | 28 ++++------------------------
>  hw/s390x/s390-ccw.c        |  2 +-
>  hw/s390x/s390-virtio-ccw.c |  8 ++++++--
>  hw/s390x/virtio-ccw.c      |  2 +-
>  include/hw/s390x/css.h     | 12 ++++--------
>  qemu-doc.texi              |  8 ++++++++
>  qemu-options.hx            |  8 +++++++-
>  9 files changed, 43 insertions(+), 38 deletions(-)
> 

Currently working on queuing this for 2.12, further acks/r-bs/t-bs
gladly taken.
