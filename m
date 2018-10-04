Received: from eggs.gnu.org ([2001:4830:134:3::10]:42955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g7zOT-0004bo-BM
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 04:54:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g7zOP-00006B-VY
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 04:54:01 -0400
Date: Thu, 4 Oct 2018 10:53:45 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181004105345.674e27d3.cohuck@redhat.com>
In-Reply-To: <1538466491-2073-1-git-send-email-thuth@redhat.com>
References: <1538466491-2073-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/s390x/s390-pci-bus: Convert sysbus init
 function to realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Yi Min Zhao <zyimin@linux.ibm.com>, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Pierre Morel <pmorel@linux.ibm.com>

On Tue,  2 Oct 2018 09:48:11 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The SysBusDeviceClass->init() interface is considered as a legacy interface
> and there are currently some efforts going on to get rid of it. Thus let's
> convert the init function in the s390x code to realize() instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/s390-pci-bus.c | 34 +++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)

Thanks, applied.
