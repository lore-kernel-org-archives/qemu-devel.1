Received: from eggs.gnu.org ([2001:4830:134:3::10]:53871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eokMU-0001NI-UP
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 01:28:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eokMR-0003pQ-QW
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 01:28:10 -0500
References: <1519241752-28083-1-git-send-email-walling@linux.vnet.ibm.com>
	<1519241752-28083-13-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f981ed82-f512-2a75-7188-da0486cb49db@redhat.com>
Date: Thu, 22 Feb 2018 07:27:47 +0100
MIME-Version: 1.0
In-Reply-To: <1519241752-28083-13-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v8 12/13] s390-ccw: use zipl
 values when no boot menu options are present
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, mihajlov@linux.vnet.ibm.com, borntraeger@de.ibm.com, eblake@redhat.com

On 21.02.2018 20:35, Collin L. Walling wrote:
> If no boot menu options are present, then flag the boot menu to
> use the zipl options that were set in the zipl configuration file
> (and stored on disk by zipl). These options are found at some
> offset prior to the start of the zipl boot menu banner. The zipl
> timeout value is limited to a 16-bit unsigned integer and stored
> as seconds, so we take care to convert it to milliseconds in order
> to conform to the rest of the boot menu functionality. This is
> limited to CCW devices.
> 
> For reference, the zipl configuration file uses the following
> fields in the menu section:
> 
>       prompt=1      enable the boot menu
>       timeout=X     set the timeout to X seconds
> 
> To explicitly disregard any boot menu options, then menu=off or
> <bootmenu enable='no' ... /> must be specified.
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> ---
>  hw/s390x/ipl.c          |  5 +++++
>  hw/s390x/ipl.h          |  1 +
>  pc-bios/s390-ccw/iplb.h |  1 +
>  pc-bios/s390-ccw/main.c |  3 ++-
>  pc-bios/s390-ccw/menu.c | 14 ++++++++++++++
>  5 files changed, 23 insertions(+), 1 deletion(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
