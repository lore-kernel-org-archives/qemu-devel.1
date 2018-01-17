Received: from eggs.gnu.org ([2001:4830:134:3::10]:39964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebkly-0007vb-Fl
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 05:16:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebklu-0001iw-Ei
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 05:16:46 -0500
References: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516034665-27606-9-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2a0f0236-0095-6492-fce7-2bc2e23fd95b@redhat.com>
Date: Wed, 17 Jan 2018 11:16:34 +0100
MIME-Version: 1.0
In-Reply-To: <1516034665-27606-9-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 8/8] s390-ccw: interactive boot menu for
 scsi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com

On 15.01.2018 17:44, Collin L. Walling wrote:
> Interactive boot menu for scsi. This follows the same procedure
> as the interactive menu for eckd dasd. An example follows:
> 
>     s390x Enumerated Boot Menu.
> 
>     3 entries detected. Select from index 0 to 2.
> 
>     Please choose:
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> ---
>  pc-bios/s390-ccw/bootmap.c |  9 ++++++---
>  pc-bios/s390-ccw/main.c    |  3 +++
>  pc-bios/s390-ccw/menu.c    | 14 ++++++++++++++
>  pc-bios/s390-ccw/menu.h    |  1 +
>  4 files changed, 24 insertions(+), 3 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
