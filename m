Received: from eggs.gnu.org ([2001:4830:134:3::10]:55088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eokSu-0002hp-Mc
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 01:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eokSr-00032j-It
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 01:34:48 -0500
References: <1519241752-28083-1-git-send-email-walling@linux.vnet.ibm.com>
	<1519241752-28083-14-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1980df55-5bc5-b768-3861-e95c31d1e0d8@redhat.com>
Date: Thu, 22 Feb 2018 07:34:22 +0100
MIME-Version: 1.0
In-Reply-To: <1519241752-28083-14-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v8 13/13] s390-ccw:
 interactive boot menu for scsi
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
> Interactive boot menu for scsi. This follows a similar procedure
> as the interactive menu for eckd dasd. An example follows:
> 
>     s390x Enumerated Boot Menu.
> 
>     3 entries detected. Select from index 0 to 2.
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/ipl.c              |  1 +
>  pc-bios/s390-ccw/bootmap.c  |  4 ++++
>  pc-bios/s390-ccw/main.c     |  1 +
>  pc-bios/s390-ccw/menu.c     | 14 ++++++++++++++
>  pc-bios/s390-ccw/s390-ccw.h |  1 +
>  5 files changed, 21 insertions(+)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index a0f4f40..566248e 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -238,6 +238,7 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
>              *flags |= QIPL_FLAG_BM_OPTS_ZIPL;
>              return;
>          }
> +    case S390_IPL_TYPE_QEMU_SCSI:
>          break;

It's not a real bug, but I'm pretty sure this will cause Coverity to
report an issue of unintended switch-case fall through. Could you please
add a break before the new case label?
(Since all other patches look fine to me, this could maybe also be fixed
when the patches are picked up, so no need to respin the whole patch
series just because of this)

 Thomas
