Received: from eggs.gnu.org ([2001:4830:134:3::10]:49029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1epFca-0007nK-0O
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:50:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1epFcY-0004Zb-Nb
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:50:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1epFcY-0004ZH-Em
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:50:50 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1NFn231025195
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 10:50:49 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gak0jr89y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 10:50:48 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Fri, 23 Feb 2018 15:50:43 -0000
References: <1519400599-21081-1-git-send-email-walling@linux.vnet.ibm.com>
	<1519400599-21081-14-git-send-email-walling@linux.vnet.ibm.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Fri, 23 Feb 2018 16:50:38 +0100
MIME-Version: 1.0
In-Reply-To: <1519400599-21081-14-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <1818cb72-895b-2397-5385-8fc10b22921d@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v9 13/13] s390-ccw: interactive boot menu
 for scsi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, thuth@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, eblake@redhat.com

On 23.02.2018 16:43, Collin L. Walling wrote:
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
>  pc-bios/s390-ccw/menu.c     | 20 ++++++++++++++++++++
>  pc-bios/s390-ccw/s390-ccw.h |  2 ++
>  5 files changed, 28 insertions(+)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index c12e460..edbec90 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -246,6 +246,7 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
>              *flags |= QIPL_FLAG_BM_OPTS_ZIPL;
>              return;
>          }
break still missing here ...
> +    case S390_IPL_TYPE_QEMU_SCSI:
>          break;
>      default:
>          error_report("boot menu is not supported for this device type.");

otherwise, LGTM
-- 
Regards,
 Viktor Mihajlovski
